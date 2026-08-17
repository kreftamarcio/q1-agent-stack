---
name: anti-hallucination-deterministic-gate
description: The final gate before any "done", commit, PR, or deploy. No LLM judgment substitutes deterministic verification - typecheck, tests, lint, and build must pass, or the failure must be reported verbatim. Use ALWAYS as the last layer, after all other anti-hallucination skills.
---

# Anti-Hallucination: Deterministic Gate (Layer 7)

> **An LLM opinion is never evidence. Only deterministic checks close a task.**

## When to Use

- Before ANY "done" / "complete" / "fixed" claim
- Before every commit, PR, and deploy
- ALWAYS after adversarial/doubt review passes - judgment first, proof last

## The Gate (run in order, stop on first failure)

| # | Check | Default command | On failure |
|---|-------|-----------------|------------|
| 1 | Typecheck | `npx tsc --noEmit` | Fix types; never silence with `any` / `@ts-ignore` |
| 2 | Tests | `npm test` | Fix the code, not the test |
| 3 | Lint | `npm run lint` | Fix violations; never disable rules inline |
| 4 | Build | `npm run build` | Fix the build; never ship on a broken build |

Adapt commands to the detected stack (read `package.json` scripts / `pyproject.toml`).
Never invent scripts: verify the script exists before claiming you ran it.

## Output Contract

Report the REAL output, verbatim:

```
GATE RESULT:
1. typecheck: PASS (tsc --noEmit, exit 0)
2. tests:     FAIL (2/34 failed: auth.spec.ts:41, auth.spec.ts:58)
   -> FIX: expired-token branch returns 200, expected 401. See src/middleware/auth.ts:27
3. lint:      NOT RUN (blocked by #2)
4. build:     NOT RUN (blocked by #2)
VERDICT: BLOCKED
```

- Every failure MUST include a fix instruction, not just the error.
- `VERDICT: PASSED` requires ALL gates run in THIS session with exit 0.

## Degraded Mode (no shell access)

```
WARNING: GATE NOT RUN - no execution environment.
A human (or CI) must run: [exact commands]
Status remains NOT DONE until results are pasted back.
```

NEVER imply gates passed. NEVER mark done in degraded mode.

## NEVER

- Claim "tests pass" without running them in THIS session
- Weaken a test/lint rule to make the gate green
- Substitute this gate with any LLM review, including the other 6 layers
- Report summarized/paraphrased gate output - verbatim only
