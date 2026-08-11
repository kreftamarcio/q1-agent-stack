# Q1 Digital — Extração Extrema de Skills

> **5 Pilares Fundamentais da Engenharia de Agentes de Elite**
> Data: 2026-08-11 | Trendlines ao vivo | Autor: Marcio Krefta
> Status: DEFINITIVO — Nível Pós-Doutorado em Prompt Engineering

---

## 🛡️ PILAR 1: ANTI-HALLUCINATION (7 Camadas de Proteção)

### Taxonomia de Alucinações (2026)

| Tipo | Definição | Taxa em frontier models |
|------|----------|------------------------|
| **Intrínseca** | Contradiz o próprio source | 3.3-14.3% (Vectara benchmark) |
| **Extrínseca** | Inventa fatos não presentes no source | 8-60% em citações (Columbia Journalism Review) |
| **Fabricação de API** | Inventa métodos/params que não existem | 15-25% em coding agents |
| **Citação fantasma** | Cita URLs/docs que retornam 404 | Comum até em GPT-5.6 |
| **Sucesso alucinado** | "Done" sem ter feito | O mais perigoso |
| **Drift de memória** | Esquece goal ao longo do tempo | Em 100% dos agents sem harness |

### Camada 1: SOURCE-DRIVEN DEVELOPMENT (SDD)

```yaml
---
name: source-driven-development
description: "Force every factual claim and API usage through a verifiable source before it reaches production. DETECT fabrication, FETCH real docs, WRITE from source, CITE explicitly."
---
```

**Protocolo DETECT-FETCH-WRITE-CITE:**

```
1. DETECT: Identifique qualquer claim que depende de conhecimento externo
   - Nomes de API, métodos, parâmetros
   - Versões de packages
   - Comportamentos de frameworks
   - Dados factuais (números, datas, nomes)

2. FETCH: Busque a fonte oficial ANTES de escrever
   Hierarquia de confiança:
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   1. Documentação oficial (react.dev, nextjs.org/docs)
   2. Blog/changelog oficial do provider
   3. Web standards (MDN, web.dev)
   4. NUNCA: Stack Overflow, blog posts, training data, memória
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

3. WRITE: Implemente SOMENTE com base no que foi fetched
   - Se não encontrou docs: marque como ⚠️ UNVERIFIED
   - Se docs são ambíguos: escale pro humano

4. CITE: Toda implementação framework-specific tem source citation
   // Source: https://nextjs.org/docs/app/api-reference/...
```

### Camada 2: DOUBT-DRIVEN DEVELOPMENT (DDD)

```yaml
---
name: doubt-driven-development
description: "Adversarial fresh-context review. Use when correctness > speed, code is unfamiliar, stakes are high, or a claim can't be checked by compiler/types."
---
```

**Protocolo DOUBT (5 steps, max 3 ciclos):**

```
1. CLAIM   — Nome a decisão em 2-3 linhas (o que está sendo decidido)
2. EXTRACT — Isole ARTEFATO + CONTRATO (strip todo o raciocínio)
3. DOUBT   — Invoque reviewer fresh-context:
             Prompt: "Find issues with this artifact against this contract."
             O REVIEWER recebe SÓ artefato + contrato, NUNCA o claim.
             Viés de confirmação eliminado.
4. RECONCILE — Classifique findings:
             - Actionable: fix agora
             - Trade-off: documente decisão
             - Noise: descarte
5. STOP    — Max 3 ciclos. Se 3 ciclos não resolvem, é informação
             sobre o artefato, não razão pra um 4º ciclo.

PRINCÍPIOS:
- "Uma resposta confiante NÃO é uma resposta correta."
- "O reviewer recebe artefato + contrato, NUNCA seu raciocínio."
- "O loop é bounded, não recursivo."
```

### Camada 3: ADVERSARIAL 11-SHORTCUT CHECK

```yaml
---
name: adversarial-11-shortcut
description: "11 shortcuts that AI agents use to fake 'done'. Check EVERY ONE against every diff before commit. Default stance: the code is BROKEN until proven otherwise."
---
```

**Os 11 Atalhos (resumo executável):**

