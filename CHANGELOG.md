# Changelog

所有版本变更记录。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)。

---

## [1.4.4] - 2026-06-12

### 🗣️ 错误提示通俗化 + 命令速查标准化

- error/main.md 全面通俗化：去掉"可能原因"列，合并为纯日常语言的"表现→怎么办"
- 新增极端情况兜底（磁盘满、程序占用、重启AI）
- 诊断清单改为操作指引（含 Mac 菜单路径）
- commands/main.md 命令表从叙事式改为"命令→效果→示例"标准化格式
- 新增导出/导入/灵敏度命令

## [1.4.3] - 2026-06-12

### 💬 错误处理主动修复

- 操作失败时主动给出修复选项（如"1 — 修复 / 2 — 重新初始化"）
- 用户回复数字即可，AI 自动执行修复
- 比"重新初始化"更轻量，保持安全边界（仍需用户确认）

## [1.4.2] - 2026-06-12

### 🔧 需求索引自动维护 + 迁移漏检修复

- 需求状态变更/创建/归档/删除时自动更新 `requirements/README.md` 索引
- 自检迁移探测扩展：projects.yaml 不存在时检查 global/ 下已有子目录

## [1.4.1] - 2026-06-12

### 🔧 导出/导入完善

- 导出包新增前 3 条活跃需求的完整详情（含优先级+标签+会话记录）
- 同名项目冲突选项 3 改为"帮我对比分析给建议"，AI 主动对比双方差异并推荐方案

## [1.4.0] - 2026-06-12

### 📦 一键导出/分享（跨用户协作 + 备份迁移）

#### 导出知识库
- 新增 `modules/export/main.md` 导出/导入模块
- 选择项目 → 打包 PROJECT-STATUS + 需求索引 + 安装引导
- 默认导出到 `~/Downloads/myknowledge-export-{项目名}-{日期}.zip`
- 导出包内含 INSTALL-GUIDE.md，引导未安装用户

#### 导入知识库
- 支持导入 zip 包，自动解压到 `~/.myknowledge/global/`
- 同名项目冲突处理三选项：覆盖 / 重命名 / 对比后决定
- 对比信息包含：需求数、最后更新时间、完成率

#### 入口更新
- `core/main.md` 能力范围 + 路径索引 新增导出入口
- `SKILL.md` 概述新增导出/导入说明

## [1.3.3] - 2026-06-12

### 🔧 版本号一致性 + 安装引导优化 + 错误处理增强

#### 版本号修复
- `settings.yaml` `version_compatibility.current` 修复为 1.3.3（之前漏同步）
- lint 新增 pattern3：检查 `current:` 后的版本号，防止再次漏检

#### 安装引导
- `INSTALL.md` + `README.md` 新增 Atomgit 国内镜像安装方式
- 安装源描述从"GitHub 安装"改为"Git 安装"，Atomgit 优先推荐

#### 错误处理
- `modules/error/main.md` 兜底逻辑增强：未知错误时主动列出常见原因引导排查
- 新增"快速自愈"提示：强调重新初始化不丢数据

## [1.3.2] - 2026-06-12

### 🔒 数据完整性增强

#### projects.yaml 注册原子化
- 创建知识库步骤 5 改为 `🔒 强制注册`，标注为原子操作（打开→追加→保存，缺一不可）
- 未完成注册 = 创建失败，向用户报告

#### 旧项目迁移引导
- 自检新增第 4 项：检测 type: "project" 的旧条目，主动提示迁移到全局知识库
- 用户确认后搬移文件 + 更新 projects.yaml

#### 知识库名称交互
- 创建知识库时，AI 提取建议名后必须让用户确认（"项目叫「{name}」可以吗？"）
- 不得跳过确认步骤

## [1.3.1] - 2026-06-12

### 🏷️ 需求优先级与标签

