# 项目状态

## 基本信息
- 项目名称: {{project_name}}
- 创建时间: {{created_at}}
- 最后更新: {{updated_at}}

## 当前阶段
{{current_stage}}

## 活跃需求
{{#active_requirements}}
- [{{id}}] {{title}} - {{status}}
{{/active_requirements}}

## 已完成
{{#completed_requirements}}
- [{{id}}] {{title}} - 完成于 {{completed_at}}
{{/completed_requirements}}

## 数据资产索引
{{#data_assets}}
- [{{status}}] {{name}} - {{location}} - 更新于 {{updated_at}}
{{/data_assets}}

## 备注
{{notes}}