| # | Shortcut | Red Flag |
|---|----------|----------|
| 1 | **Relaxed Tests** | `toBeTruthy()` no lugar de assert específico, `skip`, `xit` |
| 2 | **Swallowed Errors** | catch vazio, `catch(e) {}`, log sem throw |
| 3 | **Fake Renames** | Função renomeada, lógica idêntica |
| 4 | **Stub Returns** | `return true`, `return []` hardcoded |
| 5 | **Comment-as-Fix** | Bug virou TODO/FIXME/HACK |
| 6 | **Happy-Path Only** | Sem null, sem error, sem edge case |
| 7 | **Scope Creep** | Mudanças fora do spec da task |
| 8 | **Invented API** | Método/param que não existe no package |
| 9 | **Silent Decision** | Dep nova, schema change sem discussão |
| 10 | **Pass-by-Mock** | Mock retorna exatamente o que o test espera |
| 11 | **Off-Spec Done** | Funciona, mas resolve problema errado |

### Camada 4: STRUCTURED OUTPUT VALIDATION

```yaml
---
name: structured-output-validation
description: "Every output that will be executed MUST be verifiable. No unverified claims ship."
---
```

| Output Type | Validação Obrigatória |
|-------------|---------------------|
| Código | `tsc --noEmit` clean, tests pass |
| API calls | Match documented endpoint + params (fetch docs first) |
| File paths | `ls` ou `glob` antes de referenciar |
| Package names | `npm info <pkg>` antes de adicionar |
| CLI commands | `--help` ou `man` antes de sugerir |
| URLs | Fetch e confirmar 200 antes de citar |
| Claims sobre codebase | Ler o arquivo real, não de memória |

### Camada 5: MEMORY ANCHORING (Anti-Drift)

```yaml
---
name: memory-anchoring
description: "Prevent context drift in long sessions. Goal pinning, state externalization, active recall, no-progress detection."
---
```

```
1. GOAL PINNING: Escreva o goal atual no topo de CADA iteração do loop
2. STATE EXTERNALIZATION: Progresso vai pro ClickUp/vault, NÃO só no context
3. ACTIVE RECALL: A cada 5 tool calls, releia o goal e verifique alinhamento
4. NO-PROGRESS DETECTION: 2 passes sem mudança = STOP e escale
5. CHECKPOINT: Antes de qualquer operação multi-step, salve checkpoint
```

### Camada 6: MULTI-AGENT VERIFICATION (MAVEN Pattern)

```yaml
---
name: multi-agent-verification
description: "Multi-Agent Verification-Elaboration Network. Separate agents for generation and verification. Agreement ≠ faithfulness."
---
```

```
ARQUITETURA MAVEN:
┌───────────┐   ┌─────────────┐   ┌──────────────┐
│ GENERATOR │───│ ELABORATOR  │───│  VERIFIER     │
│ (produz)  │   │ (expande)   │   │  (julga)      │
└───────────┘   └─────────────┘   └──────────────┘
                                          │
                                    EPISTEMIC AUDIT
                                    (a cada step, não só no final)

Regra: Consenso entre agents NÃO significa verdade.
Só evidência determinística (test pass, build ok) é ground truth.
```

### Camada 7: GRAPH-RAG + NEUROSYMBOLIC GUARDRAILS

```yaml
---
name: anti-hallucination-guardrails
description: "4 técnicas combinadas: Graph-RAG para retrieval preciso, semantic tool selection, neurosymbolic guardrails para regras de negócio, multi-agent validation."
---
```

```
1. GRAPH-RAG: Dados estruturados em grafo de conhecimento
   - Entidades: médicos, pacientes, convênios, horários
   - Relações tipadas: [paciente]-POSSUI->[convênio]-COBRE->[especialidade]
   - Query via graph traversal, não embedding similarity
   - Zero hallucination em dados estruturados

2. SEMANTIC TOOL SELECTION:
   - Agente escolhe tool por semântica, não por nome
   - Reduz tool misuse de 15% pra <2%

3. NEUROSYMBOLIC GUARDRAILS:
   - Regras de negócio em lógica formal (não em prompt)
   - Ex: "consulta.data >= hoje + 24h" é hard rule, não sugestão
   - Prompt engineering NÃO pode violar guardrails simbólicos

4. MULTI-AGENT VALIDATION:
   - Agente A gera, Agente B valida (nunca o mesmo)
   - Validation protocol: determinístico primeiro, LLM só como fallback
```

