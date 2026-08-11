# Q1 Digital — Golden Trio Model Routing

> **Trio de Ouro:** Claude Opus 5 · GPT-5.6 Sol · Gemini 3.1 Pro
> Atualizado: 2026-08-11
> Autor: Marcio Krefta — Q1 Digital

---

## Filosofia

Cada modelo é uma ferramenta. Nenhum é melhor em tudo. O Trio de Ouro explora o pico de cada motor:

| Motor | Superpoder | Fraqueza relativa |
|-------|-----------|-------------------|
| Claude Opus 5 | Raciocínio profundo, agentic long-horizon, self-verification | Custo de output alto ($25/M) |
| GPT-5.6 Sol | Coding agent #1, token-efficient, frontend aesthetics | Reasoning puro ligeiramente abaixo do Opus 5 |
| Gemini 3.1 Pro | Custo/benefício, multimodal nativo, context 1M, velocidade | SWE-bench abaixo dos outros dois |

---

## Routing Table

### 🧠 RACIOCÍNIO & DECISÃO → Claude Opus 5

```
Model ID: claude-opus-5
Effort: high | xhigh (para decisões arquiteturais)
Context: 1M tokens
Pricing: $5 input / $25 output per M tokens
Thinking: ON by default (não desligar)
```

**Usar quando:**
- Arquitetura de sistema (boundaries, interfaces, contracts)
- Planning estratégico (decomposição de features em DAG)
- Code review profundo (segurança, lógica de negócio)
- Decisões arquiteturais (ADRs)
- Doubt-driven development (adversarial review)
- PRD e spec writing
- Debugging complexo (root-cause em sistemas distribuídos)
- Análise de segurança (OWASP, HIPAA, LGPD)
- Compliance e análise jurídica
- Prompts que precisam de self-correction

**Skills ativadas:**
- `doubt-driven-development`
- `architecture-design`
- `security-review`
- `spec-driven-development`
- `adversarial-verify` (11 shortcuts)
- `plan-orchestrate`
- `delivery-gate`
- `production-audit`
- `hipaa-compliance`

**Prompting patterns (Opus 5 específico):**
```
1. Define outcome + constraints (não microgerencie o caminho)
2. Deixe o thinking trabalhar (não force step-by-step no prompt)
3. Use effort dial:
   - xhigh: decisões irreversíveis
   - high: planning e review
   - medium: tarefas rotineiras de análise
   - low: classificação e triage
4. Subagent delegation: Opus 5 delega sozinho, não precisa orquestrar manualmente
5. Self-verification: ele verifica o próprio output, confie no gate interno
```

---

### ⚡ CODING & EXECUÇÃO → GPT-5.6 Sol

```
Model ID: gpt-5.6-sol
Context: 1.05M tokens
Pricing: $5 input / $30 output per M tokens
Reasoning: max (para tasks complexas) | default (para tasks rotineiras)
```

**Usar quando:**
- Implementação de features (código novo)
- Codex agent (autonomous coding)
- Frontend development (layout, visual hierarchy, design judgment)
- Refatoração de código existente
- Testes (unit, integration, e2e)
- CI/CD pipelines
- Docker/containerização
- API implementation (REST, GraphQL)
- Database schemas e migrations
- Git workflow (PRs, branches, merge)
- Bug fixes (não root-cause, mas fix direto)

**Skills ativadas:**
- `react-patterns` / `react-performance` / `react-testing`
- `nextjs-turbopack`
- `frontend-patterns` / `frontend-a11y`
- `backend-patterns`
- `api-design`
- `prisma-patterns`
- `docker-patterns`
- `tdd-workflow`
- `git-workflow`
- `e2e-testing`
- `error-handling`
- `incremental-implementation`
- `orch-build-mvp` / `orch-add-feature` / `orch-fix-defect`

**Prompting patterns (Sol específico):**
```
1. Prompts enxutos > prompts longos (41-66% menos tokens = melhor resultado)
2. Remova exemplos redundantes e instruções repetidas
3. Tool descriptions curtas e precisas
4. Defina outcome + constraints + completion bar, deixe o modelo escolher o path
5. Frontend: descreva o resultado visual desejado, Sol tem design judgment nativo
6. Use Codex harness pra tasks autônomas (multi-file, multi-step)
7. Max reasoning: ative só pra tasks complexas (economiza tokens)
```

---

### 🚀 PROTOTIPAGEM & MULTIMODAL → Gemini 3.1 Pro

```
Model ID: gemini-3.1-pro-preview
Context: 1M tokens (multimodal: texto, imagem, vídeo, áudio, PDF)
Pricing: ~$2 input / $12 output per M tokens
Thinking levels: low | medium | high
```

**Usar quando:**
- Prototipagem rápida (vibe coding)
- Análise de imagens, vídeos, áudios, PDFs
- Processamento de documentos grandes
- Research e deep-dive (custo baixo permite mais iterações)
- Content generation (marketing, SEO, social media)
- Data analysis e reporting
- Tarefas de alto volume / baixo risco
- Multimodal tasks (screenshot analysis, UI review visual)
- Agentic workflows com muitas tool calls
- Quick iterations (fail fast, iterate fast)

