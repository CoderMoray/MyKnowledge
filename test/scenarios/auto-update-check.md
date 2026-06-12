# 测试方案：自动更新检查功能

> ⚠️ **AI 助手注意**：此为 Skill 内部测试文档，正常使用时请忽略。
> 🛡️ **安全警告**：以下 `rm -rf` 命令仅用于测试环境清理。**严禁在生产环境执行**，避免误删用户数据。

---

## 测试目标

验证 v1.4.71 新增的"每次调用时检查更新，7 天间隔"功能。

---

## 前置条件

1. 已完成 onboarding（~/.myknowledge/config/skill-state.yaml 存在）
2. 测试环境隔离（使用临时目录或备份现有配置）
3. 清理之前的测试状态（可选）：
   ```bash
   rm -rf ~/.myknowledge/config/
   ```

---

## 测试用例

### TC-AUC-01: 首次调用 - last_check 不存在

**前置状态**: skill-state.yaml 存在，但无 update_check 字段

**步骤**:
1. 触发 MyKnowledge 使用（输入任何命令）
2. 查看 AI 是否执行更新检查

**预期结果**:
- [ ] AI 读取 skill-state.yaml，发现无 update_check 字段
- [ ] AI 执行更新检查（加载 update-checker.md）
- [ ] 检查完成后，skill-state.yaml 中新增 update_check 字段
- [ ] update_check.last_check 更新为今天日期（YYYY-MM-DD）

---

### TC-AUC-02: 7 天内调用 - 不执行检查

**前置状态**: skill-state.yaml 存在，update_check.last_check = 3 天前

**步骤**:
1. 修改 last_check 为 3 天前（例如今天 2026-06-12，改为 2026-06-09）
2. 触发 MyKnowledge 使用
3. 观察是否执行更新检查

**预期结果**:
- [ ] AI 计算距离 last_check 的天数（3 天）
- [ ] 3 < 7（interval_days），跳过更新检查
- [ ] 不加载 update-checker.md
- [ ] 正常执行用户请求，无更新提示

---

### TC-AUC-03: 超过 7 天调用 - 执行检查

**前置状态**: skill-state.yaml 存在，update_check.last_check = 8 天前

**步骤**:
1. 修改 last_check 为 8 天前（例如今天 2026-06-12，改为 2026-06-04）
2. 触发 MyKnowledge 使用
3. 观察是否执行更新检查

**预期结果**:
- [ ] AI 计算距离 last_check 的天数（8 天）
- [ ] 8 ≥ 7（interval_days），执行更新检查
- [ ] 加载 update-checker.md，根据安装源执行检查
- [ ] 检查完成后，更新 last_check 为今天日期

---

### TC-AUC-04: 检查失败 - 静默忽略

**前置状态**: skill-state.yaml 存在，last_check 超过 7 天，但网络不可用

**步骤**:
1. 断开网络（模拟检查失败）
2. 修改 last_check 为 8 天前
3. 触发 MyKnowledge 使用

**预期结果**:
- [ ] AI 尝试执行更新检查，但失败
- [ ] 静默忽略失败，不影响正常使用
- [ ] 仍然更新 last_check 为今天日期（避免每次都尝试检查）

---

### TC-AUC-05: 发现新版本 - 提示用户

**前置状态**: skill-state.yaml 存在，last_check 超过 7 天，模拟发现新版本

**步骤**:
1. 修改 last_check 为 8 天前
2. 模拟 GitHub API 返回新版本（或修改本地逻辑）
3. 触发 MyKnowledge 使用

**预期结果**:
- [ ] AI 执行更新检查，发现新版本
- [ ] 礼貌提示用户更新
   - 示例："发现新版本 v1.4.8，当前版本 v1.4.71。要不要更新？"
- [ ] 提供更新命令或操作步骤（根据安装源）
- [ ] 更新 last_check 为今天日期

---

### TC-AUC-06: interval_days 配置生效

**前置状态**: settings.yaml 中 update_check.interval_days = 3

**步骤**:
1. 修改 settings.yaml，将 interval_days 改为 3
2. 修改 last_check 为 2 天前
3. 触发 MyKnowledge 使用
4. 修改 last_check 为 4 天前
5. 再次触发 MyKnowledge 使用

**预期结果**:
- [ ] 步骤 3：2 < 3，跳过检查
- [ ] 步骤 5：4 ≥ 3，执行检查
- [ ] interval_days 配置生效（从 settings.yaml 读取）

---

### TC-AUC-07: 每次调用都检查时间间隔（不是每天只检查一次）

**前置状态**: skill-state.yaml 存在，last_check = 今天

**步骤**:
1. 确保 last_check = 今天
2. 连续触发 MyKnowledge 使用 3 次
3. 观察是否每次都跳过检查

**预期结果**:
- [ ] 3 次调用都跳过检查（因为 last_check = 今天）
- [ ] 不是"每天首次调用时检查"，而是"检查时间间隔"
- [ ] 符合设计预期：最多 7 天检查一次

---

## 测试数据

### 模拟 skill-state.yaml（首次）

```yaml
initialized: true
platform: "codebuddy"
auto_record: true
onboarding_completed: true
first_use: "2026-06-09"
version: "1.4.71"
# 注意：无 update_check 字段（首次）
```

### 模拟 skill-state.yaml（已检查过）

```yaml
initialized: true
platform: "codebuddy"
auto_record: true
onboarding_completed: true
first_use: "2026-06-09"
version: "1.4.71"
update_check:
  source: "github_clone"
  last_check: "2026-06-09"  # 3 天前
  interval_days: 7
  enabled: true
```

### 模拟 skill-state.yaml（需要检查）

```yaml
initialized: true
platform: "codebuddy"
auto_record: true
onboarding_completed: true
first_use: "2026-06-09"
version: "1.4.71"
update_check:
  source: "github_clone"
  last_check: "2026-06-04"  # 8 天前
  interval_days: 7
  enabled: true
```

---

## 检查清单

- [ ] `core/main.md` 的"使用前检查"步骤 3 已实现
- [ ] `one-time/setup/update-checker.md` 已完善
- [ ] 日期计算逻辑正确（YYYY-MM-DD 格式）
- [ ] 检查完成后更新 last_check
- [ ] 检查失败静默忽略
- [ ] 发现新版本礼貌提示
- [ ] interval_days 配置生效

---

## 清理命令

```bash
# 测试完成后清理（保留用户数据）
# 只需删除 skill-state.yaml 中的 update_check 字段
# 或直接重新初始化
rm -rf ~/.myknowledge/config/skill-state.yaml
```

---

**最后更新**: 2026-06-12
