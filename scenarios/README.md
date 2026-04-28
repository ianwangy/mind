# Scenarios · 开发者指南

Intent Fabric 的 4 层 UX 框架本身是**领域无关**的。把它用到一个具体领域，需要一份「场景定义」—— 就在这个目录里，每份场景一个 `.md` 文件。

本文档告诉你：**怎么写一个新的场景 md？**

---

## 0. 三分钟上手

1. 复制 [TEMPLATE.md](TEMPLATE.md) 为 `scenarios/your-scenario.md`
2. 改文件开头 `json` 代码块里的字段
3. 用 HTTP 打开页面：`http://localhost:xxx/ux-prototype.html?scenario=your-scenario`
4. 如果红色错误横幅出现 → 按提示补字段 / 修 JSON 语法

> ⚠️ 用 `file://` 双击打开 HTML 会因浏览器安全策略加载不了 md，页面会退回到**内嵌的 fallback 场景**并在顶部提示。要编辑 md 就必须起一个本地 HTTP 服务（`python -m http.server`、`npx serve`、VSCode Live Server 都行）。

---

## 1. 为什么是 md 而不是 json 或 yaml

- **md 不是格式，是壳**：我们把整段 JSON 嵌在 ` ```json ` 代码块里，其余 markdown 是给**人**看的设计注记。
- 写 md 的人同时是在写文档——这个文档本身逼你思考"为什么这个场景选了这些参数"。
- 系统只解析第一个 `json` 代码块，忽略其他所有文本。你想写多少散文都行。

---

## 2. 必填字段参考

| 字段 | 类型 | 说明 | 影响哪一层 |
|---|---|---|---|
| `id` | string | URL 安全的唯一标识（短横线分隔） | 路由 `?scenario=<id>` |
| `label` | string | 顶部 badge 里显示的场景中文名 | 全局 |
| `taskName` | string | 简短任务名，会被塞进 prompt（如"产品发布"） | L1-L3 prompts |
| `taskObject` | string | 产出物名，会被塞进 prompt（如"产品发布策略"） | L1-L3 prompts |
| `defaultRequest` | string | textarea 的默认模糊请求 | L1 输入框 |
| `contextCards` | array | L1 顶部三张环境感知卡（UI 展示） | L1 UI |
| `contextForPrompt` | object | 三个字符串字段：`calendar / screens / habits`，写进 L1 prompt | L1 prompt |
| `intentSchema` | object | **关键字段**。L1 intent_summary 里希望 LLM 输出哪些字段，每个字段写上生成约束 | L1 prompt + Crystal |
| `defaultAxes` | object | `x / y`，LLM 推轴失败时的兜底 | L2 |
| `axisExamples` | string | 给 LLM 的正交轴例子 | L2 prompt |
| `draftSections` | string | "大而全"初稿要覆盖的维度列表 | L2 subtractive |
| `planSizeHint` | string | 计划步数范围（如"5-7 步"） | L3 prompt |
| `planFlowHint` | string | 常规流程骨架（如"调研 → 起草 → 审核 → 执行 → 度量"） | L3 prompt |
| `conflicts` | object | L3 侧栏两张 mock 冲突卡 | L3 UI |
| `timelineTotalDays` | number | L4 Gantt 总跨度 | L4 |
| `timelineDayStep` | number | L4 Gantt 刻度间隔 | L4 |

缺任何一项 → 页面顶部红色错误横幅，并列出缺失字段。

---

## 3. 写好每个字段的门道

### `intentSchema` —— 场景最重要的字段

这是 L1 的「本体」。你列几个 key，LLM 就按这些 key 组织它对用户意图的理解，L1 prompt / answer_options / Intent Crystal 三处都会从这个 schema 反射。

**支持两种写法**：**简写**和**富形式**，可以混用。

#### 简写（value 是字符串 · 给 LLM 的约束）

```json
"intentSchema": {
  "goal":     "用一句话概括当前对目标的理解(16字内)",
  "audience": "目标对象(12字内,未知则空)"
}
```

简写被系统归一为 `{ label: key, hint: 字符串, critical: true, type: "text" }`。适合纯文本字段。

#### 富形式（value 是对象 · 携带更多信号）

```json
"intentSchema": {
  "priority": {
    "label":    "首要考量",
    "hint":     "本次发布最优先保护的目标",
    "critical": true,
    "type":     "enum",
    "options":  ["速度上线", "品牌势能", "成本控制", "风险防控", "用户体验"]
  }
}
```

字段含义：
| 字段 | 说明 | 反映到哪 |
|---|---|---|
| `label` | 中文显示名 | Intent Crystal 的前缀 |
| `hint` | 对 LLM 的生成约束 | intent_summary 的 JSON 模板 |
| `critical` | 是否关键字段(默认 `true`) | 🔑 标记 · `should_proceed` 判定(所有关键字段填好才能进 L2) |
| `type` | `text` / `enum` / `number` | prompt 描述 · answer_options 策略 |
| `options` | `type=enum` 时的候选值 | 自动生成 L1 的 answer 按钮(加"其他/不确定"兜底) |

**enum 类型的好处**：用户面对的不是 LLM 随机编的 3 个选项，而是你在场景里锁定的明确选项。如 `priority` 用 enum，L1 问"你最优先保护什么"时会直接弹出 5 个你预定义的卡片。

**坏的例子**（太笼统）：
```json
"intentSchema": { "what": "想做什么", "why": "为什么" }
```

**坏的例子**（维度太多）：超过 6 个 key 会让 Crystal 面板挤死。保持 3-5 个。

> ⚠️ **编辑器限制**：`scenario-editor.html` 目前的表单只支持简写输出。要用富形式,导出 md 后手动改。后续会升级编辑器支持富形式。

---

### `defaultAxes` + `axisExamples` —— L2 的探索空间

两条**正交对立**的轴。真对立的例子："保守 / 激进"；假对立："清晰 / 专业"（两个不对立）。

`axisExamples` 是 prompt 喂给 LLM 的「灵感」，LLM 会借鉴这个风格给出本场景的轴。多给几组用逗号分隔。

---

### `contextCards` + `contextForPrompt` —— 环境感知

两个字段**故意不 DRY**：
- `contextCards` 是 **展示给用户看** 的（带 icon、Label、长句）
- `contextForPrompt` 是 **喂给 LLM** 的（短、结构化）

真实部署时，这两份数据应该由各自的 ContextProvider（日历 API、浏览器插件）产出。现在是 mock，你可以各写各的。

---

### `planSizeHint` + `planFlowHint` —— L3 的节拍

- `planSizeHint`: "3-5 步" / "5-7 步" / "7-10 步"，别更大。
- `planFlowHint`: 把你领域里"标准流程"的 5 个关键动词用 `→` 连起来。这个提示会让 LLM 的计划结构稳定很多。

低风险场景（"写邮件"、"发个推文"）通常不需要 L3。当前版本 L3 强制存在——**场景化 L3 是否必须** 是下一个框架层级的改进点，见下。

---

### `conflicts` —— L3 协作冲突 mock

两张卡：
1. `institutionalRule`: 一段纯文本，描述机构/合规约束
2. `subAgentSuggestion`: 另一个 AI 建议，用户可"接纳"变成新计划步

如果你的场景里没有这种冲突（个人任务），写成 `"institutionalRule": "（本场景无机构规则冲突）"` 就行。UI 还是会显示卡片——这是**场景插件未来要加的 `l3ShowConflicts` 开关**。

---

## 4. 场景的极限 —— 现有框架处理不了什么

写新场景时如果你卡住了，很可能不是你的锅，是框架的锅。标记在这里：

| 你的场景需要... | 框架当前能力 | 下一步改进 |
|---|---|---|
| L4 展示代码 diff / canvas / 表格而不是文本 | 只支持文本 artifact | 加 `artifactRenderer` 注册表 |
| 跳过 L3（低风险任务） | L3 强制存在 | 加 `risk_level` 字段，低风险自动压缩 L3 成"收据模式" |
| 3 条轴而不是 2 条 | L2 写死 2D | 需要重构拓扑组件 |
| 环境感知真的要接日历 / 邮件 | 完全 mock | 加 `ContextProvider` 接口 |
| 10+ 步的超长流程 | Gantt 会拥挤 | 需要 L3/L4 的分组 / 折叠机制 |
| L3 执行真实调用 API | LLM mock 产出 | 加 `ToolRegistry` |

遇到上表任何一项，先在你的场景 md 里写一段「本场景未被框架覆盖的部分」，标注原因。这是框架演进的第一手输入。

---

## 5. 运行与调试

```bash
# 在 mind/ 目录下起一个 HTTP 服务
python -m http.server 8080
# 然后在浏览器打开
# http://localhost:8080/ux-prototype.html?scenario=product-launch
```

URL 参数 `?scenario=<id>` 对应 `scenarios/<id>.md`。不带参数默认加载 `product-launch`。

加载失败时页面顶部会出现红色错误横幅，并自动退回到**内嵌的 fallback 场景**（和 product-launch 一致）。这样即使场景 md 改坏了也不会白屏。

---

## 6. 想贡献一个新场景？

候选清单（按复杂度排序）：

1. **写一封重要邮件** —— 低风险，L3 可收据化
2. **制定季度 OKR** —— 中风险，L3 需要多人协作
3. **代码重构计划** —— L4 需要 diff 视图（会暴露 artifactRenderer 缺失）
4. **安排一次多人旅行** —— L4 需要冲突的时间/预算约束
5. **危机公关应对** —— 高风险，L3 需要法务/传播多条并行轨道

写完记得在这个 README 底部加一行说明：「本场景在 X 地方突破了框架，需要 Y 改进」。