**Skills ativadas:**
- `brainstorming`
- `deep-research`
- `market-research`
- `marketing-campaign`
- `seo`
- `social-publisher`
- `content-engine`
- `brand-voice`
- `lead-intelligence`
- `dashboard-builder`
- `design-system`
- `context-driven-development`
- `performance-optimization`

**Prompting patterns (Gemini 3.1 Pro específico):**
```
1. Multimodal first: mande screenshots, diagramas, áudios direto no prompt
2. Thinking level:
   - high: problemas complexos de reasoning
   - medium: coding normal
   - low: classificação, extração, formatação
3. Agentic: melhor tool use da família Gemini, use function calling
4. Context 1M: jogue o repo inteiro se precisar, o custo é baixo
5. Iterações: custo permite 3-5x mais tentativas que Opus 5
```

---

## Routing Decision Tree

```
┌─ NOVA TASK CHEGA
│
├─ É decisão arquitetural / irreversível / segurança / compliance?
│  └─ YES → Claude Opus 5 (effort: high/xhigh)
│
├─ É implementação de código / fix / PR / deploy?
│  └─ YES → GPT-5.6 Sol (Codex harness se autônomo)
│
├─ É prototipagem / research / multimodal / content / alto volume?
│  └─ YES → Gemini 3.1 Pro (thinking: medium)
│
├─ É ambíguo?
│  ├─ Custo importa? → Gemini 3.1 Pro
│  ├─ Qualidade máxima? → Claude Opus 5
│  └─ Código + velocidade? → GPT-5.6 Sol
│
└─ FALLBACK: Gemini 3.1 Pro (melhor custo/benefício geral)
```

---

## Routing por Fase do Projeto

| Fase | Modelo primário | Modelo secundário |
|------|----------------|-------------------|
| Discovery & Research | Gemini 3.1 Pro | Opus 5 (validação) |
| Spec & PRD | Claude Opus 5 | — |
| Architecture & Design | Claude Opus 5 | — |
| Planning & Decomposition | Claude Opus 5 | Gemini (sub-tasks) |
| Implementation | GPT-5.6 Sol | Gemini (protótipo) |
| Testing | GPT-5.6 Sol | — |
| Code Review | Claude Opus 5 | Sol (auto-fix) |
| Security Audit | Claude Opus 5 | — |
| Frontend / UI | GPT-5.6 Sol | Gemini (visual review) |
| Content & Marketing | Gemini 3.1 Pro | — |
| DevOps & Deploy | GPT-5.6 Sol | — |
| Maintenance & Bug Fix | GPT-5.6 Sol | Opus 5 (root-cause) |

---

## Cost Optimization Strategy

### Budget Allocation (recomendado)

```
Claude Opus 5:  30% do budget (decisões de alto valor)
GPT-5.6 Sol:    45% do budget (bulk do coding)
Gemini 3.1 Pro: 25% do budget (volume + multimodal)
```

### Estimativa de custo mensal (projeto SaaS médio)

| Modelo | Tasks/mês | Tokens médios/task | Custo estimado |
|--------|-----------|-------------------|----------------|
| Opus 5 | ~50 | 50K in + 20K out | ~$37.50 |
| Sol | ~200 | 30K in + 40K out | ~$270.00 |
| Gemini 3.1 Pro | ~300 | 40K in + 30K out | ~$132.00 |
| **TOTAL** | **~550** | — | **~$440/mês** |

### Economia vs usar só Opus 5 para tudo:
- Custo se tudo fosse Opus 5: ~$1,200/mês
- Custo com Golden Trio: ~$440/mês
- **Economia: 63%** com qualidade igual ou superior por task

---

## Integration com q1-agent-stack

### Agents → Model Assignment

| Agent | Modelo | Razão |
|-------|--------|-------|
| architect | Claude Opus 5 | Decisões de boundary |
| auditor | Claude Opus 5 | Compliance, segurança |
| security | Claude Opus 5 | OWASP, LGPD, pentest |
| developer | GPT-5.6 Sol | Implementação |
| deployer | GPT-5.6 Sol | CI/CD, Docker, Vercel |
| debugger | GPT-5.6 Sol + Opus 5 | Sol tenta fix, Opus faz root-cause se falhar |
| orchestrator | Gemini 3.1 Pro | Routing, triage, coordenação |

### MCP Servers → Model Affinity

| MCP Server | Modelo preferido | Razão |
|------------|-----------------|-------|
| context-mode | Gemini 3.1 Pro | Alto volume de indexação |
| clickup-dev | Gemini 3.1 Pro | Operações CRUD frequentes |
| clickup-context | Claude Opus 5 | Análise profunda de context |
| github | GPT-5.6 Sol | PRs, code, branches |
| git-mcp | Gemini 3.1 Pro | Fetch docs (volume) |
| code-reasoning | Claude Opus 5 | Sequential thinking complexo |

---

## Agentic Patterns por Modelo

