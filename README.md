# Mind · Intent Fabric

> Prototypes for intent-based AI user experience — a 4-layer, domain-agnostic UX framework where each scenario is a pluggable markdown file.
>
> 面向「意图驱动」AI 体验的原型集合 —— 一个 4 层、领域无关的 UX 框架，每个场景是一份可插拔的 markdown 文件。

**Languages / 语言**: [English](#english) · [中文](#中文)

## 🚀 Live demo / 在线体验

| Page | URL |
|---|---|
| Mind Studio (landing) | https://ianwangy.github.io/mind/ |
| **Intent Fabric prototype** | https://ianwangy.github.io/mind/ux-prototype.html |
| Scenario editor | https://ianwangy.github.io/mind/scenario-editor.html |
| Reading view | https://ianwangy.github.io/mind/mind-reader.html |
| L2 topography (standalone) | https://ianwangy.github.io/mind/semantic-topography-v2.html |

> **First-time setup / 初次使用** — Click the ⚙ **Settings** button on any page and paste your own LLM API key. The repo ships with **no key**; calls fail until you set one.
>
> 点击页面上的 ⚙ **设置** 按钮，把你自己的 LLM API key 填进去。仓库**不内置任何 key**，未设置时调用会失败。
>
> Default endpoint is Alibaba Cloud DashScope's OpenAI-compatible API (`https://dashscope.aliyuncs.com/compatible-mode/v1`, model `qwen-plus`). Any OpenAI-compatible endpoint works — change `baseUrl` and `model` in the same Settings panel.
>
> 默认端点是阿里云 DashScope 的 OpenAI 兼容 API（`qwen-plus`）。任何 OpenAI 兼容端点都行 —— 在设置里改 `baseUrl` / `model` 即可。
>
> Your key is stored only in your browser's `localStorage`. Nothing is sent anywhere except the LLM endpoint you configure.
>
> 你的 key 只存在本机浏览器 `localStorage`，除了你自己配置的 LLM 端点之外不会发到任何地方。

---

## English

### What is this

`mind` is a sandbox for exploring what AI interfaces should look like once users stop *operating* software and start *delegating* outcomes. It is inspired by Jakob Nielsen's essay [*Intent by Discovery: Designing the AI User Experience*](intent-ux.md) (a local copy lives in this repo), and prototypes one possible answer: **Intent Fabric**, a 4-layer interaction model.

The four layers, in increasing structure:

| Layer | Role | Question it answers |
|---|---|---|
| **L1 · Intent** | Shape a fuzzy request into a structured intent crystal | *What does the user actually want?* |
| **L2 · Topography** | Lay out the exploration space on two orthogonal axes | *Which directions could we go?* |
| **L3 · Plan** | Negotiate a step-by-step plan, surface conflicts | *How will we get there?* |
| **L4 · Artifact** | Render the produced thing on a timeline / canvas | *What did we produce?* |

The framework is **domain-agnostic**. To adapt it to a real domain you write a *scenario* — a markdown file that drops a JSON block into the page. See [`scenarios/README.md`](scenarios/README.md) for the full author guide.

### Repository layout

```
mind/
├── ux-prototype.html             # Main 4-layer prototype (Intent Fabric)
├── scenario-editor.html          # GUI editor for scenarios/*.md
├── mind-reader.html              # Reading view of the source essay
├── semantic-topography-v2.html   # Standalone L2 (topography) experiment
├── index.html                    # Mind Studio landing page
├── intent-ux.md                  # Jakob Nielsen, "Intent by Discovery" (local copy)
├── podcast-episode-script.md     # Companion podcast script
├── scenarios/                    # Pluggable scenario definitions (.md)
│   ├── README.md                 # How to author a scenario
│   ├── TEMPLATE.md
│   ├── product-launch.md
│   ├── enterprise-strategy-design.md
│   └── podcast-production.md
└── start.bat                     # One-click local server (Windows)
```

> The `mobile-app/` directory is intentionally excluded from this repository — it is tracked separately.

### Run it locally

The HTML files load scenario `.md` files via `fetch()`, so opening them with `file://` will not work. You need a static HTTP server:

**Windows (one click)**

```
start.bat
```

This kills anything on port 8765, starts `python -m http.server 8765`, and opens the prototype in your browser.

**Any platform**

```bash
# from the repo root
python -m http.server 8080
# then open
# http://localhost:8080/ux-prototype.html?scenario=product-launch
```

The `?scenario=<id>` URL parameter selects which file under `scenarios/` to load. Without the parameter, `product-launch` is loaded by default. If a scenario fails to load (bad JSON, missing field), a red banner appears at the top and the page falls back to an embedded scenario rather than going blank.

### Authoring a new scenario

1. Copy [`scenarios/TEMPLATE.md`](scenarios/TEMPLATE.md) to `scenarios/your-scenario.md`
2. Edit the JSON block at the top (id, label, intent schema, axes, plan hints, …)
3. Open `http://localhost:<port>/ux-prototype.html?scenario=your-scenario`
4. Or use the visual editor: open `scenario-editor.html`

Full field reference and design notes: [`scenarios/README.md`](scenarios/README.md).

### Status

Research-quality prototypes. Expect rough edges, inline mocks, and explicit notes about what the framework *cannot* yet handle — see "场景的极限" / "What the framework cannot handle" in [`scenarios/README.md`](scenarios/README.md).

### License

No license file yet — all rights reserved by the author until one is added. Open an issue if you'd like to use any part of this.

---

## 中文

### 这是什么

`mind` 是一个原型实验场，探索 **当用户从「操作软件」转为「委派结果」之后，AI 界面该长什么样**。灵感来自 Jakob Nielsen 的文章 [*Intent by Discovery: Designing the AI User Experience*](intent-ux.md)（本仓库里有完整中英对照副本），并据此提出一个可能的答案：**Intent Fabric**，一个 4 层交互模型。

四层结构由模糊到具体：

| 层 | 职责 | 回答的问题 |
|---|---|---|
| **L1 · 意图 (Intent)** | 把模糊请求结晶为结构化意图 | *用户到底想要什么？* |
| **L2 · 拓扑 (Topography)** | 在两条正交对立轴上铺开探索空间 | *可以朝哪些方向走？* |
| **L3 · 计划 (Plan)** | 协商分步计划、暴露冲突 | *怎么到达？* |
| **L4 · 产物 (Artifact)** | 在时间线 / 画布上呈现产出 | *做出了什么？* |

框架本身是**领域无关**的。要落地到一个具体领域，只需要写一份**场景定义** —— 一份 markdown 文件，里面嵌一段 JSON。完整作者指南见 [`scenarios/README.md`](scenarios/README.md)。

### 目录结构

```
mind/
├── ux-prototype.html             # 4 层主原型 (Intent Fabric)
├── scenario-editor.html          # scenarios/*.md 的可视化编辑器
├── mind-reader.html              # 原文阅读视图
├── semantic-topography-v2.html   # 独立的 L2 (拓扑) 实验
├── index.html                    # Mind Studio 落地页
├── intent-ux.md                  # Jakob Nielsen 原文本地副本
├── podcast-episode-script.md     # 配套播客脚本
├── scenarios/                    # 可插拔场景定义 (.md)
│   ├── README.md                 # 场景撰写指南
│   ├── TEMPLATE.md
│   ├── product-launch.md
│   ├── enterprise-strategy-design.md
│   └── podcast-production.md
└── start.bat                     # Windows 一键本地服务
```

> `mobile-app/` 目录**不在本仓库**，单独管理。

### 本地运行

HTML 通过 `fetch()` 读取场景 `.md`，**用 `file://` 双击打不开**，必须起一个本地 HTTP 服务。

**Windows 一键**

```
start.bat
```

会自动清掉 8765 端口上的旧进程、启动 `python -m http.server 8765`、打开浏览器。

**任何平台**

```bash
# 在仓库根目录
python -m http.server 8080
# 浏览器打开
# http://localhost:8080/ux-prototype.html?scenario=product-launch
```

URL 参数 `?scenario=<id>` 决定加载 `scenarios/` 下哪个文件，不传则默认 `product-launch`。场景加载失败时（JSON 写错、字段缺失），页面顶部会出现红色横幅，并自动退回到内嵌兜底场景，避免白屏。

### 写一个新场景

1. 复制 [`scenarios/TEMPLATE.md`](scenarios/TEMPLATE.md) 为 `scenarios/your-scenario.md`
2. 改文件开头的 JSON 块（id、label、intent schema、轴、计划提示……）
3. 浏览器打开 `http://localhost:<port>/ux-prototype.html?scenario=your-scenario`
4. 或者用可视化编辑器：打开 `scenario-editor.html`

字段全集与设计注记：[`scenarios/README.md`](scenarios/README.md)。

### 状态

科研性质的原型，会有粗糙的地方，会有写死的 mock，也会**明确标注框架当前处理不了的情况** —— 见 [`scenarios/README.md`](scenarios/README.md) 中「场景的极限」。

### 许可

暂无 LICENSE 文件，作者保留所有权利。如需引用或复用，请先开 issue。
