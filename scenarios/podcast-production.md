# 播客制作 · Scenario Definition

> 由 scenario-editor.html 生成 · 可继续手动编辑

## Metadata

| 字段 | 值 |
|---|---|
| **ID** | `podcast-production` |
| **Label** | 播客制作 |
| **Task Name** | 制作播客 |
| **Task Object** | 播客节目 |

---

## Scenario Config

以下 **唯一** JSON 代码块会被 `ux-prototype.html` 解析。

```json
{
  "id": "podcast-production",
  "label": "播客制作",
  "taskName": "制作播客",
  "taskObject": "播客节目",
  "defaultRequest": "我想制作一期播客节目",
  "contextCards": [
    {
      "icon": "📅",
      "label": "Calendar",
      "text": "录音室预约 14:00-16:00"
    },
    {
      "icon": "🖥",
      "label": "Recent Screens",
      "text": "音频编辑软件界面"
    },
    {
      "icon": "🕐",
      "label": "Habits",
      "text": "每周末录制，周三发布"
    }
  ],
  "contextForPrompt": {
    "calendar": "录音室预约 14:00-16:00",
    "screens": "音频编辑软件",
    "habits": "周三录制，周一发布"
  },
  "intentSchema": {
    "主题": "播客主题，10字以内",
    "嘉宾": "嘉宾姓名或描述，可空",
    "时长": "期望时长，如30分钟",
    "风格": "风格如访谈/独白/故事，可空",
    "发布平台": "如Spotify/Apple，可空"
  },
  "defaultAxes": {
    "x": "严肃 / 轻松",
    "y": "单人 / 多人"
  },
  "axisExamples": "\"严肃/轻松\",\"单人/多人\"",
  "draftSections": "主题、嘉宾、大纲、设备、后期",
  "planSizeHint": "5-7步",
  "planFlowHint": "构思 → 邀约 → 录制 → 剪辑 → 发布",
  "conflicts": {
    "institutionalRule": "(本场景无机构规则冲突)",
    "subAgentSuggestion": {
      "text": "建议加入音效设计以提升收听体验",
      "newStep": {
        "id": "S-EXTRA",
        "title": "音效设计",
        "desc": "为播客添加背景音乐和过渡音效",
        "sources": [
          {
            "name": "音效库",
            "detail": "免版权音效网站"
          }
        ],
        "assumptions": [
          {
            "key": "版权",
            "value": "使用免版权音效"
          }
        ],
        "permissions": [
          "访问音效库"
        ],
        "duration_days": 1,
        "artifact_hint": "音频素材"
      }
    }
  },
  "timelineTotalDays": 14,
  "timelineDayStep": 1
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
