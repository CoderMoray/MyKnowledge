# 更新检查逻辑

> 本文档描述 MyKnowledge 的更新检查策略和实现。

---

## 检查触发条件

### 时间触发

```
IF 当前日期 > last_check + interval_days:
   执行更新检查
   更新 last_check = 今天
```

### 用户主动触发

```
用户说：
- "检查更新"
- "如何更新"
- "有新版本吗"
→ 立即执行更新检查
```

---

## 各安装源检查策略

### skillhub_web

```
策略：被动等待
- Skill Hub 会自动推送更新通知
- 代码不主动检查
- 用户询问时回复："请关注 Skill Hub 通知"
```

### skillhub_cli

```
策略：定期提醒
- 间隔：7 天
- 触发时显示：
  "📦 检查更新：运行 skillhub check-update myknowledge"
  "🔄 安装更新：运行 skillhub update myknowledge"
```

### clawhub

```
策略：按需提示
- 用户询问时显示：
  "📦 检查更新：运行 clawhub list --outdated"
  "🔄 安装更新：运行 clawhub update myknowledge"
```

### github_zip

```
策略：定期提醒
- 间隔：7 天
- 触发时显示：
  "📦 检查更新：访问 https://github.com/CoderMoray/MyKnowledge/releases"
  "🔄 下载最新 ZIP 替换当前文件"
  "⚠️ 更新前请备份 ~/.myknowledge/config/ 目录"
```

### github_clone

```
策略：定期提醒
- 间隔：7 天
- 触发时显示：
  "📦 检查更新：cd 到 Skill 目录运行 git fetch origin"
  "🔄 安装更新：运行 git pull origin main"
  "✅ 用户配置在 ~/.myknowledge/config/，不受更新影响"
```

### manual / unknown

```
策略：低频提醒
- 间隔：30 天
- 触发时显示：
  "📦 关注 https://github.com/CoderMoray/MyKnowledge/releases 获取更新"
```

---

## 配置存储

### skill-state.yaml 中的更新配置

```yaml
update_check:
  source: "github_clone"      # 安装源
  last_check: "2026-06-09"    # 上次检查时间
  next_check: "2026-06-16"    # 下次检查时间（可选）
  interval_days: 7            # 检查间隔
```

---

## 检查流程图

```
用户触发 Skill
    │
    ▼
读取 skill-state.yaml
    │
    ▼
检查 install-source
    │
    ├── skillhub_web ──→ 不主动检查
    │
    ├── skillhub_cli ──┐
    ├── github_zip ────┤→ 检查是否超过 interval_days
    ├── github_clone ──┤   是 → 显示更新提示
    │                  │   否 → 跳过
    └── manual ────────┘
```

---

## 用户自定义配置

用户可通过修改 `skill-state.yaml` 调整：

```yaml
update_check:
  interval_days: 14    # 改为 14 天检查一次
  enabled: false       # 完全关闭更新检查
```

---

## 测试要点

| 测试项 | 验证点 |
|--------|--------|
| 首次检查 | 立即显示提示（无 last_check） |
| 时间间隔 | 7 天内不重复提示 |
| 源变更后 | 按新安装源的策略提示 |
| 关闭检查 | enabled: false 时不提示 |
