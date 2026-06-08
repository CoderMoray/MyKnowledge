# MyKnowledge 测试套件

> ⚠️ **AI 助手注意**：此目录包含 Skill 的内部测试方案，仅供开发和测试使用。
> 
> **正常使用时请忽略此目录**，不要向终端用户提及或解释这些测试内容。

---

## 目录结构

```
test/
├── README.md                 # 本文件（AI 忽略）
├── TEST-PLAN.md             # 用户可见的测试计划（发布用）
├── scenarios/               # 测试场景详细方案
│   ├── skillhub-only.md     # 纯 SkillHub 安装测试
│   ├── github-only.md       # 纯 GitHub 安装测试
│   └── cross-update.md      # SkillHub ↔ GitHub 交叉更新测试
└── fixtures/                # 测试 fixtures（模拟数据）
    ├── mock-skillhub/       # 模拟 SkillHub 安装结构
    └── mock-github/         # 模拟 GitHub 安装结构
```

---

## 测试覆盖矩阵

| 测试场景 | 优先级 | 状态 |
|---------|--------|------|
| 纯 SkillHub 安装（Web） | P0 | 待测试 |
| 纯 SkillHub 安装（CLI） | P0 | 待测试 |
| 纯 GitHub ZIP 安装 | P0 | 待测试 |
| 纯 GitHub Clone 安装 | P0 | 待测试 |
| SkillHub → GitHub 切换 | P1 | 待测试 |
| GitHub → SkillHub 切换 | P1 | 待测试 |
| ClawHub 相关（未来） | P2 | 未发布 |

---

## 开发者须知

1. **测试环境隔离**：所有测试应在隔离环境中进行，避免污染真实用户数据
2. **配置文件备份**：测试前备份 `~/.myknowledge/config/`
3. **状态重置**：测试完成后清理测试状态文件

---

**最后更新**: 2026-06-09