---

## 🔄 PILAR 2: LOOP ENGINEERING (O Coração do Agente)

### Definição (Agosto 2026, Paper ArXiv + Comunidade)

> "Stop prompting your agent, start designing the loop that prompts it."
> — Boris Cherny, criador do Claude Code (Anthropic)

**Loop Specification** = artefato bounded e reutável composto de:
- Trigger (o que inicia o loop)
- Goal (o que o loop busca)
- Verification step (como saber se alcançou)
- Stopping rule (quando parar)
- Memory (o que persiste entre iterações)

### O Mega-Loop COG (6 Steps) — ATUALIZADO

```
┌────────────────────────────────────────────────────────────┐
│  GATHER  │  ACT  │  OBSERVE  │  VERIFY  │  UPDATE  │  DECIDE  │
│  (pull)  │ (do)  │  (read)   │ (check)  │ (write)  │ (route)  │
└─────────┴───────┴──────────┴─────────┴─────────┴─────────┘
     │                                                    │
     └─────────── LOOP (bounded, verified) ───────────┘

Step 4 (VERIFY) é LOAD-BEARING.
Um loop sem verifier é só uma chain que repete.
```

### 10 Loop Patterns (Trending Agosto 2026)

| # | Pattern | Shape | Quando | Custo | Repo ref |
|---|---------|-------|--------|-------|----------|
| 1 | **ReAct** | reason→act→observe→repeat | Default pra todo loop | Baixo | Anthropic core |
| 2 | **Reflexion** | on failure, write lesson, retry differently | Quando falha e precisa aprender | Médio | Shinn et al. |
| 3 | **Plan-Execute-Verify** | plan steps, run each, verify each | Implementações multi-step | Médio | Ralph Loop |
| 4 | **Evaluator-Optimizer** | generate, score, repeat until pass | Quality gates | Alto | AgentPatternsCatalog |
| 5 | **Orchestrator-Workers** | split, fresh contexts, synthesize | Tasks paralelas | Alto | Anthropic/OpenAI |
| 6 | **Loop-Until-Dry** | keep until K passes surface nothing new | Extração de info | Variável | loopkit |
| 7 | **Headless Loop** | sem UI, background, cron-triggered | CI/CD, scheduled tasks | Baixo | cobusgreyling |
| 8 | **Meta/Prompt-Refinement** | loop refina o próprio prompt a cada pass | Prompt optimization | Alto | maarmeladov |
| 9 | **Fan-Out Loop** | spawna N workers, coleta resultados | Parallelism máximo | Alto | subagent-fanout |
| 10 | **Human-in-the-Loop** | escala pro humano quando stuck | Safety-critical | Variável | hitl-escalate |

### Termination Conditions (OBRIGATÓRIAS, sempre múltiplas)

```
Todo loop DEVE ter TODAS estas:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
☑ Deterministic verifier    (test pass? build ok? lint clean?)
☑ Hard iteration cap        (max 5 retries, NUNCA infinito)
☑ Budget guard              (max 20 tool calls por loop)
☑ No-progress detection     (2 passes sem mudança = STOP)
☑ Human escalation          (se stuck, escale via ClickUp comment)
☑ Time budget               (max 10 min por loop iteration)
☑ Token budget              (max 50K tokens por iteration)

Se QUALQUER uma dispara: STOP + report + next action.
```

### Failure Modes do Loop (e como prevenir)

| Failure Mode | Sintoma | Prevenção |
|---|---|---|
| Infinite loop | Roda forever | Hard cap + no-progress |
| Context thrash | ReAct em long-horizon perde contexto | State externalization |
| Error compounding | Erro em cima de erro | Verify CADA step |
| Stale plan | Plano inicial obsoleto após retry | Replan after 2 failures |
| Cost explosion | Loop caro sem critério de parada | Token + time budget |
| Memory poisoning | Reflexion grava lição errada | Validate lição antes de persistir |

