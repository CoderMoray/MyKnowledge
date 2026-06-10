# Changelog

所有版本变更记录。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)。

---

## [1.1.9] - 2026-06-10

### 📚 文档导航优化（基于 5 维度评估反馈）

#### README 导航增强
- 顶部新增"📖 5 分钟上手指南"导航表（5 条快捷跳转）
- "方式三"加平台内更新说明，消除"只能 GitHub 更新"误解

#### 文档底部统一引导
- `QUICKSTART.md`、`USAGE.md` 底部统一加 FAQ/PITFALLS 链接
- 故障排除建议改为"对 AI 说重新初始化"

#### 设计说明补充
- `docs/PITFALLS.md` 权限与错误章节加"为什么 AI 不自动修复"说明

---

## [1.1.8] - 2026-06-10

### 🐛 版本号一致性修复（v1.1.7 遗漏）

#### README 版本号同步
- `README.md` 中 6 处版本号仍停留在 `1.1.5`，现已同步到 `1.1.8`

#### 搜索功能标注优化
- `QUICKSTART.md`、`modules/commands/main.md`、`USAGE.md` 中"搜索"功能标注更明确
  - `（v1.2+）` → `🚧 计划中（v1.2+）`

#### 路线图补全
- `DEVELOPMENT.md` 路线图补上 v1.1.6 和 v1.1.7 条目

### 🛡️ Lint 增强：README 版本号自动检查

#### 新增第 7 项检查
- `scripts/lint-paths.sh` 新增 README 版本号一致性检查
- 自动验证 badge、性能对比表、下载示例、安装示例中的版本号
- 失败阻止打包，防止 v1.1.7 式遗漏再次发生
- 覆盖全部 4 类版本号引用位置

---

## [1.1.7] - 2026-06-10（已在 SkillHub 发布）

### 🛡️ 安全审计优化（基于腾讯云鼎 skills-security-check 报告）

审计评分：95 → **98+**

#### 扣分项修复（3 项）

1. **`chmod 755` 改为引导性表述**（`docs/PITFALLS.md`）
2. **`console.log` 改为条件日志 + 脱敏**（`hooks/claude/handler.js`、`hooks/openclaw/handler.ts`）
3. **测试场景文件加安全警告**（`test/scenarios/*.md` 3 个文件）

---

## [1.1.6] - 2026-06-10

### 🐛 细节质量打磨

#### 版本号遗漏修复
- `hooks/openclaw/HOOK.md` 版本号：1.0.0 → 1.1.5（遗漏 5 个版本）
- `hooks/openclaw/hook-guide.md` 版本号：1.0.0 → 1.1.5
- `hooks/claude/README.md` 版本号：1.0.0 → 1.1.5
- `manifest.json` 的 `version_synced_files` 补上这 3 个文件（从 7 个扩展到 10 个）

#### README 版本号更新
- badge 更新：`version-1.1.0` → `version-1.1.5`
- 性能对比表更新：v1.0.0 vs v1.1.0 → v1.0.0 vs v1.1.5（新增自动化验证行）
- 下载/安装示例更新：v1.1.0 → v1.1.5

#### 路线图更新
- `DEVELOPMENT.md` 路线图：v1.1.1"计划中" → v1.1.x"已发布"（5 个版本）

---

## [1.1.5] - 2026-06-10

### 📚 用户文档增强

#### 新建：避坑指南（`docs/PITFALLS.md`）
- 按场景分类，17 个真实使用坑：
  - 首次使用（3 个）：跳过引导、在错误目录建知识库、混淆静默模式
  - 需求管理（4 个）：手写 ID、状态跳级、归档后找不到、会话太多
  - 静默模式（3 个）：误触发、漏检、首次确认被跳过
  - 迁移与备份（2 个）：换电脑后丢失、只备 Skill 不备用户数据
  - 权限与错误（3 个）：权限不足、配置文件损坏、不知道重置
  - 平台差异（2 个）：切换平台行为变化、Claude Hook 未生效
- 每个坑：❌ 错在哪 → ✅ 正确做法 → 💡 原理
- 底部链接到 FAQ.md

#### 新建：3 个模板的完整填写范例
- `core/templates/project-status-template.md`：销售数据分析平台范例
- `core/templates/requirement-readme-template.md`：Q2 区域销售额分析范例（含完整变更记录、会话记录）
- `core/templates/design-doc-template.md`：用户认证模块设计文档范例（含架构、接口、决策记录）

### 🔗 文档交叉引用
- `README.md` 相关资源表新增 `docs/PITFALLS.md`
- `FAQ.md` 获取帮助段新增避坑指南链接

### 🛡️ lint 调整
- `manifest.json` 新增 `PITFALLS.md` 路径检查豁免（用户文档引用的是用户 KB 路径）

---

## [1.1.4] - 2026-06-10

### 🛡️ Self-Endorsement 防御（保守方案）

**问题**：
manifest 既是"声明"又是"被验证对象"，理论上可能被误用为"状态来源"——平台读 manifest 就跳过自己的检查。

