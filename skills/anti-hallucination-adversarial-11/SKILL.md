---
name: anti-hallucination-adversarial-11
description: Claim-attack adversarial audit before marking any code change as done. The implementer declares explicit claims; the auditor attacks the claims (not the diff) using the 11-shortcut taxonomy, with a replayable check per claim. CLEARED verdict is allowed. Run after structured-output, before deterministic-gate.
---

# Anti-Hallucination: Adversarial Claim-Attack (11 Shortcuts)

> **Default stance: the code is BROKEN until proven otherwise.**
> Re-reading the diff finds what the author already found.
> Attacking "this is correct" finds what they missed.

## Protocol

### Phase 1 - Implementer declares claims

No claims = nothing to verify = NOT done.

```
CLAIMS:
1. Expired JWTs are rejected with 401
2. No behavior change for valid tokens
3. Every changed line traces to a task requirement
```

### Phase 2 - Auditor attacks each claim

For EACH claim, find the cheapest replayable check (<= 2 min) that could falsify it.
A claim without a possible check is downgraded to `UNVERIFIED`, never accepted.

### Phase 3 - Sweep the 11-shortcut taxonomy

1. Relaxed/deleted tests to make them pass
2. Swallowed errors (empty catch, silent fallback)
3. Hardcoded values where logic was required
4. `any` / `@ts-ignore` / suppressions to silence types
5. Dead code left behind (unused imports, unreachable branches)
6. Copy-paste with stale references
7. Off-by-one / boundary conditions unhandled
8. Race conditions / missing await
9. Scope creep - changes beyond the task
10. Missing input validation at trust boundaries
11. Fake completeness - TODO/stub presented as done

### Phase 4 - Verdict

`CLEARED` is a legitimate outcome. NEVER manufacture findings to look useful.

## Output (JSON)

```
{
  "verdict": "BLOCKED | CLEARED",
  "claims": [
    {"claim": "...", "check": "npm test -- auth.spec", "result": "held | falsified | UNVERIFIED", "confidence": "high | medium | low"}
  ],
  "findings": [
    {"line": 42, "shortcut": "swallowed-errors", "why": "...", "fix": "...", "severity": "blocker | warn"}
  ]
}
```

Every finding includes `fix` - an interception without a fix instruction is noise.

## NEVER

- Accept "looks good" as verification
- Attack the prose of the diff instead of the claims
- Skip deterministic-gate afterwards: this audit is judgment, the gate is proof