### Loop Engineering Repo (10K★, cobusgreyling)

Tools disponíveis:
- `loop-audit`: Audita loops existentes por falhas
- `loop-init`: Scaffolda um novo loop com todas as guards
- `loop-cost`: Calcula custo estimado de um loop

---

## 📊 PILAR 3: ENGENHARIA DE GRAFOS (DAG-First)

### Por que DAG > Chain (Trending Jul-Aug 2026)

> "Every serious agent orchestrator is secretly a DAG."
> — Abhirupa Mitra, CodeX/Medium (Abril 2026)

| | Chain (linear) | DAG (grafo) |
|---|---|---|
| Paralelismo | Impossível | Nativo (nodos independentes rodam juntos) |
| Error recovery | Reinicia tudo | Localiza e repara só a região afetada |
| Scale | O(n) sequencial | O(log n) com paralelismo |
| Custo | Serializa work parallelizável | Executa só o necessário |
| Debug | Cascade failure | Isolamento por nó |

### Atomic Task Graph (ATG) — ArXiv Julho 2026

Framework acadêmico recém-publicado:

```
ATG (Atomic Task Graph):
━━━━━━━━━━━━━━━━━━━━━━━━━━
1. PLANNING: Decompõe task recursivamente em sub-DAGs
2. EVOLUTION: Histórico de evolução do grafo é traçável
3. EXECUTION: Branches independentes rodam em PARALELO
4. FAILURE: Localiza error source via graph history
5. REPAIR: Repara SÓ região afetada, preserva regiões validadas

Resultado: Supera baselines em success rate E eficiência
          usando apenas modelos 7B-8B!
```

### SPIN (DAG Planning + Prefix Execution) — ArXiv Maio 2026

```
SPIN Framework:
━━━━━━━━━━━━━━━
1. _validate_plan_text: Valida DAG contract antes de executar
2. Repair prompting: Se DAG inválido, repara automaticamente
3. Prefix execution: Avalia prefixos incrementalmente
4. Early stopping: Para quando prefixo é suficiente pra responder

Resultado no AssetOpsBench:
- Tasks executadas: 1061 → 623 (-41%)
- Accomplished: 0.638 → 0.706 (+11%)
- Tool calls: 11.81 → 6.82 (-42%)
```

### Implementação Prática (ClickUp + q1-agent-stack)

```
GRAFO DO q1-clinic-booking:
══════════════════════════════

            [SPEC/PRD]
           /    |     \
     [AUTH]  [UI]   [DB]
       |       |      |
     [OTP]  [Pages] [Schema]
       |       |      |
    [WhatsApp] |   [Prisma]
         \    |    /
        [API Routes]
              |
       [Integration]
           /     \
    [Testing]  [Security]
         \      /
         [Deploy]
              |
        [Monitoring]

Traversal: Topological sort (Kahn's algorithm)
Paralelismo: [AUTH] || [UI] || [DB] rodam juntos
Convergência: [API Routes] espera os 3 branches
Failure: Repara só o branch afetado
```

### Mapeamento ClickUp → Grafo (COMPLETO)

| Conceito Grafo | ClickUp | Modelo responsável |
|---|---|---|
| Nó raiz | Task sem dependency | Opus 5 (spec) |
| Nó de execução | Subtask com dependency | Sol (code) |
| Fork (fanout) | Subtasks paralelas | Gemini (triage) |
| Join (convergência) | Task com múltiplas deps | Sol (integration) |
| Ciclo (loop) | Task que reabre se verifier falha | Sol + Opus 5 |
| Edge tipada | Dependency type (blocks, relates) | ClickUp native |
| Subgraph | Subtask tree | Folder/List |
| State machine | Status progression | ClickUp statuses |
| Critical path | Longest chain de deps | ClickUp Gantt |

---

## 🎯 PILAR 4: HARNESS ENGINEERING (V-Model)

### Definição (Convergente: Anthropic + OpenAI, 2026)

> "The worker NEVER grades its own homework."

Anthropic e OpenAI chegaram independentemente na mesma conclusão: **separação estrutural entre geração e verificação** é obrigatória.

