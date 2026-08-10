---
name: anti-hallucination-source-driven
description: Forces the agent to fetch and cite official documentation before writing any framework-specific code. Use ALWAYS when implementing with Next.js, React, n8n, Supabase, Prisma, or any library. Prevents invented APIs and deprecated patterns.
---

# Anti-Hallucination: Source-Driven Implementation

> **Iron Rule:** NEVER write framework-specific code from memory. Fetch, verify, cite.

## When to Use

- ANY time you write code that uses a library or framework API
- Before suggesting package installs
- Before referencing CLI commands
- Before claiming an API exists or has specific parameters

## Process

### Step 1: Detect Stack

Read dependency files to identify EXACT versions:
```
package.json → Node/React/Next.js version
pyproject.toml → Python packages
```

State what you found:
```
STACK DETECTED:
- Next.js 15.2.0 (from package.json)
- React 19.1.0
- Prisma 6.4.0
→ Fetching relevant docs.
```

### Step 2: Fetch Official Docs

Use `git-mcp` or direct fetch to get the SPECIFIC page for the API you need.

**Source hierarchy (authority order):**
1. Official documentation (react.dev, nextjs.org/docs, prisma.io/docs)
2. Official changelog/blog
3. Web standards (MDN)
4. NEVER: Stack Overflow, blog posts, your own memory

**Be precise:**
```
BAD:  Fetch the React homepage
GOOD: Fetch react.dev/reference/react/useActionState
```

### Step 3: Implement from Docs

- Use API signatures FROM THE DOCS, not from memory
- If docs show a new way: use the new way
- If docs deprecate a pattern: don't use the deprecated version
- If docs don't cover something: FLAG IT

### Step 4: Cite Sources

Every framework-specific pattern gets a citation:

```typescript
// Next.js 15 App Router - Server Action
// Source: https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions
export async function createTask(formData: FormData) {
  'use server'
  // ...
}
```

### Step 5: Flag Unverified

If you CANNOT find documentation:

```
⚠️ UNVERIFIED: I could not find official documentation for this
pattern. This is based on training data and may be outdated.
Verify before using in production.
```

## Verification

- [ ] Framework versions identified from dependency files
- [ ] Official docs fetched for framework-specific patterns
- [ ] All sources are official (not blogs/SO/training data)
- [ ] Code follows documented patterns for detected version
- [ ] Citations with full URLs included
- [ ] Anything unverified is explicitly flagged
- [ ] No deprecated APIs used
