#!/bin/bash
# SkillHub 发布包构建脚本
# 排除 GitHub 相关内容、构建脚本、测试文件
#
# 流程：
#   1. 先跑 scripts/lint-paths.sh 做路径一致性门禁（v1.1.2+）
#   2. 通过后才开始打包
#   3. 失败则退出非零状态码

set -e

# 切到脚本所在目录（仓库根）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}/.."

# 路径一致性检查（门禁）
echo "════════════════════════════════════════"
echo "🚦 发布前门禁：路径一致性检查"
echo "════════════════════════════════════════"
bash scripts/lint-paths.sh
LINT_EXIT=$?
if [ $LINT_EXIT -ne 0 ]; then
  echo ""
  echo "❌ 打包被阻止：lint 检查未通过"
  echo "   请修复上面的问题后重新打包"
  exit 1
fi

VERSION=$(grep '"version"' _meta.json | head -1 | sed 's/.*"version": "\(.*\)".*/\1/')
OUTPUT_NAME="MyKnowledge-${VERSION}-skillhub.zip"

echo "📦 打包版本: ${VERSION}"
echo "📁 输出文件: ${OUTPUT_NAME}"

# 创建临时目录
TMP_DIR=$(mktemp -d)
STAGE_DIR="${TMP_DIR}/myknowledge"

# 复制必要文件
mkdir -p "${STAGE_DIR}"
cp SKILL.md settings.yaml _meta.json manifest.json "${STAGE_DIR}/"
cp README.md "${STAGE_DIR}/" 2>/dev/null || true
cp -r core modules one-time hooks "${STAGE_DIR}/"
# 注意：scripts/、test/、.github/ 都是开发者专用，不进 SkillHub zip

cd "${TMP_DIR}"
zip -r "${OUTPUT_NAME}" myknowledge/ -x "*.DS_Store" "*/__pycache__/*"

# 确保 releases 目录存在
mkdir -p "${OLDPWD}/releases"
mv "${OUTPUT_NAME}" "${OLDPWD}/releases/"
cd "${OLDPWD}"
rm -rf "${TMP_DIR}"

echo "✅ 完成: releases/${OUTPUT_NAME}"
ls -lh "releases/${OUTPUT_NAME}"

# 验证排除项
echo ""
echo "🔍 验证 ZIP 内容（确认无 GitHub 相关文件）:"
unzip -l "releases/${OUTPUT_NAME}" | grep -E "(LICENSE|CHANGELOG|\.github|RELEASE-GUIDE|\.gitignore)" && echo "❌ 警告：发现应排除的文件" || echo "✅ 干净：无 LICENSE/CHANGELOG/.github/RELEASE-GUIDE"
