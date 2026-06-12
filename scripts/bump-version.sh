#!/bin/bash
# 批量更新 MyKnowledge 所有文件的版本号
# 用法：bash scripts/bump-version.sh 1.3.3

set -e

NEW_VERSION="${1:?用法: bash scripts/bump-version.sh <新版本号，如 1.3.4>}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "🔢 批量更新版本号 → $NEW_VERSION"
echo ""

# 10 个需要同步版本号的文件（DEVELOPMENT.md 版本号同步清单）
FILES=(
  "SKILL.md:version: \"%OLD%\""
  "settings.yaml:version: \"%OLD%\""
  "settings.yaml:current: \"%OLD%\""
  "_meta.json:\"version\": \"%OLD%\""
  "manifest.json:\"version\": \"%OLD%\""
  "one-time/onboarding/main.md:version: \"%OLD%\""
  "hooks/claude/hooks.json:\"version\": \"%OLD%\""
  "hooks/claude/README.md:\"version\": \"%OLD%\""
  "hooks/openclaw/HOOK.md:version: \"%OLD%\""
  "hooks/openclaw/hook-guide.md:version: \"%OLD%\""
)

# README 特殊处理（badge 和 性能对比表）
README_FILES=(
  "README.md:version-%OLD%"
  "README.md:v%OLD% | 变化 |"
)

# 从 SKILL.md 读当前版本
OLD_VERSION=$(grep '^version:' "$ROOT/SKILL.md" | head -1 | sed 's/.*"\(.*\)".*/\1/')

if [ -z "$OLD_VERSION" ]; then
  echo "❌ 无法从 SKILL.md 读取当前版本"
  exit 1
fi

echo "📋 当前版本: $OLD_VERSION"
echo "📋 目标版本: $NEW_VERSION"
echo ""

# 更新 10 个版本声明文件
for entry in "${FILES[@]}"; do
  file="${entry%%:*}"
  pattern="${entry#*:}"
  old_pattern="${pattern//%OLD%/$OLD_VERSION}"
  new_pattern="${pattern//%OLD%/$NEW_VERSION}"

  if [ "$(uname)" = "Darwin" ]; then
    sed -i '' "s/$old_pattern/$new_pattern/" "$ROOT/$file"
  else
    sed -i "s/$old_pattern/$new_pattern/" "$ROOT/$file"
  fi
  echo "  ✅ $file"
done

# 更新 README（badge + 性能对比表）
for entry in "${README_FILES[@]}"; do
  file="${entry%%:*}"
  pattern="${entry#*:}"
  old_pattern="${pattern//%OLD%/$OLD_VERSION}"
  new_pattern="${pattern//%OLD%/$NEW_VERSION}"

  if [ "$(uname)" = "Darwin" ]; then
    sed -i '' "s/$old_pattern/$new_pattern/" "$ROOT/$file"
  else
    sed -i "s/$old_pattern/$new_pattern/" "$ROOT/$file"
  fi
  echo "  ✅ $file"
done

echo ""
echo "✅ 版本号已全部更新: $OLD_VERSION → $NEW_VERSION"
echo ""
echo "下一步："
echo "  bash scripts/lint-paths.sh"
echo "  bash scripts/build-skillhub.sh"