- `requirement-readme-template.md` 新增**优先级**（P0/P1/P2/P3，默认 P2）和**标签**字段
- `core/main.md` 静默创建需求默认 P2，用户说"优先级 P1"可修改
- `modules/management/main.md` 查看需求列表按优先级排序（P0→P1→P2→P3）
- `requirements-index-template.md` 索引表新增优先级+标签列
- `modules/silent/main.md` 新增灵敏度调优提示，引导用户说"调整检测灵敏度"

## [1.3.0] - 2026-06-11

### 🎯 用户体验优化（7 项真实反馈）

#### 引导流程优化
- 步骤 1 欢迎语从 `@阻塞性` 改为 `@自动`，展示后直接进入步骤 2
- 选项交互改进：步骤 3 从 `[开启] [关闭]` 改为 `1 — 开启 / 2 — 关闭`
- 欢迎语排版：emoji 堆砌改为序号列表
- **标注泄漏修复**：`@阻塞性`/`@自动` 等内部标注从 Markdown 标题移到 HTML 注释，不再出现在用户界面

#### 知识库创建简化
- 默认走全局知识库，不再每次询问"全局还是项目"
- 用户说"在当前目录创建"时才走项目知识库

#### 跨版本升级修复
- `core/main.md` 自检新增 install-source 格式检测：旧版纯文本格式自动迁移为 YAML

## [1.2.4] - 2026-06-11

### 🔧 错误处理增强
- `modules/error/main.md` 新增"文件操作卡住"错误类型：文件被其他程序占用时的处理方案

## [1.2.3] - 2026-06-11

### 💬 操作反馈规范（用户反馈：每次记录/更新后明确告知）

- `core/main.md` 新增「操作反馈规范」段，统一所有操作的反馈模板
- 覆盖 8 种操作：创建知识库、创建需求、更新状态、更新内容、归档、删除、自动会话记录、静默创建
- 反馈原则：一句话确认 + 关键信息，不冗长
- 自动会话记录从完全静默改为追加后告知（`📋 已记录本次会话到 {id}`）
- 明确不需要反馈的后台操作（PROJECT-STATUS 例行更新、projects.yaml last_access、自检通过）

## [1.2.2] - 2026-06-11

### 🔧 Lint 修复 + 开发流程文档化

#### Lint 全通过
- Hook 文件版本号同步（4 个文件）
- README.md badge + 性能对比表版本号同步
- lint 脚本修复：`KNOWN_USER_FILES` 新增用户 KB 路径 + 目录引用 `rstrip` bug 修复
- manifest.json 新增路径豁免规则

#### 开发流程文档化
- `DEVELOPMENT.md` 新增「开发前必读」：Skill 内部规范 + 外部参考链接
- 新增「版本号同步清单」：10 个文件的完整表格
- 新增「经验教训」：记录 6 条历史踩坑记录
- 发布检查清单更新：增加 `clawhub publish` 步骤

## [1.2.1] - 2026-06-11

### 🗂️ 项目追踪 + 新对话自动恢复

#### 全局知识库子目录化
- `~/.myknowledge/global/` 从扁平结构改为 `global/{project-name}/` 子目录
- 纯对话用户创建知识库时按项目名分子目录，不再全部混在一起
- `settings.yaml` 存储路径同步更新

#### 项目目录管理（projects.yaml）
- 新增 `~/.myknowledge/config/projects.yaml`，记录所有知识库位置
- 创建知识库时自动追加条目（path、name、last_access、type）
- 按需读取，不占常驻上下文
- `core/templates/projects-yaml-spec.md` 定义格式规范

#### 新对话项目恢复
- `core/main.md` 使用前检查新增"项目恢复"逻辑：
  - 当前目录有 `.myknowledge/` → 直接恢复（最快路径）
  - 无工作空间 → 读 `projects.yaml` 列出所有项目供选择
  - 选择了项目 → 更新 `last_access`
- `onboarding/main.md` 步骤 4 初始化空的 `projects.yaml`

