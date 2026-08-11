# CLAUDE.md — Opus 5

Config carregada automaticamente pelo Claude Code no início da sessão.
Modelo único: **claude-opus-5**. Sem fallback.

---

## Stack

TypeScript strict, Next.js 15, React 19, Supabase, Vercel, n8n, Zod.

---

## Anti-Alucinação: Falhas Conhecidas do Opus 5

Opus 5 tem 4 modos de falha específicos:

### 1. Confabulação por excesso de confiança

Quando não sabe, inventa com fluência. Não diz "não sei".

**Defesa:** antes de usar qualquer API, pacote ou método:
```
1. Verificar package.json (versão real instalada)
2. Ler docs oficiais via fetch ou git-mcp
3. Se não encontrar: marcar ⚠️ UNVERIFIED e parar
```

Nunca inferir assinatura de método por analogia.

### 2. Over-compliance (faz mais do que pedido)

Tendência a refatorar código adjacente, adicionar features não solicitadas, "melhorar" o que não foi pedido.

**Defesa:**
- Antes de editar: reler o pedido original
- Regra: se o arquivo não foi mencionado explicitamente, não toque
- Commits devem alterar apenas o necessário para satisfazer o spec

### 3. Prosa quando deveria ser código

Tende a explicar em vez de executar. Gera parágrafos de contexto antes de entregar o artefato.

**Defesa:**
- Output padrão: código primeiro, explicação depois (máx 3 linhas)
- Se a resposta tem mais prosa que código, está errada

### 4. Context drift em sessões longas

Após ~50 tool calls, começa a "esquecer" constraints iniciais.

**Defesa:**
- A cada 10 tool calls: reler este arquivo + goal atual
- Externalizar estado em MEMORY.md ou ClickUp comment
- Checkpoint antes de operações multi-step

---

## Engenharia de Loop

Todo ciclo iterativo segue 6 fases obrigatórias:

```
GATHER → ACT → OBSERVE → VERIFY → UPDATE → DECIDE
```

**Gather:** ler task, deps, contexto. Não assumir.
**Act:** implementar UMA mudança atômica.
**Observe:** rodar test/build/lint. Ler output real.
**Verify:** verificador externo (test pass? build ok? diff correto?).
**Update:** registrar resultado. Se falhou, registrar por quê.
**Decide:** próximo nó do DAG, retry, ou escalar.

### Condições de terminação (obrigatórias)

| Condição | Limite |
|----------|--------|
| Iterações máximas | 5 |
| Tool calls por loop | 20 |
| Passes sem progresso | 2 → parar |
| Verificador | Sempre externo (nunca auto-avaliação) |

Se atingir qualquer limite: parar e escalar ao humano via ClickUp comment.

---

## Engenharia de Grafos (DAG)

Tasks são nós. Dependências são arestas. Execução segue ordem topológica.

```
1. Decompor feature em sub-tasks (nós)
2. Declarar dependências entre nós
3. Executar em ordem topológica (nó com 0 deps pendentes primeiro)
4. Nós independentes podem executar em paralelo (subagent fanout)
5. Join-node: só executa quando todos predecessores estão DONE
```

Nunca pular um nó. Nunca executar nó com dependência pendente.

---

## Spec-Driven Development

Nenhum código existe sem spec prévia.

```
1. SPEC: definir contrato (input/output/invariantes/edge cases)
2. TEST: escrever teste que falha contra o contrato
3. IMPLEMENT: código mínimo que faz o teste passar
4. VERIFY: rodar suite completa
5. REFACTOR: só após verde
```

Se o spec não existe, a primeira ação é escrever o spec. Nunca implementar e spec depois.

---

## Harness (V-Model)

```
PLANNER → EXECUTOR → VERIFIER
   ↑                      │
   └──── FEEDBACK ────────┘
```

Regra absoluta: **o executor nunca avalia seu próprio trabalho.**

O verificador recebe apenas o artefato + contrato. Nunca recebe a justificativa do executor (evita viés de confirmação).

### Agentes

| Agente | Papel | Quando |
|--------|-------|--------|
| architect | Decompor em DAG | Início de feature |
| developer | Implementar com TDD | Execução de nó |
| auditor | Verificar adversarialmente | Após cada implementação |
| debugger | Corrigir quando dev falha 2x | Escalação |
| security | Gate OWASP antes de deploy | Pré-merge |
| deployer | Pipeline Vercel | Pós-verificação |

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

Se qualquer item estiver presente: NÃO está done.

---

## Quality Gates

- [ ] Tests passam (100% código novo coberto)
- [ ] `tsc --noEmit` limpo
- [ ] Sem secrets em código
- [ ] LCP < 2.5s, CLS < 0.1
- [ ] WCAG 2.1 AA
- [ ] Commits atômicos, mensagens convencionais
- [ ] Verificador assinou (não auto-reportado)
- [ ] Adversarial 11-check passou
- [ ] Todo código framework-specific cita fonte
- [ ] Nenhum claim UNVERIFIED foi shipped sem ACK do user
