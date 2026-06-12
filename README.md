<p align="center">
  <img src="https://img.shields.io/badge/version-1.4.3-blue" alt="Version" />
  <img src="https://img.shields.io/badge/license-Apache%202.0-green" alt="License" />
  <a href="https://github.com/CoderMoray/MyKnowledge"><img src="https://img.shields.io/badge/GitHub-CoderMoray-black?logo=github" alt="GitHub" /></a>
</p>

<h1 align="center">MyKnowledge</h1>

<p align="center">一个通用的 AI 知识库管理 Skill<br/>让 AI 助手帮你自动整理知识、跟踪需求、记录进度</p>

---

## 📖 5 分钟上手指南

| 我想... | 看这里 |
|---------|--------|
| 快速安装 | → [🚀 快速开始](#-快速开始) |
| 了解能做什么/不能做什么 | → [✨ 核心特性](#-核心特性) + [⚠️ 能力边界](#️-能力边界) |
| 学会常用命令 | → [QUICKSTART.md](QUICKSTART.md) |
| 遇到问题 | → [FAQ.md](FAQ.md) 或 [docs/PITFALLS.md](docs/PITFALLS.md) |
| 深入了解 / 进阶技巧 | → [USAGE.md](USAGE.md) 或 [💡 高手技巧](#-高手技巧) |

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

| 指标 | v1.0.0 | v1.4.3 | 变化 |
|------|--------|--------|------|
| 主模块代码量 | 387 行 | **~250 行** | 🔻 -35% |
| 日常上下文占用 | ~9K tokens | **~5K tokens** | 🔻 -44% |
| 冗余加载开销 | 全量预加载 | **懒加载** | 🔻 节省 40%+ |
| 错误处理 | 分散描述 | **表格化 + 兜底** | ✅ 查找更快 |
| 平台支持 | 3 个 | **4 个**（+Claude）| ✅ 更广 |
| 自动化验证 | 无 | **lint 门禁 + 加载时自检** | 🛡️ 新增 |

> 基于 Prompt 行数和 Token 占用估算，实际效果因模型而异。

## 🚀 快速开始

### 方式一：通过 SkillHub 安装（推荐，无需 GitHub）

对 AI 说一句话即可：
```
安装 my-knowledge 技能
```

> 💡 **更新也一样**：对 AI 说"检查 MyKnowledge 更新"，或直接重新说"安装 my-knowledge 技能"即可覆盖为新版。**用户数据不会丢失。**

### 方式二：Git 下载（备选，需要终端）

```bash
# 国内用户推荐 Atomgit
git clone https://atomgit.com/CoderMoray/MyKnowledge.git ~/.codebuddy/skills/myknowledge/

# 或使用 GitHub
git clone https://github.com/CoderMoray/MyKnowledge.git ~/.codebuddy/skills/myknowledge/
```

> 其他平台替换路径：WorkBuddy → `~/.workbuddy/skills/myknowledge/`，OpenClaw → `~/.openclaw/skills/myknowledge/`，Claude → `~/.claude/plugins/myknowledge/`

---

### ✅ 安装后验证

```
创建知识库          → 自动创建到全局知识库
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

### 场景 4：导出/分享

```
你：导出项目「销售分析」
AI：📦 已导出 → ~/Downloads/myknowledge-export-销售分析.zip
   对方导入后即可恢复完整项目状态

你：导入知识库
AI：解压到全局知识库 → 同名项目提供覆盖/重命名/对比选项
```

## 🆕 版本更新

### [v1.4.0] - 2026-06-12 — 一键导出/分享

- 📦 **导出知识库**：打包为 zip（含项目状态 + 安装引导），默认保存到下载文件夹
- 📥 **导入知识库**：支持同名项目冲突处理（覆盖/重命名/对比）
- 🔧 **版本号一致性修复** + lint 增强
- 🌏 **Atomgit 国内镜像**：安装引导新增国内加速地址

### [v1.3.0] - 2026-06-11 — UX 优化 7 项

- 🎯 引导流程标注泄漏修复 + 欢迎语自动跳过 + 选项 1/2 简化
- 📁 知识库默认全局，不再每次询问类型
- 🔄 旧版跨源升级自动迁移

### [v1.1.17] - 2026-06-11 — 规则统一 + 误解消除

- 🗣️ **"没有自动修复" → 恢复极简单**：一句话恢复，不丢数据
- 📋 **静默触发规则统一**：4 个文件关键词列表对齐，不再不一致
- 📖 **FAQ 增加具体示例**：静默触发对比表 + 反模式效果对比表

### [v1.1.15] - 2026-06-11 — skillhub 命令修正

- 🔧 **`skillhub update` → `skillhub upgrade`**：基于实测纠正
- 📡 **删除"自动通知"**：SkillHub 平台无通知功能，改为"重新安装"指引
- 🧹 **波及修正**：README/INSTALL/DEVELOPMENT/测试场景同步更新

### [v1.1.14] - 2026-06-11 — AI 回复自足性增强

- 🗣️ **错误提示自足化**：AI 直接给答案，不让用户对照文档

### [v1.1.13] - 2026-06-11 — 安全设计文档化 + 错误提示自足化

- 🛡️ **"不自动重试"原因说明**：非 bug，是安全边界
- 🗣️ **错误提示自足化**：AI 直接给答案，不让用户对照文档；15 条提示全部通俗化
- 📋 **路线图更新**：v1.2.0 规划"一键导出/分享"功能

### [v1.1.12] - 2026-06-11 — 用户文档随 Skill 分发

- 📦 **FAQ + 避坑指南进 zip**：用户安装后本地即可查阅，无需跳转 GitHub
- 📋 **SKILL.md 新增用户支持章节**：AI 知道何时引导用户查看 FAQ/PITFALLS
- 🔧 **打包脚本同步更新**：build-skillhub.sh 自动包含 FAQ.md + docs/PITFALLS.md

### [v1.1.11] - 2026-06-11 — 措辞优化版

- 🗣️ **文档措辞优化**：PITFALLS 灵敏度描述优化，error/main 错误分类精简
- 📖 **导航增强**：README 导航表新增"进阶技巧"入口
- 🎯 **FAQ 措辞软化**：微调技巧描述更友好

### [v1.1.10] - 2026-06-10 — 用户体验优化版

- 📖 **安装流程简化**：GitHub 方式简化为一行命令，突出 SkillHub 无需终端
- 📚 **FAQ 增强**：新增反模式（5 条）+ 多项目管理 + 数据备份 + 进阶技巧（6 条）
- 💡 **README 高手技巧**：一键切换项目、AI 写周报、git 管理知识库
- 📋 **避坑指南扩展**：17 → 20 坑（项目切换、模板使用、git 管理）

### [v1.1.9] - 2026-06-10 — 文档导航优化版

- 📖 **README 导航增强**：顶部"5 分钟上手"导航表
- 📚 **文档底部统一引导**：QUICKSTART/USAGE 底部 FAQ/PITFALLS 链接

### [v1.1.8] - 2026-06-10 — 版本号修复版

- 🐛 **README 版本号同步**：6 处版本号修复
- 🛡️ **Lint 第 7 项检查**：README 版本号自动验证

### [v1.1.7] - 2026-06-10 — 安全审计版

- 🛡️ **安全评分 98+**：修复 3 项安全扣分（chmod 引导、console.log 脱敏、测试警告）

### [v1.1.5] - 2026-06-10 — 用户文档版

- 📚 **避坑指南**：17 个真实使用坑 + 3 个模板填写范例
- 🔗 **文档交叉引用**：README/FAQ 链接 PITFALLS

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

## 💡 高手技巧

> 熟悉基础用法后，这些技巧能让你效率翻倍。

### 一键切换项目
```
cd ~/project-a && 对 AI 说"项目进展如何"  → 看项目A
cd ~/project-b && 对 AI 说"项目进展如何"  → 看项目B
```
知识库自动跟随当前目录，无需手动切换。

### 让 AI 帮你写周报
```
把本周完成的 3 个需求总结成周报要点
把过去一周 PROJECT-STATUS.md 的变更汇总成进展报告
```

### git 管理知识库
```bash
cd ~/.myknowledge
git init && git add . && git commit -m "初始化知识库"
# 记得 .gitignore 排除 config/ 目录（含平台特定配置）
```

### 自定义静默检测
编辑 `settings.yaml`，调整检测灵敏度以匹配你的工作风格，添加常用任务关键词。

### 更多技巧
→ [USAGE.md 进阶使用](USAGE.md#进阶使用) | [FAQ.md 进阶使用](FAQ.md#进阶使用) | [PITFALLS 进阶使用](docs/PITFALLS.md#进阶使用)

---

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
