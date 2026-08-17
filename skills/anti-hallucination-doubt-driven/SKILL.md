---
name: anti-hallucination-doubt-driven
description: Structured self-doubt loop (CLAIM -> EXTRACT -> DOUBT -> RECONCILE -> STOP) for non-trivial decisions, architectural choices, and high-risk changes. Capped at 3 cycles. Not for trivial edits.
---

# Anti-Hallucination: Doubt-Driven Verification

> **Confidence is not evidence. Doubt systematically, then stop.**

## When to Use

- Architectural decisions, irreversible changes, security-sensitive code
- NOT for trivial edits (rename, comment, formatting) - doubt loops on trivia are waste

## The Loop (max 3 cycles, then STOP with best reconciled answer)

1. **CLAIM** - state the decision and its justification explicitly
2. **EXTRACT** - list the assumptions the claim depends on
3. **DOUBT** - for each assumption: "what evidence would prove this wrong?" Check the cheapest one.
4. **RECONCILE** - update or keep the claim based on what the checks showed
5. **STOP** - after 3 cycles or when no assumption remains checkable

## Worked Example (compact)

```
CLAIM: "Use Redis for session storage" (justification: multi-instance deploy)
EXTRACT: A1: app runs multi-instance; A2: sessions must survive restarts; A3: Redis is already provisioned
DOUBT: A3 -> `grep -ri redis infra/` -> no results -> FALSIFIED
RECONCILE: Redis adds provisioning cost; A1+A2 hold -> keep decision, add provisioning task explicitly
STOP: 1 cycle sufficient; remaining assumptions verified
```

## Integrations (optional)

If a task tracker (ClickUp, Linear, Jira) is connected, log the reconciled decision and falsified assumptions as a comment on the task. This section is OPTIONAL - the skill works without any tracker.

## NEVER

- Run more than 3 cycles (analysis paralysis is also a failure mode)
- Doubt without a checkable falsifier - vague doubt is theater
- Skip the loop on high-risk changes because "it is obvious"
