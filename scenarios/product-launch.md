# 产品发布策略 · Scenario Definition

> 这是 Intent Fabric 的第一个场景定义。系统会读取下方 `json` 代码块作为运行时配置，其余 markdown 文本仅作开发文档。

## Metadata

| 字段 | 值 |
|---|---|
| **ID** | `product-launch` |
| **Domain** | 企业 / 市场 |
| **Risk Level** | 中高（对外发布、法务、预算牵涉多方） |
| **Task Archetype** | 规划 · 多步编排 · 有时间线 |

---

## Scenario Config

以下 **唯一** JSON 代码块会被 `ux-prototype.html` 解析成 `scenario` 对象。保持块内是合法 JSON（无注释、无尾逗号）。

```json
{
  "id": "product-launch",
  "label": "产品发布策略",
  "taskName": "产品发布",
  "taskObject": "产品发布策略",
  "defaultRequest": "帮我制定产品发布策略",

  "contextCards": [
    { "icon": "📅", "label": "Calendar",       "text": "下周四 14:00 · 团队 roadmap 评审" },
    { "icon": "🖥", "label": "Recent Screens", "text": "Linear 定价页 · Notion 竞品分析文档" },
    { "icon": "🕐", "label": "Habits",         "text": "偏好简洁文档 · 常用\"优先级 + 时间线\"模板" }
  ],
  "contextForPrompt": {
    "calendar": "下周四 14:00 团队 roadmap 评审",
    "screens":  "Linear 定价页, Notion 竞品分析",
    "habits":   "偏好简洁文档 · 优先级 + 时间线模板"
  },

  "intentSchema": {
    "goal":     "用一句话概括当前对目标的理解(16字内)",
    "audience": "目标对象(12字内,未知则空)",
    "horizon":  { "label": "时间视野", "hint": "预期的发布窗口", "critical": true, "type": "enum", "options": ["1 个月内", "1-3 个月", "3-6 个月", "半年以上"] },
    "priority": { "label": "首要考量", "hint": "本次发布最优先保护的目标", "critical": true, "type": "enum", "options": ["速度上线", "品牌势能", "成本控制", "风险防控", "用户体验"] }
  },

  "defaultAxes": {
    "x": "即时收入 / 长期品牌",
    "y": "激进扩张 / 稳健防守"
  },
  "axisExamples": "\"即时收入 / 长期品牌\",\"激进扩张 / 稳健防守\"",

  "draftSections": "目标受众定位、核心信息、时间线、主要渠道、风险控制、成功指标",

  "planSizeHint": "5-7 步",
  "planFlowHint": "调研 → 起草 → 审核 → 执行 → 度量",

  "conflicts": {
    "institutionalRule": "销售部规则要求：发布前须经法务审核。审计受限模式下,\"法务\"相关步骤无法跳过。",
    "subAgentSuggestion": {
      "text": "另一位代理建议同时启动 A/B 测试以度量效果。",
      "newStep": {
        "id": "S-AB",
        "title": "并行 A/B 测试",
        "desc": "上线同时启动 A/B 测试,度量两种文案的转化差异",
        "sources": [{ "name": "子代理建议", "detail": "来自协同 AI 的并行测试提案" }],
        "assumptions": [{ "key": "样本", "value": "每组 ≥ 1k 用户" }],
        "permissions": ["接入 A/B 测试平台"],
        "duration_days": 7,
        "artifact_hint": "A/B 测试计划与指标定义"
      }
    }
  },

  "timelineTotalDays": 30,
  "timelineDayStep": 5
}
```

---

## 本场景的设计注记

- **为什么用 2 条正交轴**：产品发布的核心张力确实可以用"收入 vs 品牌"和"激进 vs 稳健"两组对立概念拉开，维度高了用户反而选不动。
- **为什么是 5-7 步**：产品发布的常规流程（调研 → 起草 → 审核 → 执行 → 度量）自然 5-7 步，再细就堆成噪音。
- **为什么需要 L3 编排层**：发布涉及法务/销售/市场多个利益方，典型的"高风险任务需要协商与审计"。
- **为什么 L4 时间轴以天为单位**：产品发布节奏一般按天 / 周算，30 天够覆盖从准备到首轮度量的完整周期。

如果你要换的场景不符合以上任何一条（比如"写邮件"可能根本不需要 L3），就说明你的场景对 **框架本身** 提出了新的需求——见 [README.md](README.md) 的"场景的极限"一节。