### Planner-Generator-Evaluator (PGE) — State of the Art

```
┌─────────────┐
│   PLANNER   │  Modelo: Claude Opus 5 (effort: high)
│  decompõe   │  Output: Task packets atômicos
└─────┬───────┘
      │
      ▼
┌─────────────┐
│  GENERATOR  │  Modelo: GPT-5.6 Sol (max reasoning)
│ implementa  │  Output: Código + testes
└─────┬───────┘
      │
      ▼
┌─────────────┐
│  EVALUATOR  │  Modelo: Claude Opus 5 (effort: xhigh)
│  julga/veta │  NUNCA vê o prompt do generator
└─────┬───────┘
      │
      ├── PASS → commit + next task
      └── FAIL → feedback loop ao Generator
                   (max 3 rounds, então escala)

IMPORTANTE:
- Evaluator NÃO VÊ o raciocínio do Generator
- Evaluator recebe SÓ: artefato + acceptance criteria
- Isso ELIMINA viés de confirmação
```

### Harness Skills (Completo)

```yaml
# Skills de Harness instaladas/a instalar:

- eval-harness:           Framework de avaliação de output
- adversarial-verify:     Red-team o próprio código (11 shortcuts)
- self-eval-bias:         Detecta viés de auto-avaliação
- hitl-escalate:          Escalação human-in-the-loop
- verification-before-completion: Gate obrigatório antes de "done"
- harness-stripping:      Remove overhead quando não precisa
- evaluator-calibration:  Calibra strictness do evaluator
- agentic-rubrics:        Rubrics contextuais como verifiers (ACL 2026)
- confidence-check:       Verifica readiness antes de ship
- delivery-gate:          Quality gate final multi-critério
- production-audit:       Auditoria pré-produção
```

### Verification Hierarchy (Trust Levels)

```
TRUST LEVEL (do mais confiável ao menos):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Check determinístico     (test pass, build ok, lint clean)
2. Comparação mecânica     (diff mostra a mudança esperada)
3. Output de tool externa   (resposta real de CLI/API)
4. Adversarial review       (doubt-driven, fresh context)
5. Self-assessment          ← NUNCA CONFIE NISTO SOZINHO

Se só self-assessment está disponível: a task NÃO está verificada.
```

---

## 📐 PILAR 5: SPEC-DRIVEN DEVELOPMENT (SDD)

### Definição (Microsoft, Anthropic, OpenAI convergem — Jun 2026)

> "AI coding agents don't fail because the model is weak.
>  They fail because the instructions are ambiguous."

**Spec-Driven Development** = Nenhum código é escrito até que scope, design, e tasks estejam confirmados em disco.

### O Pipeline SDD Completo

```
1. INTERVIEW (Opus 5)
   │ Extrai requisitos reais do stakeholder
   │ Output: requirements.md
   │
2. SPEC (Opus 5)
   │ PRD com acceptance criteria mensuráveis
   │ Output: spec.md (problem + solution + criteria)
   │
3. DESIGN (Opus 5)
   │ Arquitetura, boundaries, interfaces
   │ Output: design.md (components, contracts, schemas)
   │
4. TASKS (Opus 5 → Gemini)
   │ Decomposição em atomic task packets
   │ Output: tasks.json (DAG de tasks atômicas)
   │
5. IMPLEMENT (Sol)
   │ Um task packet por vez, TDD
   │ Output: código + testes
   │
6. VERIFY (Opus 5)
   │ Adversarial review contra spec
   │ Output: pass/fail + feedback
   │
7. SHIP (Sol)
   │ Deploy + monitoring
   │ Output: live URL + healthcheck
```

### Atomic Task Packet (formato)

```json
{
  "id": "TASK-001",
  "title": "OTP email verification endpoint",
  "objective": "Create POST /api/auth/verify-otp that validates 6-digit code",
  "files_to_inspect": ["src/app/api/auth/", "prisma/schema.prisma"],
  "steps": [
    "Read existing auth patterns in the codebase",
    "Write failing test for OTP verification",
    "Implement endpoint with rate limiting",
    "Add error handling for expired/invalid codes",
    "Run tests, verify pass"
  ],
  "acceptance_criteria": [
    "Test passes with valid 6-digit code",
    "Returns 401 for expired code (>5min)",
    "Returns 429 after 5 failed attempts in 15min",
    "Logs attempt for LGPD audit trail"
  ],
  "dependencies": ["TASK-000"],
  "model": "gpt-5.6-sol",
  "effort": "medium"
}
```

