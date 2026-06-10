# {{project_name}} 设计文档

**版本**: {{version}}  
**创建日期**: {{created_at}}  
**最后更新**: {{updated_at}}

---

## 1. 架构设计

### 1.1 整体架构

{{architecture_overview}}

### 1.2 模块划分

| 模块 | 职责 | 关键类/函数 |
|------|------|-------------|
| {{module_name}} | {{module_responsibility}} | {{key_components}} |

---

## 2. 接口设计

### 2.1 对外接口

```python
class {{ClassName}}:
    def {{method_name}}(self, {{params}}) -> {{return_type}}:
        """{{method_description}}"""
        pass
```

### 2.2 内部接口

{{internal_interfaces}}

---

## 3. 数据模型

### 3.1 核心数据结构

{{data_structures}}

### 3.2 状态流转

{{state_transitions}}

---

## 4. 错误处理

| 错误类型 | 处理方式 | 返回信息 |
|----------|----------|----------|
| {{error_type}} | {{handling_strategy}} | {{error_message}} |

---

## 5. 依赖关系

### 5.1 依赖项

| 依赖 | 用途 | 版本要求 |
|------|------|----------|
| {{dependency}} | {{usage}} | {{version}} |

### 5.2 被依赖项

{{dependents}}

---

## 6. 设计决策记录

| 日期 | 决策 | 原因 | 替代方案 |
|------|------|------|----------|
| {{date}} | {{decision}} | {{reason}} | {{alternatives}} |

---

## 7. 待解决问题

- [ ] {{pending_issue}}

---

## 附录

### A. 参考文档

{{references}}

### B. 术语表

| 术语 | 定义 |
|------|------|
| {{term}} | {{definition}} |
