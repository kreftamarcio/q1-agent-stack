<div align="center">

# 🧠 Q1 Agent Stack

**Production-grade AI agent infrastructure: 305+ skills, 7 orchestrated agents, 6 MCP servers.**

[![License: AGPL-3.0](https://img.shields.io/badge/License-AGPL--3.0-blue.svg)](LICENSE)
[![TypeScript](https://img.shields.io/badge/TypeScript-first-3178C6?logo=typescript&logoColor=white)]()
[![Agents](https://img.shields.io/badge/Agents-7_orchestrated-purple)]()
[![Skills](https://img.shields.io/badge/Skills-305%2B-green)]()
[![MCP](https://img.shields.io/badge/MCP_Servers-6-orange)]()

*Built by [Marcio Krefta Fontella](https://github.com/kreftamarcio) — AI Engineer, Q1 Digital*

</div>

---

## What is this?

A complete AI development infrastructure that orchestrates multiple LLM providers, agents, and tools into a unified closed-loop system. It's not a chatbot wrapper. It's the operating system for building AI-native software.

**Key differentiator:** Worker agents never evaluate their own output. The architecture enforces separation between execution and verification (V-Model Harness pattern), eliminating the single biggest source of AI errors in production.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    GOLDEN TRIO MODEL ROUTING                    │
├─────────────────────┬─────────────────────┬─────────────────────┤
│   Claude Opus 5      │   GPT-5.6 Sol       │   Gemini 3.1 Pro    │
│   Architecture       │   Implementation    │   Research          │
│   Security           │   TDD + Frontend    │   Prototyping       │
│   Compliance         │   Deploy            │   Multimodal        │
└─────────────────────┴─────────────────────┴─────────────────────┘
                              │
┌───────────────────────────┤
│  ORCHESTRATOR (DIRECTOR)    │
└────┬────┬────┬────┬────┬────┘
     │    │    │    │    │
  architect  developer  auditor  debugger  security  deployer
  (DAG)     (TDD)      (verify) (root-   (OWASP)   (Vercel)
                                cause)

┌─────────────────────────────────────────────────────────────────┐
│                       6 MCP SERVERS                             │
├─────────────────────────────────────────────────────────────────┤
│  context-mode      │ 98% token savings, smart compression       │
│  clickup-dev       │ Task CRUD, sprint management               │
│  clickup-context   │ Rich reading, images, docs                 │
│  github            │ Code, PRs, security scanning               │
│  git-mcp           │ Real docs as anti-hallucination context     │
│  code-reasoning    │ Sequential chain-of-thought                │
└─────────────────────────────────────────────────────────────────┘
```

---

## Numbers

| Metric | Value |
|--------|-------|
| Skills (total after install) | **305+** |
| Agents (orchestrated) | **7** |
| MCP Servers | **6** |
| MCP Tools | **42+** |
| Commands | **122+** |
| Anti-hallucination layers | **7** |
| Install scripts | **4** |
| Token savings (context-mode) | **98%** |

---

## Engineering Principles

### 1. Closed-Loop Harness (V-Model)
Worker never evaluates its own work. `developer ≠ auditor`. Every output passes through an independent verification agent before reaching production.

### 2. Anti-Hallucination (7 Layers)
```
source-driven → doubt-driven → adversarial-11 → structured-output
     → memory-anchor → clickup-brain → git-mcp (real docs)
```

### 3. DAG Thinking
Tasks decomposed as nodes in a Directed Acyclic Graph. Topological traversal ensures correct execution order. No circular dependencies, no blocked pipelines.

### 4. Loop Engineering (COG 6-Step)
```
Gather → Act → Observe → Verify → Update → Decide
```
Every agent iteration follows this cycle. No open-ended loops. 5-layer termination: verifier + cap + budget + no-progress + human escalation.

### 5. Spec-Driven Development
No code before spec + acceptance criteria are confirmed. Architecture decisions documented in ADRs before implementation begins.

### 6. Golden Trio Routing
Each model handles what it does best. Cost-aware routing sends cheap tasks to fast models and complex tasks to capable ones. See `MODEL_ROUTING.md`.

---

## Skills Inventory

| Category | Count | Examples |
|----------|-------|----------|
| Anti-Hallucination | 6 | source-driven, doubt-driven, adversarial-11 |
| Loop Engineering | 14 | closed-loop, review-cockpit, ultragoal |
| Harness & Verification | 53 | eval-harness, adversarial-verify, spec-first |
| Development | 20 | react-patterns, tdd-workflow, api-design |
| Security | 5 | security-scan, gateguard, owasp-review |
| Cost Optimization | 7 | cost-tracking, context-budget, token-budget |
| AI & Agents | 8 | agentic-engineering, autonomous-loops |
| Orchestration | 6 | orch-build-mvp, orch-fix-defect |
| Design & UI | 6 | design-system, dashboard-builder |
| Marketing & Business | 9 | seo, lead-intelligence, content-engine |
| Memory | 4 | unified-memory, continuous-learning |
| Vercel Deploy | 41 | ai-sdk, vercel-functions, deployments-cicd |
| Core Workflow | 8 | project-flow-ops, plan-orchestrate |

**Full manifest:** [`SKILLS_MANIFEST.md`](SKILLS_MANIFEST.md)

---

## Documentation

| File | Purpose |
|------|--------|
| [`ENGINEERING.md`](ENGINEERING.md) | Shared rules: loop, harness, graphs, spec-driven |
| [`MODEL_ROUTING.md`](MODEL_ROUTING.md) | Golden Trio routing logic |
| [`MCP_ARCHITECTURE.md`](MCP_ARCHITECTURE.md) | MCP server setup and integration |
| [`AGENTS.md`](AGENTS.md) | Agent configs (OpenAI Codex / GPT-5.6 Sol) |
| [`CLAUDE.md`](CLAUDE.md) | Agent config (Claude Opus 5) |
| [`GEMINI.md`](GEMINI.md) | Agent config (Antigravity / Gemini 3.1 Pro) |
| [`GOLDEN_TRIO_VERIFIED.md`](GOLDEN_TRIO_VERIFIED.md) | Verified benchmarks |
| [`LOOP_HARNESS_GRAFOS.md`](LOOP_HARNESS_GRAFOS.md) | Loop + Harness + Graph engineering |
| [`CLICKUP_WORKFLOW.md`](CLICKUP_WORKFLOW.md) | ClickUp integration workflow |
| [`MEMORY.md`](MEMORY.md) | Memory architecture |
| [`SKILLS_MANIFEST.md`](SKILLS_MANIFEST.md) | Complete skills inventory |
| [`VERCEL_SKILLS.md`](VERCEL_SKILLS.md) | Vercel deployment skills |

---

## Quick Start

```bash
git clone https://github.com/kreftamarcio/q1-agent-stack.git
cd q1-agent-stack
chmod +x *.sh

# Core install (context-mode, agents, MCP servers)
./install.sh

# Optional: ECC skills (75 skills + 21 agents)
./install-ecc.sh

# Optional: Loop Engineering + Harness (66 skills)
./install-loop-harness.sh

# Optional: Vercel deploy skills (41 skills)
./install-vercel.sh

# Configure
cp .env.example .env
# Edit .env with your API keys
```

### Requirements

- Node.js 18+
- Python 3.10+
- [Antigravity CLI](https://antigravity.google) (recommended)
- API keys: GitHub, ClickUp, OpenAI/Anthropic/Gemini (as needed)

---

## How It Works in Practice

```
You: "Build a lead enrichment API with rate limiting"

  orchestrator → architect (spec + DAG decomposition)
       → developer (TDD implementation)
       → auditor (adversarial verification, catches 3 issues)
       → developer (fixes applied)
       → security (OWASP gate: passes)
       → deployer (Vercel: live in 47s)

Result: Production API, tested, secured, deployed. Zero hallucination.
```

---

## Related Projects

| Project | Description |
|---------|-------------|
| [multi-agent-orchestrator](https://github.com/kreftamarcio/multi-agent-orchestrator) | Framework for cooperative LLM agents with fault tolerance |
| [prompt-forge](https://github.com/kreftamarcio/prompt-forge) | Prompt engineering toolkit with eval pipelines |
| [inference-gateway](https://github.com/kreftamarcio/inference-gateway) | Multi-provider LLM routing with circuit breakers |
| [rag-engine](https://github.com/kreftamarcio/rag-engine) | Production RAG with hybrid search |
| [guardrails-core](https://github.com/kreftamarcio/guardrails-core) | AI safety: PII, injection detection, Zod validation |
| [function-calling-engine](https://github.com/kreftamarcio/function-calling-engine) | Tool-use orchestration with retry and validation |
| [agent-memory](https://github.com/kreftamarcio/agent-memory) | Long-term memory: episodic, semantic, procedural |
| [eval-harness](https://github.com/kreftamarcio/eval-harness) | LLM evaluation framework with Pareto analysis |
| [mcp-toolkit](https://github.com/kreftamarcio/mcp-toolkit) | Framework for building MCP servers |

---

## License

This project is licensed under the **GNU Affero General Public License v3.0** (AGPL-3.0).

- ✅ View, fork, and learn from this code
- ✅ Modify and redistribute under the same license
- ✅ Use for personal/educational purposes
- ⚠️ Network service deployment requires full source disclosure (Section 13)
- ❌ Commercial use without AGPL-3.0 compliance is prohibited
- ❌ Removing or altering copyright notices is prohibited

For commercial licensing: kreftamarcio1@gmail.com

---

<div align="center">

**© 2026 Marcio Krefta Fontella — Q1 Digital**

*Building AI-native tooling, from problem to deploy.*

[GitHub](https://github.com/kreftamarcio) · [Website](https://q1digital.com.br) · [Email](mailto:kreftamarcio1@gmail.com)

</div>
