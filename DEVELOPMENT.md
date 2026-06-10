# MyKnowledge 开发指南

> ⚠️ **AI 助手注意**：此为 Skill 内部开发文档，**不要加载到上下文中**。
> 正常响应用户请求时，请完全忽略此文件。
>
> 本文档面向 Skill 开发者和贡献者，终端用户无需阅读。

---

## 项目架构

### 分层与责任

| 层级 | 包含 | 打包到 SkillHub zip？ | 责任方 |
|------|------|----------------------|--------|
| **Skill 内容** | `core/`、`modules/`、`one-time/`、`hooks/` | ✅ 是 | AI 平台加载运行 |
| **Skill 元数据** | `_meta.json`、`manifest.json`（根目录） | ✅ 是 | AI 平台解析、版本识别 |
| **用户文档** | `README.md`、`QUICKSTART.md`、`USAGE.md`、`FAQ.md`、`INSTALL.md`、`TEST-PLAN.md` | ❌ 否 | 仓库内可见，zip 外 |
| **开发者工具** | `scripts/build-skillhub.sh`、`scripts/lint-paths.sh` | ❌ 否 | 开发者发布前 |
| **测试** | `test/` | ❌ 否 | 开发者验证 |
| **CI 配置** | `.github/workflows/*.yml` | ❌ 否 | GitHub Actions |
| **变更记录** | `CHANGELOG.md` | ❌ 否 | 仓库内可见 |

**关键原则**：
- 用户**不**需要手动验证 → 验证是 AI 平台和 CI 的事
- 用户的"自动验证"靠 `core/main.md` 的"加载时自检"段（AI 透明执行）
- 开发者的验证靠 `scripts/lint-paths.sh`（本地 + CI 都用同一份）

### 当前目录结构

```
MyKnowledge/
├── 📄 入口与配置
│   ├── SKILL.md              # Skill 主入口
│   ├── _meta.json            # Skill Hub 元数据
│   └── settings.yaml         # 默认配置
│
├── 📁 core/                  # 核心功能
│   ├── main.md              # 主逻辑（每次加载）
│   └── templates/           # 文档模板
│
├── 📁 modules/              # 可选模块（懒加载）
│   ├── commands/            # 命令速查
│   │   └── main.md
│   ├── management/          # 需求管理
│   │   └── main.md
│   ├── error/               # 错误处理
│   │   └── main.md
│   └── silent/              # 静默模式
│       └── main.md
│
├── 📁 one-time/             # 一次性配置
│   ├── onboarding/          # 首次引导
│   │   └── main.md
│   └── setup/               # 安装源/平台/更新检测
│       ├── install-source.md
│       ├── platform-detector.md
│       └── update-checker.md
│
├── 📁 hooks/                # 平台 Hook
│   ├── openclaw/            # OpenClaw Hook
│   │   ├── HOOK.md
│   │   ├── handler.ts
│   │   └── hook-guide.md
│   └── claude/              # Claude Hook
│       ├── hooks.json
│       ├── handler.js
│       └── README.md
│
├── 📁 scripts/              # 开发者工具（不进 zip）
│   ├── build-skillhub.sh    # SkillHub 打包脚本
│   └── lint-paths.sh        # 路径一致性检查（门禁）
│
├── 📁 releases/            # 构建产物归档（不进 zip）
│
├── 📁 .github/              # CI 配置（不进 zip）
│   └── workflows/
│       └── release.yml      # GitHub Actions：tag 触发 release

└── 📁 test/                 # 测试套件（开发用，AI 忽略）
    ├── README.md
    ├── scenarios/           # 测试场景详细方案
    │   ├── skillhub-only.md
    │   ├── github-only.md
    │   └── cross-update.md
    └── fixtures/            # 测试模拟数据
        ├── mock-skill-state.yaml
        └── mock-install-source.yaml
```

### 目录结构说明

| 目录 | 用途 | 加载频率 |
|------|------|----------|
| `core/` | 核心功能 | 每次使用 |
| `modules/` | 可选功能 | 按需懒加载 |
| `one-time/` | 一次性配置 | 仅首次或特定场景 |
| `hooks/` | 平台集成 | OpenClaw/Claude 专用 |

---

## 核心设计原则

### 1. 懒加载（Lazy Loading）

```
首次使用:
  SKILL.md → 检测到无 skill-state.yaml
  → 加载 one-time/onboarding/main.md (~3K tokens)
  → 创建状态文件
  → 后续使用 core/main.md (~4.5K tokens)

正常使用:
  SKILL.md → 检测到 skill-state.yaml 存在
  → 直接加载 core/main.md
  → 遇到具体场景再懒加载 modules/*/main.md
```

**目的**：减少上下文占用， onboarding 只加载一次，模块按需加载。

### 2. 用户数据分离

```
Skill 文件（随更新替换）:
  ~/.codebuddy/skills/myknowledge/

用户数据（持久保留）:
  ~/.myknowledge/
  ├── config/
  │   ├── skill-state.yaml    # 用户配置
  │   └── install-source      # 安装源记录
  └── global/                 # 全局知识库
```

**目的**：Skill 更新时不丢失用户数据。

### 3. 安装源检测与适配

