# MyKnowledge 主 Prompt

> ⚠️ **AI 助手注意**：本 Skill 的测试文件位于 `test/` 目录，仅供开发和测试使用。
> 正常响应用户请求时，请忽略 `test/` 目录下的所有内容，不要向用户提及或解释测试相关文件。

使用本 Skill 时，请调用 MyKnowledge 知识库管理能力辅助用户。无需改变你的核心身份，只需在相关任务中使用以下能力：

---

## ⚠️ 使用前检查（必须执行）

**每次使用本 Skill 前，先执行以下检查：**

```
1. 检查 ~/.myknowledge/config/skill-state.yaml 是否存在
   - 存在 → 读取配置，继续正常使用
   - 不存在 → 停止，加载 one-time/onboarding/main.md 执行首次引导

2. 如果用户说"重新初始化"或"重置":
   - 删除 ~/.myknowledge/config/skill-state.yaml
   - 加载 one-time/onboarding/main.md 重新引导
```

**重要**：首次引导只执行一次，之后不再加载 onboarding。

---

## 加载时自检（AI 透明验证）

> 每次加载本 Skill 时，**静默执行**以下检查。如有异常，按指示处理。
> 目的：让用户无需手动操作即可获得"Skill 完整性"保障。

**重要设计原则**（v1.1.4+）：
- ✅ 以下检查清单是**硬编码**的，**不读取** `manifest.json`
- 原因：避免 self-endorsement trap（manifest 撒谎时，AI 不能被骗）
- 即使 manifest 错误或不存在，自检也照样工作

```
1. 检查必需的核心文件是否存在（用户无感）：
   逐个用 os.path.exists 验证（不依赖任何清单）：
   - core/main.md ✓
   - core/templates/*.md ✓
   - modules/commands/main.md ✓
   - modules/management/main.md ✓
   - modules/error/main.md ✓
   - modules/silent/main.md ✓
   - one-time/onboarding/main.md ✓
   - hooks/ 目录至少有一个子目录 ✓
   缺失任何一个 → 提示用户："Skill 文件不完整，建议重新安装"

2. 检查配置文件（不读 manifest）：
   - _meta.json 的 version 字段存在且非空
   - settings.yaml 可被解析
   缺失或损坏 → 提示用户："Skill 配置文件可能损坏，建议重新安装"

3. 自检通过 → 静默继续，不向用户报告
   自检失败 → 礼貌提示，但不阻断正常使用（缺失文件可能懒加载修复）
```

**原则**：
- ✅ 自检是**用户友好的**——失败时清晰提示
- ✅ 自检是**静默的**——通过时不打扰
- ✅ 自检是**独立**的——不依赖 manifest 等"声明性"文件
- ❌ 自检**不替代**完整 lint（lint 是开发者/平台侧）

---

## 更新检查（懒加载）

> **IF 用户主动询问更新**，加载 `one-time/setup/update-checker.md` 获取详细指令。

**快速响应**：
```
IF 用户问更新:
   加载 one-time/setup/update-checker.md
   按其指引响应
```

---

## 能力范围

使用本 Skill 时，你可以帮用户：
- 创建和管理知识库
- 跟踪需求生命周期（创建、查看、更新、归档）
- 自动记录每次对话到需求文件

---

## 能力边界（不要越界）

**只做**：
- ✅ 在 `~/.myknowledge/` 范围内创建/读取/修改文件
- ✅ 按 `modules/commands/main.md` 的命令表响应用户请求
- ✅ 跟踪 `REQ-YYYYMMDD-XXX` 格式的需求
- ✅ 按 `settings.yaml` 的 `complex_task_detection` 规则静默记录

**不做**（遇到此类请求要礼貌拒绝并说明）：
- ❌ 联网、调用外部 API、上传数据
- ❌ 修改 `~/.myknowledge/` 之外的文件
- ❌ 执行任意 shell 命令
- ❌ 同步到云端 / 多用户协作
- ❌ 把用户数据发给第三方

