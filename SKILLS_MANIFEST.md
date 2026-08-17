# Skills Manifest

Inventário de skills disponíveis neste stack. Separação clara entre o que está NESTE REPO vs o que é instalado externamente.

---

## Skills neste repo (criadas por mim)

Diretório: `skills/`

| Skill | Propósito |
|-------|----------|
| anti-hallucination-source-driven | Docs oficiais antes de qualquer código |
| anti-hallucination-memory-anchor | Goal pinning + recall a cada N tool calls |
| anti-hallucination-clickup-brain | Só quando operar via ClickUp |
| anti-hallucination-structured-output | Validação batch de todos os claims |
| anti-hallucination-adversarial-11 | Ataque adversarial às claims (claim-attack) |
| anti-hallucination-doubt-driven | Só decisões não-triviais / alto risco |
| anti-hallucination-deterministic-gate | Gate determinístico final: tsc, test, lint, build |

## Pipeline das 7 camadas (loop COG)

| Fase | Skill | Papel |
|------|-------|-------|
| Gather | `source-driven` | Docs oficiais antes de qualquer código |
| Act (contínuo) | `memory-anchor` | Goal pinning + recall a cada N tool calls |
| Act (condicional) | `clickup-brain` | Só quando operar via ClickUp |
| Verify 1 | `structured-output` | Validação batch de todos os claims |
| Verify 2 | `adversarial-11` | Ataque adversarial às claims |
| Verify 3 | `doubt-driven` | Só decisões não-triviais / alto risco |
| Verify 4 (final) | `deterministic-gate` | Prova mecânica: tsc, test, lint, build |

---

## Skills instaladas via scripts (frameworks de terceiros)

Estas skills NÃO estão neste repo. São instaladas pelos scripts `install*.sh` em diretórios externos do IDE.

### Via `install.sh` (core)

**oh-my-antigravity** (MIT)
- 11 skills de metodologia ($plan, $execute, $prd, $research, etc.)
- 14 sub-agentes (oma-architect, oma-planner, oma-executor, etc.)
- 30+ comandos (/oma:team, /oma:goal, /oma:loop, etc.)

**agent-skills by Addy Osmani** (MIT)
- 24 skills cobrindo o SDLC completo (spec → plan → build → test → review → ship)
- 4 agentes (code-reviewer, test-engineer, security-auditor, web-performance-auditor)
- 8 comandos (/spec, /plan, /build, /test, /review, /ship, etc.)

**SuperAntigravity** (MIT)
- 19 skills auto-triggered (brainstorming, TDD, debugging, verification, etc.)
- 8 agentes (code-reviewer, backend-architect, frontend-architect, etc.)
- 16+ comandos

### Via `install-ecc.sh`

**ECC (Everything Claude Code)** (MIT)
- 75 skills cherry-picked de um vault maior
- 21 agentes
- Focado em Claude Code mas funciona em qualquer IDE que lê SKILL.md

### Via `install-loop-harness.sh`

**COG + loopkit** (MIT)
- 66 skills de loop engineering e harness
- Patterns: ReAct, Reflexion, Plan-Execute-Verify, Evaluator-Optimizer
- Tools: adversarial-verify, hitl-escalate, eval-harness, evaluator-calibration

### Via `install-vercel.sh`

**vercel-plugin + vercel-labs** (Apache 2.0 / MIT)
- 32 skills focadas em deploy Vercel
- 3 agentes
- Skills: nextjs, ai-sdk, vercel-functions, vercel-storage

---

## Totais verificados

| Categoria | Quantidade |
|-----------|------------|
| Skills neste repo | 7 |
| Skills externas (após install completo) | ~70 configuradas |
| Agentes nos frameworks | ~29 |
| Agentes extras (ECC + Vercel) | ~24 |
| Comandos disponíveis | ~54 |
| MCP Servers | 6 |
| MCP Tools | 42+ |

**Nota:** os frameworks disponibilizam mais skills do que as configuradas. Os números acima refletem o que está efetivamente em uso após rodar todos os install scripts.
