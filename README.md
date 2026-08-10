# Q1 Agent Stack

Complete AI agent infrastructure for Q1 Digital. Integrates **Antigravity CLI + Gemini** with **ClickUp** for end-to-end software delivery.

## What's Inside

| Component | Purpose | Stars |
|-----------|---------|-------|
| [oh-my-antigravity](https://github.com/Joonghyun-Lee-Frieren/oh-my-antigravity) | Multi-agent orchestration (14 agents, 30+ commands) | 203 |
| [agent-skills](https://github.com/addyosmani/agent-skills) | Production-grade SDLC skills (24 skills) | 85K |
| [SuperAntigravity](https://github.com/derHaken/SuperAntigravity) | Auto-triggered workflow + TDD enforcement | 436 |
| [antigravity-skills](https://github.com/rmyndharis/antigravity-skills) | 300+ domain skills vault | 1.3K |
| [context-mode](https://github.com/mksglu/context-mode) | 98% context window savings | 19K |
| [clickup-agentic-native](https://github.com/zenzenzen/clickup-agentic-native) | ClickUp ↔ GitHub MCP bridge | — |

## Quick Install

```bash
git clone https://github.com/kreftamarcio/q1-agent-stack.git
cd q1-agent-stack
chmod +x install.sh
./install.sh
```

## Total Capabilities

- **64+ skills** across engineering, security, design, and operations
- **54+ slash commands** for every phase of development
- **26 specialist agents** with automatic model routing
- **31+ MCP tools** (context optimization + ClickUp operations)
- **98% token savings** via context-mode sandbox
- **Automatic GitHub ↔ ClickUp sync** via dev-sync

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                  ANTIGRAVITY CLI (agy)                    │
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │  oh-my-      │  │  agent-      │  │  Super-      │  │
│  │  antigravity │  │  skills      │  │  Antigravity │  │
│  │  (orchestr.) │  │  (lifecycle) │  │  (auto-fire) │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
│                                                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │              MCP Servers Layer                     │   │
│  │  ┌────────────────┐  ┌─────────────────────┐     │   │
│  │  │  context-mode  │  │  clickup-agent      │     │   │
│  │  │  (sandbox)     │  │  (ClickUp↔GitHub)   │     │   │
│  │  └────────────────┘  └─────────────────────┘     │   │
│  └──────────────────────────────────────────────────┘   │
│                                                          │
│  Model Routing:                                          │
│  Pro (planning) │ Flash (code) │ Lite (quick fixes)     │
└─────────────────────────────────────────────────────────┘
```

## Files

- `GEMINI.md` — Master agent config (copy to project roots)
- `settings.json` — Gemini CLI hooks + MCP config (copy to ~/.gemini/)
- `mcp_config.json` — Standalone MCP server registration
- `install.sh` — One-command full installation
- `SKILLS_MANIFEST.md` — Complete inventory of all 64+ skills
- `CLICKUP_WORKFLOW.md` — Daily ClickUp↔GitHub workflow guide
- `MEMORY.md` — Cross-session learning storage

## License

MIT
