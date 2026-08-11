# CODEX.md — GPT-5.6 Sol

Config para OpenAI Codex / ChatGPT operando com GPT-5.6 Sol.
Modelo único: **gpt-5.6-sol**. Sem fallback.

---

## Stack

TypeScript strict, Next.js 15, React 19, Supabase, Vercel, n8n, Zod.

---

## Anti-Alucinação: Falhas Conhecidas do GPT-5.6 Sol

Sol tem 4 modos de falha específicos:

### 1. Confiança calibrada como certeza

Quando não sabe, responde com a mesma confiança de quando sabe. Não sinaliza incerteza.

**Defesa:**
- Tratar toda afirmação sobre API/método como hipótese até verificar
- Obrigatório: rodar `npm info <pkg>` antes de adicionar dependência
- Obrigatório: ler assinatura real do método no source antes de usar
- Se não verificável: marcar UNVERIFIED e não prosseguir

### 2. Pattern-matching de training data desatualizado

Tende a gerar código de versões anteriores (React class components, Next.js pages router, Express patterns antigos).

**Defesa:**
- Sempre verificar versão em package.json ANTES de implementar
- Se Next.js >= 13: App Router, Server Components, Server Actions
- Se React >= 18: hooks only, sem class components
- Se Prisma >= 5: nova API de client extensions
- Regra: **se o pattern não aparece na doc da versão instalada, não use**

### 3. Completação pré-matura ("pronto" cedo demais)

Declara "done" após implementar happy-path. Não testa edge cases espontaneamente.

**Defesa:**
- Checklist obrigatório antes de declarar done:
  - [ ] Input vazio testado
  - [ ] Input malformado testado
  - [ ] Erro de rede/timeout testado
  - [ ] Concurrent access considerado
  - [ ] Null/undefined em toda boundary
- Se qualquer item falta: NÃO está done

### 4. Invenção de APIs com nomes plausíveis

Gera métodos que "parecem" existir mas não existem (ex: `prisma.user.upsertMany`, `next/headers.getSession`).

**Defesa:**
- Toda chamada de API deve ser verificada contra:
  1. `node_modules/<pkg>/dist/index.d.ts` (tipos reais)
  2. Ou docs oficiais via fetch
- Se o método não aparece no .d.ts: NÃO EXISTE. Parar.

---

## Engenharia de Loop

Todo ciclo iterativo segue 6 fases obrigatórias:

```
GATHER → ACT → OBSERVE → VERIFY → UPDATE → DECIDE
```

**Gather:** ler task + dependências + código existente. Ler, não assumir.
**Act:** implementar UMA mudança atômica. Nunca 2+ coisas por vez.
**Observe:** executar tests/build/lint. Ler stdout/stderr REAL.
**Verify:** check externo (teste passa? tipo compila? diff está contido?).
**Update:** registrar resultado. Se falhou: causa + o que tentar diferente.
**Decide:** avançar pro próximo nó, retryar com estratégia diferente, ou escalar.

### Condições de terminação

| Condição | Limite |
|----------|--------|
| Iterações máximas | 5 |
| Tool calls por loop | 20 |
| Passes sem progresso | 2 → parar |
| Verificador | Sempre externo |

Limite atingido = escalar ao humano. Nunca ignorar.

---

## Engenharia de Grafos (DAG)

Tasks são nós num grafo acíclico dirigido.

```
1. Decompor feature em sub-tasks (nós atômicos)
2. Mapear dependências (arestas)
3. Executar em ordem topológica
4. Nós sem dependência pendente podem paralelizar
5. Join-node espera todos predecessores
```

Regra: nunca executar nó com dep pendente. Nunca pular nó.

Se descobrir dependência cíclica: o grafo está mal decomposto. Parar e redecompor.

---

## Spec-Driven Development

```
1. SPEC → contrato (input types, output types, invariantes, erros esperados)
2. TEST → teste que falha (red)
3. IMPLEMENT → código mínimo pra verde
4. VERIFY → suite completa + build
5. REFACTOR → só com verde
```

Se não tem spec: primeira ação é perguntar ao humano ou derivar spec da task.
Nunca implementar sem contrato definido.

---

## Harness (V-Model)

```
PLANNER → EXECUTOR → VERIFIER
   ↑                      │
   └──── FEEDBACK ────────┘
```

**O executor nunca avalia seu próprio trabalho.**

O verificador recebe:
- Artefato (código/diff)
- Contrato (spec)
- NAO recebe: justificativa, raciocínio, ou context do executor

Isso previne viés de confirmação.

### Agentes

| Agente | Papel | Quando |
|--------|-------|--------|
| architect | Decompor em DAG | Início de feature |
| developer | Implementar com TDD | Execução de nó |
| auditor | Verificar adversarialmente | Após cada impl |
| debugger | Corrigir após 2 falhas | Escalação |
| security | OWASP gate | Pré-merge |
| deployer | Vercel pipeline | Pós-verificação |

---

## Adversarial 11-Check

Antes de marcar code como done:

1. Testes relaxados?
2. Erros engolidos?
3. Rename fake?
4. Return stub (hardcoded)?
5. Comment-as-fix?
6. Só happy-path?
7. Scope creep?
8. API inventada?
9. Decisão silenciosa?
10. Pass-by-mock?
11. Off-spec done?

Qualquer "sim" = não está done. Corrigir primeiro.

---

## Regras de Output

- Código primeiro, explicação depois (máx 3 linhas)
- Nunca usar: "leverage", "streamline", "robust", "cutting-edge", "paradigm"
- Números concretos, nomes reais, datas específicas
- Se não sabe: "não sei" > inventar
- Commit messages: conventional commits, max 72 chars

---

## Quality Gates

- [ ] Tests passam (100% código novo coberto)
- [ ] `tsc --noEmit` limpo
- [ ] Sem secrets em código
- [ ] Edge cases cobertos (vazio, malformado, timeout)
- [ ] LCP < 2.5s, CLS < 0.1
- [ ] Commits atômicos
- [ ] Verificador externo assinou
- [ ] 11-check passou
- [ ] Toda API chamada foi verificada contra .d.ts ou docs
- [ ] Nenhum pattern de versão anterior (pages router, class components)
