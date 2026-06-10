#!/bin/bash
# 路径一致性检查 - 防止文档/配置与实际文件不一致
# 用法：bash scripts/lint-paths.sh [--strict]
# 退出码：0=全部通过, 1=有错误
#
# 用途说明（v1.1.2+）：
#   历史上多次出现"文档里写的路径在文件系统中找不到"的问题（如
#   `prompts/main.md` vs `core/main.md`、遗漏 Claude 平台等）。
#   本脚本读取 manifest.json 这个"单一真理来源"，自动检查：
#     1. 必需文件是否都存在
#     2. 文档里引用的所有路径是否有效
#     3. 是否还在使用历史别名
#     4. 多个文件里的版本号是否一致
#     5. 用户文档是否提及了所有支持的平台
#   配合 scripts/build-skillhub.sh 使用，作为发布门禁。

# 不使用 set -e，因为我们要收集所有错误再退出
# set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${ROOT_DIR}"

STRICT_MODE=0
if [ "${1:-}" = "--strict" ]; then
  STRICT_MODE=1
fi

echo "🔍 MyKnowledge 路径一致性检查"
echo "📁 工作目录: ${ROOT_DIR}"
echo ""

ERRORS=0
WARNINGS=0

ok()   { echo "  ✅ $1"; }
err()  { echo "  ❌ $1"; ERRORS=$((ERRORS + 1)); }
warn() { echo "  ⚠️  $1"; WARNINGS=$((WARNINGS + 1)); }
section() { echo ""; echo "── $1 ──"; }

# ============================================================
# 1. manifest.json 存在
# ============================================================
section "1. manifest.json 检查"
if [ ! -f "manifest.json" ]; then
  err "manifest.json 不存在，无法继续"
  exit 1
fi
ok "manifest.json 存在"

# 提取目标版本号
EXPECTED_VERSION=$(python3 -c "import json; print(json.load(open('manifest.json'))['version'])")
ok "目标版本: ${EXPECTED_VERSION}"

