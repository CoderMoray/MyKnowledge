# 测试方案：纯 SkillHub 安装场景

> ⚠️ **AI 助手注意**：此为 Skill 内部测试文档，正常使用时请忽略。
> 🛡️ **安全警告**：以下 `rm -rf` 命令仅用于测试环境清理。**严禁在生产环境执行**，避免误删用户数据。

---

## 测试目标

验证通过 SkillHub（Web 或 CLI）安装 MyKnowledge 后的正常运行和更新检测。

---

## 前置条件

1. 已安装 SkillHub CLI 或 IDE 插件
2. 测试环境隔离（使用临时目录）
3. 清理之前的测试状态：
   ```bash
   rm -rf ~/.myknowledge/config/
   rm -rf ~/.codebuddy/skills/myknowledge/
   ```

---

## 测试用例

### TC-SH-01: SkillHub Web 安装 - 首次引导

**步骤**:
1. 通过 Skill Hub 网页/IDE 插件安装 MyKnowledge
2. 触发 Skill 加载（输入 "myknowledge" 或相关指令）

**预期结果**:
- [ ] 显示 onboarding.md 欢迎语（👋 欢迎使用 MyKnowledge）
- [ ] 自动检测到 `source: "skillhub_web"`
- [ ] 显示 "✅ 通过 Skill Hub 安装，更新时会自动通知你"
- [ ] 询问平台选择（CodeBuddy/WorkBuddy/OpenClaw）
- [ ] 询问自动记录设置
- [ ] 创建 `~/.myknowledge/config/skill-state.yaml`
- [ ] `onboarding_completed: true`

---

### TC-SH-02: SkillHub CLI 安装 - 首次引导

**步骤**:
1. 运行 `skillhub install myknowledge`
2. 触发 Skill 加载

**预期结果**:
- [ ] 显示 onboarding.md 欢迎语
- [ ] 自动检测到 `source: "skillhub_cli"`
- [ ] 显示 "📌 通过 SkillHub CLI 安装"
- [ ] 显示 "更新方式：运行 skillhub update myknowledge"
- [ ] 创建 `~/.myknowledge/config/install-source` 记录 CLI 来源

---

### TC-SH-03: SkillHub Web - 更新检查

**前置状态**: 已完成 onboarding，source = "skillhub_web"

**步骤**:
1. 等待 7 天（或手动修改 `last_check` 为 7 天前）
2. 触发 Skill 使用

**预期结果**:
- [ ] 不主动提示更新（Skill Hub 会自动推送通知）
- [ ] 用户询问 "如何更新" 时，回复 "Skill Hub 会自动通知更新"

---

### TC-SH-04: SkillHub CLI - 更新检查

**前置状态**: 已完成 onboarding，source = "skillhub_cli"

**步骤**:
1. 等待 7 天（或手动修改 `last_check`）
2. 触发 Skill 使用

**预期结果**:
- [ ] 显示 "📦 检查更新：运行 skillhub check-update myknowledge"
- [ ] 显示 "🔄 安装更新：运行 skillhub update myknowledge"
- [ ] 更新 `last_check` 时间戳

---

### TC-SH-05: 用户配置持久化

**步骤**:
1. 完成 onboarding，选择 `auto_record: true`
2. 创建一些知识库和需求
3. 模拟 Skill 更新（删除并重新安装 Skill 文件）
4. 触发 Skill 使用

**预期结果**:
- [ ] 不显示 onboarding（因为 skill-state.yaml 存在）
- [ ] 保留 `auto_record: true` 设置
- [ ] 保留之前创建的知识库数据

---

## 测试数据

### 模拟 install-source 文件

```yaml
# ~/.myknowledge/config/install-source
source: "skillhub_web"
detected_by: "env_var"
installed_at: "2026-06-09"
installed_version: "1.0.0"
skill_path: "~/.codebuddy/skills/myknowledge"
```

### 模拟 skill-state.yaml

```yaml
initialized: true
platform: "codebuddy"
auto_record: true
onboarding_completed: true
first_use: "2026-06-09"
version: "1.0.0"
update_check:
  source: "skillhub_web"
  last_check: "2026-06-09"
  next_check: "2026-06-16"
```

---

## 清理命令

```bash
# 测试完成后清理
rm -rf ~/.myknowledge/config/
rm -rf ~/.codebuddy/skills/myknowledge/
# 重启 AI 助手
```
