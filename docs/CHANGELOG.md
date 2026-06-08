# Changelog

所有版本变更记录。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)。

---

## [1.0.0] - 2026-06-09

### 🎉 初始发布

#### 核心功能
- **知识库管理**: 创建标准化的知识库目录结构
  - 全局知识库（~/MyKnowledge/global/）
  - 项目知识库（{project}/.myknowledge/）
  - 自动初始化 README、PROJECT-STATUS.md 等文件

- **需求生命周期管理**: 完整跟踪需求状态
  - 创建需求（REQ-{date}-{seq} 格式）
  - 状态流转（Created → In Progress → Review → Done → Cancelled）
  - 自动归档已完成需求

- **静默模式**: 智能检测复杂任务
  - 关键词匹配（分析、统计、开发等 10+ 关键词）
  - 可配置敏感度（min_keyword_count）
  - 首次触发时询问用户偏好

#### 跨平台支持
- **CodeBuddy**: 意图识别模式
- **WorkBuddy**: 意图识别模式
- **OpenClaw**: Hook + 意图识别（支持真静默）

#### 安装与更新
- **6种安装源支持**: SkillHub(Web/CLI)、ClawHub、GitHub(ZIP/Clone)、手动安装
- **安装源自动检测**: 环境变量、目录标记、用户确认
- **安装源变更检测**: 自动检测或用户主动告知
- **用户数据分离**: 配置存储在 ~/.myknowledge/config/，Skill 更新不丢失

#### 首次引导
- 平台自动检测（CodeBuddy/WorkBuddy/OpenClaw）
- 安装源自动识别
- 自动记录偏好设置
- 可选新手实操教程
- 引导完成后不再显示

#### 文档与模板
- 完整的用户文档（README、QUICKSTART、USAGE、FAQ、INSTALL）
- 3种文档模板（项目状态、需求文档、设计文档）
- 开发文档（DEVELOPMENT、helpers/）
- 测试套件（test/）

#### 技术特性
- 懒加载设计：onboarding 只加载一次
- 上下文优化：正常使用约 9K tokens
- 身份不冲突：能力声明式 Prompt，不覆盖 Agent 角色
- 无外部依赖：纯 Prompt + YAML 实现

---

## 版本规划

### [1.1.0] - 计划中

#### 预期功能
- [ ] 需求优先级管理
- [ ] 标签/分类系统
- [ ] 需求依赖关系
- [ ] 导出功能（PDF、HTML）
- [ ] 多语言支持

### [1.2.0] - 计划中

#### 预期功能
- [ ] 与项目2（Agent Team Skill）集成
- [ ] 自动工作流生成
- [ ] 数据血缘追踪
- [ ] 高级搜索功能

---

## 版本号说明

采用 [语义化版本](https://semver.org/lang/zh-CN/)：

- **主版本号**：不兼容的 API 修改
- **次版本号**：向下兼容的功能新增
- **修订号**：向下兼容的问题修正

---

**维护者**: CoderMoray  
**GitHub**: https://github.com/CoderMoray/MyKnowledge  
**许可证**: Apache License 2.0