**修复**：
- `manifest.json` 新增 `_truth_disclaimer` 字段
  - 明确声明："我是清单，不是事实"
  - 提醒平台：必须独立用文件系统验证
  - 提醒开发者：修改 manifest 后必须跑 lint
- `core/main.md` "加载时自检"段改为**硬编码**清单
  - 不再读 `manifest.json`
  - 即使 manifest 撒谎，AI 也能发现真实问题
  - 自检逻辑独立于任何"声明性"文件

**未触动**：
- `manifest.json` 字段不变（保持 8 类）
- `lint-paths.sh` 不变
- 现有功能完全保留

### 📚 文档

#### README 更新
- `## 🆕 版本更新` 段：新增 v1.1.1 ~ v1.1.4 摘要
- `## 📂 目录结构` 段：补充 manifest.json、新增"开发者专用"分组
- 反映"用户层 vs 开发者层"的责任划分

---

## [1.1.3] - 2026-06-10

### 🏗️ 架构与责任分层

#### 重新设计：谁需要验证？
- **核心洞察**：普通用户**不**应该手动跑 lint 脚本
  - 非技术用户根本不会用 bash
  - 验证是 AI 平台和 CI 的事
- **新的责任划分**：

  | 层级 | 责任方 | 是否进 SkillHub zip |
  |------|--------|---------------------|
  | Skill 内容（core/、modules/、hooks/）| AI 平台加载 | ✅ |
  | Skill 元数据（manifest.json）| AI 平台解析 | ✅ |
  | 用户文档（README/QUICKSTART/...）| 仓库内可见 | ❌ |
  | 开发者工具（scripts/）| 开发者发布前 | ❌ |
  | 测试（test/）| 开发者验证 | ❌ |
  | CI 配置（.github/）| GitHub Actions | ❌ |

#### 新增：加载时自检（给用户的自动验证）
- `core/main.md` 新增"加载时自检"段
- AI 加载 Skill 时**透明**检查：
  - 必需文件存在性
  - 配置文件一致性
  - 元数据版本同步
- 通过时静默，失败时清晰提示

#### 新增：GitHub Actions 自动化
- 新建 `.github/workflows/release.yml`
- 推送 v* tag 自动触发：
  1. 跑 lint-paths.sh --strict 门禁
  2. 跑 build-skillhub.sh 打包
  3. 同时打 GitHub Release zip（含开发者工具）
  4. 创建 GitHub Release，上传两个 zip

#### build 脚本调整
- `manifest.json` 加入 zip（用户级元数据）
- `scripts/`、`test/`、`.github/` 不进 zip（开发者专用）
- `manifest.json` 的 `skillhub_includes` 同步更新

#### 文档改进
- `DEVELOPMENT.md` 新增"分层与责任"小节
- 目录树更新：scripts/ 加 lint-paths.sh、新增 .github/
- 移除 RELEASE-GUIDE.md 引用（文件实际不存在）

---

## [1.1.2] - 2026-06-10

### 🛡️ 自动化质量保障

#### 路径一致性检查（防止文档-文件对不上）
- 新建 `manifest.json`（路径真理来源）：
  - 声明 23 个必需文件
  - 声明 skillhub 打包内容
  - 声明历史别名映射
  - 声明版本号需同步的文件（7 个）
  - 声明支持的平台（4 个）
  - 声明路径检查豁免规则
- 新建 `scripts/lint-paths.sh`（一致性检查器）：
  - 6 个检查：必需文件、文档引用、历史别名、版本号、平台完整性、目录结构
  - 支持 `--strict` 模式（警告也失败）
  - 退出码：0=通过，1=有错误
- `scripts/build-skillhub.sh` 集成 lint 门禁：
  - 打包前自动跑 lint
  - lint 不过则阻止打包

#### 漏网之鱼修复
- 修正 `hooks/claude/hooks.json` 版本号（1.0.0 → 1.1.1）
- `FAQ.md` 模板路径补 `core/` 前缀
- `hooks/claude/README.md` handler.js 引用补全路径
- `DEVELOPMENT.md` 中"在 onboarding.md 中同步说明"豁免规则登记

### 📚 文档改进

#### 维护规范
- 三个 root cause 写明：路径真实性的真理来源、软硬引用混用、发布前缺门禁、缺权威分层
- 通过 manifest + lint 工具链实现"事前预防"，不再依赖第三方检测反馈

---

## [1.1.1] - 2026-06-10

### 🐛 问题修复

#### 文档与文件路径对齐
- 重写 `DEVELOPMENT.md` 目录树和核心文件表（v1.0.0 旧路径 → v1.1.0 实际路径）
- 删除 `DEVELOPMENT.md` 中"待创建"的 `helpers/` 和 `docs/` 小节（已不存在）
- 修正 `settings.yaml` 中 `prompt_file` 和 `templates/` 路径
- `USAGE.md` 平台表新增 Claude 列；`design.md` 标注为可选
- `FAQ.md` 平台列表新增 Claude；`templates/` 加 `core/` 前缀
- `INSTALL.md`、`TEST-PLAN.md` 平台列表新增 Claude
- 多个文档的"最后更新"日期同步

