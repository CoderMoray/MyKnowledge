# 测试方案：SkillHub ↔ GitHub 交叉更新场景

> ⚠️ **AI 助手注意**：此为 Skill 内部测试文档，正常使用时请忽略。
> 🛡️ **安全警告**：以下 `rm -rf` 命令仅用于测试环境清理。**严禁在生产环境执行**，避免误删用户数据。

---

## 测试目标

验证用户在 SkillHub 和 GitHub 之间切换安装源时，Skill 能正确检测变更并调整更新策略。

---

## 前置条件

1. 已完成纯 SkillHub 和纯 GitHub 的测试
2. 熟悉两种安装方式的结构差异
3. 测试环境隔离

---

## 测试用例

### TC-CU-01: SkillHub Web → GitHub Clone 切换检测

**前置状态**: 
- 通过 Skill Hub Web 安装
- `install-source` 记录为 `skillhub_web`
- 无 `.git` 目录

**步骤**:
1. 用户手动运行 `git init && git remote add origin https://github.com/CoderMoray/MyKnowledge.git && git pull`
2. 或删除 Skill 目录后重新 `git clone`
3. 触发 Skill 使用

**预期结果**:
- [ ] AI 检测到 `.git` 目录存在
- [ ] 对比记录 `source: "skillhub_web"` 与实际不符
- [ ] 显示 ⚠️ "检测到安装源变更："
- [ ] 显示 "你原本通过 Skill Hub 安装，但现在 Skill 目录包含 Git 仓库。"
- [ ] 显示 "是否已改用 GitHub 更新？"
- [ ] 用户选择 "是"
- [ ] 更新 `install-source` 为 `github_clone`
- [ ] 显示 "✅ 已更新安装源记录为 github_clone"

---

### TC-CU-02: SkillHub Web → GitHub Clone 切换 - 用户拒绝

**前置状态**: source = `skillhub_web`，存在 `.git` 目录

**步骤**:
1. 触发 Skill 使用
2. AI 询问是否变更安装源
3. 用户选择 "否" 或 "保持原样"

**预期结果**:
- [ ] 显示 "保持原记录，但请注意版本同步问题"
- [ ] `install-source` 保持 `skillhub_web`
- [ ] 后续更新提示仍按 Skill Hub 方式

---

### TC-CU-03: GitHub Clone → SkillHub Web 切换检测

**前置状态**:
- 通过 GitHub Clone 安装
- `install-source` 记录为 `github_clone`
- 存在 `.git` 目录

**步骤**:
1. 用户通过 Skill Hub Web 安装新版本（覆盖或替换）
2. `.git` 目录消失
3. 触发 Skill 使用

**预期结果**:
- [ ] AI 检测到 `.git` 目录消失
- [ ] 对比记录 `source: "github_clone"` 与实际不符
- [ ] 显示 ⚠️ "检测到安装源变更：Git 仓库标记消失"
- [ ] 显示 "是否已通过其他方式（如 Skill Hub）更新？"
- [ ] 用户确认是 Skill Hub
- [ ] 询问并更新为 `skillhub_web`

---

### TC-CU-04: SkillHub CLI → GitHub Clone 切换

**前置状态**: source = `skillhub_cli`

**步骤**:
1. 用户改用 `git clone` 重新安装
2. 触发 Skill 使用

**预期结果**:
- [ ] 检测到 `.git` 目录
- [ ] 提示安装源变更
- [ ] 更新记录为 `github_clone`
- [ ] 后续更新提示变为 git pull 方式

---

### TC-CU-05: GitHub ZIP → GitHub Clone 切换

**前置状态**: source = `github_zip`

**步骤**:
1. 用户在 ZIP 安装的目录运行 `git init && git pull`
2. 触发 Skill 使用

**预期结果**:
- [ ] 检测到 `.git` 目录
- [ ] 询问是否改为 Git 方式管理
- [ ] 更新记录为 `github_clone`
- [ ] 显示 "✅ 已更新为 git clone 方式，可用 git pull 更新"

---

### TC-CU-06: 配置持久化验证（跨源更新后）

**前置状态**: 
- 原 SkillHub 安装，已创建知识库
- `auto_record: true`
- 多个需求记录

**步骤**:
1. 切换到 GitHub Clone 方式更新 Skill
2. 确认安装源变更
3. 检查用户数据

**预期结果**:
- [ ] `~/.myknowledge/config/skill-state.yaml` 内容完整保留
- [ ] `auto_record` 设置不变
- [ ] 已创建的知识库可正常访问
- [ ] 需求状态可正常更新

---

### TC-CU-07: 多次切换场景

**步骤**:
1. SkillHub → GitHub Clone（TC-CU-01）
2. GitHub Clone → SkillHub Web（TC-CU-03）
3. 再次 SkillHub → GitHub

**预期结果**:
- [ ] 每次切换都正确检测
- [ ] 安装源记录始终与实际一致
- [ ] 用户数据始终完整

---

## 边界情况

### TC-CU-B1: 同时存在多个标记

**场景**: Skill 目录同时有 `.git` 和 `.skillhub`

**预期行为**:
- 优先检测 `.git`（因为 GitHub 方式更明确）
- 或提示用户确认实际使用方式

### TC-CU-B2: 安装源文件损坏

**场景**: `install-source` 文件内容为空或格式错误

**预期行为**:
- 视为 `source: "unknown"`
- 重新检测实际安装方式
- 询问用户确认

### TC-CU-B3: 用户手动修改安装源

**场景**: 用户手动编辑 `install-source` 文件

**预期行为**:
- 下次使用时按用户修改的值
- 如果与实际检测不符，提示变更

---

## 测试数据模板

### 变更检测场景数据

```yaml
# 变更前 install-source
source: "skillhub_web"
detected_by: "env_var"
installed_at: "2026-06-01"
installed_version: "1.0.0"

# 变更后（用户手动执行 git init）
# 目录新增 .git/
# AI 应检测到变更
```

### 变更后 install-source

```yaml
source: "github_clone"
detected_by: "git_dir"
installed_at: "2026-06-01"  # 保持原时间
updated_at: "2026-06-09"     # 新增变更时间
installed_version: "1.0.0"
previous_source: "skillhub_web"  # 记录历史
```

---

## 自动化测试思路（未来）

```bash
#!/bin/bash
# 伪代码：交叉更新测试脚本

# 1. 模拟 SkillHub 安装
mkdir -p ~/.codebuddy/skills/myknowledge
echo "source: skillhub_web" > ~/.myknowledge/config/install-source

# 2. 模拟切换到 GitHub
cd ~/.codebuddy/skills/myknowledge
git init
git remote add origin https://github.com/CoderMoray/MyKnowledge.git

# 3. 触发 Skill 检测
# 验证：AI 应提示安装源变更
```

---

## 清理命令

```bash
rm -rf ~/.myknowledge/config/
rm -rf ~/.codebuddy/skills/myknowledge/
rm -rf ~/.workbuddy/skills/myknowledge/
```
