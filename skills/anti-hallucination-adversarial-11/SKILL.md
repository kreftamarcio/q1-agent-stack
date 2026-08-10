---
name: anti-hallucination-adversarial-11
description: The 11-shortcut adversarial check before marking any code change as done. Assumes the code is BROKEN until proven otherwise. Run after EVERY implementation pass before commit.
---

# Anti-Hallucination: 11-Shortcut Adversarial Check

> **Default stance: the code is BROKEN until proven otherwise.**

## When to Use

- After EVERY code change, before marking done
- Before every commit
- Before every PR
- When an agent says "done" or "complete"

## The 11 Shortcuts Agents Use to Fake "Done"

Check EACH ONE against the diff:

### 1. Relaxed Tests
Assertions weakened or deleted to make red go green.
- Look for: `expect().toBeTruthy()` replacing specific assertions
- Look for: removed test cases
- Look for: `skip` or `xit` added

### 2. Swallowed Errors
try/catch that hides the failure instead of handling it.
- Look for: empty catch blocks
- Look for: `catch(e) { }` or `catch(e) { console.log(e) }`
- Look for: generic error returns that hide specifics

### 3. Fake Renames
A function "fixed" by renaming, behavior unchanged.
- Compare old and new: is the logic actually different?

### 4. Stub Returns
Hardcoded return values that pass the one test, fail everything else.
- Look for: `return true`, `return []`, `return null` without logic
- Look for: values that match test expectations suspiciously exactly

### 5. Comment-as-Fix
The bug is now a TODO.
- Search for: new TODO, FIXME, HACK comments in the diff
- If the "fix" is a comment, it's not a fix

### 6. Happy-Path Only
500s, empty inputs, missing files unhandled.
- Ask: what happens with null input?
- Ask: what happens with network error?
- Ask: what happens with empty array?
- Ask: what happens with unauthorized user?

### 7. Scope Creep
Changes unrelated to the goal.
- Compare diff to original task spec
- Every changed line must trace back to the requirement

### 8. Invented API
A method/param that doesn't exist in the actual source.
- Verify every imported function exists in the package
- Run `npm info` or check `node_modules` types
- Use git-mcp to confirm API exists in library docs

### 9. Silent Decision
An architectural choice made without flagging it.
- Look for: new dependencies added without discussion
- Look for: schema changes without migration
- Look for: auth/security changes without review

### 10. Pass-by-Mock
The test mocks the exact thing it claims to verify.
- If `fetchUser` is mocked to return `{name: 'test'}` and the test asserts `name === 'test'`, it tests NOTHING

### 11. Off-Spec Done
Code works, tests pass, but solves a DIFFERENT problem than asked.
- Re-read the original task/spec
- Does the implementation match what was ASKED, not what was easy?

## Output Format

```json
{
  "passes": false,
  "failures": [
    {"line": 42, "shortcut": "swallowed errors", "why": "catch block logs but doesn't throw or return error state"},
    {"line": 78, "shortcut": "invented API", "why": "useServerAction doesn't exist in Next.js 15"}
  ]
}
```

If it genuinely passes ALL 11 checks: `{"passes": true}`

## Verification

- [ ] All 11 shortcuts checked against the diff
- [ ] Every failure has a specific line number and explanation
- [ ] No self-assessment ("looks good") accepted as verification
- [ ] Deterministic checks run (tests, build, lint) in addition to this
