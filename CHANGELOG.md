# Changelog

所有版本变更记录。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)。

---

## [1.0.0] - 2026-06-08

### 🎉 初始发布

#### 新增
- **核心功能**: 知识库创建和管理
  - 支持全局知识库（~/MyKnowledge/global/）
  - 支持项目知识库（{project}/.myknowledge/）
  
- **需求管理**: 完整的需求生命周期管理
  - 创建需求（REQ-{date}-{seq} 格式）
  - 状态流转（Created → In Progress → Review → Done）
  - 自动更新 PROJECT-STATUS.md

- **静默模式**: 自动检测复杂任务
  - 关键词检测（分析、统计、开发等）
  - 自动创建知识库和记录需求
  - 可配置的检测规则

- **平台适配**: 支持三大 AI 平台
  - CodeBuddy（意图识别模式）
  - WorkBuddy（意图识别模式）
  - OpenClaw（Hook + 意图识别）

- **首次引导**: 智能的平台检测和引导流程
  - 自动检测当前平台
  - 针对性的配置引导
  - 状态持久化（skill-state.yaml）

- **会话恢复**: 从文件恢复项目状态
  - 读取 PROJECT-STATUS.md
  - 恢复任务上下文

#### 文档
- README.md - 项目概述
- SKILL.md - Skill 主入口
- settings.yaml - 配置说明
- INSTALL.md - 安装指南
- USAGE.md - 使用指南
- TEST-PLAN.md - 测试计划
- 模板文件（PROJECT-STATUS、需求 README、设计文档）

#### 技术特性
- 纯 Prompt + YAML 配置实现
- 可选的 OpenClaw Hook 支持
- 跨平台兼容
- 无外部依赖

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
