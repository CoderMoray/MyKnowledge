# 更新检查

当用户询问更新时，按本指引响应。

> ⚠️ **用户数据安全**：`~/.myknowledge/` 与 Skill 文件分离，更新/重装不会影响你的知识库、配置和需求记录。

---

## 各安装源检查策略

| 安装源 | 检查方式 | 升级方式 |
|--------|---------|---------|
| skillhub_web | 无自动通知，需手动检查 | 在 SkillHub 中搜索 my-knowledge 并重新安装，或对 AI 说"安装 my-knowledge 技能" |
| skillhub_cli | `skillhub list` 查看可用版本 | `skillhub upgrade myknowledge` |
| clawhub | `clawhub list --outdated` | `clawhub update myknowledge` |
| github_zip | 访问 https://github.com/CoderMoray/MyKnowledge/releases | 下载新版 ZIP 解压覆盖 |
| github_clone | `git fetch origin` | `git pull origin main` |
| manual/unknown | 访问 https://github.com/CoderMoray/MyKnowledge/releases | 手动下载覆盖 |

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
