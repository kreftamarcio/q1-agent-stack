---
name: anti-hallucination-memory-anchor
description: Prevents context drift and goal forgetting during long agent sessions. Pins the current goal, externalizes state, forces re-read every N steps. Use for ANY task that takes more than 10 tool calls.
---

# Anti-Hallucination: Memory Anchoring

> **Problem:** Long sessions cause agents to forget the original goal, drift to tangents, or hallucinate completed steps.

## When to Use

- Any task exceeding 10 tool calls
- Multi-file implementations
- Sessions that span context compactions
- When the agent seems to be solving the wrong problem

## The 5 Anchoring Rules

### 1. Goal Pinning

At the START of every loop iteration, write the goal:

```
┌────────────────────────────────────────┐
│ CURRENT GOAL: [exact task from ClickUp]   │
│ ACCEPTANCE: [what "done" looks like]       │
│ ITERATION: 3/5 (cap)                      │
│ REMAINING: [what still needs to happen]    │
└────────────────────────────────────────┘
```

If you cannot write this clearly, you have drifted. Re-read the task.

### 2. State Externalization

**Never keep state only in the conversation.** Write it somewhere persistent:

- ClickUp task comments (decision-log, work-log)
- MEMORY.md in the project
- context-mode FTS5 index
- /oma:checkpoint

The conversation is SCRATCH. The external store is TRUTH.

### 3. Active Recall (every 5 tool calls)

Every 5 tool calls, pause and:
1. Re-read the original task goal
2. Compare current work against acceptance criteria
3. Ask: "Am I still solving the RIGHT problem?"
4. If drifted: correct course before next action

### 4. No-Progress Detection

If 2 consecutive passes produce no meaningful change:
- Do NOT try a third time with the same approach
- Log what was attempted
- Either try a DIFFERENT approach (Reflexion) or escalate (hitl-escalate)

### 5. Checkpoint Before Complexity

Before ANY of these, save state:
- Multi-file refactoring
- Database migration
- Auth/security changes
- Dependency upgrades
- Deployment operations

Command: `/oma:checkpoint` or `clickup-agent run work-log`

## Integration with ClickUp

```bash
# Save progress every significant step
clickup-agent run work-log --task-id <ID> --checklist progress --add-item "Completed: auth middleware"

# Log when drifting detected
clickup-agent run comment --task-id <ID> --text "Drift detected: was implementing auth, wandered into DB schema. Correcting."

# Escalate when stuck
clickup-agent run comment --task-id <ID> --text "Stuck after 2 attempts: [describe blocker]. Need human input."
```

## Integration with ClickUp Brain

When using ClickUp's AI (Brain), these same rules apply:
- Pin the goal in the prompt
- Don't ask vague questions ("help me with this task")
- Instead: reference the specific task ID and acceptance criteria
- Ask Brain to verify against the task's checklist, not general knowledge

## Verification

- [ ] Goal is explicitly pinned at start of every iteration
- [ ] State written to external store (not just conversation)
- [ ] Active recall performed every 5 tool calls
- [ ] No-progress detected and handled (different approach or escalation)
- [ ] Checkpoint saved before complex operations
- [ ] ClickUp work-log updated with progress
