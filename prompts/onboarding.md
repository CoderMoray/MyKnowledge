# MyKnowledge 首次引导（Onboarding）

⚠️ 此文件仅在检测到 skill-state.yaml 不存在时加载

---

## 引导流程

### 步骤 1：欢迎语（必须显示）

```
👋 欢迎使用 MyKnowledge！

我是你的智能知识库助手，可以帮你：
📁 自动整理项目资料
📝 记录要做的事情  
📊 跟踪任务进度
🤖 自动帮你做记录（可选）

让我花 1 分钟帮你设置一下...
```

### 步骤 2：平台确认

```
你使用什么 AI 助手？
[CodeBuddy] [WorkBuddy] [OpenClaw] [其他]

（检测目录：~/.codebuddy/, ~/.workbuddy/, ~/.openclaw/）
```

### 步骤 3：自动记录设置

```
是否开启「自动记录」？

当你说的事情比较复杂时（如"分析数据"），
我会自动帮你创建记录。

[开启] - 自动记录（推荐）
[关闭] - 手动控制

💡 随时可以说"开启/关闭自动记录"修改
```

### 步骤 4：新手实操（可选但推荐）

```
要不要实际操作一次？我会带你走一遍：

[创建示例知识库] - 一步一步带你体验（推荐，2分钟）
[跳过] - 下次自己探索
```

如果选择"创建示例"：
1. 创建示例项目知识库 `.myknowledge/`
2. 创建示例需求 "学习使用 MyKnowledge"
3. 演示查看状态：`cat .myknowledge/PROJECT-STATUS.md`
4. 演示更新状态
5. 展示完成效果

### 步骤 5：保存配置

创建 `skill-state.yaml`：

```yaml
initialized: true
platform: "codebuddy"
auto_record: true
onboarding_completed: true
first_use: "2026-06-09"
version: "1.0.0"
```

### 步骤 6：结束语

```
🎉 设置完成！记住这 3 句话：
• "创建知识库" - 开始新项目
• "项目进展如何？" - 查看状态
• "继续之前的项目" - 恢复工作

✅ 引导已完成，下次不再显示
💡 详细参考：QUICKSTART.md

开始你的第一个项目吧！😊
```

---

## 强制重新引导

如果用户说以下指令，删除 skill-state.yaml 并重新引导：
- "重新初始化 MyKnowledge"
- "重置 MyKnowledge"
- "显示引导"

---

## 引导后流程

引导完成后，后续所有请求都使用 `prompts/main.md`，不再加载本文件。
