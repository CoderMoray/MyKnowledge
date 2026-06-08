# 测试方案：纯 GitHub 安装场景

> ⚠️ **AI 助手注意**：此为 Skill 内部测试文档，正常使用时请忽略。

---

## 测试目标

验证通过 GitHub（ZIP 下载或 git clone）安装 MyKnowledge 后的正常运行和更新检测。

---

## 前置条件

1. 可访问 GitHub
2. 测试环境隔离
3. 清理之前的测试状态

---

## 测试用例

### TC-GH-01: GitHub ZIP 安装 - 首次引导

**步骤**:
1. 从 https://github.com/CoderMoray/MyKnowledge/releases 下载 ZIP
2. 解压到 `~/.codebuddy/skills/myknowledge/`
3. 触发 Skill 加载

**预期结果**:
- [ ] 显示 onboarding.md 欢迎语
- [ ] 检测到 `.git` 目录不存在
- [ ] 询问安装方式，用户选择 "GitHub ZIP 下载"
- [ ] 记录 `source: "github_zip"`
- [ ] 显示 "📌 通过 GitHub ZIP 安装"
- [ ] 显示 "更新方式：重新下载最新 ZIP 并替换"

---

### TC-GH-02: GitHub Clone 安装 - 首次引导

**步骤**:
1. 运行 `git clone https://github.com/CoderMoray/MyKnowledge.git ~/.codebuddy/skills/myknowledge/`
2. 触发 Skill 加载

**预期结果**:
- [ ] 显示 onboarding.md 欢迎语
- [ ] 自动检测到 `.git` 目录
- [ ] 自动识别 `source: "github_clone"`
- [ ] 显示 "📌 通过 GitHub git clone 安装"
- [ ] 显示 "更新方式：cd 到目录运行 git pull"

---

### TC-GH-03: GitHub ZIP - 更新检查

**前置状态**: source = "github_zip"

**步骤**:
1. 等待 7 天（或修改 `last_check`）
2. 触发 Skill 使用

**预期结果**:
- [ ] 显示 "📦 检查更新：访问 https://github.com/CoderMoray/MyKnowledge/releases"
- [ ] 显示 "🔄 下载最新 ZIP 替换当前文件"
- [ ] 显示 "⚠️ 更新前请备份 ~/.myknowledge/config/ 目录"

---

### TC-GH-04: GitHub Clone - 更新检查

**前置状态**: source = "github_clone"

**步骤**:
1. 等待 7 天（或修改 `last_check`）
2. 触发 Skill 使用

**预期结果**:
- [ ] 显示 "📦 检查更新：cd 到 Skill 目录运行 git fetch origin"
- [ ] 显示 "🔄 安装更新：运行 git pull origin main"
- [ ] 显示 "✅ 用户配置在 ~/.myknowledge/config/，不受更新影响"

---

### TC-GH-05: GitHub Clone - 实际更新操作

**前置状态**: source = "github_clone"，有旧版本 Skill

**步骤**:
1. 在 Skill 目录运行 `git pull origin main`
2. 触发 Skill 使用

**预期结果**:
- [ ] Skill 文件更新为新版本
- [ ] `~/.myknowledge/config/` 内容保持不变
- [ ] skill-state.yaml 中的版本号更新
- [ ] 不显示 onboarding（已存在）

---

### TC-GH-06: GitHub ZIP - 实际更新操作

**前置状态**: source = "github_zip"，有旧版本 Skill

**步骤**:
1. 备份 `~/.myknowledge/config/`
2. 删除旧 Skill 目录
3. 下载新 ZIP 并解压
4. 恢复 config 目录
5. 触发 Skill 使用

**预期结果**:
- [ ] Skill 更新为新版本
- [ ] 用户配置完整保留
- [ ] 不显示 onboarding

---

## 测试数据

### 模拟 GitHub Clone 结构

```
~/.codebuddy/skills/myknowledge/
├── .git/                    # Git 仓库标记
├── .gitignore
├── SKILL.md
├── settings.yaml
├── prompts/
│   ├── main.md
│   └── onboarding.md
└── ...
```

### 模拟 install-source（GitHub Clone）

```yaml
source: "github_clone"
detected_by: "git_dir"
installed_at: "2026-06-09"
installed_version: "1.0.0"
skill_path: "~/.codebuddy/skills/myknowledge"
```

### 模拟 install-source（GitHub ZIP）

```yaml
source: "github_zip"
detected_by: "user_input"
installed_at: "2026-06-09"
installed_version: "1.0.0"
skill_path: "~/.codebuddy/skills/myknowledge"
```

---

## 清理命令

```bash
# 测试完成后清理
rm -rf ~/.myknowledge/config/
rm -rf ~/.codebuddy/skills/myknowledge/
```