```
检测优先级:
  1. 环境变量 (SKILLHUB_INSTALL, CLAWHUB_INSTALL)
  2. 目录标记 (.clawhub/, .skillhub/, .git/)
  3. 用户确认

适配策略:
  - skillhub_web: 依赖 Skill Hub 通知
  - skillhub_cli: 提示 skillhub update 命令
  - github_clone: 提示 git pull
  - github_zip: 提示重新下载
```

---

## 文件职责说明

### 核心文件

| 文件 | 职责 | 加载时机 |
|------|------|----------|
| `core/main.md` | 主逻辑、命令分发、错误处理引用 | 每次使用 |
| `core/templates/*.md` | 文档生成模板 | 创建时 |
| `one-time/onboarding/main.md` | 首次引导流程 | 仅首次 |
| `one-time/setup/install-source.md` | 安装源检测与管理 | 询问/检测时 |
| `one-time/setup/platform-detector.md` | 平台自动检测 | 首次引导 |
| `one-time/setup/update-checker.md` | 更新检查策略 | 用户询问时 |
| `modules/commands/main.md` | 固定命令速查、同义词映射 | 用户问"能做什么"时 |
| `modules/management/main.md` | 需求查看、更新、归档、删除 | 操作 REQ 时 |
| `modules/error/main.md` | 错误分类、诊断清单、恢复步骤 | 报错时 |
| `modules/silent/main.md` | 复杂任务自动检测 | 触发静默时 |
| `hooks/openclaw/handler.ts` | OpenClaw 事件处理 | OpenClaw 平台 |
| `hooks/claude/handler.js` | Claude 事件处理 | Claude 平台 |
| `scripts/build-skillhub.sh` | SkillHub 打包脚本 | 发布时 |

---

## 开发规范

### 1. Prompt 编写规范

```markdown
# 文件头格式

---
name: xxx
description: |
  简短描述
  
  使用说明：
  1. 步骤一
  2. 步骤二
version: "1.0.0"
---

# 正文使用三级标题

## 主要功能

### 子功能一

具体说明...

### 子功能二

具体说明...
```

### 2. 配置变更规范

修改 `settings.yaml` 时需检查：
- [ ] 是否影响现有用户配置？
- [ ] 是否需要配置迁移逻辑？
- [ ] 是否在 `onboarding.md` 中同步说明？

### 3. 新增功能流程

```
1. 在 core/main.md 添加功能入口（保持精简，详细放模块）
2. 如需新模块，创建 modules/<name>/main.md
3. 如需模板，在 core/templates/ 创建
4. 更新 USAGE.md 或对应文档
5. 在 test/scenarios/ 添加测试用例
6. 更新 CHANGELOG.md
```

---

## 测试策略

### 测试金字塔

```
        /\
       /  \
      / E2E \          test/scenarios/cross-update.md
     /--------\
    / Integration \     test/scenarios/skillhub-only.md
   /--------------\
  /    Unit        \    test/fixtures/*.yaml
 /------------------\
```

### 关键测试场景

| 场景 | 测试文件 | 优先级 |
|------|----------|--------|
| 首次引导 | `skillhub-only.md` TC-SH-01 | P0 |
| 更新检查 | `github-only.md` TC-GH-04 | P0 |
| 源变更检测 | `cross-update.md` TC-CU-01 | P1 |
| 配置持久化 | `cross-update.md` TC-CU-06 | P1 |

---

## 发布流程

### 版本号规范（SemVer）

```
主版本.次版本.修订号
  1.   0.   0

- 主版本：不兼容的 API 变更
- 次版本：向下兼容的功能添加
- 修订号：向下兼容的问题修复
```

### 发布检查清单

- [ ] 版本号更新（`settings.yaml`, `_meta.json`, `SKILL.md` 等 10 个文件）
- [ ] CHANGELOG.md 更新
- [ ] `bash scripts/lint-paths.sh` 通过
- [ ] `bash scripts/build-skillhub.sh` 生成 zip 到 `releases/`
- [ ] `git tag vX.Y.Z && git push --tags`（触发 GitHub Actions）
- [ ] 确认 GitHub Release 创建成功
- [ ] Skill Hub 提交（如适用）

---

## 贡献指南

### 提交 Issue

请包含：
1. 平台（CodeBuddy/WorkBuddy/OpenClaw）
2. 安装方式（SkillHub/GitHub/手动）
3. 复现步骤
4. 期望行为 vs 实际行为

### 提交 PR

1. Fork 仓库
2. 创建功能分支：`feature/xxx` 或 `fix/xxx`
3. 提交变更
4. 确保测试通过
5. 提交 PR 并描述变更

---

## 路线图

### v1.1.x（已发布）
- [x] v1.1.1：命令速查 + 能力边界 + 错误兜底 + 文档对齐
- [x] v1.1.2：manifest + lint 路径一致性检查
- [x] v1.1.3：责任分层 + 加载时自检 + GitHub Actions
- [x] v1.1.4：Self-endorsement 防御 + 硬编码自检
- [x] v1.1.5：避坑指南 + 模板填写范例

### v1.2.0（未来）
- [ ] 关键词搜索
- [ ] 知识库备份/导出
- [ ] 与 Agent Team Skill 集成
- [ ] 需求优先级/标签/依赖

### 未来考虑
- [ ] ClawHub 官方支持
- [ ] 多语言支持
- [ ] 团队协作功能
- [ ] 可视化界面
- [ ] 云端同步

---

**最后更新**: 2026-06-10
