#!/bin/bash
# 检查 Skill 中 AI 会加载的文件的行数
# 输出超过阈值的文件，帮助控制上下文占用

THRESHOLD="${1:-200}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "📏 MyKnowledge 文件行数检查（阈值: ${THRESHOLD}行）"
echo ""

# AI 每次加载的文件（SKILL.md → core/main.md）
ALWAYS_LOADED=(
  "SKILL.md"
  "core/main.md"
)

# AI 按需加载的模块（懒加载）
LAZY_LOADED=(
  "modules/commands/main.md"
  "modules/management/main.md"
  "modules/error/main.md"
  "modules/export/main.md"
  "modules/silent/main.md"
  "one-time/onboarding/main.md"
  "one-time/setup/install-source.md"
  "one-time/setup/platform-detector.md"
  "one-time/setup/update-checker.md"
)

# 模板文件（创建时加载）
TEMPLATES=(
  "core/templates/project-status-template.md"
  "core/templates/requirement-readme-template.md"
  "core/templates/requirements-index-template.md"
  "core/templates/kb-readme-template.md"
  "core/templates/public-readme-template.md"
  "core/templates/archive-readme-template.md"
  "core/templates/design-doc-template.md"
  "core/templates/projects-yaml-spec.md"
)

# 用户文档（AI 可能被引导读取）
USER_DOCS=(
  "FAQ.md"
  "README.md"
  "INSTALL.md"
  "docs/PITFALLS.md"
)

# 开发者文档
DEV_DOCS=(
  "DEVELOPMENT.md"
  "RELEASE-LOG.md"
)

total=0
over=0

check_files() {
  local label="$1"
  shift
  echo "## $label"
  for f in "$@"; do
    if [ -f "$ROOT/$f" ]; then
      lines=$(wc -l < "$ROOT/$f" | tr -d ' ')
      total=$((total + lines))
      if [ "$lines" -gt "$THRESHOLD" ]; then
        over=$((over + 1))
        printf "  ⚠️  %4d 行  %s\n" "$lines" "$f"
      else
        printf "  ✅  %4d 行  %s\n" "$lines" "$f"
      fi
    fi
  done
  echo ""
}

check_files "每次加载" "${ALWAYS_LOADED[@]}"
check_files "懒加载模块" "${LAZY_LOADED[@]}"
check_files "模板" "${TEMPLATES[@]}"
check_files "用户文档（按需）" "${USER_DOCS[@]}"
check_files "开发者文档" "${DEV_DOCS[@]}"

echo "════════════════════════════════"
echo "📊 总计: ${total} 行 | 超阈值: ${over} 个"
echo "   AI 每次加载: ~$(wc -l < "$ROOT/SKILL.md" | tr -d ' ') + ~$(wc -l < "$ROOT/core/main.md" | tr -d ' ') 行"
echo "   规则文件:     ~$(wc -l < "$ROOT/../.codebuddy/rules/MyKnowledge_开发规则.mdc" 2>/dev/null | tr -d ' ') 行"
echo ""
