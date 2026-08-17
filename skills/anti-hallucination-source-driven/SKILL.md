---
name: anti-hallucination-source-driven
description: Fetch and cite official documentation BEFORE writing code that uses any external API, library, or config format. Every technical claim carries source:line + verbatim quote, or is explicitly marked UNVERIFIED. Use at the Gather phase, before implementation.
---

# Anti-Hallucination: Source-Driven Development

> **If you did not read it this session, you do not know it.**

## Protocol

1. **Detect the stack**: read `package.json` / lockfiles to get EXACT versions.
2. **Fetch official docs** for those versions (official docs > changelog > source code > blog posts; never Stack Overflow as primary source).
3. **Cache per session**: keep a `SOURCES` list; never re-claim from memory what you can re-quote from the cache.

## Citation Contract (mandatory)

Every technical claim about an external API must be one of:

```
CLAIM: next.config.js supports `serverExternalPackages` since v15
SOURCE: https://nextjs.org/docs/app/api-reference/config (fetched this session)
QUOTE: "serverExternalPackages: opt-out specific dependencies..."
```

or

```
CLAIM: [statement]
STATUS: UNVERIFIED - docs not fetched. Do not build on this claim.
```

There is no third option. Paraphrase from training memory = UNVERIFIED.

## Precedence (overlap with sibling skills)

- THIS skill governs how facts ENTER the context (Gather).
- `structured-output` governs how claims are VALIDATED in batch (Verify).
- `adversarial-11` governs how claims are ATTACKED (Verify).

## NEVER

- Write code against an API signature you have not quoted this session
- Cite a version-less doc for version-sensitive behavior
- Let an UNVERIFIED claim silently become the basis of an implementation
