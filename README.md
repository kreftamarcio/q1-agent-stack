# Q1 Agent Stack

Infraestrutura de desenvolvimento assistido por IA. Integra Antigravity IDE (Gemini) + Claude Code + OpenAI Codex + ClickUp Brain + Vercel + GitHub via MCP.

## O que é

Repo de configuração e documentação que unifica:
- 6 MCP servers operando em paralelo
- ~70 skills curadas de 6 frameworks open-source
- 6 skills anti-alucinação customizadas
- 7 agentes em closed-loop orquestrado (ver abaixo)
- Golden Trio model routing: Claude Opus 5 + GPT-5.6 Sol + Gemini 3.1 Pro
- Deploy via Vercel (41 skills Vercel disponíveis)

## Arquitetura

```
Golden Trio (3 modelos, cada um no que faz melhor):
  ├─ Claude Opus 5: Arquitetura, spec, security, compliance
  ├─ GPT-5.6 Sol: Implementação, TDD, frontend, deploy
  └─ Gemini 3.1 Pro: Research, prototipagem, multimodal, triage

7 Agentes em Loop Orquestrado:
  orchestrator (DIRECTOR) ─────────────────────
  ├─ architect   (decomposição de features em DAG)
  ├─ developer   (TDD, implementação)
  ├─ auditor     (verificação adversarial, worker ≠ evaluator)
  ├─ debugger    (root-cause quando dev falha 2x)
  ├─ security    (OWASP gate pré-deploy)
  └─ deployer    (Vercel pipeline)

6 MCP Servers:
  ├─ context-mode     (redução de contexto, 98% token savings)
  ├─ clickup-dev      (operações em tasks)
  ├─ clickup-context  (leitura rica, imagens)
  ├─ github           (código, PRs, security)
  ├─ git-mcp          (docs reais como contexto anti-alucinação)
  └─ code-reasoning   (rac. sequencial)

Deploy: Vercel (serverless, edge, KV, Blob)
```

## Inventário

| Métrica | Total |
|---------|-------|
| Skills neste repo | 6 (anti-alucinação) |
| Skills externas (após install) | ~70 configuradas |
| Skills Vercel (após install-vercel.sh) | 41 |
| Agentes | 7 |
| MCP Servers | 6 |
| MCP Tools | 42+ |
| Install Scripts | 4 |

## Princípios de engenharia

1. **Closed-loop (Harness):** Worker nunca avalia próprio trabalho (developer ≠ auditor)
2. **Anti-alucinação (7 camadas):** source-driven, doubt-driven, adversarial-11, structured output, memory anchor
3. **DAG thinking:** Tasks como nós de grafo dirigido acíclico, travessia topológica
4. **Loop Engineering:** COG 6-step (Gather→Act→Observe→Verify→Update→Decide)
5. **Spec-Driven:** Nenhum código antes de spec + acceptance criteria confirmados
6. **Golden Trio:** Cada modelo no que faz melhor (ver MODEL_ROUTING.md)

## Documentação

| Arquivo | Propósito |
|---------|----------|
| CLAUDE.md | Config Claude Code (Opus 5) |
| AGENTS.md | Config OpenAI Codex (GPT-5.6 Sol) |
| GEMINI.md | Config Antigravity (Gemini 3.1 Pro) |
| ENGINEERING.md | Regras compartilhadas (loop, harness, grafos, spec-driven) |
| MODEL_ROUTING.md | Routing entre os 3 modelos |
| GOLDEN_TRIO_VERIFIED.md | Benchmarks auditados (fonte verificada) |
| SKILLS_MANIFEST.md | Inventário de skills |
| VERCEL_SKILLS.md | Skills de deploy Vercel |
| LOOP_HARNESS_GRAFOS.md | Engenharia de loop + harness + grafos |
| CLICKUP_WORKFLOW.md | Workflow ClickUp |
| MCP_ARCHITECTURE.md | Documentação MCP |

## Install

```bash
git clone https://github.com/kreftamarcio/q1-agent-stack.git
cd q1-agent-stack
chmod +x *.sh
./install.sh              # Core: oh-my-antigravity + agent-skills + SuperAntigravity
./install-ecc.sh          # ECC: 75 skills Claude Code
./install-loop-harness.sh # COG + loopkit: 66 skills de loop/harness
./install-vercel.sh       # Vercel: 41 skills de deploy
cp .env.example .env      # Configurar API keys
```

## License

This project is licensed under the **GNU Affero General Public License v3.0** (AGPL-3.0).

This means:

- ✅ You can view, fork, and learn from this code
- ✅ You can modify and redistribute under the same license
- ✅ You can use for personal/educational purposes
- ⚠️ If you deploy this (or a modified version) as a network service, you MUST make the complete source code available to all users
- ❌ Commercial use without AGPL-3.0 compliance is prohibited
- ❌ Removing or altering copyright notices is prohibited

For commercial licensing, contact: kreftamarcio1@gmail.com

---

© 2026 Marcio Krefta Fontella — Q1 Digital. All rights reserved under AGPL-3.0.
