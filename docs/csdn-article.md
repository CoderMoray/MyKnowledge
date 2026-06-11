# MyKnowledge：让你的 AI 编程助手不再"失忆"——一个开源的知识库管理 Skill

> 周一让 AI 分析了销售数据，周五再问它却什么都不记得了？  
> 项目需求散落在几十个对话里，想找个上周的决定要翻半天？  
> 这个开源工具帮你解决。

---

## 🤔 AI 编程助手的"失忆症"

如果你用过 CodeBuddy、Claude Code 这类 AI 编程助手，一定有过这种体验：

```
周一：帮我分析一下 Q2 的销售数据，找出增长最快的区域
AI：好的，分析完成！华东区增长 23%，华南区增长 18%...

周五：上周分析的那个销售数据，华东区具体增长了几个点？
AI：抱歉，我无法访问之前的对话记录...
```

**AI 助手不会帮你记东西。** 每次对话都是独立的，需求、进度、设计决策全部散落在不同的会话里。项目越复杂，这个问题越严重。

## 💡 解决方案：MyKnowledge

[MyKnowledge](https://github.com/CoderMoray/MyKnowledge) 是一个开源的 AI Skill，让 AI 助手变身你的项目知识管家。

它的核心能力就三条：

| 能力 | 说明 |
|------|------|
| 📁 **自动建知识库** | 检测到复杂任务时，自动创建结构化的项目文档 |
| 📋 **需求生命周期** | 从创建 → 进行中 → 审核 → 完成 → 归档，全程跟踪 |
| 🔄 **跨会话记忆** | 关闭对话再打开，AI 能直接恢复上次的项目状态 |

### 实际效果

```
你：继续之前的销售分析项目
AI：（自动读取 PROJECT-STATUS.md）
    当前项目：Q2 区域销售分析
    活跃需求：
    • REQ-20260611-001 数据分析 - 已完成
    • REQ-20260611-002 报告生成 - 进行中
    上次你让我把图表改成柱状图，还没改完，要继续吗？
```

**所有信息都存在本地 Markdown 文件里**，不依赖云端，不担心隐私。

---

## 🚀 1 分钟安装

### 方式一：SkillHub（推荐，零命令行）

对 AI 直接说：

```
安装 my-knowledge 技能
```

### 方式二：Git 克隆

```bash
# GitHub（国际）
git clone git@github.com:CoderMoray/MyKnowledge.git ~/.codebuddy/skills/myknowledge/

# AtomGit（国内，速度更快）
git clone https://atomgit.com/CoderMoray/MyKnowledge.git ~/.codebuddy/skills/myknowledge/
```

> 支持平台：CodeBuddy / WorkBuddy / OpenClaw / Claude

---

## 🧠 它怎么工作的？

MyKnowledge 本质上是一套 **Prompt 工程 + 文件模板**，没有外部依赖，不调用 API：

```
用户发消息
    ↓
AI 加载 MyKnowledge Skill（~5K tokens）
    ↓
检测任务复杂度（关键词匹配：分析、统计、开发、设计...）
    ↓
简单任务 → 正常对话
复杂任务 → 自动创建知识库 + 记录需求
    ↓
后续对话自动恢复上下文
```

### 懒加载架构

日常对话只加载核心模块（~5K tokens），相比 v1.0.0 的 ~9K tokens 减少了 44%。用到具体功能时才按需加载命令速查、需求管理、错误处理等模块。

### 数据安全

- 所有知识库文件存在本地 `~/.myknowledge/`
- Skill 更新**不会**触碰用户数据
- 你可以用 git 管理知识库，随时备份

---

## 📊 已经迭代了 16 个版本

从 v1.0.0 到 v1.1.16，持续打磨：

| 版本 | 亮点 |
|------|------|
| v1.1.0 | 懒加载架构，Token 占用减半 |
| v1.1.3 | GitHub Actions 自动化发布 |
| v1.1.7 | 安全审计评分 98+ |
| v1.1.10 | 20 个避坑指南 + 高手技巧 |
| v1.1.16 | 规则统一 + 体验消除误解 |

---

## 🔗 链接

- **GitHub**：[github.com/CoderMoray/MyKnowledge](https://github.com/CoderMoray/MyKnowledge)
- **AtomGit（国内镜像）**：[atomgit.com/CoderMoray/MyKnowledge](https://atomgit.com/CoderMoray/MyKnowledge)
- **许可证**：Apache 2.0

---

## 📝 适合谁用？

- ✅ 用 AI 编程助手做项目的开发者
- ✅ 需要跟踪多个需求/任务的独立开发者
- ✅ 想用 Markdown 管理项目知识的人
- ❌ 需要多人实时协作（请用 Notion/Confluence）
- ❌ 需要富文本编辑（请用 Typora/Obsidian）

---

**如果你也觉得 AI 助手"记性不好"，试试 MyKnowledge。**  
有问题欢迎提 Issue，觉得有用就点个 Star ⭐！
