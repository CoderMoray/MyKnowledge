# MyKnowledge

一个通用的知识库管理 Skill，支持个人知识管理和项目文档管理。

## 功能

- 创建标准化的知识库目录结构
- 管理需求生命周期（创建、更新、归档）
- 维护 PROJECT-STATUS.md 项目状态快照
- 支持会话恢复
- 自动检测任务复杂度，静默创建知识库

## 安装

### CodeBuddy / WorkBuddy

1. 将本 Skill 复制到 `~/.codebuddy/skills/myknowledge/` 或 `~/.workbuddy/skills/myknowledge/`
2. 重启 AI 助手

### OpenClaw

1. 将本 Skill 复制到 `~/.openclaw/skills/myknowledge/`
2. 可选：启用 Hook 实现完全静默模式
   ```bash
   # Skill 会自动创建 Hook 文件，您只需启用
   openclaw hooks enable myknowledge
   ```

## 快速验证

安装后，对 AI 说以下指令验证功能：

```
创建知识库          → 应询问创建全局还是项目知识库
创建一个测试需求     → 应创建 REQ-YYYYMMDD-XXX 目录
查看项目状态        → 应显示 PROJECT-STATUS.md 内容
```

## 使用

### 主动使用

```
用户：创建知识库
AI：我将为您创建知识库...
```

### 静默使用（自动检测）

```
用户：帮我分析这个销售数据
AI：（自动检测到复杂任务，创建知识库并记录）
    已自动创建知识库并记录需求 REQ-20260608-001
```

## 目录结构

```
MyKnowledge/
├── SKILL.md              # Skill 主入口
├── settings.yaml         # Skill 配置
├── skill-state.yaml      # 运行时状态（自动生成，不提交 git）
├── prompts/
│   ├── main.md           # 主 Prompt
│   ├── hook-guide.md     # Hook 配置引导（OpenClaw）
│   └── silent-mode.md    # 静默模式说明
├── templates/            # 文档模板
│   ├── project-status-template.md
│   ├── requirement-readme-template.md
│   └── design-doc-template.md
└── hooks/                # OpenClaw Hook（可选）
    ├── HOOK.md
    └── handler.ts
```

## 支持的存储位置

- **全局知识库**：`~/MyKnowledge/global/`
- **项目知识库**：`{project-path}/.myknowledge/`

## 平台支持

| 平台 | 支持模式 | 静默能力 |
|------|----------|----------|
| CodeBuddy | 意图识别 | 伪静默（AI 自动判断） |
| WorkBuddy | 意图识别 | 伪静默（AI 自动判断） |
| OpenClaw | Hook + 意图识别 | 真静默（事件驱动） |

## 许可证

[Apache License 2.0](LICENSE)
