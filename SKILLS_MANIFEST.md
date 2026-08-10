# Q1 Digital — Skills Manifest

Complete inventory of all installed agent skills, organized by source and purpose.

## Source: oh-my-antigravity (v0.9.2)

### Skills (11)
| Skill | Focus |
|-------|-------|
| `$plan` | Convert goals into phased plan |
| `$oma-plan` | Planning alias (avoids /plan collision) |
| `$ralplan` | Strict stage-gated planning with rollback |
| `$execute` | Implement a scoped plan slice |
| `$prd` | Convert requests into measurable acceptance criteria |
| `$research` | Explore options/tradeoffs |
| `$deep-dive` | Trace-to-interview discovery before planning |
| `$ultragoal` | Durable multi-goal workflows with checkpoints |
| `$blueprint` | Lock product/UI workflow decisions |
| `$context-optimize` | Improve context structure |
| `$learn` | Extract reusable session patterns |

### Sub-Agents (14)
| Agent | Responsibility | Model |
|-------|---------------|-------|
| oma-architect | System boundaries, interfaces | gemini-3.1-pro |
| oma-planner | Task decomposition | gemini-3.1-pro |
| oma-product | Scope lock, acceptance criteria | gemini-3.1-pro |
| oma-executor | Fast implementation | gemini-3-flash |
| oma-reviewer | Correctness checks | gemini-3.1-pro |
| oma-verifier | Release-readiness | gemini-3.1-pro |
| oma-debugger | Root-cause analysis | gemini-3.1-pro |
| oma-consensus | Decision convergence | gemini-3.1-pro |
| oma-researcher | External analysis | gemini-3.1-pro |
| oma-director | Team routing, conflict resolution | gemini-3.1-pro |
| oma-consultant | Strategic analysis | gemini-3.1-pro |
| oma-editor | Deliverable structure | gemini-3-flash |
| oma-quick | Small tactical fixes | gemini-3.1-flash-lite |
| oma-interview | Requirements discovery | gemini-3.1-pro |

### Commands (30+)
`/oma:status`, `/oma:doctor`, `/oma:team-assemble`, `/oma:team`, `/oma:team-plan`, `/oma:team-prd`, `/oma:team-exec`, `/oma:team-verify`, `/oma:team-fix`, `/oma:loop`, `/oma:goal`, `/oma:ultragoal`, `/oma:autopilot`, `/oma:ralph`, `/oma:ultrawork`, `/oma:workspace`, `/oma:taskboard`, `/oma:recall`, `/oma:mode`, `/oma:model`, `/oma:approval`, `/oma:checkpoint`, `/oma:stop`, `/oma:blueprint`, `/oma:reasoning`, `/oma:deep-init`, `/oma:notify`, `/oma:hooks`, `/oma:memory`, `/oma:intent`, `/oma:rules`, `/oma:consensus`

---

## Source: agent-skills (Addy Osmani, 85K⭐)

### Skills (24)
| Phase | Skill | Purpose |
|-------|-------|--------|
| Define | interview-me | Extract real requirements |
| Define | idea-refine | Divergent/convergent thinking |
| Define | spec-driven-development | PRD before code |
| Plan | planning-and-task-breakdown | Atomic verifiable tasks |
| Build | incremental-implementation | Thin vertical slices |
| Build | test-driven-development | Red-Green-Refactor |
| Build | context-engineering | Right info at right time |
| Build | source-driven-development | Official docs grounding |
| Build | doubt-driven-development | Adversarial review |
| Build | frontend-ui-engineering | Components, a11y, responsive |
| Build | api-and-interface-design | Contract-first, Hyrum's Law |
| Verify | browser-testing-with-devtools | Chrome DevTools MCP |
| Verify | debugging-and-error-recovery | 5-step triage |
| Review | code-review-and-quality | 5-axis review |
| Review | code-simplification | Chesterton's Fence |
| Review | security-and-hardening | OWASP Top 10 |
| Review | performance-optimization | Measure-first |
| Ship | git-workflow-and-versioning | Trunk-based, atomic |
| Ship | ci-cd-and-automation | Shift Left, feature flags |
| Ship | deprecation-and-migration | Code-as-liability |
| Ship | documentation-and-adrs | ADRs, API docs |
| Ship | observability-and-instrumentation | OpenTelemetry, RED |
| Ship | shipping-and-launch | Staged rollouts |
| Meta | using-agent-skills | Skill discovery |

### Commands (8)
`/spec`, `/plan`, `/build`, `/build auto`, `/test`, `/review`, `/webperf`, `/code-simplify`, `/ship`