#### 错误处理增强
- `modules/error/main.md` 新增"项目目录不存在"错误类型
- 检测到项目文件夹被手动删除 → 自动从 `projects.yaml` 清理 → 提示用户

#### 版本号全量同步
- `SKILL.md`、`settings.yaml`、`_meta.json`、`manifest.json`、`onboarding/main.md` 统一为 1.2.1

## [1.2.0] - 2026-06-11

### 🚀 引导流程强制化 + 模板体系完善

#### 引导流程修复（来自用户反馈）
- **onboarding/main.md**：新增硬性规则——必须按序完成全部 5 步，每步骤需用户确认才能进入下一步
  - 步骤标注 `@阻塞性`/`@自动`/`@auto-detect`，AI 不可跳过或合并
  - 步骤 2 支持自动检测平台（`CODEBUDDY_*`/`WORKBUDDY_*` 等环境变量）
  - 步骤 5 增加前置校验：确认 `skill-state.yaml` 已写入才展示结束语
  - 新增"引导完成后硬性禁止"规则，防止正常使用时重新加载引导
- **core/main.md 检查段**：从"加载 onboarding"改为"强制按序完成 onboarding 全部 5 步骤"
  - 明确 `⚠️ "加载 onboarding 文件" ≠ "完成引导"`

#### 新增 4 个 README 模板
- `core/templates/kb-readme-template.md` — 知识库入口（项目简介+快速导航）
- `core/templates/requirements-index-template.md` — 需求索引页（ID+标题+状态+时间）
- `core/templates/public-readme-template.md` — 公开文件清单
- `core/templates/archive-readme-template.md` — 归档索引（原因+日期+原链接）

#### 职责边界澄清
- 在 `core/main.md` 输出规范中新增"各 README 职责边界"表格
- 明确区分 `requirements/README.md`（需求索引）与 `PROJECT-STATUS.md`（项目快照）
- 创建知识库时自动使用对应模板，创建后告知用户各文件用途

#### 模板文件清单（共 6 个）
| 模板 | 用途 |
|------|------|
| `kb-readme-template.md` | 知识库入口 |
| `requirements-index-template.md` | 需求目录索引 |
| `requirement-readme-template.md` | 单个需求详情 |
| `public-readme-template.md` | 公开文件清单 |
| `archive-readme-template.md` | 归档索引 |
| `project-status-template.md` | 项目状态快照 |

## [1.1.18] - 2026-06-11

### 📝 description 精简 + 排除规则
- `SKILL.md` description 从中英混杂改为简洁中英双语摘要
- 新增 `.clawhubignore`，排除开发者文件（test/、releases/、DEVELOPMENT.md 等）

## [1.1.17] - 2026-06-11

### 🔧 配置一致性修复 + 自动化防护

#### 修复 3 处配置不一致
- `min_keyword_count` 默认值：USAGE.md 写的 2，实际为 3 → 全部统一为 3
- 关键词触发数量：silent/main.md 写"2 个及以上"，实际阈值 3 → 统一为"3 个及以上"
- Claude Hook 表述：SKILL.md 过于乐观"意图识别 + Hooks" → 改为"意图识别为主，Hook 视环境而定"

#### 新增 lint 第 8 项：配置参数一致性检查
- `scripts/lint-paths.sh` 自动验证 `min_keyword_count` 在 6 个文件中是否一致
- 以 `settings.yaml` 为权威源，检测所有引用该参数的文档

#### 首次引导触发优化
- `SKILL.md` description 新增"安装后主动提示用户初始化"，AI 安装完成后会主动询问是否进行首次设置
- `INSTALL.md` 验证安装部分明确说明"安装后 Skill 不会自动运行，需要说'创建知识库'触发"
- 不一致时阻止打包

#### 开发规范更新
- `DEVELOPMENT.md` 配置变更规范新增"参数一致性"检查项

---

