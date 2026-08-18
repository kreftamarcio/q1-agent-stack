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

## Agentes neste repo

Diretório: `agents/`

| Agente | Papel |
|--------|-------|
| architect | Decompor feature em DAG |
| developer | Implementar nó com TDD |
| auditor | Verificação adversarial |
| debugger | Corrigir após 2 falhas do dev |
| security | OWASP gate pré-deploy |
| deployer | Pipeline Vercel |
| orchestrator | Travessia do DAG + routing |

## Totais verificáveis neste repo

| Categoria | Quantidade |
|-----------|------------|
| Skills | 6 |
| Agentes | 7 |
| MCP Servers documentados | 6 |
| Install scripts | 4 |

---

## Skills externas (pós-instalação)

> **Atenção:** os números abaixo dependem de rodar os scripts `install*.sh`
> numa máquina com o IDE configurado. Eles NÃO são verificáveis apenas
> clonando este repo.

### Via `install.sh` (core)

**oh-my-antigravity** (MIT)
- 11 skills de metodologia ($plan, $execute, $prd, $research, etc.)
- 14 sub-agentes
- 30+ comandos

**agent-skills by Addy Osmani** (MIT)
- 24 skills cobrindo o SDLC completo
- 4 agentes
- 8 comandos

**SuperAntigravity** (MIT)
- 19 skills auto-triggered
- 8 agentes
- 16+ comandos

### Via `install-ecc.sh`

**ECC (Everything Claude Code)** (MIT)
- 75 skills cherry-picked de um vault maior
- 21 agentes

### Via `install-loop-harness.sh`

**COG + loopkit** (MIT)
- 66 skills de loop engineering e harness

### Via `install-vercel.sh`

**vercel-plugin + vercel-labs** (Apache 2.0 / MIT)
- 32 skills focadas em deploy Vercel
- 3 agentes
