# MyKnowledge 开发指南

> ⚠️ **AI 助手注意**：此为 Skill 内部开发文档，**不要加载到上下文中**。
> 正常响应用户请求时，请完全忽略此文件。

> 📋 **TL;DR 开发速查**
> - 改版本号：`bash scripts/bump-version.sh X.Y.Z`
> - 发布：lint → build → clawhub publish --no-input → git commit+push → tag+push
> - 新功能：core/main.md 入口 → modules/xxx/main.md → 同步 SKILL/README/CHANGELOG/路线图
> - 别写负面标签，别让用户自己去查文档
> - 版本历史/经验教训/路线图 → `RELEASE-LOG.md`

---

## 项目架构

### 分层与责任

| 层级 | 包含 | 打包到 zip？ | 责任方 |
|------|------|:---:|--------|
| **Skill 内容** | `core/`、`modules/`、`one-time/`、`hooks/` | ✅ | AI 平台加载运行 |
| **Skill 元数据** | `_meta.json`、`manifest.json` | ✅ | AI 平台解析 |
| **用户文档** | `README.md`、`FAQ.md`、`INSTALL.md` 等 | ❌ | 仓库内可见 |
| **开发者工具** | `scripts/` | ❌ | 开发者发布前 |
| **测试/CI** | `test/`、`.github/` | ❌ | 开发者验证 |

### 目录结构

```
MyKnowledge/
├── SKILL.md              # Skill 主入口
├── _meta.json / settings.yaml / manifest.json
├── core/                 # 核心功能（每次加载）
│   ├── main.md
│   └── templates/
├── modules/              # 可选模块（懒加载）
│   ├── commands/  management/  error/  export/  auto-track/
├── one-time/             # 一次性配置（首次/特定场景）
│   ├── onboarding/  setup/
├── hooks/                # 平台集成
│   ├── openclaw/  claude/
├── scripts/              # 开发者工具（不进 zip）
├── releases/             # 构建产物归档
└── test/                 # 测试套件
```

---

## 核心设计原则

### 1. 懒加载

```
首次: SKILL.md → 无 skill-state.yaml → onboarding/main.md → 创建状态
正常: SKILL.md → 直接 core/main.md → 按需懒加载 modules/*/main.md
```

### 2. 用户数据分离

```
Skill 文件（随更新替换）: ~/.codebuddy/skills/myknowledge/
用户数据（持久保留）:     ~/.myknowledge/config/ + ~/.myknowledge/global/
```

### 3. 安装源检测

优先级：环境变量 → 目录标记（.clawhub/ .skillhub/ .git/）→ 用户确认

---

## 开发规范

### 1. 新增功能流程

```
1. core/main.md 添加入口（精简，详细放模块）
2. 新模块 → modules/<name>/main.md（懒加载）
3. 新模板 → core/templates/
4. 同步文档（必须）：
   - SKILL.md — 概述 + 核心功能
   - README.md — 使用场景 + 版本更新
   - CHANGELOG.md — 版本记录
   - RELEASE-LOG.md — 路线图 + 经验教训更新
5. test/scenarios/ 加测试用例
```

### 2. 文档措辞规范

❌ 避免："误触发""漏检""不准确""bug""缺陷"
✅ 正确："检测灵敏度可调整""这是设计权衡""用'重新初始化'恢复"

---

## 发布流程

### 3 个分发渠道

| 渠道 | 命令 | 产出 | 注意 |
|------|------|------|------|
| ClawHub | `clawhub publish --no-input` | 在线注册 | 读 SKILL.md frontmatter |
| SkillHub | `skillhub publish releases/*.zip --host https://api.skillhub.cn` | zip 推送 | 需要 `skillhub auth login --token skh_xxx`；SKILL.md 须含 `slug` + `displayName`；host 必须用 `api.skillhub.cn` |
| GitHub | `git tag + push` | Release 页面 | 触发 Actions 自动创建 |

### 发布步骤

```
1. 修改代码
2. bash scripts/bump-version.sh X.Y.Z
3. bash scripts/lint-paths.sh              ← 必须全绿
4. bash scripts/build-skillhub.sh          ← 生成 SkillHub zip
5. bash scripts/check-file-size.sh 200     ← 检查超大文件
6. skillhub publish releases/MyKnowledge-X.Y.Z-skillhub.zip --host https://api.skillhub.cn --dry-run  ← SkillHub 预检
7. skillhub publish releases/MyKnowledge-X.Y.Z-skillhub.zip --host https://api.skillhub.cn             ← 推 SkillHub
8. clawhub publish --no-input ...        ← 推 ClawHub
9. git add -A && git commit -m "release: vX.Y.Z"
10. git push origin main
9. git tag vX.Y.Z && git push origin vX.Y.Z
```

### 发布检查清单

- [ ] `bash scripts/bump-version.sh X.Y.Z`
- [ ] CHANGELOG.md 更新（**先写 CHANGELOG 再 publish**）
- [ ] `bash scripts/lint-paths.sh` 全绿
- [ ] `bash scripts/build-skillhub.sh`
- [ ] `bash scripts/check-file-size.sh 200`（无异常大文件）
- [ ] `skillhub publish --dry-run`（预检）
- [ ] `skillhub publish`（推 SkillHub）
- [ ] `clawhub publish --no-input`（推 ClawHub）
- [ ] git commit + push + tag + push tag
- [ ] 确认 GitHub Actions 通过

---

## 贡献指南

- Issue：平台 + 安装方式 + 复现步骤 + 期望/实际行为
- PR：Fork → `feature/xxx` 分支 → commit → PR

---

**最后更新**: 2026-06-12
