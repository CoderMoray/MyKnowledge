<p align="center">
  <img src="https://img.shields.io/badge/version-1.1.8-blue" alt="Version" />
  <img src="https://img.shields.io/badge/license-Apache%202.0-green" alt="License" />
  <a href="https://github.com/CoderMoray/MyKnowledge"><img src="https://img.shields.io/badge/GitHub-CoderMoray-black?logo=github" alt="GitHub" /></a>
</p>

<h1 align="center">MyKnowledge</h1>

<p align="center">一个通用的 AI 知识库管理 Skill<br/>让 AI 助手帮你自动整理知识、跟踪需求、记录进度</p>

---

## ✨ 核心特性

| 特性 | 说明 |
|------|------|
| 📁 **标准化知识库** | 一键创建目录结构（全局 / 项目级别） |
| 📋 **需求生命周期** | 创建 → 进行中 → 审核 → 完成 → 归档 |
| 🤖 **智能静默模式** | 检测复杂任务，自动创建记录（可选） |
| 💬 **会话自动记录** | 对话内容自动追加到对应需求文档 |
| 🔀 **多平台支持** | CodeBuddy / WorkBuddy / OpenClaw / Claude |

---

## ⚠️ 能力边界（本 Skill 不做什么）

为了让你用得放心，这里**明确**说清楚本 Skill 的边界：

| 不做的事 | 原因 / 替代方案 |
|----------|----------------|
| ❌ 联网 / 云端同步 | 本地文件管理；需要同步请用 git |
| ❌ 多用户实时协作 | 单机文件；团队请用 Notion / Confluence |
| ❌ 富文本 / 所见即所得编辑 | Markdown 优先；需要 WYSIWYG 请用 Typora |
| ❌ 自动备份到云端 | 手动 cp -r 或 git commit 即可 |
| ❌ 修改 `~/.myknowledge/` 之外的文件 | 严格沙箱，保护你的数据 |
| ❌ 执行任意 shell 命令 | 不在 Skill 职责内，避免误操作 |
| ❌ 跨平台配置同步 | 每个平台独立安装（轻量级） |

**如果你需要以上能力**——本 Skill 不是合适工具，请选择专业产品。

---

## 📊 性能对比

| 指标 | v1.0.0 | v1.1.8 | 变化 |
|------|--------|--------|------|
| 主模块代码量 | 387 行 | **~250 行** | 🔻 -35% |
| 日常上下文占用 | ~9K tokens | **~5K tokens** | 🔻 -44% |
| 冗余加载开销 | 全量预加载 | **懒加载** | 🔻 节省 40%+ |
| 错误处理 | 分散描述 | **表格化 + 兜底** | ✅ 查找更快 |
| 平台支持 | 3 个 | **4 个**（+Claude）| ✅ 更广 |
| 自动化验证 | 无 | **lint 门禁 + 加载时自检** | 🛡️ 新增 |

> 基于 Prompt 行数和 Token 占用估算，实际效果因模型而异。

## 🚀 快速开始

### 方式一：下载 ZIP（推荐，通用）

```bash
# 1. 下载最新版本（访问 GitHub Releases 获取最新版本号）
# https://github.com/CoderMoray/MyKnowledge/releases

# 2. 解压（以 v1.1.8 为例）
wget https://github.com/CoderMoray/MyKnowledge/archive/refs/tags/v1.1.8.zip
unzip v1.1.8.zip
```

### 方式二：按平台安装

根据你的 AI 助手，将解压后的文件夹复制到对应位置：

| 平台 | 安装路径 |
|------|----------|
| CodeBuddy | `~/.codebuddy/skills/myknowledge/` |
| WorkBuddy | `~/.workbuddy/skills/myknowledge/` |
| OpenClaw | `~/.openclaw/skills/myknowledge/` |
| Claude | `~/.claude/plugins/myknowledge/` |

```bash
# 以 CodeBuddy 为例（将 X.Y.Z 替换为实际版本号）
mkdir -p ~/.codebuddy/skills/
cp -r MyKnowledge-1.1.8 ~/.codebuddy/skills/myknowledge/
```

### 方式三：通过 SkillHub

对支持 SkillHub 的 AI 助手说：
```
安装 my-knowledge 技能
```

---

### ✅ 安装后验证

