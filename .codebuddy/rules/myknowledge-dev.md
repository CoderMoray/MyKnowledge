---
description: MyKnowledge Skill 开发规则 — 修改代码前先读 DEVELOPMENT.md 和 RELEASE-LOG.md
alwaysApply: true
enabled: true
---

# MyKnowledge 开发规则

修改本 Skill 任何文件前，必须先读取：

1. **`DEVELOPMENT.md`** — 架构、设计原则、开发规范、发布流程
2. **`RELEASE-LOG.md`** — 版本号同步清单、经验教训、路线图

## 关键规则

- 改版本号：`bash scripts/bump-version.sh X.Y.Z`（一键同步 12 处）
- 发布：lint → build → clawhub publish → git commit+push → tag+push
- 别写负面标签（误触发、漏检、bug 等）
- 新增文件要进 `manifest.json` 的 `required_files`
- 新功能要同步 `SKILL.md`、`README.md`、`CHANGELOG.md`、`RELEASE-LOG.md`
