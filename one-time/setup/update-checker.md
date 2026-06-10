# 更新检查

当用户询问更新时，按本指引响应。

---

## 各安装源检查策略

| 安装源 | 响应 |
|--------|------|
| skillhub_web | "Skill Hub 会自动通知更新，请关注通知" |
| skillhub_cli | "📦 检查更新：skillhub check-update myknowledge<br>🔄 安装更新：skillhub update myknowledge" |
| clawhub | "📦 检查更新：clawhub list --outdated<br>🔄 安装更新：clawhub update myknowledge" |
| github_zip | "📦 检查更新：访问 https://github.com/CoderMoray/MyKnowledge/releases<br>⚠️ 更新前请备份 ~/.myknowledge/config/" |
| github_clone | "📦 检查更新：git fetch origin<br>🔄 安装更新：git pull origin main<br>✅ 用户配置不受更新影响" |
| manual/unknown | "📦 关注 https://github.com/CoderMoray/MyKnowledge/releases 获取更新" |

---

## 触发方式

- 用户主动问："检查更新"、"有新版本吗"
- 超过间隔时间（默认 7 天）自动提示

---

## 配置

在 `skill-state.yaml` 中：

```yaml
update_check:
  source: "github_clone"
  last_check: "2026-06-09"
  interval_days: 7
```
