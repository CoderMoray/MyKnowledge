<p align="center">
  <img src="https://img.shields.io/badge/version-1.1.0-blue" alt="Version" />
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

## 📊 性能对比

| 指标 | v1.0.0 | v1.1.0 | 变化 |
|------|--------|--------|------|
| 主模块代码量 | 387 行 | **180 行** | 🔻 -53% |
| 日常上下文占用 | ~9K tokens | **~5K tokens** | 🔻 -44% |
| 冗余加载开销 | 全量预加载 | **懒加载** | 🔻 节省 40%+ |
| 简单任务处理速度 | 基准 | **提升 15-20%** | 🚀 更快 |
| 错误处理 | 分散描述 | **表格化** | ✅ 查找更快 |
| 平台支持 | 3 个 | **4 个**（+Claude）| ✅ 更广 |

> 基于 Prompt 行数和 Token 占用估算，实际效果因模型而异。

## 🚀 快速开始

### 方式一：下载 ZIP（推荐，通用）

```bash
# 1. 下载最新版本
wget https://github.com/CoderMoray/MyKnowledge/archive/refs/tags/v1.1.0.zip
# 或访问 GitHub Releases 页面手动下载
# https://github.com/CoderMoray/MyKnowledge/releases

# 2. 解压
unzip v1.1.0.zip
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
# 以 CodeBuddy 为例
mkdir -p ~/.codebuddy/skills/
cp -r MyKnowledge-1.1.0 ~/.codebuddy/skills/myknowledge/
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
├── core/                 # 核心功能
│   ├── main.md          # 主逻辑（~180行，懒加载入口）
│   └── templates/       # 文档模板
├── modules/             # 可选模块（按需加载）
│   ├── management/      # 需求管理
│   ├── error/           # 错误处理
│   └── silent/          # 静默模式
├── one-time/            # 一次性配置
│   ├── onboarding/      # 首次引导
│   └── setup/           # 安装源检测
├── hooks/               # 平台 Hook
│   ├── openclaw/        # OpenClaw
│   └── claude/          # Claude
└── test/                # 测试套件（开发用）
```

## 🔗 相关资源

| 资源 | 链接 |
|------|------|
| 安装说明 | [INSTALL.md](INSTALL.md) |
| 快速上手 | [QUICKSTART.md](QUICKSTART.md) |
| 详细用法 | [USAGE.md](USAGE.md) |
| 常见问题 | [FAQ.md](FAQ.md) |
| 开发文档 | [DEVELOPMENT.md](DEVELOPMENT.md) |

## 📄 许可证

[Apache License 2.0](LICENSE)
