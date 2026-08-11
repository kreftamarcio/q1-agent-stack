# Q1 Digital — Agent Operating System (Universal)

> This file is loaded by Codex, OpenCode, GitHub Copilot, and other tools that read AGENTS.md.
> Same rules as GEMINI.md and CLAUDE.md.

## Core Rules

1. Source-Driven: fetch docs before coding. Flag UNVERIFIED if not found.
2. TDD: failing test first, always.
3. Small commits: ~100 lines, conventional commits.
4. Anti-hallucination: validate every output. Never self-grade.
5. Loop Engineering: Gather→Act→Observe→Verify→Update→Decide.
6. V-Model: Developer ≠ Auditor. Separate executor from verifier.
7. Graph Thinking: tasks are DAG nodes. Pick fewest pending deps first.

## Agents

See `agents/` directory. 7 agents operate as a loop:
- architect (plan) → developer (code) → auditor (verify) → security (gate) → deployer (ship)
- debugger activates when developer fails 2x
- orchestrator directs the flow

## Anti-Hallucination (11-Shortcut Check)

Before EVERY commit verify NO: relaxed tests, swallowed errors, fake renames, stub returns, comment-as-fix, happy-path only, scope creep, invented API, silent decisions, pass-by-mock, off-spec done.

## Handoff Contract

Every agent transition passes:
```json
{"from": "...", "to": "...", "node": "...", "payload": {"files_changed": [], "tests_added": 0, "acceptance_criteria_met": [], "unresolved": []}, "status": "..."}
```

## Quality Gates

- Tests pass
- tsc clean
- Security clean
- Performance: LCP < 2.5s
- Verifier sign-off (not self-reported)
- Anti-slop passed
- Source citations present
