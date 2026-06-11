# 需求列表

> 本文档是需求索引页，列出所有活跃需求的状态和最后更新时间。
> **职责边界**：本文档仅做索引（ID+标题+状态+时间），不包含需求详情。
> 需求详情在 `requirements/{id}/README.md` 中，项目整体状态在 `PROJECT-STATUS.md` 中。

## 活跃需求

| 需求ID | 标题 | 状态 | 最后更新 | 负责人 |
|--------|------|------|----------|--------|
{{#active_requirements}}
| [{{id}}](./{{id}}/README.md) | {{title}} | {{status}} | {{updated_at}} | {{owner}} |
{{/active_requirements}}

{{^active_requirements}}
*暂无活跃需求*
{{/active_requirements}}

## 已完成需求

| 需求ID | 标题 | 完成时间 |
|--------|------|----------|
{{#completed_requirements}}
| [{{id}}](../archive/{{id}}/README.md) | {{title}} | {{completed_at}} |
{{/completed_requirements}}

{{^completed_requirements}}
*暂无已完成需求*
{{/completed_requirements}}
