# Q1 Agent Stack

> Complete AI agent infrastructure for global-level software development.
> Integrates **Antigravity IDE (Gemini)** + **ClickUp Brain** + **Vercel** + **GitHub**.

## Architecture

```
┌───────────────────────────────────────────────────────────┐
│              ANTIGRAVITY IDE (Gemini Engine)               │
│                                                           │
│  Plugins:                                                  │
│  ├─ oh-my-antigravity (14 agents, 30+ commands)            │
│  ├─ agent-skills (24 SDLC skills by Addy Osmani)           │
│  ├─ SuperAntigravity (19 auto-trigger + TDD)               │
│  ├─ vercel-plugin (32 skills + 3 agents)                   │
│  ├─ antigravity-skills vault (300+ domain skills)           │
│  ├─ ECC skills (75 cherry-picked)                          │
│  ├─ COG + loopkit (66 harness/loop skills)                  │
│  └─ 6 anti-hallucination custom skills                     │
│                                                           │
│  3-Agent Loop:                                             │
│  DEVELOPER (Flash) → AUDITOR (Pro) → DEBUGGER (Pro)        │
│       ↑                    │ pass         │               │
│       └─── fix ready ─────┘─────────────┘               │
│                                                           │
│  MCP Servers (6):                                          │
│  ┌───────────────┐ ┌───────────────┐ ┌───────────────┐  │
│  │ context-mode │ │ clickup-dev   │ │clickup-context│  │
│  │ (98% saving)│ │ (task ops)    │ │ (rich read)   │  │
│  └───────────────┘ └───────────────┘ └───────────────┘  │
│  ┌───────────────┐ ┌───────────────┐ ┌───────────────┐  │
│  │ github      │ │ git-mcp       │ │ code-reason  │  │
│  │ (code+PRs)  │ │(anti-halluc.) │ │ (thinking)   │  │
│  └───────────────┘ └───────────────┘ └───────────────┘  │
│                                                           │
│  Model Routing:                                            │
│  Pro (planning/audit) │ Flash (code) │ Lite (quick)       │
└───────────────────────────────────────────────────────────┘
            │ (same data)              │ (deploys)
            ▼                           ▼
┌───────────────────────┐  ┌───────────────────────┐
│  CLICKUP BRAIN          │  │  VERCEL                  │
│  (gestão, triagem,      │  │  (deploy, CDN, edge,     │
│   sprint planning)      │  │   storage, AI gateway)   │
└───────────────────────┘  └───────────────────────┘
```

## Numbers (verified)

| Métrica | Total |
|---------|-------|
| Skills | **321+** |
| Commands | **126+** |
| Agents | **80+** (77 + 3 custom loop agents) |
| MCP Servers | **6** |
| MCP Tools | **42+** |
| Install Scripts | **4** |
| Custom Loop Agents | **3** (developer, auditor, debugger) |
| Anti-Hallucination Rules | **7** (in GEMINI.md) |
| Anti-Hallucination Skills | **6** (custom SKILL.md) |

## Quick Install

```bash
git clone https://github.com/kreftamarcio/q1-agent-stack.git
cd q1-agent-stack
chmod +x *.sh

# Full install (all components)
./install.sh              # Core: 9 steps (includes loop/harness)
./install-ecc.sh          # ECC: 75 skills + 21 agents
./install-vercel.sh       # Vercel: 41 skills + 3 agents

# Environment
cp .env.example .env      # Fill in your tokens
```

## Files

| File | Purpose |
|------|--------|
| `GEMINI.md` | Master agent config (anti-hallucination + loop rules) |
| `settings.json` | 6 MCP servers + hooks (copy to ~/.gemini/) |
| `mcp_config.json` | Standalone MCP config (no hooks) |
| `.env.example` | Required environment variables |
| `install.sh` | Core installer (9 steps) |
| `install-ecc.sh` | ECC skills installer |
| `install-loop-harness.sh` | COG + loopkit skills |
| `install-vercel.sh` | Vercel plugin + labs skills |
| `agents/developer.md` | Developer agent (EXECUTOR) |
| `agents/auditor.md` | Auditor agent (VERIFIER) |
| `agents/debugger.md` | Debugger agent (REFACTORER) |
| `skills/` | 6 custom anti-hallucination SKILL.md files |
| `SKILLS_MANIFEST.md` | Complete inventory |
| `MCP_ARCHITECTURE.md` | MCP layer documentation |
| `ECC_INTEGRATION.md` | ECC skills guide |
| `LOOP_HARNESS_GRAFOS.md` | Loop + Harness + Graph engineering |
| `VERCEL_SKILLS.md` | Vercel ecosystem guide |
| `CLICKUP_WORKFLOW.md` | Daily workflow guide |
| `MEMORY.md` | Cross-session learnings |

## Engineering Principles

1. **Loop Engineering:** Gather → Act → Observe → Verify → Update → Decide
2. **Harness (V-Model):** Worker NEVER grades own work
3. **Graph Thinking:** Tasks = DAG nodes, topological traversal
4. **Anti-Hallucination:** Source-driven, doubt-driven, adversarial-11, structured output
5. **3-Agent Loop:** Developer → Auditor → Debugger (closed loop)

## Dual-AI Workflow

- **Antigravity (Gemini):** Code, implementation, deploy, TDD, security
- **ClickUp Brain:** Gestão, triagem, sprint planning, task search, decisions
- **Both operate on the same ClickUp workspace data via MCP**

## Sources & Licenses

| Source | License | Status |
|--------|---------|--------|
| oh-my-antigravity | MIT | ✅ |
| agent-skills (Addy Osmani) | MIT | ✅ |
| SuperAntigravity | MIT | ✅ |
| ECC | MIT | ✅ |
| antigravity-skills vault | MIT | ✅ |
| Superpowers (obra) | MIT | ✅ |
| Ruflo (agent swarms) | MIT | ✅ |
| clickup-agentic-native | Apache 2.0 | ✅ |
| github-mcp-server | MIT | ✅ |
| hauptsacheNet/clickup-mcp | MIT | ✅ |
| git-mcp | MIT | ✅ |
| code-reasoning | MIT | ✅ |
| vercel-plugin | Apache 2.0 | ✅ |
| vercel-labs/agent-skills | MIT | ✅ |
| COG second-brain | MIT | ✅ |
| loopkit | MIT | ✅ |
| context-mode | ELv2 | ⚠️ OK uso interno |

## License

MIT
