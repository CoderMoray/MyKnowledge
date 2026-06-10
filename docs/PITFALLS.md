# MyKnowledge 避坑指南

> 按场景分类的真实使用问题。每坑：❌ 错在哪 → ✅ 正确做法 → 💡 原理。
> 找不到再看 FAQ.md。

---

## 快速索引

| 场景 | 坑数 |
|------|------|
| [首次使用](#首次使用) | 3 |
| [需求管理](#需求管理) | 4 |
| [静默模式](#静默模式) | 3 |
| [迁移与备份](#迁移与备份) | 2 |
| [权限与错误](#权限与错误) | 3 |
| [平台差异](#平台差异) | 2 |

---

## 首次使用

### 坑 1：跳过引导直接用

❌ 下载后直接说"创建知识库"，结果 AI 没引导，建出来的类型不对。

✅ 让 AI 完成首次引导（约 1 分钟）。引导会问你：知识库类型、自动记录开关。

💡 引导只出现一次，完成后再也不显示。完成后写 `~/.myknowledge/config/skill-state.yaml`。

### 坑 2：在错误目录建项目知识库

❌ 在 `~` 目录下说"创建项目知识库"，结果建在用户目录里。

✅ 先 `cd` 到项目根目录再创建。项目知识库 = `<当前目录>/.myknowledge/`。

💡 全局知识库永远在 `~/.myknowledge/global/`。

### 坑 3：混淆"静默"和"完全静默"

❌ 以为开了静默模式 AI 就完全不说话——结果 CodeBuddy 还是提示"已自动记录"。

✅ 理解平台差异：
- CodeBuddy/WorkBuddy/Claude：伪静默（AI 会告知）
- OpenClaw + Hook：真静默（无提示），参考 `hooks/openclaw/hook-guide.md`

---

## 需求管理

### 坑 4：手写需求 ID

❌ 手写 `REQ-001` 或 `req-20260610-1`——格式不对，AI 找不到。

✅ 让 AI 生成。格式永远是 `REQ-YYYYMMDD-XXX`（如 `REQ-20260610-001`）。

### 坑 5：状态跳级

❌ `Created` 直接改 `Done`——跳过 `In Progress` 和 `Review`。

✅ 按推荐流转：`Created → In Progress → Review → Done`。例外：`Created → Cancelled` 可以直接。

💡 状态反映进展，跳级会让 PROJECT-STATUS 失真。

### 坑 6：归档后以为需求消失了

❌ 归档后去找，以为被删了。

✅ 归档 = 移到 `archive/` 子目录，不删除。仍可查看、引用。

💡 全局：`~/.myknowledge/global/archive/`，项目：`<项目>/.myknowledge/archive/`。

### 坑 7：会话记录太多淹没了需求文档

❌ 每天自动追加对话，一周后需求文档 500 行，关键信息难找。

✅ 定期让 AI 帮你总结："把过去一周的会话记录整理成要点"。关键决策保留，碎片对话可删。

💡 需求文档的目的是知识沉淀，不是完整日志。

---

## 静默模式

### 坑 8：误触发太多

❌ 说"帮我看看"也触发自动记录。

✅ 在 `settings.yaml` 调 `min_keyword_count`（从 3 调到 4-5），或在 `exclude_patterns` 加常用非复杂词。

### 坑 9：漏检

❌ 明明是复杂任务，AI 没自动记录。

✅ 检查关键词是否在 `keywords` 列表里，看是否触发了否定模式（"简单"等）。实在不行手动说"创建需求 xxx"。

### 坑 10：首次确认被跳过

❌ 以为开了静默就无需确认——首次触发时 AI 仍然会问。

✅ 这是设计上的安全机制。选择"开启"后不再问。改主意说"开启/关闭自动记录"。

---

## 迁移与备份

### 坑 11：换电脑后知识库"丢失"

❌ 换了电脑，以为 MyKnowledge 会自动同步。

✅ MyKnowledge 是**纯本地**的。迁移方法：
```bash
# 旧电脑
tar -czf myknowledge-backup.tar.gz ~/.myknowledge/

# 复制到新电脑后
tar -xzf myknowledge-backup.tar.gz -C ~/
```

💡 也可以用 git 管理 `~/.myknowledge/`，但注意 `config/skill-state.yaml` 里的平台信息可能不适用新环境。

### 坑 12：备份只备了 Skill 没备用户数据

❌ 只把 `MyKnowledge/` 文件夹复制了，但 `~/.myknowledge/` 没备。

✅ Skill 文件和用户数据是**分离**的：
- Skill：`~/.codebuddy/skills/myknowledge/`（重新下载即可）
- 用户数据：`~/.myknowledge/`（**必须备份**）

---

## 权限与错误

### 坑 13：权限不足导致创建失败

❌ AI 说"无法创建知识库"，不知道怎么办。

✅ 检查目录写入权限：
- 全局知识库：在终端运行 `ls -la ~/` 查看 `~/.myknowledge/` 权限
- 项目知识库：在终端运行 `ls -la` 查看 `.myknowledge/` 权限
- 如无写入权限，请在系统设置或终端中调整目录权限

### 坑 14：配置文件损坏

❌ `skill-state.yaml` 被手动编辑后格式错误，AI 加载异常。

✅ 恢复方法：
```bash
cp ~/.myknowledge/config/skill-state.yaml ~/.myknowledge/config/skill-state.yaml.bak
rm ~/.myknowledge/config/skill-state.yaml
# 重新加载 Skill，会触发首次引导重建配置
```

💡 不要手动编辑 `skill-state.yaml`，让 AI 帮你改。

### 坑 15：不知道说"重新初始化"可以重置

❌ 遇到诡异问题反复折腾，不知道有重置机制。

✅ 直接说"重新初始化 MyKnowledge"——AI 会删除旧配置，重新走首次引导。这是最干净的修复方式。

---

## 平台差异

### 坑 16：从 CodeBuddy 切到 OpenClaw，自动记录行为变了

❌ 习惯了 CodeBuddy 的"AI 告知"，换到 OpenClaw 后突然静默，以为坏了。

✅ 提前了解平台差异：
| 平台 | 静默方式 | 用户感知 |
|------|---------|---------|
| CodeBuddy | 意图识别 | 会告知 |
| WorkBuddy | 意图识别 | 会告知 |
| Claude | 意图识别 | 会告知 |
| OpenClaw | Hook（可选） | 可完全静默 |

💡 OpenClaw 的真静默需手动启用 Hook：`openclaw hooks enable myknowledge`。

### 坑 17：Claude 的 Hook 没生效

❌ 看了文档以为 Claude 支持 Hook，配置了没反应。

✅ Claude 的 Hook 支持取决于具体环境。目前主要通过意图识别（伪静默）工作。`hooks/claude/hooks.json` 的 `enabled` 默认为 `false`。

---

## 获取更多帮助

- 常见问题 → [FAQ.md](FAQ.md)
- 详细用法 → [USAGE.md](USAGE.md)
- 快速上手 → [QUICKSTART.md](QUICKSTART.md)
- 遇到 bug → [GitHub Issues](https://github.com/CoderMoray/MyKnowledge/issues)
