# Model Routing

Três modelos, cada um no que faz melhor. Sem fallback cruzado desnecessário.

---

## Routing por tipo de task

| Tipo de task | Modelo | Por quê |
|--------------|--------|--------|
| Arquitetura, spec, PRD | Claude Opus 5 | Raciocínio profundo, self-verification nativo |
| Code review, security audit | Claude Opus 5 | Adversarial review, compliance |
| Implementação, TDD, bug fix | GPT-5.6 Sol | Coding agent mais eficiente em tokens |
| Frontend, UI, deploy | GPT-5.6 Sol | Design judgment nativo, Codex harness |
| Prototipagem, research | Gemini 3.1 Pro | Custo baixo, multimodal, iteração rápida |
| Triage, routing, coordenação | Gemini 3.1 Pro | Rápido, function calling robusto |

---

## Routing por agente

| Agente | Modelo | Razão |
|--------|--------|-------|
| architect | Opus 5 | Decisões de boundary e decomposição |
| auditor | Opus 5 | Verificação adversarial |
| security | Opus 5 | OWASP, compliance |
| developer | Sol | Implementação eficiente |
| deployer | Sol | CI/CD, Vercel |
| debugger | Sol (fix) + Opus 5 (root-cause) | Sol tenta, Opus escala |
| orchestrator | Gemini 3.1 Pro | Triage e routing |

---

## Routing por fase do projeto

| Fase | Primário | Secundário |
|------|----------|------------|
| Discovery & Research | Gemini | Opus 5 (validação) |
| Spec & PRD | Opus 5 | — |
| Architecture | Opus 5 | — |
| Implementation | Sol | — |
| Testing | Sol | — |
| Code Review | Opus 5 | Sol (auto-fix) |
| Frontend/UI | Sol | Gemini (visual review) |
| DevOps & Deploy | Sol | — |
| Content & Marketing | Gemini | — |

---

## Decision tree

```
Task chega
├─ Decisão irreversível / segurança / compliance? → Opus 5
├─ Implementação / fix / PR / deploy? → Sol
├─ Prototipagem / research / multimodal / volume? → Gemini 3.1 Pro
└─ Ambíguo? → Gemini (melhor custo/benefício geral)
```

---

## Princípios de custo

- Opus 5 é caro. Usar só quando a decisão justifica o custo.
- Sol é eficiente. Bulk do coding vai aqui.
- Gemini é barato. Volume, iteração, prototipagem.
- Regra: se o output pode ser verificado por test/build, use Sol. Se precisa de julgamento profundo, use Opus 5. Se precisa de velocidade/volume, use Gemini.

---

## Handoff entre modelos

Contexto passa via ClickUp task (persistência real, não context window):

```json
{
  "task_id": "CLICKUP_ID",
  "from_model": "opus-5",
  "to_model": "sol",
  "artifacts": ["spec.md", "dag.md"],
  "constraints": ["TDD", "max 100 lines/commit"],
  "acceptance_criteria": ["tests pass", "tsc clean"]
}
```

O modelo receptor lê da task, não herda context do anterior.