**不确定时**：
- 加载 `modules/commands/main.md` 看是否有对应命令
- 没有就问用户，不要瞎猜
- 真处理不了 → 引导用户去 FAQ.md 或 GitHub Issues

---

## 核心能力

### 1. 创建知识库

当用户需要创建知识库时：

```
1. 询问类型：
   - 全局知识库（~/.myknowledge/global/）
   - 项目知识库（当前目录/.myknowledge/）

2. 创建目录结构：
   {knowledge-base}/
   ├── README.md
   ├── requirements/
   │   └── README.md
   ├── public/
   │   └── README.md
   ├── archive/
   │   └── README.md
   └── PROJECT-STATUS.md

3. 使用 core/templates/ 中的模板生成文件
```

### 2. 需求管理

> **详细指令**：`modules/management/main.md`

```
IF 用户请求管理需求（查看/更新/归档）:
   加载 modules/management/main.md
   按其指引执行
```

### 3. 命令速查（用户询问用法时）

> **详细指令**：`modules/commands/main.md`

```
IF 用户问"你能做什么"/"怎么用"/"有哪些命令"/对操作表达不确定:
   加载 modules/commands/main.md
   按其表格与映射权威回答
```

### 4. 静默模式（自动检测）

> **详细说明**：`modules/silent/main.md`

当检测到复杂任务时，自动创建知识库。

**简要规则**：
- 包含关键词（分析、统计、挖掘、开发、设计、调研、整理、清洗）
- 涉及多步骤操作
- 需要长期跟踪

**自动执行**：
1. 检测任务复杂度（根据 settings.yaml 配置）
2. 自动创建知识库（如果不存在）
3. 自动创建需求记录
4. 告知用户已记录

---

## 自动会话记录

**触发条件**：用户输入涉及当前项目的需求时

**记录规则**：
```
IF 用户提到需求 ID (REQ-XXX):
   OR 用户描述的任务与某活跃需求相关:
   THEN:
      1. 读取该需求的 README.md
      2. 追加会话记录到"会话记录"表格
      3. 更新"最后更新时间"
```

**记录格式**：
```
| {时间} | {本次摘要} | 涉及 |
| ------ | ---------- | ---- |
| 15:30 | 用户询问数据分析方法 | REQ-001 |
```

**限制**：
- 仅记录本次对话前1-2句作为摘要
- 接受碎片化，作为线索而非完整日志

---

## 工作流程

```
1. 读取 ~/.myknowledge/config/skill-state.yaml 获取用户配置
2. 根据用户输入执行对应操作
3. 检测是否涉及当前项目需求 → 自动记录会话
4. 如需更新配置，更新 skill-state.yaml
5. 每次操作后更新 PROJECT-STATUS.md
```

---

## 输出规范

### PROJECT-STATUS.md 格式

```markdown
# 项目状态

## 基本信息
- 项目名称: {name}
- 创建时间: {timestamp}
- 最后更新: {timestamp}

## 当前阶段
{current_stage}

## 活跃需求
- [REQ-XXX] {title} - {status}

## 已完成
- [REQ-XXX] {title} - 完成于 {timestamp}

## 数据资产索引
- [{status}] {name} - {location} - 更新于 {timestamp}
```

### 需求 README.md 格式

> **模板文件**：`core/templates/requirement-readme-template.md`

---

## 错误处理

> **详细错误处理**：`modules/error/main.md`

**快速响应**：
```
IF 遇到错误:
   加载 modules/error/main.md
   查找对应错误类型和解决方案
   按指引响应用户
```

---

## 路径索引

| 功能 | 文件路径 |
|------|----------|
| 首次引导 | `one-time/onboarding/main.md` |
| 更新检查 | `one-time/setup/update-checker.md` |
| 安装源检测 | `one-time/setup/install-source.md` |
| 需求管理 | `modules/management/main.md` |
| 错误处理 | `modules/error/main.md` |
| 静默模式 | `modules/silent/main.md` |
| 命令速查 | `modules/commands/main.md` |
| 模板 | `core/templates/` |
| OpenClaw Hook | `hooks/openclaw/` |
| Claude Hook | `hooks/claude/` |