# ============================================================
# 2. 必需文件存在性
# ============================================================
section "2. 必需文件存在性"
MISSING=$(python3 -c "
import json, os
m = json.load(open('manifest.json'))
print('\n'.join(p for p in m.get('required_files', []) if not os.path.exists(p)))
")
if [ -z "$MISSING" ]; then
  COUNT=$(python3 -c "import json; print(len(json.load(open('manifest.json'))['required_files']))")
  ok "所有 ${COUNT} 个必需文件都存在"
else
  err "以下必需文件不存在："
  echo "$MISSING" | sed 's/^/      /'
fi

# ============================================================
# 3. 文档路径引用检查
# ============================================================
section "3. 文档路径引用检查"

# 这些文件里的路径引用只用于描述"用户侧"或"历史"，不需要在仓库里真实存在
# 通过 manifest.json 的 excluded_from_path_check 字段声明豁免
BROKEN=$(python3 << 'PYEOF'
import json, os, re

m = json.load(open('manifest.json'))
required_files = set(m.get('required_files', []))

# 豁免规则：
# 1. CHANGELOG.md / CHANGELOG 类似文件天然出现历史引用
# 2. 只含文件名的引用（无目录）通常是"代码示例"里的项目文件，不是 Skill 自身文件
# 3. 我们只检查 required_files 里声明的"Skill 自身文件"是否被正确引用
# 4. 文档里出现的"用户侧路径"（如 PROJECT-STATUS.md 在用户 KB 里）不强制要求

doc_files = []
skip_dirs = {'/test', '/scripts', '/node_modules', '/.git', '/.codegraph', '/releases'}
for root, dirs, files in os.walk('.'):
    root_norm = root.replace('\\', '/')
    if any(s in root_norm for s in skip_dirs):
        continue
    for f in files:
        if f.endswith('.md'):
            doc_files.append(os.path.join(root, f))

# 重点检查：required_files 里的文件名（如 SKILL.md, settings.yaml, modules/commands/main.md）
# 必须以正确的相对路径出现在文档中（且路径真实存在）
ref_pattern_path = re.compile(r'`((?:[\w\-]+/)*[\w\-]+\.[a-z]{2,3})`')
ref_pattern_dir = re.compile(r'`((?:[\w\-]+/)+)`')

SKIP_PREFIXES = ('http', 'chmod', 'cp ', 'git ', 'npm ', 'openclaw ', 'skillhub ', 'clawhub ')

# CHANGELOG 等历史文件豁免
EXEMPT_FILES = {'CHANGELOG.md', 'manifest.json'}

# 从 manifest.json 读取 path_check_exempt 规则
EXEMPT_RULES = m.get('path_check_exempt', {})
# 格式：{文件名: {line_ranges: [[start,end],...], patterns: [str,...]}}

# 文档中"提到"但实际可能不存在的合理文件（用户侧产物）
KNOWN_USER_FILES = {
    'PROJECT-STATUS.md',          # 用户 KB 里的文件
    'README.md',                   # 用户 KB 里的文件（在根目录/KB 根）
    'design.md',                   # 单个需求的设计文档（可选）
    'mock-install-source.yaml',   # test 目录（已 skip）
    'mock-skill-state.yaml',      # test 目录（已 skip）
    'requirements/REQ-YYYYMMDD-XXX/',  # 需求目录格式示例
}

broken = []
for doc in doc_files:
    if any(doc.endswith(ef) for ef in EXEMPT_FILES):
        continue
    try:
        with open(doc) as f:
            content = f.read()
    except Exception:
        continue

    # 解析每行（用于行号豁免）
    lines = content.split('\n')

    # 取得当前文档的豁免规则
    doc_basename = os.path.basename(doc)
    doc_rules = EXEMPT_RULES.get(doc_basename, {})
    exempt_line_ranges = doc_rules.get('line_ranges', [])
    exempt_patterns = doc_rules.get('patterns', [])

    def is_exempt_by_line(start_line, end_line):
        # start_line/end_line 是 1-based（行号）
        for s, e in exempt_line_ranges:
            if s <= start_line <= e:
                return True
        return False

    # 路径引用（如 `core/main.md`）
    for m in ref_pattern_path.finditer(content):
        ref = m.group(1)
        if any(ref.startswith(p) for p in SKIP_PREFIXES):
            continue
        if '://' in ref or '{' in ref or '}' in ref:
            continue
        # 跳过明显的用户侧文件
        if ref in KNOWN_USER_FILES:
            continue
        # 跳过 "v1.0.0" 格式的"看起来像路径但不是"的东西
        if re.match(r'v?\d+\.\d+', ref):
            continue
        # 跳过豁免模式
        if any(p in ref or ref in p for p in exempt_patterns):
            continue
        # 检查是否在豁免行范围内
        # 计算 ref 出现在哪一行
        ref_line = content[:m.start()].count('\n') + 1
        if is_exempt_by_line(ref_line, ref_line):
            continue
        if not os.path.exists(ref):
            broken.append((doc, ref))
    # 目录引用（如 `templates/`）
    for m in ref_pattern_dir.finditer(content):
        ref = m.group(1).rstrip('/')
        if any(ref.startswith(p) for p in SKIP_PREFIXES):
            continue
        if '://' in ref:
            continue
        if ref in {'core/', 'modules/', 'one-time/', 'hooks/', 'test/', 'scripts/', 'requirements/', 'public/', 'archive/'}:
            continue
        if any(p in ref or ref in p for p in exempt_patterns):
            continue
        ref_line = content[:m.start()].count('\n') + 1
        if is_exempt_by_line(ref_line, ref_line):
            continue
        if not os.path.exists(ref):
            broken.append((doc, ref + '/'))

for doc, ref in broken:
    print(f"{doc}: {ref}")
PYEOF
)

if [ -z "$BROKEN" ]; then
  ok "所有文档里的路径引用都有效"
else
  err "以下文档路径引用在文件系统中找不到："
  echo "$BROKEN" | sed 's/^/      /'
fi

# ============================================================
# 4. 历史别名检查（警告级）
# ============================================================
section "4. 历史别名检查"
ALIAS_HITS=$(python3 << 'PYEOF'
import json, os, re

with open('manifest.json') as f:
    m = json.load(f)
aliases = m.get('path_aliases', {})

# CHANGELOG.md 天然包含历史别名（描述过去的修复）
EXEMPT_FILES = {'CHANGELOG.md'}

hits = []
skip_dirs = {'/test', '/scripts', '/node_modules', '/.git', '/.codegraph', '/releases'}
for root, dirs, files in os.walk('.'):
    root_norm = root.replace('\\', '/')
    if any(s in root_norm for s in skip_dirs):
        continue
    for fname in files:
        if not fname.endswith('.md'):
            continue
        if fname in EXEMPT_FILES:
            continue
        path = os.path.join(root, fname)
        try:
            with open(path) as f:
                content = f.read()
        except Exception:
            continue
        # 只匹配反引号包裹的纯别名（如 `templates/`），不匹配 `core/templates/`
        for alias in aliases:
            # 反引号 + alias + 收尾符号
            if re.search(r'`' + re.escape(alias) + r'(?![a-zA-Z0-9_\-/])', content):
                hits.append((path, alias))

for path, alias in hits:
    print(f"{path}: {alias}")
PYEOF
)

if [ -z "$ALIAS_HITS" ]; then
  ok "没有发现使用历史别名"
else
  warn "以下文档还在使用历史别名（应改为实际路径）："
  echo "$ALIAS_HITS" | sed 's/^/      /'
fi

# ============================================================
# 5. 版本号一致性
# ============================================================
section "5. 版本号一致性"
# 智能策略：
#   - CHANGELOG.md 豁免（历史版本是合理的）
#   - 其他文件如果在文档元数据/YAML/JSON 头部声明了版本号，必须等于 EXPECTED_VERSION
#   - 历史段（如 "v1.0.0 发布" 的描述）允许出现其他版本号
VERSION_MISMATCH=$(python3 << 'PYEOF'
import json, os, re

m = json.load(open('manifest.json'))
expected = m['version']
synced_files = m.get('version_synced_files', [])

# CHANGELOG 天然包含历史版本，豁免
EXEMPT_FROM_VERSION = {'CHANGELOG.md'}

# 检查策略：扫描文件前 30 行（YAML/JSON 头部 + 文档元数据），看看 "version" 字段
# 不同于历史段的"v1.0.0 发布"叙述
mismatches = []
for fpath in synced_files:
    if fpath in EXEMPT_FROM_VERSION:
        continue
    if not os.path.exists(fpath):
        continue
    with open(fpath) as fh:
        content = fh.read()

    # 策略 A：YAML/JSON/Markdown front-matter 的 version 字段
    # 匹配 "version: 1.x.x" 或 '"version": "1.x.x"'
    declared_versions = set()
    # 不在 raw string 里用 \'（bash heredoc 友好），改用字符类
    pattern1 = re.compile(r'version:[\s"=]+(1\.\d+\.\d+)')
    pattern2 = re.compile(r'"version"[\s":=]+"(1\.\d+\.\d+)"')
    for pattern in [pattern1, pattern2]:
        for mt in pattern.findall(content):
            declared_versions.add(mt)

    other = declared_versions - {expected}
    if other:
        mismatches.append((fpath, '声明的版本字段', other))

for fpath, kind, vs in mismatches:
    print(f"{fpath}: {kind} {vs}")
PYEOF
)

if [ -z "$VERSION_MISMATCH" ]; then
  ok "所有同步文件的版本声明都是 ${EXPECTED_VERSION}"
else
  err "以下文件的版本声明不一致："
  echo "$VERSION_MISMATCH" | sed 's/^/      /'
fi

# ============================================================
# 6. 平台完整性
# ============================================================
section "6. 平台完整性"
PLATFORM_ISSUES=$(python3 << 'PYEOF'
import json, os

with open('manifest.json') as f:
    m = json.load(f)
doc_platforms = ['CodeBuddy', 'WorkBuddy', 'OpenClaw', 'Claude']

issues = []
for doc in ['README.md', 'USAGE.md', 'FAQ.md', 'INSTALL.md', 'TEST-PLAN.md']:
    if not os.path.exists(doc):
        continue
    with open(doc) as f:
        content = f.read()
    for plat in doc_platforms:
        if plat not in content:
            issues.append(doc + ': 缺少平台 ' + plat)

for i in issues:
    print(i)
PYEOF
)

if [ -z "$PLATFORM_ISSUES" ]; then
  ok "所有用户文档都提及了 4 个支持的平台"
else
  err "以下用户文档缺少平台提及："
  echo "$PLATFORM_ISSUES" | sed 's/^/      /'
fi

# ============================================================
# 汇总
# ============================================================
echo ""
echo "════════════════════════════════════════"
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo "✅ 全部通过（0 错误, 0 警告）"
  exit 0
elif [ $ERRORS -eq 0 ]; then
  echo "⚠️  通过但有 ${WARNINGS} 个警告"
  if [ $STRICT_MODE -eq 1 ]; then
    echo "❌ --strict 模式下警告也算失败"
    exit 1
  fi
  exit 0
else
  echo "❌ 失败：${ERRORS} 个错误, ${WARNINGS} 个警告"
  echo ""
  echo "💡 修复建议："
  echo "   1. 查看上面 ❌ 项"
  echo "   2. 修改文档/manifest.json"
  echo "   3. 重新运行此脚本"
  echo "   4. 通过后再运行 scripts/build-skillhub.sh"
  exit 1
fi