#### 命令速查独立模块
- 新建 `modules/commands/main.md`（懒加载）
- 13 条固定命令 + 同义词映射 + 模糊时确认话术
- `core/main.md` 增加懒加载引用（保持 main.md 精简）
- `QUICKSTART.md` 同步高频命令表

### ✨ 功能增强

#### 能力边界（解决"做不了什么"没说清）
- `README.md` 顶部新增"⚠️ 能力边界"小节（7 条 + 替代方案）
- `core/main.md` 新增"能力边界"段（AI 侧权威规则）
- 明确"做"与"不做"，避免越界

#### 错误处理兜底
- `modules/error/main.md` 新增"5. 未列举错误（兜底）"小节
- 包含：未知错误、平台不支持、文件夹权限、路径错误
- 引导用户去 FAQ.md 或"重新初始化"

---

## [1.1.0] - 2026-06-10

### ⚡ 架构优化

#### 目录结构重组
- 核心功能迁移到 `core/`（main.md, templates/）
- 可选模块集中到 `modules/`（懒加载）
- 一次性配置归类到 `one-time/`
- 平台 Hook 统一到 `hooks/`

#### 性能优化
- main.md 精简：387行 → ~180行（减少 53%）
- 懒加载架构：按需加载模块，日常工作 Token 消耗更低
- onboarding 轻量化：~200行 → ~150行

#### 功能增强
- 错误处理表格化：统一错误码和解决方案
- 需求管理独立模块：查看、更新、归档更清晰
- 静默模式说明独立文档

### 🐛 问题修复
- 修复懒加载路径引用错误
- 修复模板路径更新遗漏
- 修复文档间交叉引用

---

## [1.0.18] - 2026-06-10

### 🎉 新平台支持

#### Claude 平台适配
- 新增 `hooks/claude/`：Claude Hook 支持
- `claude/handler.js`：Claude 平台专用处理脚本
- 支持 Claude CLI 集成

#### 开源完善
- GitHub 仓库链接：`https://github.com/CoderMoray/MyKnowledge`
- README 添加 GitHub 徽章和链接
- CHANGELOG 添加许可证信息

---

## [1.0.0] - 2026-06-09

### 🎉 初始发布

#### 核心功能
- **知识库管理**: 创建标准化的知识库目录结构
  - 全局知识库（~/MyKnowledge/global/）
  - 项目知识库（{project}/.myknowledge/）
  - 自动初始化 README、PROJECT-STATUS.md 等文件

- **需求生命周期管理**: 完整跟踪需求状态
  - 创建需求（REQ-{date}-{seq} 格式）
  - 状态流转（Created → In Progress → Review → Done → Cancelled）
  - 自动归档已完成需求

- **静默模式**: 智能检测复杂任务
  - 关键词匹配（分析、统计、开发等 10+ 关键词）
  - 可配置敏感度（min_keyword_count）
  - 首次触发时询问用户偏好

#### 跨平台支持
- **CodeBuddy**: 意图识别模式
- **WorkBuddy**: 意图识别模式
- **OpenClaw**: Hook + 意图识别（支持真静默）

#### 安装与更新
- **6种安装源支持**: SkillHub(Web/CLI)、ClawHub、GitHub(ZIP/Clone)、手动安装
- **安装源自动检测**: 环境变量、目录标记、用户确认
- **安装源变更检测**: 自动检测或用户主动告知
- **用户数据分离**: 配置存储在 ~/.myknowledge/config/，Skill 更新不丢失

#### 首次引导
- 平台自动检测（CodeBuddy/WorkBuddy/OpenClaw）
- 安装源自动识别
- 自动记录偏好设置
- 可选新手实操教程
- 引导完成后不再显示

#### 文档与模板
- 完整的用户文档（README、QUICKSTART、USAGE、FAQ、INSTALL）
- 3种文档模板（项目状态、需求文档、设计文档）
- 开发文档（DEVELOPMENT、helpers/）
- 测试套件（test/）

#### 技术特性
- 懒加载设计：onboarding 只加载一次
- 上下文优化：正常使用约 9K tokens
- 身份不冲突：能力声明式 Prompt，不覆盖 Agent 角色
- 无外部依赖：纯 Prompt + YAML 实现

---

## 版本规划

### [1.1.6] - 已发布

#### 完成内容
- [x] 3 个 Hook 文件版本号遗漏修复
- [x] README badge + 性能表 + 下载链接版本号更新
- [x] DEVELOPMENT 路线图更新
- [x] manifest version_synced_files 扩展（7→10 个文件）

### [1.2.0] - 计划中

#### 预期功能
- [ ] 关键词搜索
- [ ] 知识库备份/导出
- [ ] 与 Agent Team Skill 集成
- [ ] 需求优先级/标签/依赖

---

## 版本号说明

采用 [语义化版本](https://semver.org/lang/zh-CN/)：

- **主版本号**：不兼容的 API 修改
- **次版本号**：向下兼容的功能新增
- **修订号**：向下兼容的问题修正

---

**维护者**: CoderMoray  
**GitHub**: https://github.com/CoderMoray/MyKnowledge  
**许可证**: Apache License 2.0
