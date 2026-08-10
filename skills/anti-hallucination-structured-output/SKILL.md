---
name: anti-hallucination-structured-output
description: Forces validation of every output before it reaches the user or codebase. Every claim must be verifiable, every code must compile, every path must exist. Use for ALL outputs that will be executed or acted upon.
---

# Anti-Hallucination: Structured Output Validation

> **Rule: If you cannot verify it, you cannot output it.**

## When to Use

- Before outputting any code that will be executed
- Before suggesting file paths
- Before recommending packages
- Before citing URLs
- Before claiming features/APIs exist

## Validation Matrix

| Output Type | Validation Method | If Fails |
|-------------|-------------------|----------|
| TypeScript code | `tsc --noEmit` (no type errors) | Fix before outputting |
| File paths | `ls` or `glob` confirms existence | Correct path or flag as new file |
| Package names | `npm info <pkg>` returns data | Verify spelling, check if exists |
| CLI commands | `<cmd> --help` works | Verify syntax with docs |
| URLs | Fetch returns 200 | Remove or flag as unverified |
| API endpoints | Documented in official docs | Fetch docs via git-mcp |
| Import statements | Module exists in node_modules or project | Check with grep/find |
| Environment variables | Referenced in .env.example or docs | Flag if undocumented |
| Database queries | Schema matches actual migrations | Cross-reference schema files |
| Regex patterns | Test against sample inputs | Run regex test |

## Process

### Step 1: Classify Output

Before outputting, ask: "Will someone execute this, copy this, or make a decision based on this?"

- YES → Must validate
- NO (just explaining) → Can output with caveats

### Step 2: Validate Each Claim

For each verifiable claim in your output:

```
CLAIM: "Use useActionState from React 19"
VERIFICATION: Fetch react.dev/reference/react/useActionState
RESULT: ✅ Exists, documented for React 19
```

```
CLAIM: "Run npx create-t3-app@latest"
VERIFICATION: npm info create-t3-app
RESULT: ✅ Package exists, latest version 8.x
```

```
CLAIM: "Import from @/lib/auth"
VERIFICATION: ls src/lib/auth* or grep -r "lib/auth"
RESULT: ❌ File doesn't exist → must create it or fix path
```

### Step 3: Flag Unverifiable

If you cannot run verification (no access, no tool available):

```
⚠️ UNVERIFIED: Cannot confirm this API exists in your version.
Please verify: [specific thing to check]
```

NEVER output unverified claims without this flag.

### Step 4: Compile Check

For any code block >5 lines:
- Does it have all imports?
- Do types align?
- Are all variables defined?
- Would `tsc --noEmit` pass?

If unsure about ANY of these: run the check before outputting.

## Anti-Patterns (DO NOT DO)

- ❌ Output a file path without checking if it exists
- ❌ Suggest `npm install x` without verifying the package name
- ❌ Reference an API without citing documentation
- ❌ Write imports from modules you haven't verified exist
- ❌ Suggest env vars that aren't in .env.example
- ❌ Claim "this will work" without running it

## Verification

- [ ] Every verifiable claim has been validated
- [ ] Unverifiable claims are explicitly flagged
- [ ] Code compiles without type errors
- [ ] All file paths exist or are marked as new
- [ ] All packages verified with npm info
- [ ] All URLs confirmed accessible
- [ ] No invented APIs
