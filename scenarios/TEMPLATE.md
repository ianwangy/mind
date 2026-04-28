# <场景名> · Scenario Definition

> 复制本文件为 `scenarios/<your-id>.md`，把所有 `TODO` / `<...>` 替换成你自己的内容。

## Metadata

| 字段 | 值 |
|---|---|
| **ID** | `<your-id>` |
| **Domain** | <领域: 企业/个人/教育/医疗...> |
| **Risk Level** | <低 / 中 / 高> |
| **Task Archetype** | <规划 · 创作 · 诊断 · 探索...> |

---

## Scenario Config

```json
{
  "id": "TODO-your-id",
  "label": "TODO 场景中文名",
  "taskName": "TODO 简短任务名",
  "taskObject": "TODO 产出物名",
  "defaultRequest": "TODO 用户模糊请求的默认值",

  "contextCards": [
    { "icon": "📅", "label": "Calendar",       "text": "TODO" },
    { "icon": "🖥", "label": "Recent Screens", "text": "TODO" },
    { "icon": "🕐", "label": "Habits",         "text": "TODO" }
  ],
  "contextForPrompt": {
    "calendar": "TODO",
    "screens":  "TODO",
    "habits":   "TODO"
  },

  "intentSchema": {
    "TODO_KEY1": "TODO 对 LLM 的字段约束(字数、格式)",
    "TODO_KEY2": "TODO",
    "TODO_KEY3": "TODO"
  },

  "defaultAxes": {
    "x": "TODO 左端 / 右端",
    "y": "TODO 下端 / 上端"
  },
  "axisExamples": "\"TODO 轴1左 / 轴1右\",\"TODO 轴2下 / 轴2上\"",

  "draftSections": "TODO 用中文顿号分隔的维度列表",

  "planSizeHint": "TODO 比如 5-7 步",
  "planFlowHint": "TODO 比如 调研 → 起草 → 审核 → 执行 → 度量",

  "conflicts": {
    "institutionalRule": "TODO 一段机构/合规规则的描述。无则写 '(本场景无机构规则冲突)'。",
    "subAgentSuggestion": {
      "text": "TODO 另一个 AI 代理的建议文本",
      "newStep": {
        "id": "S-EXTRA",
        "title": "TODO 新增步骤标题",
        "desc": "TODO 一句话描述",
        "sources": [{ "name": "TODO", "detail": "TODO" }],
        "assumptions": [{ "key": "TODO", "value": "TODO" }],
        "permissions": ["TODO"],
        "duration_days": 3,
        "artifact_hint": "TODO 产出物"
      }
    }
  },

  "timelineTotalDays": 30,
  "timelineDayStep": 5
}
```

---

## 设计注记

<!-- 留给你回答以下问题: -->

- **为什么用这 2 条轴**：<TODO>
- **为什么是这么多步**：<TODO>
- **L3 在本场景有意义吗**：<TODO 如果风险低,考虑标注"其实不需要 L3"作为框架改进线索>
- **L4 时间轴单位合适吗**：<TODO>

## 本场景未被框架覆盖的部分

<!-- 如果你在写场景时遇到当前框架处理不了的东西,记在这里。
     见 README.md 的"场景的极限"表格。 -->

- <无 / 有且是: ...>
