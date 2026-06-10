# MyKnowledge 常见问题解答

## 快速导航

- [静默模式问题](#静默模式问题)
- [平台相关问题](#平台相关问题)
- [知识库管理问题](#知识库管理问题)
- [需求管理问题](#需求管理问题)
- [安装与更新问题](#安装与更新问题)

---

## 静默模式问题

### Q1: 为什么简单对话也会创建知识库？

**A**: 静默模式通过关键词检测判断任务复杂度。如果过于敏感，可以：

1. **首次触发时**：AI 会询问是否开启自动模式，可选择"否"
2. **调整敏感度**：修改 `settings.yaml` 中的 `min_keyword_count`（默认 3，提高到 4-5 更严格）
3. **添加排除词**：在 `exclude_patterns` 中添加你常用的非复杂任务词汇

### Q2: CodeBuddy 和 OpenClaw 的静默模式有什么区别？

**A**: 

| 平台 | 静默模式类型 | 说明 |
|------|-------------|------|
| **CodeBuddy** | 意图识别 | AI 根据对话内容判断是否创建，会提示用户 |
| **WorkBuddy** | 意图识别 | 同上 |
| **OpenClaw** | Hook + 意图识别 | 可通过 Hook 实现真正静默（无感知），也可使用意图识别 |

**建议**：CodeBuddy/WorkBuddy 用户首次使用时关闭自动模式，熟悉后再开启。

### Q3: 如何完全关闭静默模式？

**A**: 修改 `settings.yaml`：

```yaml
features:
  silent_mode:
    enabled: false  # 改为 false
```

---

## 平台相关问题

### Q4: 支持哪些 AI 平台？

**A**: 目前支持：
- **CodeBuddy** - 腾讯 AI 助手
- **WorkBuddy** - 企业版 AI 助手  
- **OpenClaw** - 开源 AI 助手框架
- **Claude** - Anthropic 的 AI 助手（v1.0.18+）

### Q5: 不同平台的功能有差异吗？

**A**: 核心功能一致，但静默模式实现不同：

- **OpenClaw** 支持 Hook 实现真正静默
- **CodeBuddy/WorkBuddy** 依赖 AI 意图识别，会有提示

### Q6: 如何知道当前使用的是什么平台？

**A**: 
1. Skill 首次加载时会自动检测并询问
2. 查看 `skill-state.yaml` 中的 `platform` 字段
3. 直接问 AI："你是什么平台？"

---

## 知识库管理问题

### Q7: 全局知识库和项目知识库的区别？

**A**:

| 类型 | 位置 | 用途 | 共享范围 |
|------|------|------|----------|
| **全局知识库** | `~/MyKnowledge/global/` | 跨项目通用知识 | 所有项目可访问 |
| **项目知识库** | `{project}/.myknowledge/` | 项目专属文档 | 仅限本项目 |

**建议**：
- 通用方法论、工具总结 → 全局知识库
- 具体项目需求、数据 → 项目知识库

### Q8: 知识库可以移动或重命名吗？

**A**: 
- **可以**，直接移动文件夹即可
- 注意更新相关路径引用
- 项目知识库移动后，在新位置重新初始化即可恢复

### Q9: 如何备份知识库？

**A**:
```bash
# 备份全局知识库
cp -r ~/MyKnowledge/global ~/MyKnowledge/global-backup

# 备份项目知识库
cp -r .myknowledge .myknowledge-backup
```

---

## 需求管理问题

### Q10: 需求 ID 是如何生成的？

**A**: 格式为 `REQ-YYYYMMDD-XXX`
- `REQ` - 需求前缀
- `YYYYMMDD` - 日期
- `XXX` - 当日序号（001, 002, ...）

### Q11: 可以自定义需求 ID 吗？

**A**: 目前不支持完全自定义，但可以：
1. 在创建时指定标题来区分
2. 在需求 README 中添加自定义标签

### Q12: 需求状态有哪些？如何流转？

**A**: 

**状态列表**：
- `Created` - 已创建
- `In Progress` - 进行中
- `Review` - 审核中
- `Done` - 已完成
- `Cancelled` - 已取消

**流转规则**：
```
Created → In Progress → Review → Done
   ↓
Cancelled
```

### Q13: 已完成的需求在哪里查看？

**A**: 
- 在 `{knowledge-base}/archive/` 目录下
- 在 `PROJECT-STATUS.md` 的"已完成"章节
- 使用命令："查看已完成需求"

---

## 故障排除

### 问题：无法创建知识库

**检查清单**：
1. [ ] 当前目录是否有写入权限？
2. [ ] 路径是否包含非法字符？
3. [ ] 磁盘空间是否充足？

### 问题：需求状态不更新

**检查清单**：
1. [ ] 知识库是否已初始化？
2. [ ] PROJECT-STATUS.md 是否存在？
3. [ ] 需求 ID 是否正确？

### 问题：Skill 未加载

**检查清单**：
1. [ ] Skill 是否放在正确的 skills 目录？
2. [ ] 目录名是否为 `myknowledge`？
3. [ ] AI 是否已重启？

### 问题：安装源变更后更新提示不正确

**场景**：原本通过 Skill Hub/ClawHub 安装，后来改用 GitHub 更新

**解决方法（推荐）**：
```
直接告诉 AI：
- "我改用 GitHub 更新了" → AI 自动更新记录
- "切换安装源到 skillhub" → 切换到 SkillHub
- "安装源是 clawhub" → 切换到 ClawHub
```

**备用方法（手动修改）**：
```bash
# 编辑安装源文件
~/.myknowledge/config/install-source

# 修改为对应的安装源
source: "github_clone"    # 或 skillhub_web / clawhub 等
```

**自动检测（如果可用）**：
```
1. 告诉 AI："检查安装源"
2. AI 会尝试检测 Skill 目录的标记文件（.git / .skillhub / .clawhub）
3. 如果检测到变更，会询问是否更新记录
```

**ClawHub 特有场景**：
- ClawHub 安装的 Skill 可能有 `.clawhub` 标记目录
- 如果从 ClawHub 切换到 Skill Hub，检测逻辑会提示变更

---

## 进阶使用

### 如何与其他 Skill 配合？

MyKnowledge 可以作为基础 Skill，被其他 Skill 调用：
- 数据分析 Skill 可调用 MyKnowledge 记录分析过程
- 项目管理 Skill 可调用 MyKnowledge 管理需求

### 如何自定义模板？

修改 `core/templates/` 目录下的文件：
- `core/templates/project-status-template.md` - 项目状态模板
- `core/templates/requirement-readme-template.md` - 需求文档模板
- `core/templates/design-doc-template.md` - 设计文档模板

---

## 获取帮助

- **GitHub Issues**: https://github.com/CoderMoray/MyKnowledge/issues
- **文档**: https://github.com/CoderMoray/MyKnowledge/blob/main/README.md
- **避坑指南**: [docs/PITFALLS.md](docs/PITFALLS.md) — 常见坑与正确做法

---

**最后更新**: 2026-06-10