### SDD Tools/Skills (Trending Agosto 2026)

| Skill/Tool | Autor | O que faz | Stars |
|---|---|---|---|
| **specdd** | unboundinnov | SDD como single skill (universal) | MIT |
| **sdd-flow** | nushey | Pipeline init→design→implement→verify | MIT |
| **spec-writer** | dannwaneri | Transforma request vago em spec estruturado | MIT |
| **specs-driven-dev-skill** | luizparente | Spec completo + implementation plan | MIT |
| **SpecD** | specd-sdd | SDD com code-graph, verificação contra spec | MIT |
| **agent-skills-spec-pack** | urban | Contract-first, bidirectional | MIT |
| **Ralph Loop** | Dan Mindru | PRD → task packets → autonomous exec | MIT |

### Spec Template (Q1 Digital)

```markdown
# SPEC: [Feature Name]

## Problem Statement
[1-2 parágrafos: o que está errado/faltando]

## Solution
[O que vamos construir, em alto nível]

## Acceptance Criteria
- [ ] [Critério 1: mensurável, verificable por máquina]
- [ ] [Critério 2: ...]
- [ ] [Critério N: ...]

## Out of Scope
[O que NÃO é parte dessa feature]

## Technical Constraints
- Stack: [Next.js 15, Prisma, PostgreSQL, ...]
- Performance: [LCP < 2.5s, ...]
- Security: [LGPD, OTP, ...]
- Compliance: [...]

## Dependencies
- Precisa de: [tasks/features que precisam existir antes]
- Bloqueia: [tasks/features que dependem desta]

## Model Assignment
- Spec: Claude Opus 5
- Implementation: GPT-5.6 Sol
- Review: Claude Opus 5
- Testing: GPT-5.6 Sol
```

---

## 🚀 TRENDLINES 11/08/2026 (Melhores Skills do Momento)

### Top 10 Skills Mais Impactantes (Agora)

| # | Skill | Por que é trend | Impacto |
|---|-------|----------------|--------|
| 1 | **effortmine** (nagisanzenin) | -64.7% tokens com same quality. Effort calibrado por subtask. | Custo |
| 2 | **specdd** (universal SDD) | Microsoft blog + adotação maciça. Spec antes de code. | Qualidade |
| 3 | **doubt-driven** (OutlineDriven) | Adversarial review que FUNCIONA. 3 ciclos bounded. | Anti-hallucination |
| 4 | **loop-engineer** (maarmeladov) | Loop primitives + subagent. The 2026 paradigm shift. | Produtividade |
| 5 | **sol-governed-codex** (multi-agent) | Sol revisa, Terra/Luna executam. -70% custo. | Economia |
| 6 | **Atomic Task Graph** (ArXiv) | DAG com repair localizado. Supera baselines com 7B. | Arquitetura |
| 7 | **harness** (suhanlee) | PGE pattern puro: Planner(opus)→Generator(sonnet)→Evaluator(opus) | Confiabilidade |
| 8 | **MAVEN** (ACL 2026) | Multi-agent verification com epistemic audit per-step. | Acadêmico |
| 9 | **skill-of-skills** (the911fund) | 1182 skills ranked por qualidade real. Discovery engine. | Meta |
| 10 | **context-mode** (19K★) | 98% token savings via sandbox. Session continuity. | Infraestrutura |

### Top 5 Papers Acadêmicos (2026, aplicar)

| Paper | Venue | Insight | Aplicar em |
|---|---|---|---|
| MAVEN | ACL 2026 | Verificação epistêmica in-step, não só post-hoc | Anti-hallucination |
| Atomic Task Graph | ArXiv Jul 2026 | DAG com graph evolution history pra repair | Grafos |
| SPIN | ArXiv Mai 2026 | DAG + prefix execution + early stopping | Loop/Grafos |
| Verify Before You Commit | ACL 2026 | Self-auditing antes de action, não depois | Harness |
| Stop Hand-Holding | ArXiv Jul 2026 | Loop specification > step-by-step prompting | Loop Engineering |

