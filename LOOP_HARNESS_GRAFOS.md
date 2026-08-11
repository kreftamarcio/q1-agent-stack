# Loop + Harness + Grafos

As 3 engenharias que governam como os agentes iteram, verificam, e se organizam.

---

## 1. Loop Engineering

Todo ciclo iterativo segue 6 fases:

```
GATHER → ACT → OBSERVE → VERIFY → UPDATE → DECIDE
```

Step 4 (VERIFY) é load-bearing. Um loop sem verificador é só uma chain que repete.

### Terminação (sempre múltiplas condições)

| Condição | Limite |
|----------|--------|
| Verificador determinístico | Test pass? Build ok? |
| Hard cap de iterações | Max 5 |
| Budget de tool calls | Max 20 |
| No-progress detection | 2 passes sem mudança = stop |
| Escalação humana | ClickUp comment |

### Patterns

| Pattern | Quando |
|---------|--------|
| ReAct | Default: reason → act → observe → repeat |
| Reflexion | Falhou: escrever lição, tentar diferente |
| Plan-Execute-Verify | Multi-step: verificar cada passo |
| Evaluator-Optimizer | Quality gate: gerar, avaliar, repetir |
| Orchestrator-Workers | Paralelo: split em fresh contexts |
| Human-in-the-Loop | Stuck: escalar via ClickUp |

---

## 2. Harness (V-Model)

```
PLANNER → EXECUTOR → VERIFIER
   ↑                      │
   └──── FEEDBACK ────────┘
```

Regra: **o executor nunca avalia seu próprio trabalho.**

O verificador recebe artefato + contrato. Nunca recebe justificativa do executor.

### Anti-patterns que o harness previne

| Anti-pattern | Sintoma | Fix |
|--------------|---------|-----|
| Sucesso alucinado | "Looks done" | Verificador determinístico |
| Loop infinito | Roda sem parar | Hard cap + no-progress |
| Context rot | Esquece constraints | Externalizar estado |
| Erro composto | Erro em cima de erro | Verificar cada pass |
| Goal drift | Esqueceu objetivo | Goal pinning |

---

## 3. Engenharia de Grafos (DAG)

Tasks são nós num grafo acíclico dirigido. Execução segue ordem topológica.

```
     [Spec]
      / \
   [Auth] [UI]         ← paralelo
     |      |
   [API]  [Pages]
     \      /
    [Integration]      ← convergência
         |
      [Deploy]
```

### Regras

- Nó com 0 deps pendentes executa primeiro
- Nós independentes paralelizam (subagent fanout)
- Join-node espera todos predecessores
- Sem ciclos. Se detectar: redecompor.
- Max 7 nós por feature. Se mais: dividir.

### Mapeamento ClickUp

| Conceito | ClickUp |
|----------|--------|
| Nó | Task |
| Aresta | Dependency |
| Sub-grafo | Subtask tree |
| Fork | Subtasks paralelas |
| Join | Task com múltiplas deps |
| State machine | Status progression |

---

## Workflow integrado

```
1. Task no ClickUp (nó no grafo)
2. Gather: ler context da task
3. Planner: decompor em sub-DAG
4. Taskboard: próximo nó (ordem topológica)
5. Executor: implementar 1 nó
6. Verifier: check determinístico
   ├─ PASS → next node
   └─ FAIL → feedback → retry (max 5)
7. Convergência: todos deps do join-node done
8. Delivery gate + security gate
9. Deploy
```