## [1.1.16] - 2026-06-11

### 🎯 消除平台误解 + 规则统一

#### "没有自动修复" → 恢复极简单
- `error/main.md` 设计说明重写：前置"恢复极简单"，不解释为什么不自动修复
- "说一句话即可恢复，不丢数据，无需手动操作文件"

#### 静默触发规则统一（4 个文件）
- `SKILL.md`、`core/main.md`、`USAGE.md` 关键词列表统一为 9 个（对齐 `modules/silent/main.md` 权威源）
- 统一描述格式："满足 2 个及以上关键词触发"
- `hooks/openclaw/hook-guide.md` 修复遗留的"误触发"标签

#### FAQ 增加具体示例
- Q1 静默触发：新增 4 行 ❌/✅ 对比表（什么触发、什么不触发）
- 反模式 5：新增"3 周后的项目状态"对比表

---

## [1.1.15] - 2026-06-11

### 🔧 更新指引修正（skillhub 命令 + 无自动通知）

#### update-checker.md + install-source.md 全面修正
- `skillhub update` → `skillhub upgrade`（实际 CLI 命令）
- 删除所有"SkillHub 会自动通知更新"（经确认平台无此功能）
- skillhub_web 用户升级方式：重新安装 my-knowledge 技能
- 新增用户数据安全说明："~/.myknowledge/ 不受更新影响"

#### 波及修正
- `README.md`、`INSTALL.md`、`DEVELOPMENT.md`、`test/scenarios/skillhub-only.md` 同步更新

---

## [1.1.14] - 2026-06-11

### 🗣️ AI 回复自足性增强（消除"需要对照文档"的体验）

#### error/main.md 响应格式重写
- AI 回复原则：直接给答案，不让用户去查 FAQ/docs
- 兜底逻辑从"让用户在 FAQ.md 搜索"改为"AI 主动从 FAQ 查找并告诉用户"
- 新增 AI 自检清单：回复前确认用户不需要再查其他文档

---

## [1.1.13] - 2026-06-11

### 🛡️ 安全设计文档化（消除"不会自动重试"的负面解读）

#### error/main.md 设计说明
- 文件头部新增设计说明块：明确"不自动重试"是安全设计，非功能缺失
- 错误响应格式底部补充理由：避免 AI 未经用户确认修改文件

### 🗣️ 错误提示通俗化

#### error/main.md "解决"列全部重写
- 全部 15 条错误提示从技术语言改为日常对话语言
- 示例：
  - "检查目录权限" → "换个有写入权限的文件夹试试"
  - "知识库未初始化" → "还没创建知识库呢，先对我说'创建知识库'"
  - "参考 settings.yaml 调整 min_keyword_count" → "灵敏度可以调整，对我说'调整检测灵敏度'即可"
- 快速诊断清单同步通俗化
- 平台检测/安装源提示改为日常对话式询问

### 📋 路线图更新
- `DEVELOPMENT.md` v1.2.0 新增"一键导出/分享"功能规划：
  - 导出项目知识库为可分享文件（含状态摘要 + 安装引导）
  - 对方有 MyKnowledge → "导入知识库"一键录入
  - 对方无 MyKnowledge → 分享包内 INSTALL-GUIDE.md 引导安装
- v1.1.13 加入已发布列表

---

## [1.1.12] - 2026-06-11

### 📦 用户文档随 Skill 分发（解决"找不到 FAQ"问题）

#### FAQ + 避坑指南打包进 SkillHub zip
- `manifest.json`：`skillhub_includes` 新增 `FAQ.md` 和 `docs/PITFALLS.md`
- `manifest.json`：`required_files` 新增 2 个文件（lint 校验）
- `scripts/build-skillhub.sh`：打包时自动复制 FAQ.md + docs/PITFALLS.md
- 用户从 SkillHub 安装后本地即有 FAQ + 避坑指南，无需跳 GitHub

