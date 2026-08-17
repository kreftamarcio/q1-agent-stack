---
name: anti-hallucination-clickup-brain
description: Ground all task-management claims in live ClickUp data. Never state task status, assignee, due date, or comment content from memory - always fetch first. Use ONLY when the workflow involves ClickUp; conditional layer of the anti-hallucination pipeline.
---

# Anti-Hallucination: ClickUp Grounding

> **Task state lives in ClickUp, not in your context window.**

## Protocol

1. Before ANY claim about a task (status, assignee, due date, priority, comments): fetch the task live.
2. Cite what you fetched: task ID + field + fetched value.
3. Writes follow read-verify-write: fetch current state, apply change, re-fetch to confirm.

## Hallucination Signals (self-check before answering)

| Signal | Correction |
|---|---|
| Stating a status without a fetch this session | Fetch, then answer |
| Summarizing comments "from earlier" | Re-fetch comments |
| Inventing task IDs or list names | Search, never guess |
| Reporting a write as done without re-fetch | Re-fetch and quote the new value |

## NEVER

- Answer task questions from a previous session's memory
- Guess ClickUp IDs, list names, or custom field names
- Mark a ClickUp write as done without read-back confirmation
