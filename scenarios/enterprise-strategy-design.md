# 战略设计 · Scenario Definition

> 由 scenario-editor.html 生成 · 可继续手动编辑

## Metadata

| 字段 | 值 |
|---|---|
| **ID** | `enterprise-strategy-design` |
| **Label** | 战略设计 |
| **Task Name** | 战略设计 |
| **Task Object** | 战略规划书 |

---

## Scenario Config

以下 **唯一** JSON 代码块会被 `ux-prototype.html` 解析。

```json
{
  "id": "enterprise-strategy-design",
  "label": "战略设计",
  "taskName": "战略设计",
  "taskObject": "战略规划书",
  "defaultRequest": "我们需要制定未来三年的战略方向",
  "contextCards": [
    {
      "icon": "📅",
      "label": "Calendar",
      "text": "与董事会战略会议"
    },
    {
      "icon": "🖥",
      "label": "Recent Screens",
      "text": "行业分析报告"
    },
    {
      "icon": "🕐",
      "label": "Habits",
      "text": "每周领导层例会"
    }
  ],
  "contextForPrompt": {
    "calendar": "战略会议",
    "screens": "行业报告",
    "habits": "领导层周会"
  },
  "intentSchema": {
    "key1": "目标: 最多100字，描述战略目标",
    "key2": "资源: 最多200字，列出可用资源",
    "key3": "时间范围: 如1-3年",
    "key4": "风险偏好: 保守/平衡/激进",
    "key5": "关键成果: 最多50字，描述关键成果"
  },
  "defaultAxes": {
    "x": "收益 / 风险",
    "y": "稳定 / 增长"
  },
  "axisExamples": "\"收益稳定\",\"风险增长\"",
  "draftSections": "市场分析、竞争分析、内部能力、目标设定、行动计划",
  "planSizeHint": "5-7 步",
  "planFlowHint": "诊断 → 分析 → 规划 → 对齐 → 执行",
  "conflicts": {
    "institutionalRule": "(本场景无机构规则冲突)",
    "subAgentSuggestion": {
      "text": "建议增加风险对冲步骤",
      "newStep": {
        "id": "S-EXTRA",
        "title": "风险对冲规划",
        "desc": "识别关键风险并制定对冲策略",
        "sources": [
          {
            "name": "风险库",
            "detail": "历史风险数据"
          }
        ],
        "assumptions": [
          {
            "key": "风险概率",
            "value": "中高"
          }
        ],
        "permissions": [
          "CEO审批"
        ],
        "duration_days": 14,
        "artifact_hint": "风险对冲方案"
      }
    }
  },
  "timelineTotalDays": 90,
  "timelineDayStep": 7
}
```

---

## 设计注记

<!-- 留给开发者回答以下问题: -->

- **为什么选这 2 条轴**：<TODO>
- **为什么是这么多步**：<TODO>
- **L3 在本场景有意义吗**：<TODO>
- **L4 时间轴单位合适吗**：<TODO>

## 本场景未被框架覆盖的部分

<!-- 如果你在写场景时遇到当前框架处理不了的东西,记在这里。见 README.md -->

- <无 / 有且是: ...>