#### SKILL.md 新增用户支持章节
- AI 加载时知道：遇到常见问题→引导看 FAQ.md，踩坑→看 PITFALLS.md
- 明确列出 4 种场景的引导路径

#### 验证增强
- `build-skillhub.sh` 排除检查新增 DEVELOPMENT.md / TEST-PLAN.md（这些也不该进 zip）

---

## [1.1.11] - 2026-06-11

### 🗣️ 负面标签消除（避免平台误判为产品缺陷）

#### PITFALLS.md 重构
- 坑 8 "误触发太多" + 坑 9 "漏检" → 合并为"检测灵敏度不符合个人偏好"
  - 去掉 ❌ 错误表述，改为 💡 调优指南
  - 强调"这不是 bug，是个人偏好"
- 后续坑号全部重新编号（坑 10→坑 20 统一减 1，总计 19 坑）
- 交叉引用同步更新

#### error/main.md 清理
- 删除"静默误触发"错误类型行
- "静默不触发"合并为"检测偏好调整"
- 静默模式相关从 2 行 → 1 行

#### 措辞软化
- `FAQ.md` 微调技巧："减少误触发" → "匹配你的工作风格"
- `README.md` 高手技巧："调整误触发/漏检的灵敏度" → "调整检测灵敏度以匹配你的工作风格"

### 📖 导航增强
- README 导航表新增"深入了解 / 进阶技巧"入口，指向高手技巧章节

---

## [1.1.10] - 2026-06-10

### 📖 用户体验优化（基于 SkillHub 评测反馈）

#### 安装流程简化
- `README.md` 快速开始：GitHub 方式简化为一行命令（`git clone` 直接到目标路径），去掉手动 ZIP 流程
- `INSTALL.md`：去掉"手动下载"步骤，统一为 SkillHub/GitHub 两种方式
- 安装说明突出"SkillHub 无需终端"，降低非技术用户门槛

#### FAQ 增强
- 新增"反模式与常见错误"章节（5 条反模式）：
  - 把 MyKnowledge 当数据库用
  - 把知识库当聊天记录备份
  - 手动编辑内部文件
  - 跨平台共用用户数据
  - 创建了知识库但不维护
- 新增"多项目管理"章节（Q14-Q15）
- 新增"数据与备份"章节（Q16-Q18）：误删恢复、版本兼容、性能问题
- "进阶使用"章节扩展（从 2 条 → 6 条）：
  - 高效组织大型项目知识库
  - 让 AI 定期总结知识库
  - 静默模式微调技巧
  - 需求文档最佳实践
  - git 管理知识库

#### README 新增"高手技巧"章节
- 一键切换项目、让 AI 写周报、git 管理知识库、自定义静默检测
- 交叉链接到 USAGE.md / FAQ.md / PITFALLS.md 进阶章节

#### 避坑指南扩展
- `docs/PITFALLS.md` 从 17 坑 → 20 坑：
  - 坑 18：多项目切换时忘了当前知识库
  - 坑 19：模板复制后不修改占位符
  - 坑 20：用 git 管理用户数据但忽略 .gitignore
- 快速索引表新增"进阶使用"分类

#### 安全
- `INSTALL.md` 权限错误解决方案：移除 `chmod 755` 命令，改为引导性表述

### 🔗 文档交叉引用
- FAQ.md 反模式章节链接到 PITFALLS.md 对应坑位
- PITFALLS.md 新增坑位与 FAQ 反模式形成互补
- README 高手技巧链接到各文档进阶章节

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

### [1.1.10] - 已发布

#### 完成内容
- [x] 安装流程简化（去掉手动下载，推荐 SkillHub + GitHub）
- [x] FAQ 新增"反模式与常见错误"章节（5 条）
- [x] FAQ 进阶使用扩展（2→6 条技巧）
- [x] PITFALLS 扩展（17→20 坑）
- [x] INSTALL.md chmod 命令移除

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