```
创建知识库          → 应询问创建全局还是项目知识库
创建一个测试需求     → 应创建 REQ-YYYYMMDD-XXX 目录
查看项目状态        → 应显示 PROJECT-STATUS.md 内容
```

## 💡 使用场景

### 场景 1：主动使用

```
你：创建知识库
AI：我将为您创建知识库...（询问类型 → 生成结构）
```

### 场景 2：静默模式（推荐）

```
你：帮我分析这个销售数据
AI：（检测到复杂任务）
   已自动创建知识库并记录需求 REQ-20260608-001
```

### 场景 3：项目状态追踪

```
你：项目进展如何？
AI：（读取 PROJECT-STATUS.md）
   当前有 3 个活跃需求：
   • REQ-001 数据分析 - 进行中
   • REQ-002 报告生成 - 待审核
   • REQ-003 文档整理 - 已完成
```

## 🆕 版本更新

### [v1.1.4] - 2026-06-10 — 自检防护版

- 🛡️ **加载时自检**：AI 加载 Skill 时自动检查文件完整性（不依赖 manifest）
- 🛡️ **Self-Endorsement 防御**：manifest 加免责声明，提醒平台独立验证
- 📋 **近期更新**：CHANGELOG 累计 4 个小版本改进

### [v1.1.3] - 2026-06-10 — 责任分层版

- 🏗️ **责任重新划分**：用户不需手动验证（AI 自动 + CI 自动化）
- 🤖 **加载时自检**：core/main.md 加自检段（AI 透明执行）
- 🔧 **GitHub Actions**：推 tag 自动跑 lint + 打 zip + 发 release

### [v1.1.2] - 2026-06-10 — 自动化质量保障版

- 🛡️ **`manifest.json`**：路径真理来源（机器可读元数据）
- 🛡️ **`scripts/lint-paths.sh`**：6 项路径一致性自动检查
- 🚦 **发布门禁**：build-skillhub.sh 集成 lint，失败则阻止打包

### [v1.1.1] - 2026-06-10 — 用户体验优化版

- ⚡ **命令速查模块**：`modules/commands/main.md`（13 条固定命令 + 同义词映射）
- 📋 **能力边界**：README + core/main.md 双写（用户侧 + AI 侧）
- 🐛 **错误处理兜底**：未列举错误的回退方案

### [v1.1.0] - 2026-06-10 — 架构优化版

- ⚡ **懒加载架构**：核心模块按需加载，日常对话更轻快
- 📦 **目录重组**：core/modules/one-time/hooks 分层结构
- 🐛 **错误处理表格化**：统一错误码 + 解决方案
- 🤖 **新增 Claude 支持**

[查看完整变更日志 →](CHANGELOG.md)

## 📂 目录结构

```
MyKnowledge/
├── SKILL.md              # Skill 主入口（AI 执行指令）
├── settings.yaml         # Skill 配置
├── _meta.json            # Skill Hub 元数据
├── manifest.json         # 路径清单（用户级元数据，含免责声明）
├── core/                 # 核心功能
│   ├── main.md          # 主逻辑（懒加载入口，含加载时自检）
│   └── templates/       # 文档模板
├── modules/             # 可选模块（按需加载）
│   ├── commands/        # 命令速查（v1.1.1+）
│   ├── management/      # 需求管理
│   ├── error/           # 错误处理
│   └── silent/          # 静默模式
├── one-time/            # 一次性配置
│   ├── onboarding/      # 首次引导
│   └── setup/           # 安装源/平台/更新检测
└── hooks/               # 平台 Hook
    ├── openclaw/        # OpenClaw
    └── claude/          # Claude

开发者专用（不进 SkillHub zip）：
├── scripts/             # build-skillhub.sh、lint-paths.sh
├── test/                # 测试套件
└── .github/             # CI 配置
```

## 🔗 相关资源

| 资源 | 链接 |
|------|------|
| 安装说明 | [INSTALL.md](INSTALL.md) |
| 快速上手 | [QUICKSTART.md](QUICKSTART.md) |
| 详细用法 | [USAGE.md](USAGE.md) |
| 常见问题 | [FAQ.md](FAQ.md) |
| 避坑指南 | [docs/PITFALLS.md](docs/PITFALLS.md) |
| 开发文档 | [DEVELOPMENT.md](DEVELOPMENT.md) |

## 📄 许可证

[Apache License 2.0](LICENSE)
