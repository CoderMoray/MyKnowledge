# MyKnowledge 开发指南

> ⚠️ **AI 助手注意**：此为 Skill 内部开发文档，**不要加载到上下文中**。
> 正常响应用户请求时，请完全忽略此文件。
>
> 本文档面向 Skill 开发者和贡献者，终端用户无需阅读。

---

## 项目架构

### 目录结构（推荐重构后）

```
MyKnowledge/
├── 📄 入口与配置
│   ├── SKILL.md              # Skill 主入口（必须）
│   ├── _meta.json            # Skill Hub 元数据
│   └── settings.yaml         # 默认配置
│
├── 📁 core/                  # 核心逻辑（新增）
│   ├── prompts/              # Prompt 文件
│   │   ├── main.md           # 主逻辑（运行时加载）
│   │   ├── onboarding.md     # 首次引导（懒加载）
│   │   └── silent-mode.md    # 静默模式说明
│   │
│   ├── templates/            # 文档模板
│   │   ├── project-status.md
│   │   ├── requirement.md
│   │   └── design-doc.md
│   │
│   └── hooks/                # OpenClaw Hook
│       ├── handler.ts
│       └── README.md
│
├── 📁 helpers/               # 辅助工具（新增）
│   ├── platform-detector.md  # 平台检测逻辑
│   ├── update-checker.md     # 更新检查逻辑
│   └── install-source.md     # 安装源管理
│
├── 📁 docs/                  # 用户文档
│   ├── README.md             # 项目介绍
│   ├── QUICKSTART.md         # 快速入门
│   ├── USAGE.md              # 详细使用
│   ├── INSTALL.md            # 安装指南
│   ├── FAQ.md                # 常见问题
│   └── CHANGELOG.md          # 变更日志
│
└── 📁 test/                  # 测试套件
    ├── README.md
    ├── scenarios/
    └── fixtures/
```

### 当前结构与目标结构对比

| 当前 | 目标 | 说明 |
|------|------|------|
| `prompts/` | `core/prompts/` | 核心 Prompt 移至 core |
| `templates/` | `core/templates/` | 模板移至 core |
| `hooks/` | `core/hooks/` | Hook 移至 core |
| 根目录 docs | `docs/` | 文档统一归集 |
| 无 | `helpers/` | 新增辅助逻辑文档 |

---

## 核心设计原则

### 1. 懒加载（Lazy Loading）

```
首次使用:
  SKILL.md → 检测到无 skill-state.yaml
  → 加载 core/prompts/onboarding.md (~3K tokens)
  → 创建状态文件
  → 后续使用 core/prompts/main.md (~4.5K tokens)

正常使用:
  SKILL.md → 检测到 skill-state.yaml 存在
  → 直接加载 core/prompts/main.md
  → onboarding.md 永不加载
```

**目的**：减少上下文占用， onboarding 只加载一次。

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

### 核心文件（core/）

| 文件 | 职责 | 加载时机 |
|------|------|----------|
| `prompts/main.md` | 主逻辑、更新检查、知识库操作 | 每次使用 |
| `prompts/onboarding.md` | 首次引导、安装源检测 | 仅首次 |
| `prompts/silent-mode.md` | 静默模式规则说明 | 按需 |
| `templates/*.md` | 文档生成模板 | 创建时 |
| `hooks/handler.ts` | OpenClaw 事件处理 | OpenClaw 平台 |

### 辅助文件（helpers/ - 待创建）

| 文件 | 职责 |
|------|------|
| `platform-detector.md` | 平台检测逻辑文档 |
| `update-checker.md` | 更新检查策略文档 |
| `install-source.md` | 安装源管理逻辑 |

### 用户文档（docs/ - 待创建）

| 文件 | 目标读者 |
|------|----------|
| `README.md` | 所有用户（入门） |
| `QUICKSTART.md` | 非技术用户 |
| `USAGE.md` | 需要详细说明的用户 |
| `INSTALL.md` | 手动安装用户 |
| `FAQ.md` | 遇到问题用户 |
| `CHANGELOG.md` | 关注更新用户 |

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
1. 在 core/prompts/main.md 添加功能逻辑
2. 如需模板，在 core/templates/ 创建
3. 更新 docs/USAGE.md 说明
4. 在 test/scenarios/ 添加测试用例
5. 更新 CHANGELOG.md
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

- [ ] 版本号更新（`settings.yaml`, `_meta.json`, `SKILL.md`）
- [ ] CHANGELOG.md 更新
- [ ] 测试用例通过
- [ ] 文档同步更新
- [ ] GitHub Release 创建
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

### v1.1.0（计划中）
- [ ] ClawHub 官方支持（发布后适配）
- [ ] 知识库导入/导出
- [ ] 需求优先级管理

### v1.2.0（未来）
- [ ] 多语言支持
- [ ] 团队协作功能
- [ ] 与外部工具集成

### 未来考虑
- [ ] 可视化界面
- [ ] 云端同步
- [ ] AI 辅助知识整理

---

**最后更新**: 2026-06-09