### Claude Opus 5: Autonomous Deep Worker
```
Patterns nativos:
- Self-verification (verifica próprio output)
- Subagent delegation (cria sub-agents dinamicamente)
- Thinking narration (explica raciocínio em tempo real)
- Long-horizon planning (mantém coerência em tasks longas)
- Effort scaling (ajusta profundidade por subtask)

Quando o agent "pensa":
- Opus 5 tem thinking ON by default
- Gasta tokens de thinking que NÃO contam no output
- Mais thinking = melhor resultado em tasks complexas
- Menos thinking (effort: low) = mais rápido pra triage
```

### GPT-5.6 Sol: Efficient Coder
```
Patterns nativos:
- Codex harness (autonomous multi-file coding)
- Token-efficient execution (faz mais com menos)
- Design judgment (frontend aesthetics built-in)
- Lean prompts win (menos instrução = melhor output)
- Max reasoning toggle (ativa só quando precisa)

Quando o agent "executa":
- Sol é o mais eficiente em tokens por task
- Prompts curtos e diretos performam melhor
- Codex mode: define goal, Sol executa multi-step sozinho
- Não precisa de exemplos extensos (já tem strong priors)
```

### Gemini 3.1 Pro: Fast Multimodal Coordinator
```
Patterns nativos:
- Multimodal input (imagem + texto + áudio em um prompt)
- Tool use avançado (function calling robusto)
- Context window 1M (cabe um monorepo inteiro)
- Thinking levels granulares (low/medium/high)
- Speed-first (respostas mais rápidas dos três)

Quando o agent "coordena":
- Gemini é o melhor orquestrador (rápido, barato, multimodal)
- Use como triage: classifica tasks e roteia pros outros modelos
- Research loops: custo permite 5x mais iterações
- Visual review: mande screenshots pra análise de UI
```

---

## Handoff Protocol (entre modelos)

```
1. ORCHESTRATOR (Gemini 3.1 Pro) recebe task
   │
2. Classifica: { tipo, complexidade, risco, domínio }
   │
3. Routing decision:
   ├─ reasoning/architecture/security → OPUS 5
   ├─ coding/implementation/deploy → SOL
   └─ research/content/multimodal → SELF (Gemini)
   │
4. Context handoff:
   ├─ Gera context packet (goal, constraints, artifacts)
   ├─ Escreve em ClickUp task comment (persistência)
   └─ Passa pro modelo alvo via API
   │
5. Execution:
   ├─ Modelo alvo executa
   ├─ Output volta pro orchestrator
   └─ Orchestrator valida formato e completude
   │
6. Verification:
   ├─ Se output é código → Sol roda tests
   ├─ Se output é decisão → Opus 5 valida (doubt-driven)
   └─ Se output é content → Gemini faz quality check
   │
7. Delivery:
   ├─ Atualiza ClickUp (status, comment, checklist)
   ├─ dev-sync se tem branch
   └─ Marca como done ou escala
```

---

## API Keys & Endpoints

```env
# Claude Opus 5 (Anthropic)
ANTHROPIC_API_KEY=sk-ant-...
CLAUDE_MODEL=claude-opus-5
CLAUDE_MAX_TOKENS=128000

# GPT-5.6 Sol (OpenAI)
OPENAI_API_KEY=sk-...
OPENAI_MODEL=gpt-5.6-sol
OPENAI_MAX_TOKENS=128000

# Gemini 3.1 Pro (Google)
GOOGLE_AI_API_KEY=AIza...
GEMINI_MODEL=gemini-3.1-pro-preview
GEMINI_MAX_TOKENS=65536

# Model Routing
DEFAULT_MODEL=gemini-3.1-pro-preview
ARCHITECTURE_MODEL=claude-opus-5
CODING_MODEL=gpt-5.6-sol
RESEARCH_MODEL=gemini-3.1-pro-preview
```

---

## Upgrade Checklist

- [x] Definir Golden Trio (Opus 5 + Sol + Gemini 3.1 Pro)
- [x] Routing table por tipo de task
- [x] Routing por fase de projeto
- [x] Cost optimization strategy
- [x] Agent → Model assignment
- [x] MCP → Model affinity
- [x] Agentic patterns por modelo
- [x] Handoff protocol
- [x] API configuration
- [ ] Implementar router service (TypeScript)
- [ ] Integrar com ClickUp task types
- [ ] Dashboard de custo por modelo
- [ ] A/B testing framework
- [ ] Fallback chain (se um modelo cai)

---

## Fallback Chain

```
Claude Opus 5 indisponível → GPT-5.6 Sol (reasoning mode: max)
GPT-5.6 Sol indisponível → Claude Opus 5 (effort: medium)
Gemini 3.1 Pro indisponível → GPT-5.6 Luna ($0.20/M, fast)
Todos indisponíveis → Queue task, notify via WhatsApp
```

---

## Métricas de Sucesso

| Métrica | Target |
|---------|--------|
| Custo médio por task | < $1.00 |
| Tasks completadas/dia (autônomas) | > 20 |
| Taxa de re-route (modelo errado) | < 5% |
| First-pass success rate | > 85% |
| Human escalation rate | < 10% |
| Context utilization | > 60% |

---

*Golden Trio v1.0 — Q1 Digital Agent Stack*
*"O melhor modelo pra cada job. Sem desperdício, sem compromisso."*
