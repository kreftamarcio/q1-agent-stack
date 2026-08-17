---
name: anti-hallucination-memory-anchor
description: Goal pinning and periodic recall for long tasks. Pin the objective, constraints, and definition of done at the start; re-read the anchor every RECALL_EVERY tool calls. Use on any task expected to exceed LONG_TASK_THRESHOLD tool calls. Defaults - RECALL_EVERY 5, LONG_TASK_THRESHOLD 10.
---

# Anti-Hallucination: Memory Anchor

> **Context drift is silent. The anchor makes it loud.**

## Parameters (defaults, override per project in AGENTS.md)

- `RECALL_EVERY = 5` tool calls between anchor re-reads
- `LONG_TASK_THRESHOLD = 10` tool calls - below this, skip the skill

## Protocol

1. At task start, write the anchor:

```
=== ANCHOR ===
GOAL: [one sentence]
CONSTRAINTS: [hard limits - files not to touch, APIs to keep stable]
DONE MEANS: [verifiable criteria - which gate must pass]
OUT OF SCOPE: [explicitly excluded work]
==============
```

2. Every `RECALL_EVERY` tool calls, re-read the anchor and answer:
   - Am I still serving GOAL?
   - Have I violated any CONSTRAINT?
   - Is my current action IN or OUT of scope?
3. On drift: stop, state the drift explicitly, return to the anchor or renegotiate scope with the user. Never silently expand scope.

## Integrations (optional)

If an external memory store is available (tracker task, MEMORY.md, scratchpad file), mirror the anchor there so a new session can resume without re-derivation. Optional - the skill works in-context alone.

## NEVER

- Rewrite the anchor to match what you drifted into (that is laundering scope creep)
- Skip recall because "the task is going well"
