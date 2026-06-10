# MyKnowledge 安装指南

## 支持的 AI 平台

| 平台 | 支持版本 | 安装方式 |
|------|----------|----------|
| CodeBuddy | 最新版 | 手动安装 |
| WorkBuddy | 最新版 | 手动安装 |
| OpenClaw | 最新版 | 手动安装 |
| Claude | 最新版 | 手动安装 |

---

## 安装步骤

### 方式一：Git 克隆（推荐）

```bash
# 克隆仓库
git clone https://github.com/CoderMoray/MyKnowledge.git

# 根据平台选择安装路径
```

---

### 方式二：手动下载

1. 访问 https://github.com/CoderMoray/MyKnowledge
2. 点击 "Code" → "Download ZIP"
3. 解压到合适的位置

---

### 平台特定安装

#### CodeBuddy

```bash
# 创建 skills 目录（如不存在）
mkdir -p ~/.codebuddy/skills

# 复制 Skill
cp -r MyKnowledge ~/.codebuddy/skills/myknowledge

# 重启 CodeBuddy
```

#### WorkBuddy

```bash
# 创建 skills 目录（如不存在）
mkdir -p ~/.workbuddy/skills

# 复制 Skill
cp -r MyKnowledge ~/.workbuddy/skills/myknowledge

# 重启 WorkBuddy
```

#### OpenClaw

```bash
# 创建 skills 目录（如不存在）
mkdir -p ~/.openclaw/skills

# 复制 Skill
cp -r MyKnowledge ~/.openclaw/skills/myknowledge

# 重启 OpenClaw
```

---

## 验证安装

安装完成后，对 AI 说：

```
创建知识库
```

如果 AI 响应并询问创建全局还是项目知识库，说明安装成功。

---

## 可选配置

### OpenClaw 启用 Hook（推荐）

OpenClaw 用户可启用 Hook 实现真正的静默模式：

```bash
# 启用 Hook
openclaw hooks enable myknowledge

# 验证 Hook 状态
openclaw hooks list
```

---

## 卸载

```bash
# CodeBuddy
rm -rf ~/.codebuddy/skills/myknowledge

# WorkBuddy
rm -rf ~/.workbuddy/skills/myknowledge

# OpenClaw
rm -rf ~/.openclaw/skills/myknowledge
```

---

## 故障排除

### 问题：Skill 未加载

**检查清单**:
1. 目录名是否为 `myknowledge`（小写）
2. SKILL.md 是否在目录根级别
3. AI 是否已重启

### 问题：首次引导未显示

**检查清单**:
1. 检查 `skill-state.yaml` 是否已存在
2. 删除 `skill-state.yaml` 重新加载

### 问题：权限错误

**解决**:
```bash
chmod -R 755 ~/.codebuddy/skills/myknowledge
```

---

## 获取帮助

- GitHub Issues: https://github.com/CoderMoray/MyKnowledge/issues
- 文档: https://github.com/CoderMoray/MyKnowledge/blob/main/README.md

---

**最后更新**: 2026-06-10
