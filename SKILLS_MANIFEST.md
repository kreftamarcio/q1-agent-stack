# Skills Manifest

Inventário de skills disponíveis neste stack. Separação clara entre o que está NESTE REPO vs o que é instalado externamente.

---

## Skills neste repo (criadas por mim)

Diretório: `skills/`

| Skill | Propósito |
|-------|----------|
| anti-hallucination-adversarial-11 | Checklist de 11 atalhos que agentes usam pra falar "done" sem estar |
| anti-hallucination-clickup-brain | Regras específicas pra operação via ClickUp Brain |
| anti-hallucination-doubt-driven | Protocolo CLAIM→EXTRACT→DOUBT→RECONCILE→STOP |
| anti-hallucination-memory-anchor | Goal pinning, state externalization, no-progress detection |
| anti-hallucination-source-driven | Forçar verificação de fonte antes de qualquer API call |
| anti-hallucination-structured-output | Validação de todo output executável |

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
| Skills neste repo | 6 |
| Skills externas (após install completo) | ~70 configuradas |
| Agentes nos frameworks | ~29 |
| Agentes extras (ECC + Vercel) | ~24 |
| Comandos disponíveis | ~54 |
| MCP Servers | 6 |
| MCP Tools | 42+ |

**Nota:** os frameworks disponibilizam mais skills do que as configuradas. Os números acima refletem o que está efetivamente em uso após rodar todos os install scripts.
