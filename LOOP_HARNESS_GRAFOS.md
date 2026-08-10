# Loop Engineering + Harness + Engenharia de Grafos

> A meta-engenharia que governa COMO os agentes iteram, verificam, e se organizam topologicamente.

## Regra de Ouro

**O WORKER NUNCA AVALIA SEU PRÓPRIO TRABALHO.**

Quem executa ≠ quem verifica. Sempre.

---

## 1. Loop Engineering (COG Pattern)

### O Loop COG (6 steps)

```
┌──────────────────────────────────────────────┐
│  1. Gather    pull context (ClickUp + vault)  │
│  2. Act       one step: implement / fetch     │
│  3. Observe   read the REAL result            │
│  4. Verify    run DETERMINISTIC check         │
│  5. Update    write progress to ClickUp       │
│  6. Decide    continue? → loop                │
│               stop?     → finish + report     │
└──────────────────────────────────────────────┘
```

**Step 4 é load-bearing.** Um loop sem verifier é só uma chain que repete.

### Termination Conditions (SEMPRE múltiplas, nunca uma só)

| Exit | O que é | Exemplo |
|------|---------|--------|
| Deterministic verifier | Pass/fail mecânico | "Tests pass? Build ok?" |
| Hard iteration cap | Max passes | "Stop after 5 iterations" |
| Budget guard | Max tool calls/tokens | "Stop after 20 fetches" |
| No-progress detection | Nada mudou em N passes | "2 loops sem mudança = stop" |
| Human escalation | Agente cria comment no ClickUp pedindo input | "Asked twice, still unclear" |

### Patterns Nomeados

| Pattern | Shape | Quando usar |
|---------|-------|-------------|
| **ReAct** | reason → act → observe → repeat | Base de todo loop |
| **Reflexion** | on failure, write lesson, retry differently | Quando falha e precisa aprender |
| **Plan-Execute-Verify** | plan steps, run them, verify each | Implementações multi-step |
| **Evaluator-Optimizer** | generate, score, repeat until pass | Quality gates |
| **Orchestrator-Workers** | split, run in fresh windows, synthesize | Tasks paralelas |
| **Loop-Until-Dry** | keep going until K passes surface nothing new | Extração de informação |
| **Human-in-the-Loop** | escalate when stuck | ClickUp comment + assign |

---

## 2. Harness Engineering

### V-Model (COG)

```
┌─────────┐    ┌─────────────┐    ┌──────────┐
│ PLANNER │───→│  EXECUTOR   │───→│ VERIFIER │
└─────────┘    └─────────────┘    └──────────┘
     ↑                                    │
     └────────── FEEDBACK LOOP ───────────┘
```

### Anti-patterns que o Harness Previne

| Anti-pattern | Sintoma | Fix |
|--------------|---------|-----|
| Hallucinated success | "Looks done to me" | Verifier determinístico |
| Silent infinite loop | Roda pra sempre sem progresso | No-progress detection + hard cap |
| Context rot | Window cheia, agente esquece | Externalize to vault/ClickUp |
| Compounding errors | Erro em cima de erro | Verify cada pass, não só no final |
| Goal drift | Esqueceu o que tava fazendo | Goal + stop conditions no topo |

### Skills de Harness Instaladas (loopkit)

- `eval-harness`: Framework de avaliação de output
- `adversarial-verify`: Red-team o próprio código
- `self-eval-bias`: Detecta viés de auto-avaliação
- `hitl-escalate`: Escalação human-in-the-loop
- `verification-before-completion`: Gate obrigatório antes de "done"
- `harness-stripping`: Remove harness overhead quando não precisa
- `evaluator-calibration`: Calibra o evaluator pra não ser lenient/strict demais

---

## 3. Engenharia de Grafos (aplicada ao ClickUp)

### Tasks como Grafos Dirigidos Acíclicos (DAG)

```
     [Spec]           ← Nó raiz (sem dependência)
      / \
   [Auth] [UI]        ← Nós paralelos (fanout)
     |      |
   [API]  [Pages]     ← Dependem dos anteriores
     \      /
    [Integration]     ← Nó de convergência
         |
      [Deploy]        ← Nó terminal
```

### Como Implementar no ClickUp + Antigravity

1. **Cada task = nó** com:
   - Pre-conditions (tasks que precisam estar "done" antes)
   - Post-conditions (acceptance criteria pro verifier)
   - Model assignment (Pro pra planning, Flash pra exec)

2. **`/oma:taskboard next`** percorre o grafo topologicamente:
   - Pega a task com MENOR dependência pendente
   - Nunca pula pra frente no grafo
   - Se bloqueado, escala via `hitl-escalate`

3. **`subagent-fanout`** pra nós paralelos:
   - Spawna workers independentes em fresh contexts
   - Cada worker recebe só o slice que precisa
   - Orchestrator sintetiza no final

4. **`/oma:workspace`** pra lanes paralelas:
   - Cada branch do grafo = uma lane
   - Workspace audit antes de merge/convergência

### Mapeamento ClickUp → Grafo

| Conceito Grafo | Equivalente ClickUp |
|----------------|---------------------|
| Nó | Task |
| Aresta (dependência) | Task dependency |
| Sub-grafo | Subtask tree |
| Nó raiz | Task sem dependency |
| Nó terminal | Task que fecha a feature |
| Fork (fanout) | Subtasks paralelas |
| Join (convergência) | Task com múltiplas deps |
| Ciclo (loop) | Task que reabre se verifier falha |
| State machine | Status progression (todo→wip→review→done) |

---

## 4. Workflow Integrado: ClickUp + Antigravity + 3 Engenharias

```
1. ClickUp Task criada (nó no grafo)
   │
2. clickup-agent context load (gather)
   │
3. /oma:team-assemble (define PLANNER + EXECUTOR + VERIFIER)
   │
4. PLANNER: /spec → /plan → decompõe em sub-grafo no ClickUp
   │
5. /oma:taskboard next (percorre DAG topologicamente)
   │
6. EXECUTOR: implementa UM nó (Act)
   │
7. VERIFIER: roda check determinístico (Verify)
   │         ├─ PASS → marca task "done", next node
   │         └─ FAIL → feedback ao EXECUTOR (Reflexion)
   │                   ├─ retry ≤ cap? → loop
   │                   └─ retry > cap? → hitl-escalate (ClickUp comment)
   │
8. Convergência: quando todas deps do join-node estão done
   │
9. delivery-gate + production-audit (final harness)
   │
10. clickup-agent run dev-sync + set-status "done"
```

---

## 5. Referências Arquiteturais (não instalar, usar como design patterns)

| Repo | Stars | Usar pra |
|------|-------|----------|
| [LangGraph](https://github.com/langchain-ai/langgraph) | 39K | Entender state machines de agentes |
| [deer-flow](https://github.com/bytedance/deer-flow) (ByteDance) | 79K | Referência de SuperAgent harness de longa duração |
| [deepagents](https://github.com/langchain-ai/deepagents) | 27K | Batteries-included harness pattern |

Estes são Python-heavy e mais complexos. A implementação prática pra teu caso está toda no **oh-my-antigravity + loopkit + COG + ECC** rodando no Antigravity com Gemini.

---

## 6. Licenças

| Repo | Licença | Status |
|------|---------|--------|
| COG-second-brain | MIT | ✅ Livre |
| loopkit | MIT | ✅ Livre |
| LangGraph | MIT | ✅ Livre (referência) |
| deer-flow | Apache 2.0 | ✅ Livre (referência) |
| deepagents | MIT | ✅ Livre (referência) |