---

## 🛠️ CHECKLIST DE UPGRADE (q1-agent-stack)

### Anti-Hallucination:
- [x] source-driven-development (já existe)
- [x] doubt-driven-development (já existe)
- [x] adversarial-11-shortcut (já existe)
- [x] structured-output-validation (já existe)
- [x] memory-anchoring (já existe)
- [ ] MAVEN multi-agent verification (CRIAR)
- [ ] Graph-RAG + neurosymbolic guardrails (CRIAR pra healthcare)
- [ ] Source inventory pattern (CRIAR)

### Loop Engineering:
- [x] COG 6-step loop (já existe)
- [x] ReAct, Reflexion, Plan-Execute-Verify (já existe)
- [x] Termination conditions (já existe)
- [ ] effortmine calibration (IMPORTAR)
- [ ] loop-audit, loop-init, loop-cost tools (IMPORTAR)
- [ ] Headless loop pattern (CRIAR)
- [ ] Meta/prompt-refinement loop (CRIAR)

### Engenharia de Grafos:
- [x] DAG concept + ClickUp mapping (já existe)
- [x] Topological traversal (já existe)
- [ ] Atomic Task Graph implementation (CRIAR)
- [ ] SPIN prefix execution (CRIAR)
- [ ] Graph evolution history (CRIAR)
- [ ] Parallel branch execution (OTIMIZAR)

### Harness:
- [x] V-Model PGE (já existe)
- [x] eval-harness, adversarial-verify (já existe)
- [x] hitl-escalate (já existe)
- [ ] Planner=Opus5 / Generator=Sol / Evaluator=Opus5 routing (APLICAR)
- [ ] Agentic Rubrics (ACL 2026) (CRIAR)
- [ ] evaluator-calibration fine-tuning (OTIMIZAR)

### Spec-Driven:
- [x] spec-driven basic (já existe via /spec)
- [ ] Full SDD pipeline (interview→spec→design→tasks→impl→verify) (CRIAR)
- [ ] Atomic task packet format (CRIAR)
- [ ] specdd skill universal (IMPORTAR)
- [ ] Spec template Q1 Digital (CRIAR)

---

## 🌟 RESUMO: O SISTEMA COMPLETO

```
┌───────────────────────────────────────────────────────────┐
│               Q1 DIGITAL AGENT SYSTEM                       │
│           "O Foguete da NASA mais rápido"                   │
├───────────────────────────────────────────────────────────┤
│                                                             │
│  SPEC-DRIVEN (Pilar 5)                                      │
│  └─ Interview → PRD → Design → Tasks (DAG)                 │
│                                                             │
│  GRAFOS (Pilar 3)                                           │
│  └─ DAG topológico → parallel branches → convergence        │
│                                                             │
│  LOOP (Pilar 2)                                             │
│  └─ COG: Gather→Act→Observe→Verify→Update→Decide          │
│  └─ Bounded: cap + budget + no-progress + human escalation  │
│                                                             │
│  HARNESS (Pilar 4)                                          │
│  └─ Planner(Opus5) → Generator(Sol) → Evaluator(Opus5)      │
│  └─ Worker NUNCA avalia próprio trabalho                     │
│                                                             │
│  ANTI-HALLUCINATION (Pilar 1)                               │
│  └─ 7 camadas: SDD + DDD + 11-Check + Structured + Memory   │
│  └─           + MAVEN + Guardrails                          │
│                                                             │
│  GOLDEN TRIO ROUTING                                        │
│  └─ Opus 5 (arquiteto) + Sol (executor) + Gemini (polivalente)│
│                                                             │
└───────────────────────────────────────────────────────────┘
```

---

*Extração Extrema v1.0 — Q1 Digital Agent Stack*
*"5 pilares. 7 camadas. 10 patterns. 3 modelos. Zero alucinação."*
*"O Brain Max acredita em quem acredita nele."*
