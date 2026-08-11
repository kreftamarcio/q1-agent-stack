# Q1 Agent Stack

Infraestrutura de desenvolvimento assistido por IA. Integra Antigravity IDE (Gemini) + ClickUp Brain + Vercel + GitHub via MCP.

## O que é

Repo de configuração e documentação que unifica:
- 6 MCP servers operando em paralelo
- ~70 skills curadas de 6 frameworks open-source
- 6 skills anti-alucinação customizadas
- 3 agentes em closed-loop (Developer → Auditor → Debugger)
- Workflow dual-AI documentado

## Arquitetura

```
Antigravity IDE (Gemini)
  ├─ 3-Agent Loop: Developer (Flash) → Auditor (Pro) → Debugger (Pro)
  ├─ 6 MCP Servers:
  │   ├─ context-mode (redução de contexto)
  │   ├─ clickup-dev (operações em tasks)
  │   ├─ clickup-context (leitura rica)
  │   ├─ github (código + PRs)
  │   ├─ git-mcp (anti-alucinação via docs reais)
  │   └─ code-reasoning (raciocínio sequencial)
  ├─ Model Routing: Pro (planning) | Flash (code) | Lite (quick)
  └─ Skills instaladas de:
      oh-my-antigravity, agent-skills, SuperAntigravity,
      ECC, antigravity-skills vault, COG/loopkit

ClickUp Brain: gestão, triagem, sprint planning
Vercel: deploy, CDN, edge
```

## Inventário real

| Métrica | Total verificado |
|---------|------------------|
| Skills instaladas | ~70 (de 6 fontes) |
| Skills customizadas | 6 (anti-alucinação) |
| Agentes nos frameworks | ~29 (oh-my: 14, agent-skills: 4, Super: 8, custom: 3) |
| Agentes extras (ECC + Vercel) | ~24 |
| MCP Servers | 6 |
| MCP Tools | 42+ |
| Install Scripts | 4 |
| Comandos disponíveis | ~54 |

**Nota:** os frameworks instalados disponibilizam 300+ skills no total, mas ~70 estão efetivamente configuradas e em uso.

## Conteúdo criado por mim (não curadoria)

- `skills/` — 6 skills anti-alucinação (adversarial-11, doubt-driven, source-driven, memory-anchor, structured-output, clickup-brain)
- `agents/` — 3 configs de agente (developer.md, auditor.md, debugger.md)
- `GEMINI.md` — Config master com regras anti-alucinação e loop
- `MCP_ARCHITECTURE.md` — Documentação da camada MCP
- `CLICKUP_WORKFLOW.md` — Workflow diário
- `install*.sh` — 4 scripts de instalação
- Toda a documentação de integração

## Curadoria (frameworks de terceiros, todos MIT/Apache)

| Fonte | Licença | O que fornece |
|-------|---------|---------------|
| oh-my-antigravity | MIT | 11 skills, 14 agentes, 30+ comandos |
| agent-skills (Addy Osmani) | MIT | 24 skills SDLC, 4 agentes |
| SuperAntigravity | MIT | 19 auto-triggered skills, 8 agentes |
| ECC | MIT | 75 skills cherry-picked, 21 agentes |
| antigravity-skills vault | MIT | ~10 bundles instalados |
| context-mode | ELv2 | 11 MCP tools (uso interno OK) |

## Princípios de engenharia

1. **Closed-loop**: agente nunca avalia próprio trabalho (Developer ≠ Auditor)
2. **Anti-alucinação**: source-driven, doubt-driven, adversarial-11, structured output
3. **DAG thinking**: tasks como nós de grafo, travessia topológica
4. **Context economy**: context-mode reduz consumo de tokens via indexação FTS5

## Install

```bash
git clone https://github.com/kreftamarcio/q1-agent-stack.git
cd q1-agent-stack
chmod +x *.sh
./install.sh
./install-ecc.sh
./install-vercel.sh
cp .env.example .env
```

## Licença

MIT
