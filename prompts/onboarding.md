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

---

### 步骤 2：检测安装源

**自动检测逻辑**：

```bash
检测顺序：
1. 检查环境变量
   - SKILLHUB_INSTALL=true → skillhub_web
   - SKILLHUB_CLI_INSTALL=true → skillhub_cli
   - CLAWHUB_INSTALL=true → clawhub

2. 检查目录特征
   - .skillhub 目录存在 → skillhub_web
   - .clawhub 目录存在 → clawhub
   - .git 目录存在 → github_clone

3. 询问用户确认
   "请问你是如何安装本 Skill 的？"
   [Skill Hub 网页/插件] 
   [SkillHub CLI 命令行]
   [ClawHub]
   [GitHub ZIP 下载]
   [GitHub git clone]
   [手动复制]
```

**保存安装源信息**：

创建 `~/.myknowledge/config/install-source`：

```yaml
source: "skillhub_web"  # 用户选择的安装源
detected_by: "env_var"  # 检测方式：env_var / dir / user_input
installed_at: "2026-06-09"
installed_version: "1.0.0"
skill_path: "~/.codebuddy/skills/myknowledge"  # 实际安装路径
```

**根据安装源显示不同提示**：

```
IF source == "skillhub_web":
   "✅ 通过 Skill Hub 安装，更新时会自动通知你"

IF source == "skillhub_cli":
   "📌 通过 SkillHub CLI 安装"
   "更新方式：运行 skillhub update myknowledge"

IF source == "clawhub":
   "📌 通过 ClawHub 安装"
   "更新方式：运行 clawhub update myknowledge"

IF source == "github_zip":
   "📌 通过 GitHub ZIP 安装"
   "更新方式：重新下载最新 ZIP 并替换"

IF source == "github_clone":
   "📌 通过 GitHub git clone 安装"
   "更新方式：cd 到目录运行 git pull"

IF source == "manual":
   "📌 手动安装"
   "更新方式：关注 https://github.com/CoderMoray/MyKnowledge/releases"
```

---

### 步骤 3：平台确认

```
你使用什么 AI 助手？
[CodeBuddy] [WorkBuddy] [OpenClaw] [其他]

（检测目录：~/.codebuddy/, ~/.workbuddy/, ~/.openclaw/）
```

---

### 步骤 4：自动记录设置

```
是否开启「自动记录」？

当你说的事情比较复杂时（如"分析数据"），
我会自动帮你创建记录。

[开启] - 自动记录（推荐）
[关闭] - 手动控制

💡 随时可以说"开启/关闭自动记录"修改
```

---

### 步骤 5：新手实操（可选但推荐）

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

---

### 步骤 6：保存配置

**创建用户数据目录结构**：

```
~/.myknowledge/
├── config/
│   ├── install-source      # 安装源信息
│   ├── skill-state.yaml    # 用户配置和状态
│   └── version             # 当前版本
└── global/                 # 全局知识库（如用户选择创建）
    └── ...
```

**skill-state.yaml 内容**：

```yaml
initialized: true
platform: "codebuddy"           # 用户平台
auto_record: true               # 自动记录开关
onboarding_completed: true      # 引导完成标记
first_use: "2026-06-09"
version: "1.0.0"

# 更新检查配置（根据安装源设置）
update_check:
  source: "skillhub_web"        # 安装源
  last_check: ""                # 上次检查时间
  next_check: ""                # 下次检查时间
```

---

### 步骤 7：结束语

```
🎉 设置完成！记住这 3 句话：
• "创建知识库" - 开始新项目
• "项目进展如何？" - 查看状态
• "继续之前的项目" - 恢复工作

✅ 引导已完成，下次不再显示
💡 详细参考：QUICKSTART.md

📦 你的安装方式：{install_source}
   更新方法：{update_method}

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
