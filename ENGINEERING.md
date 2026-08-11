# Engineering Rules (Shared)

This file contains rules shared across all model configs (CLAUDE.md, GEMINI.md, AGENTS.md).
Each model config references this file and adds only model-specific anti-hallucination rules.

---

## Engenharia de Loop

Todo ciclo iterativo segue 6 fases:

```
GATHER → ACT → OBSERVE → VERIFY → UPDATE → DECIDE
```

| Fase | O que faz | Validação |
|------|-----------|----------|
| Gather | Ler task, deps, código existente | Confirmar que leu (não assumiu) |
| Act | 1 mudança atômica | Diff contido no escopo |
| Observe | Rodar test/build/lint | Ler stdout/stderr real |
| Verify | Check externo | Test pass? Build ok? Tipos ok? |
| Update | Registrar resultado | ClickUp comment ou MEMORY.md |
| Decide | Próximo nó, retry, ou escalar | Baseado em evidência |

### Condições de Terminação

| Condição | Limite |
|----------|--------|
| Iterações máximas por nó | 5 |
| Tool calls por loop | 20 |
| Passes sem progresso | 2 → parar |
| Verificador | Sempre externo (nunca auto-avaliação) |
| Escalação | ClickUp comment ao humano |

---

## Engenharia de Grafos (DAG)

```
1. Feature → decompor em sub-tasks (nós atômicos)
2. Declarar dependências (arestas)
3. Ordenar topologicamente
4. Executar: nó com 0 deps pendentes primeiro
5. Nós independentes podem paralelizar (subagent fanout)
6. Join-node: esperar todos predecessores DONE
```

Regras:
- Sem ciclos. Se detectar: redecompor.
- Sem pular nós. Sem executar com dep pendente.
- Max 7 nós por feature. Se mais: dividir em 2 features.

---

## Spec-Driven Development

```
1. SPEC → contrato (input types, output types, invariantes, erros esperados)
2. TEST → teste que falha (red)
3. IMPLEMENT → código mínimo pra verde
4. VERIFY → suite completa + build
5. REFACTOR → só após verde
```

Sem spec = perguntar ao humano ou derivar da task.
Nunca implementar sem contrato definido.

---

## Harness (V-Model)

```
PLANNER → EXECUTOR → VERIFIER
   ↑                      │
   └──── FEEDBACK ────────┘
```

O executor nunca avalia seu próprio trabalho.
O verificador recebe: artefato + contrato. Nunca recebe justificativa do executor.

Loop: developer → auditor → (pass: security → deployer | fail: debugger → auditor)

### Agentes

| Agente | Papel | Quando |
|--------|-------|--------|
| architect | Decompor feature em DAG | Início de feature |
| developer | Implementar nó com TDD | Execução de nó |
| auditor | Verificar adversarialmente | Após cada implementação |
| debugger | Corrigir após 2 falhas do dev | Escalação |
| security | OWASP gate pré-deploy | Pré-merge |
| deployer | Pipeline Vercel | Pós-verificação |
| orchestrator | Travessia do DAG + routing | Direção contínua |

### Handoff entre agentes

```json
{
  "from": "developer",
  "to": "auditor",
  "node": "auth-middleware",
  "files_changed": ["src/middleware.ts"],
  "tests_added": 3,
  "status": "ready_for_audit"
}
```

---

## Adversarial 11-Check

Antes de marcar QUALQUER código como done, verificar ausência de:

1. Testes relaxados (assertion enfraquecida pra ficar verde)
2. Erros engolidos (try/catch vazio ou que retorna null)
3. Renomeação fake (nome mudou, comportamento não)
4. Retorno stub (valor hardcoded que passa 1 teste)
5. Comentário como fix (bug virou TODO)
6. Só happy-path (sem erro, sem vazio, sem edge case)
7. Scope creep (mudança não relacionada ao goal)
8. API inventada (método/param que não existe na source)
9. Decisão silenciosa (escolha arquitetural não flagada)
10. Pass-by-mock (teste mocka exatamente o que diz verificar)
11. Off-spec done (funciona mas resolve problema errado)

Se qualquer item presente: NÃO está done.

---

## Quality Gates

- [ ] Código novo tem teste que prova o contrato (contract-coverage)
- [ ] `tsc --noEmit` limpo
- [ ] Sem secrets em código
- [ ] LCP < 2.5s, CLS < 0.1
- [ ] WCAG 2.1 AA
- [ ] Commits atômicos, mensagens convencionais
- [ ] Verificador externo assinou (não auto-reportado)
- [ ] Adversarial 11-check passou
- [ ] Toda API verificada contra docs reais
- [ ] Imports verificados (arquivo existe, pacote em package.json)

---

## Output Rules

- Código primeiro, explicação depois (máx 3 linhas)
- Output deve ser verificável: nomes de arquivo reais, números mensuráveis, referências concretas
- Se uma frase funciona em qualquer contexto, é genérica demais. Reescrever com especificidade.
- Se não sabe: dizer "não sei" > inventar
- Commit messages: conventional commits, max 72 chars
