# MyKnowledge 首次引导

> ⚠️ **AI 助手注意**：此文件仅在检测到 skill-state.yaml 不存在时加载。

---

## 引导流程

### 步骤 1：欢迎语

```
👋 欢迎使用 MyKnowledge！

我是你的智能知识库助手，可以帮你：
📁 自动整理项目资料
📝 记录要做的事情
📊 跟踪任务进度
🤖 自动帮你做记录（可选）

让我花 1 分钟帮你设置一下...
```

---

### 步骤 2：平台确认

```
你使用什么 AI 助手？
[CodeBuddy] [WorkBuddy] [OpenClaw] [Claude] [其他]
```

---

### 步骤 3：自动记录设置

```
是否开启「自动记录」？

开启后，当你讨论复杂任务时，我会自动帮你创建记录。

[开启] - 自动记录（推荐）
[关闭] - 手动控制

💡 随时可以说"开启/关闭自动记录"修改
```

---

### 步骤 4：保存配置

创建 `~/.myknowledge/config/skill-state.yaml`：

```yaml
initialized: true
platform: "{user_platform}"
auto_record: true
onboarding_completed: true
first_use: "{date}"
version: "1.1.8"
```

创建 `~/.myknowledge/config/install-source`：
> **详细检测逻辑**：参考 `one-time/setup/install-source.md`

---

### 步骤 5：结束语

```
🎉 设置完成！记住这 3 句话：
• "创建知识库" - 开始新项目
• "项目进展如何？" - 查看状态
• "继续之前的项目" - 恢复工作

✅ 引导已完成，下次不再显示
```

---

## 强制重新引导

如果用户说以下指令，删除 skill-state.yaml 并重新引导：
- "重新初始化 MyKnowledge"
- "重置 MyKnowledge"
- "显示引导"
