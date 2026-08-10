---
name: anti-hallucination-doubt-driven
description: Subjects every non-trivial decision to a fresh-context adversarial review. The reviewer is biased to DISPROVE, not approve. Use when correctness matters more than speed, in unfamiliar code, or when stakes are high.
---

# Anti-Hallucination: Doubt-Driven Development

> **A confident answer is NOT a correct answer.**

## When to Apply

A decision is non-trivial when:
- It introduces or modifies branching logic
- It crosses a module or service boundary
- It asserts something the type system cannot verify
- Its correctness depends on invisible context
- Its blast radius is irreversible

## The 5-Step Doubt Cycle

```
- [ ] Step 1: CLAIM — name the decision (2-3 lines + why it matters)
- [ ] Step 2: EXTRACT — isolate artifact + contract (strip reasoning)
- [ ] Step 3: DOUBT — adversarial review ("find issues, do NOT validate")
- [ ] Step 4: RECONCILE — classify findings against artifact
- [ ] Step 5: STOP — trivial findings, 3 cycles, or user override
```

### Step 1: CLAIM

```
CLAIM: "The auth middleware correctly rejects expired JWTs"
WHY THIS MATTERS: A bypass here exposes all user data
```

### Step 2: EXTRACT

Give the reviewer ONLY:
- The artifact (code diff or function)
- The contract (what it must satisfy)

**DO NOT give:** your reasoning, your CLAIM, your confidence level.

### Step 3: DOUBT

The reviewer prompt MUST be adversarial:

```
Adversarial review. Find what is WRONG.
Assume the author is overconfident. Look for:
- Unstated assumptions
- Edge cases not handled
- Hidden coupling or shared state
- Ways the contract could be violated
- Failure modes under unexpected input

Do NOT validate. Do NOT summarize. Find issues only.

ARTIFACT: [paste]
CONTRACT: [paste]
```

### Step 4: RECONCILE

Classify each finding (precedence order, first match wins):

1. **Contract misread** — reviewer misunderstood the spec → fix contract
2. **Valid + actionable** — real issue → fix it, re-loop
3. **Valid trade-off** — real but cost > benefit → document explicitly
4. **Noise** — correct under context reviewer didn't have → note and move on

### Step 5: STOP

Stop when:
- Next iteration returns only trivial findings, OR
- 3 cycles completed (escalate to user), OR
- User says "ship it"

## Integration with ClickUp

When doubt cycle reveals actionable issues:
1. `clickup-agent run comment --task-id <ID> --text "Doubt cycle found: [issue]"`
2. If cannot resolve in 3 cycles: `hitl-escalate` via ClickUp comment + assign
3. Log trade-off decisions: `clickup-agent run decision-log --task-id <ID>`

## NEVER

- Trust "I'm confident" as evidence
- Pass the CLAIM to the reviewer (biases toward agreement)
- Accept reviewer output as verdict without re-reading artifact
- Loop >3 cycles without escalating
- Skip doubt under time pressure on high-stakes code

## Verification

- [ ] Every non-trivial decision was named as a CLAIM
- [ ] Reviewer received ARTIFACT + CONTRACT only (not CLAIM)
- [ ] Reviewer prompt was adversarial ("find issues")
- [ ] Findings classified using precedence order
- [ ] Stop condition met (trivial / 3 cycles / user override)
- [ ] Actionable findings fixed
- [ ] Trade-offs documented in ClickUp decision-log
