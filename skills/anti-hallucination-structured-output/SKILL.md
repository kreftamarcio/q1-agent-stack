---
name: anti-hallucination-structured-output
description: Convert every deliverable into an explicit claim list and validate ALL claims in a single batch pass with deterministic commands where possible. First Verify layer, before adversarial-11.
---

# Anti-Hallucination: Structured Output Validation

> **A deliverable is a list of claims. Unlisted claims are unvalidated claims.**

## Protocol

1. Extract every claim from the deliverable (APIs used, files touched, behaviors changed, packages added).
2. Assign each claim a validation command from the matrix.
3. Run the batch. Report ALL results together - no cherry-picking.

## Validation Matrix

| Claim type | Command |
|---|---|
| Types compile | `npx tsc --noEmit` |
| Package exists / version | `npm info <pkg> version` |
| File/path exists | `ls <path>` |
| Export exists | `grep -n "export.*<name>" <file>` |
| Script exists | `cat package.json` (scripts block) |
| Behavior | targeted test run |

## Batch Output (JSON)

```
{
  "claims": [
    {"id": 1, "claim": "zod@4 is installed", "command": "npm info zod version", "result": "pass | fail | UNVERIFIED", "evidence": "4.0.2"}
  ],
  "summary": {"pass": 0, "fail": 0, "unverified": 0}
}
```

`unverified > 0` must be stated in the final answer. It never rounds up to "pass".

## Degraded Mode

No shell: mark every mechanical claim `UNVERIFIED`, list the exact commands for a human, and say so explicitly in the deliverable.

## Precedence

Runs AFTER `source-driven` (facts in) and BEFORE `adversarial-11` (claims attacked) and `deterministic-gate` (final proof).
