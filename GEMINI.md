# GEMINI.md — Gemini 3.1 Pro

Config carregada automaticamente pelo Antigravity CLI no início da sessão.
Modelo único: **gemini-3.1-pro**. Sem fallback para Flash ou Lite.

---

## Stack

TypeScript strict, Next.js 15, React 19, Supabase, Vercel, n8n, Zod.

---

## MCP Servers (6)

| Server | Função |
|--------|--------|
| context-mode | Sandbox de outputs grandes, 98% redução de tokens |
| clickup-dev | Operações em tasks (create/update/sync) |
| clickup-context | Leitura rica (imagens, busca multilingual) |
| github | Repos, issues, PRs, security scans |
| git-mcp | Docs reais como contexto (anti-alucinação) |
| code-reasoning | Raciocínio sequencial estruturado |

---

## Anti-Alucinação: Falhas Conhecidas do Gemini 3.1 Pro

Gemini 3.1 Pro tem 4 modos de falha específicos:

### 1. Loop infinito em schemas complexos

Quando MCP tools têm schemas com $ref circulares ou arrays aninhados >3 níveis, Gemini repete o plano sem executar tools.

**Defesa:**
- Limitar toolsets expostos por sessão (`--toolsets repos,issues`)
- MAX_RESPONSE_SIZE_MB = 5 nos servers ClickUp
- Se detectar repetição de plano sem ação: parar, reduzir scope, retry com menos tools

### 2. Pula verificação quando "parece certo"

Após implementar, tende a declarar "done" sem rodar tests. Confia na própria geração.

**Defesa:**
- Regra hard: NENHUM nó é "done" sem output de verificador externo
- Verificador = test pass + build clean + lint clean (os 3)
- Self-report de "funciona" não conta. Nunca.

### 3. Context drift severo após compactação

Após context-mode comprimir a sessão, Gemini pode "esquecer" regras deste arquivo.

**Defesa:**
- Hooks de SessionStart recarregam este arquivo automaticamente
- PreCompress cria snapshot do estado
- A cada 10 tool calls: goal pinning (reler objetivo da task)
- Externalizar decisões em ClickUp comments (persistência real)

### 4. Gera código plausível com imports inexistentes

Tende a importar de paths que "fazem sentido" mas não existem no projeto.

**Defesa:**
- Antes de importar: verificar com `ls` ou glob que o arquivo existe
- Antes de usar pacote: verificar package.json
- Antes de usar método: ler .d.ts real ou docs via git-mcp

---

## Engenharia de Loop

Todo ciclo iterativo:

```
GATHER → ACT → OBSERVE → VERIFY → UPDATE → DECIDE
```

| Fase | O que faz | Validação |
|------|-----------|----------|
| Gather | Ler task, deps, código | Verificar que leu (não assumiu) |
| Act | 1 mudança atômica | Diff deve ser contido |
| Observe | Rodar test/build/lint | Ler stdout real |
| Verify | Check externo | Test pass? Build ok? |
| Update | Registrar resultado | ClickUp comment ou MEMORY.md |
| Decide | Próximo nó ou retry | Baseado em evidência, não feeling |

### Terminação

- Max 5 iterações por nó
- Max 20 tool calls por loop
- 2 passes sem progresso = parar
- Verificador sempre externo (worker não se auto-avalia)
- Escalação: ClickUp comment ao humano

---

## Engenharia de Grafos (DAG)

```
1. Feature → decompor em sub-tasks (nós)
2. Declarar dependências (arestas)
3. Ordenar topologicamente
4. Executar: nó com 0 deps pendentes primeiro
5. Paralelizar nós independentes (subagent fanout)
6. Join-node: esperar todos predecessores DONE
```

Sem ciclos. Se detectar ciclo: redecompor.
Sem pular nós. Sem executar com dep pendente.

---

## Spec-Driven Development

```
SPEC → TEST (red) → IMPLEMENT (green) → VERIFY (suite) → REFACTOR
```

Sem spec = perguntar ao humano ou derivar da task.
Nunca implementar sem contrato definido (input/output/erros/invariantes).

---

## Harness (V-Model)

```
PLANNER → EXECUTOR → VERIFIER
   ↑                      │
   └──── FEEDBACK ────────┘
```

O executor nunca avalia seu próprio trabalho.
O verificador recebe: artefato + contrato. Nunca recebe justificativa do executor.

### Agentes

| Agente | Papel |
|--------|-------|
| architect | Decompor feature em DAG |
| developer | Implementar nó com TDD |
| auditor | Verificar adversarialmente |
| debugger | Corrigir após 2 falhas do dev |
| security | OWASP gate pré-deploy |
| deployer | Pipeline Vercel |
| orchestrator | Travessia do DAG + routing |

Loop: developer → auditor → (pass: security → deployer | fail: debugger → auditor)

---

## Adversarial 11-Check

Antes de marcar done:

1. Testes relaxados?
2. Erros engolidos?
3. Rename fake?
4. Return stub?
5. Comment-as-fix?
6. Só happy-path?
7. Scope creep?
8. API inventada?
9. Decisão silenciosa?
10. Pass-by-mock?
11. Off-spec done?

Qualquer presente = não está done.

---

## Context Optimization

- Outputs grandes: context-mode sandbox (não polui janela)
- Busca: ctx_search com FTS5 (BM25) em conteúdo indexado
- Batch: ctx_batch_execute pra múltiplos comandos em 1 call
- Persistência: hooks restauram estado após compactação

---

## Quality Gates

- [ ] Tests passam (100% código novo coberto)
- [ ] `tsc --noEmit` limpo
- [ ] Sem secrets em código
- [ ] LCP < 2.5s, CLS < 0.1
- [ ] WCAG 2.1 AA
- [ ] Commits atômicos, mensagens convencionais
- [ ] Verificador externo assinou
- [ ] 11-check passou
- [ ] Toda API verificada contra docs reais (git-mcp)
- [ ] Imports verificados (arquivo existe, pacote está em package.json)
- [ ] Nenhum loop sem terminação explícita