### Agents (4)
code-reviewer, test-engineer, security-auditor, web-performance-auditor

---

## Source: SuperAntigravity

### Auto-Triggered Skills (19)
| Skill | Triggers when... |
|-------|------------------|
| brainstorming | Building something new |
| writing-plans | Design ready to implement |
| executing-plans | Written plan to execute |
| subagent-driven-development | Executing with fresh subagents |
| test-driven-development | Any feature or bug fix |
| systematic-debugging | Bug or unexpected behavior |
| verification-before-completion | About to claim done |
| requesting-code-review | Between implementation tasks |
| receiving-code-review | Received review feedback |
| finishing-a-development-branch | Implementation complete |
| dispatching-parallel-agents | 2+ independent tasks |
| writing-skills | Creating/editing skills |
| deep-research | Needs external info |
| performance-optimization | Code needs profiling |
| security-review | Auth, input, sensitive data |
| architecture-design | System/API design |
| confidence-check | Verifies readiness |
| browser-agent | UI testing, browser automation |

### Slash Commands (16+)
`/brainstorm`, `/plan`, `/implement`, `/research`, `/build`, `/test`, `/git`, `/analyze`, `/design`, `/troubleshoot`, `/explain`, `/improve`, `/review`, `/cleanup`, `/document`, `/estimate`, `/business-panel`, `/spec-panel`, `/recommend`

### Agents (8)
code-reviewer, backend-architect, frontend-architect, security-engineer, deep-research, system-architect, socratic-mentor, repo-index

---

## Source: antigravity-skills vault (300+ skills)

### Installed Bundles
- **core-dev**: python-pro, typescript-pro, bash-pro, git-operations, code-review, testing basics
- **security-core**: security-auditor, sast-configuration, security-scanning, vulnerability-assessment

### Individual Skills Installed
- `typescript-pro` — TypeScript best practices and patterns
- `nextjs-app-router-patterns` — Next.js 15 App Router
- `react-modernization` — React 19 patterns
- `fastapi-pro` — FastAPI (for n8n custom nodes / Python APIs)
- `api-design-principles` — Contract-first API design
- `security-auditor` — Security audit workflows
- `conductor-implement` — Multi-step implementation conductor
- `context-driven-development` — Context-aware development

---

## Source: context-mode (19K⭐)

### MCP Tools (11)
| Tool | Purpose |
|------|--------|
| ctx_batch_execute | Multiple commands in ONE call |
| ctx_execute | Run code in 12 languages, only stdout enters context |
| ctx_execute_file | Process files in sandbox |
| ctx_index | Chunk markdown into FTS5 |
| ctx_search | Query indexed content (BM25) |
| ctx_fetch_and_index | Fetch URL, chunk, index |
| ctx_stats | Context savings report |
| ctx_doctor | Installation diagnostics |
| ctx_upgrade | Update to latest |
| ctx_purge | Delete indexed content |
| ctx_insight | Analytics dashboard |

### Hooks (Gemini CLI / Antigravity CLI)
- BeforeTool: intercepts large-output tools
- AfterTool: captures session events
- PreCompress: builds snapshot before compaction
- SessionStart: restores state after compaction

---

## Source: clickup-agentic-native

### MCP Tools (via clickup-agent mcp)
| Command | Purpose |
|---------|--------|
| search | Find tasks by query |
| list-hierarchy | Browse workspace structure |
| create-task | Create new task |
| create-subtask | Create subtask under parent |
| update-task | Update name/status/priority |
| set-status | Change task status |
| set-due-date | Set deadline |
| assign-me | Assign to current user |
| comment | Add comment to task |
| create-checklist | Create checklist with items |
| sync-checklist | Sync checklist state |
| dev-sync | Sync GitHub branch ↔ ClickUp task |
| work-log | Add work log entry |
| decision-log | Log architectural decision |
| catch-up-docs | Bidirectional doc sync |
| context load | Load task context for handoff |
| get-task | Fetch task details |
| subtasks | List subtasks |
| tags | Add/remove tags |
| timer | Start/stop time tracking |

---

## Total Inventory

| Source | Skills | Commands | Agents | MCP Tools |
|--------|--------|----------|--------|-----------|
| oh-my-antigravity | 11 | 30+ | 14 | — |
| agent-skills | 24 | 8 | 4 | — |
| SuperAntigravity | 19 | 16+ | 8 | — |
| antigravity-skills | 10+ (bundles) | — | — | — |
| context-mode | — | — | — | 11 |
| clickup-agent | — | — | — | 20+ |
| **TOTAL** | **64+** | **54+** | **26** | **31+** |
