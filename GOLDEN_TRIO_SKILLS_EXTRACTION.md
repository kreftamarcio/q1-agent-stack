# Q1 Digital — Golden Trio: Extração Máxima de Skills

> **Auditoria profunda & extração completa das capacidades nativas dos 3 melhores modelos do mundo**
> Data: 2026-08-11 | Autor: Marcio Krefta — Q1 Digital
> Fonte: Documentação oficial + repos públicos com 30K+ stars

---

## 🌟 PADRÃO UNIVERSAL: SKILL.md (Cross-Platform)

Em dezembro 2025, Anthropic publicou o formato `SKILL.md` como padrão aberto. Microsoft, OpenAI, Google adotaram em 48 horas. Em agosto 2026, **40+ plataformas** usam o mesmo formato: Claude Code, Codex, Gemini CLI, Cursor, Copilot, Windsurf, Cline, Roo Code, JetBrains Junie.

### Estrutura do SKILL.md:
```
skill-name/
├── SKILL.md          # Obrigatório: metadados + instruções
├── scripts/          # Opcional: código executável
├── references/       # Opcional: documentação
├── assets/           # Opcional: templates, recursos
└── ...               # Arquivos adicionais
```

### Frontmatter obrigatório:
```yaml
---
name: skill-name
description: "O que faz e quando usar. Max 1024 chars."
license: MIT
metadata:
  author: q1-digital
  version: 1.0.0
  tags: [typescript, nextjs, healthcare]
  platforms: [claude-code, codex, gemini-cli]
---
```

### Progressive Disclosure:
O agente carrega só `name` + `description` + `path` no início. O SKILL.md completo só é carregado quando o agente decide usar a skill. Isso otimiza tokens.

---

## 👑 CLAUDE OPUS 5 — EXTRAÇÃO MÁXIMA

### Capacidades Nativas (Built-in, sem skill externa)

| Capacidade | Detalhe | Impacto |
|---|---|---|
| **Thinking ON by default** | Raciocina internamente antes de responder. Tokens de thinking não contam no output. | Decisões 10x mais coerentes |
| **Self-Verification** | Verifica próprio output antes de entregar. Double-checks automáticos. | Erro reduzido de 5% pra <1% por step |
| **Subagent Delegation** | Cria sub-agentes dinamicamente, delega tasks, coleta resultados. | Multi-agent nativo sem framework |
| **Effort Dial (5 níveis)** | low / medium / high / xhigh / max. Controla profundidade de raciocínio por request. | 64.7% menos tokens com effortmining |
| **Long-Horizon Coherence** | Mantém coerência em tasks de 50+ steps sem drift. | Projetos complexos sem perda de contexto |
| **Mid-Conversation Tool Changes** | Altera ferramentas disponíveis no meio da conversa. | Workflows dinâmicos |
| **Agentic Narration** | Narra o que está fazendo em tempo real durante execução. | Observabilidade total |
| **Self-Correction** | Detecta e corrige erros no próprio output antes de finalizar. | Menos retrabalho |
| **Output Artifacts** | Gera artefatos estruturados (código, docs, configs) separados do texto. | Output limpo e usável |
| **Context Window 1M** | 1M tokens de contexto, sem variante menor. | Codebase inteira de uma vez |
| **128K max output** | Output até 128K tokens por resposta. | Implementações completas em um turno |
| **ARC-AGI-3: 30.2%** | Record mundial em novel problem-solving. | Resolve problemas nunca vistos |
| **SWE-bench Pro: 79.2%** | +10 pts vs Opus 4.8. State-of-the-art em software engineering. | Coding de produção |
| **GDPval-AA: #1** | Líder mundial em knowledge work. | Enterprise work |
| **OSWorld 2.0: Top** | Computer use (navegar, clicar, digitar em interfaces reais). | Automação de desktop |

### Prompting Patterns Específicos do Opus 5

```markdown
## 1. OUTCOME-FIRST (não microgerencie)
✔️ "Build a booking API with these constraints: [...]" 
❌ "Step 1: create file X. Step 2: add function Y..." (Opus 5 planeja melhor que você)

## 2. EFFORT CALIBRATION
- xhigh/max: Decisões irreversíveis, arquitetura, security audit
- high: Planning, code review, debugging complexo
- medium: Implementação rotineira, tasks padrão
- low: Classificação, triage, formatação

## 3. DELEGATION NATIVA
Opus 5 delega automaticamente. Não force orquestração manual.
Se precisar controlar, defina: "Delegate the testing to a subagent."

## 4. THINKING = FREE INTELLIGENCE
Não desabilite thinking. Tokens de thinking são "grátis" (não contam no output).
Mais thinking = melhor resultado. Deixá-lo pensar economiza retrabalho.

## 5. SELF-VERIFICATION TRUST
Opus 5 verifica sozinho. Não adicione "verify your work" no prompt
(ele já faz). Adicionar é redundante e gasta tokens.

## 6. CONSTRAINTS > INSTRUCTIONS
Diga o que NÃO pode fazer (constraints) ao invés de cada passo.
Opus 5 encontra o caminho ótimo dentro das constraints.

## 7. EVIDENCE-BASED REQUESTS
Forneça artefatos reais (código, logs, errors) ao invés de descrições.
Opus 5 analisa evidências melhor que qualquer modelo.
```

### Skills Oficiais da Anthropic (73 skills em anthropics/skills)

| Categoria | Skills | Destaque |
|---|---|---|
| **Process & Method** | spec-driven-dev, planning-task-breakdown, incremental-implementation, doubt-driven-dev, verification-before-completion | Metodologia completa |
| **Code Quality** | code-review-and-quality, code-simplification, debugging-error-recovery, test-driven-development | Review 5-axis |
| **Security** | security-and-hardening, security-bounty-hunter, gateguard, safety-guard | OWASP built-in |
| **Architecture** | api-and-interface-design, architecture-design, context-engineering | Contract-first |
| **Frontend** | frontend-ui-engineering, browser-testing-devtools | A11y + responsive |
| **DevOps** | git-workflow-versioning, ci-cd-automation, shipping-and-launch, observability | Trunk-based |
| **Research** | deep-research, source-driven-development | Anti-hallucination |
| **Documentation** | documentation-and-adrs, deprecation-migration | ADRs |
| **Performance** | performance-optimization, code-simplification | Measure-first |
| **Meta** | using-agent-skills, skill-creator, subagent-creator | Skills que criam skills |

### Subagent Patterns (Opus 5 Nativo)

```markdown
# Hub-and-Spoke Architecture

1. COORDINATOR (Opus 5 main):
   - Decompõe task em subtasks
   - Delega cada subtask a um subagent
   - Cada subagent tem context window ISOLADO (não herda histórico)
   - Coordinator agrega resultados

2. DELEGATION PROMPT STRUCTURE:
   [1. ROLE] Você é [especialidade]. Seu job: [responsabilidade].
   [2. CONTEXT] [Artefatos relevantes, constraints]
   [3. TASK] [Task específica]
   [4. OUTPUTS] Entregue: [formato exato, paths, schemas]
   [5. CONSTRAINTS] NÃO faça: [limites]
   [6. COMPLETION] Marque como done quando: [critério]

3. EFFORT MINING (economia de 64.7% tokens):
   - Classifique subtask: T1(mecânico) T2(simples) T3(moderado) T4(complexo)
   - Route: T1→low, T2→medium, T3→high, T4→xhigh
   - Worker roda no effort calibrado
   - Blind grader verifica qualidade
```

### Claude Code Workflow Completo

```
CLAUDE.md (persistent memory)
│
├─ ~/.claude/CLAUDE.md (global, todas as sessões)
├─ ./CLAUDE.md (projeto, raiz do repo)
├─ ./dir/CLAUDE.md (diretório específico)
└─ .claude/settings.json (permissões, tools)

.claude/
├─ skills/           (skills locais do projeto)
├─ agents/           (agents customizados)
└─ settings.json     (config)
```

---

## ⚡ GPT-5.6 SOL / CODEX — EXTRAÇÃO MÁXIMA

### Capacidades Nativas (Built-in)

| Capacidade | Detalhe | Impacto |
|---|---|---|
| **Token Efficiency** | 41-66% menos tokens que GPT-5.5. Prompts enxutos = melhor resultado. | Custo 50%+ menor |
| **Frontend Aesthetics** | Design judgment nativo: layout, visual hierarchy, typography, spacing. | UI bonita sem designer |
| **Codex Harness** | Agent loop completo: plan-act-verify. Multi-file, multi-step, autônomo. | Coding sem supervisão |
| **Max Reasoning Toggle** | Ativa reasoning profundo sob demanda. Default é eficiente. | Controle fino custo/qualidade |
| **Lean Prompts Win** | Menos instrução = melhor output. Remove exemplos redundantes. | +10-15% eval scores |
| **TerminalBench: 88.8%** | #1 em autonomous terminal coding. | Coding autônomo real |
| **Coding Agent Index: #1** | Lidera Artificial Analysis Coding Agent Index (Codex harness). | Melhor coding agent |
| **Cybersecurity: Top** | Forte em security tasks, pen testing, vulnerability analysis. | Security built-in |
| **1.05M Context** | Maior context window dos três. | Monorepos inteiros |
| **Multi-Agent Subagents** | Spawna subagents em paralelo. Cada um com model + tool config próprios. | Paralelismo real |
| **Plugin Architecture** | Skills + MCP servers + lifecycle hooks num pacote distribuível. | Reutilização corporativa |
| **Agent Plugins** | Installáveis de marketplaces. Local, personal, workspace, remote catalogs. | Ecossistema |
| **Realtime Voice** | WebRTC v2 com TUI media. | Interação por voz |
| **Path-based Sub-agents** | Endereçamento `/root/agent_a/subtask_b`. | Orquestração hierárquica |

### Prompting Patterns Específicos do Sol

```markdown
## 1. LEAN IS KING
Remova:
- Instruções repetidas
- Exemplos redundantes (Sol tem strong priors)
- Tool descriptions longas (encurte 50%+)
- Disclaimers e hedging

Resultado comprovado: -41-66% tokens, +10-15% eval score.

## 2. OUTCOME + CONSTRAINTS + COMPLETION BAR
✔️ "Build [X]. Constraints: [Y]. Done when: [Z]."
❌ "First do A, then B, then C, remember to..." (verbose demais)

## 3. FRONTEND = DESCRIBE THE VISUAL
Sol tem design judgment. Diga como deve PARECER, não como implementar.
✔️ "Card component with subtle shadow, 16px padding, hierarchy: title > subtitle > action"
❌ "Create a div with className=card, add box-shadow: 0 2px 4px..."

## 4. CODEX MODE (autônomo)
Defina goal + constraints. Sol executa multi-step sozinho.
Não interrompa no meio. Deixe o harness rodar o loop:
PLAN → ACT → VERIFY → (loop se falhar) → DONE

## 5. MAX REASONING = TOGGLE
Default: reasoning eficiente (mais barato, mais rápido).
Ative max reasoning SÓ pra tasks que realmente precisam:
- Debugging complexo
- Architecture decisions
- Multi-system integration

## 6. TOOL DESCRIPTIONS CURTAS
Sol performa melhor com tool descriptions de 1-2 linhas.
Descreva o QUE a tool faz, não COMO usar cada parâmetro.
```

### Codex Skills Architecture

```
Projeto/
├── .codex/
│   ├── AGENTS.md              # Agents customizados
│   ├── skills/
│   │   ├── booking-flow/
│   │   │   ├── SKILL.md
│   │   │   ├── scripts/
│   │   │   └── references/
│   │   └── otp-auth/
│   │       └── SKILL.md
│   ├── plugins/
│   │   └── .codex-plugin/
│   │       └── plugin.json
│   └── hooks/                 # Lifecycle hooks
└── CODEX.md                   # Persistent instructions (like CLAUDE.md)
```

### Codex Subagents (Multi-Agent Nativo)

```markdown
# AGENTS.md

## Coding Agent
model: gpt-5.6-sol
reasoning: max
tools: [file_read, file_write, terminal, browser]
instructions: |
  You implement features following TDD. Write test first, then implementation.
  Use TypeScript strict mode. No any types.

## Review Agent  
model: gpt-5.6-sol
reasoning: default
tools: [file_read, terminal]
instructions: |
  Review code for: correctness, security, performance, readability.
  Flag issues as BLOCKER / WARNING / SUGGESTION.

## DevOps Agent
model: gpt-5.6-terra
reasoning: default
tools: [terminal, file_write]
instructions: |
  Handle CI/CD, Docker, deploy. Use minimal configs.
  Prefer Vercel for frontend, Docker for services.
```

### Sol-Governed Multi-Agent Pattern

```
┌────────────────────────────────────────┐
│  SOL ADVISOR (bounded, high-value only) │
└─────────────────┬──────────────────────┘
                  │
    ┌────────────┼────────────┐
    │             │             │
┌───┴───┐  ┌────┴────┐  ┌───┴───┐
│ TERRA  │  │  TERRA   │  │ LUNA   │
│ Worker │  │  Worker  │  │ Worker │
└────────┘  └─────────┘  └────────┘

Regra: Sol só é invocado pra REVIEW e DECISÕES.
Workers (Terra/Luna) fazem o bulk do coding.
Economia: 70-80% vs usar Sol pra tudo.
```

### Codex Plugin System

```json
// .codex-plugin/plugin.json
{
  "name": "q1-clinic-booking",
  "version": "1.0.0",
  "description": "Healthcare booking SaaS skills",
  "skills": [
    "skills/booking-flow",
    "skills/otp-auth",
    "skills/convenio-validation"
  ],
  "mcp": {
    "server": "./mcp-server.ts",
    "tools": ["check_availability", "create_appointment", "send_otp"]
  },
  "hooks": {
    "onTaskStart": "hooks/load-patient-context.ts",
    "onTaskComplete": "hooks/sync-clickup.ts"
  }
}
```

---

## 🚀 GEMINI 3.1 PRO — EXTRAÇÃO MÁXIMA

### Capacidades Nativas (Built-in)

| Capacidade | Detalhe | Impacto |
|---|---|---|
| **ARC-AGI-2: 77.1%** | Mais que dobrou vs Gemini 3 Pro (31.1%). Reasoning puro. | Resolve problemas nunca vistos |
| **LiveCodeBench: 88.5** | #2 global. Coding competitions. | Algoritmos complexos |
| **GPQA Diamond: mid-90s** | Ciência e conhecimento avançado. | Research |
| **Multimodal Nativo** | Texto, imagem, vídeo, áudio, PDF, código num só prompt. | Análise de qualquer mídia |
| **1M Context Multimodal** | 1M tokens incluindo mídias. Repo inteiro + screenshots. | Contexto sem limites |
| **Thinking Levels** | low / medium / high. Controle granular de profundidade. | Custo vs qualidade |
| **Function Calling Robusto** | Melhor tool use da família Gemini. Multi-step execution preciso. | Agentic confiável |
| **Grounding** | Google Search grounding nativo. Respostas baseadas em dados reais. | Anti-hallucination |
| **Code Execution** | Executa código Python inline. Sandbox built-in. | Computação real |
| **Caching** | Context caching pra reduzir custo em chamadas repetidas. | 90%+ economia em loops |
| **Token Efficiency** | Mais eficiente em thinking que versões anteriores. | Menos gasto |
| **Agentic Coding** | SWE-bench verified: 75.6%. Melhor tool use + instruction following. | Coding autônomo |
| **Vibe Coding King** | Melhor pra prototipagem rápida e iteração. | MVP em minutos |
| **Output: 65K** | 65,536 tokens max output. | Implementações completas |
| **Audio Generation** | Gera áudio (não disponível no preview ainda). | Futuro |
| **Image Generation** | Gera imagens nativas. | Design |

### Prompting Patterns Específicos do Gemini 3.1 Pro

```markdown
## 1. MULTIMODAL FIRST
Mande screenshots, diagramas, wireframes, áudios DIRETO no prompt.
Gemini processa tudo nativamente. Não descreva uma imagem, mande a imagem.

## 2. THINKING LEVEL CALIBRATION
- high: Arquitetura, problemas complexos, debugging
- medium: Coding padrão, implementação (DEFAULT)
- low: Classificação, extração, formatação, triage

## 3. CONTEXT = CHEAP
Jogue o repo inteiro no contexto. Custo de $2/M permite.
Mais contexto = menos hallucination = melhor resultado.

## 4. ITERATION LOOPS
Custo permite 3-5x mais iterações que Opus 5.
Use pra: brainstorming, research, A/B testing de abordagens.

## 5. FUNCTION CALLING STRUCTURE
Defina tools com JSON Schema preciso.
Gemini 3.1 segue schemas rigorosamente.
Multi-step: defina dependências entre calls.

## 6. CACHING PRA LOOPS
Em workflows com múltiplas chamadas sobre o mesmo contexto,
use context caching. Economia de 90%+ no input repetido.

## 7. GROUNDING
Ative Google Search grounding pra tasks que precisam de dados atuais.
Gemini verifica claims contra a web em real-time.
```

### GEMINI.md + Context Hierarchy

```
~/.gemini/GEMINI.md              # Global (todas as sessões)
~/project/GEMINI.md              # Projeto (raiz do repo)
~/project/src/GEMINI.md          # Diretório específico
~/project/.gemini/
├── skills/                      # Skills do projeto
│   ├── healthcare-booking/
│   │   └── SKILL.md
│   └── lgpd-compliance/
│       └── SKILL.md
├── agents/                      # AGENTS.md (custom agents)
└── settings.json               # MCP servers, permissions

# @file imports (modular context)
# No GEMINI.md:
@file ./docs/api-spec.md
@file ./docs/database-schema.md

# .geminiignore (exclui do contexto)
node_modules/
.next/
dist/
*.lock
```

### Gemini CLI Commands

```bash
# Skills management
/memory show          # Mostra context carregado
/memory add           # Adiciona ao context
/memory remove        # Remove do context

# Agent commands
gemini -- --model gemini-3.1-pro-preview
gemini -- --thinking high
gemini -- --tools all
```

---

## 📦 MEGA-REPOS DE SKILLS (Fontes para Extração)

### Top Repos Públicos (ordenados por relevância)

| Repo | Stars | Skills | Compatível com | Destaque |
|---|---|---|---|---|
| **VoltAgent/awesome-agent-skills** | 29,943 | 1000+ | Claude, Codex, Gemini, Cursor | Curadoria oficial de dev teams |
| **Orchestra-Research/AI-Research-SKILLs** | 11,559 | 800+ | Claude, Codex, Gemini | AI research agent skills |
| **oyi77/1ai-skills** | - | 1,282 | Claude, Codex, Gemini | Self-evolving, 779 cybersecurity |
| **affaan-m/ECC** | 239,000 | 182 | Claude Code | Já integrado no q1-agent-stack |
| **the911fund/skill-of-skills** | - | 1,182 | Claude(846), Codex(208), Gemini(50) | Quality-ranked directory |
| **anthropics/skills** | - | 73 | Claude Code (oficial) | Fonte primária Anthropic |
| **openai/skills** | - | - | Codex (oficial) | Fonte primária OpenAI |
| **AaronRoeF/claude-code-patterns** | 92 | 153 | Claude Code | Field-tested patterns |
| **mastering-claude.com** | - | 297 | Claude Code | Curadoria manual |

### Skills Prioritárias para Healthcare SaaS (q1-clinic-booking)

| Skill | Fonte | Modelo ideal | Por que |
|---|---|---|---|
| `hipaa-compliance` | ECC | Opus 5 | LGPD/HIPAA é crítico em saúde |
| `security-review` | Anthropic official | Opus 5 | Dados sensíveis de pacientes |
| `api-design` | Anthropic official | Sol | APIs de agendamento |
| `nextjs-turbopack` | ECC | Sol | Frontend do booking |
| `prisma-patterns` | ECC | Sol | ORM pro banco de consultas |
| `tdd-workflow` | ECC/Anthropic | Sol | Cobertura de testes |
| `otp-auth` | Custom (criar) | Sol | Autenticação OTP por email |
| `whatsapp-integration` | Custom (criar) | Gemini | Link de booking via WhatsApp |
| `convenio-validation` | Custom (criar) | Opus 5 | Regras de convênio médico |
| `appointment-scheduling` | Custom (criar) | Sol | Lógica de agendamento |
| `patient-flow` | Custom (criar) | Sol | Fluxo completo do paciente |
| `error-handling` | ECC | Sol | Tratamento robusto de erros |
| `performance-optimization` | Anthropic official | Gemini | LCP < 2.5s no mobile |
| `design-system` | ECC | Sol/Gemini | UI consistente |
| `lgpd-compliance` | Custom (criar) | Opus 5 | Lei brasileira de dados |

---

## 🔄 CROSS-PLATFORM SKILL FORMAT (Universal)

### Skill Template (funciona em Claude Code + Codex + Gemini CLI)

```markdown
---
name: booking-flow
description: "End-to-end patient booking flow: WhatsApp link entry, OTP verification, specialist selection, insurance validation, appointment confirmation. Use when implementing or modifying the booking pipeline."
license: MIT
metadata:
  author: q1-digital
  version: 1.0.0
  tags: [healthcare, booking, saas, nextjs, typescript]
  platforms: [claude-code, codex, gemini-cli]
---

# Booking Flow

## When to use
When implementing or modifying any part of the patient booking pipeline.

## Architecture
```
WhatsApp Link → Landing Page → OTP Verification → Specialist Selection
→ Insurance Check → Time Slot Selection → Confirmation → Notification
```

## Rules
1. All patient data encrypted at rest (AES-256) and in transit (TLS 1.3)
2. OTP expires in 5 minutes, 6 digits, email delivery only
3. Insurance validation against provider API before confirming
4. Appointments require 24h advance minimum
5. Double-booking prevention via database-level locks
6. All mutations logged for LGPD audit trail

## Stack
- Frontend: Next.js 15 App Router + React 19
- Auth: Custom OTP (not OAuth, by design)
- DB: PostgreSQL via Prisma
- WhatsApp: Evolution API
- Email: Resend
- Deploy: Vercel
- Queue: Vercel KV + cron

## Patterns
- Server Components for all read operations
- Server Actions for mutations
- Optimistic UI for appointment selection
- Zod schemas for all inputs
- Rate limiting on OTP endpoint (5 attempts/15min)

## Testing
- Unit: Vitest for business logic
- Integration: Playwright for booking flow
- Load: k6 for concurrent booking stress test
```

---

## 🧠 INTELLIGENCE COMPARISON (Skills Extraction Summary)

### O que cada modelo FAZ MELHOR que os outros:

```
CLAUDE OPUS 5 — "O Arquiteto"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Self-verification (nenhum outro faz nativamente)
• Subagent delegation dinâmica (cria agents on-the-fly)
• Effort dial com 5 níveis calibrados
• Thinking gratuito (tokens não contam no output)
• Long-horizon sem drift (50+ steps coerentes)
• Novel problem-solving (ARC-AGI-3: 30.2% record)
• Knowledge work #1 global (GDPval-AA)
• Alignment mais seguro entre os frontier models

GPT-5.6 SOL — "O Executor"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Token efficiency absurda (faz mais com menos)
• Frontend aesthetics built-in (design judgment)
• Codex harness (agent loop production-ready)
• Plugin ecosystem maduro (marketplace)
• Multi-agent com path addressing (/root/agent_a)
• Lifecycle hooks (onStart, onComplete, onError)
• TerminalBench #1 (autonomous terminal coding)
• Lean prompts = melhor output (anti-verbose)

GEMINI 3.1 PRO — "O Polivalente"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
• Multimodal nativo (imagem+vídeo+áudio+texto num prompt)
• Custo 60% menor que os outros dois
• Context caching (90%+ economia em loops)
• Google Search grounding nativo
• Code execution sandbox built-in
• Vibe coding (prototipagem mais rápida)
• @file imports (context modular)
• ARC-AGI-2: 77.1% (reasoning puro monstruoso)
```

---

## 🛠️ UPGRADE PLAN: q1-agent-stack

### Fase 1: Atualizar Infra (IMEDIATO)
- [ ] Criar `CLAUDE.md` padrão Q1 (substitui/complementa GEMINI.md)
- [ ] Criar `CODEX.md` / `AGENTS.md` padrão Q1
- [ ] Atualizar `GEMINI.md` com thinking levels + @file imports
- [ ] Adicionar diretório `.claude/skills/` com skills universais
- [ ] Adicionar diretório `.codex/skills/` com skills universais
- [ ] Criar `MODEL_ROUTER.ts` (TypeScript service)

### Fase 2: Skills Universais (SKILL.md format)
- [ ] Migrar skills existentes pro formato SKILL.md
- [ ] Criar skills healthcare (booking, OTP, convênio, LGPD)
- [ ] Importar top skills de VoltAgent/awesome-agent-skills
- [ ] Importar AI research skills de Orchestra-Research
- [ ] Setup progressive disclosure (lazy loading)

### Fase 3: Multi-Model Integration
- [ ] Claude Code GitHub Actions (já existe em q1-digital, replicar)
- [ ] Codex plugin local (q1-clinic-booking como plugin)
- [ ] Gemini CLI integration via GEMINI.md atualizado
- [ ] Handoff protocol entre modelos
- [ ] Cost tracking dashboard

### Fase 4: q1-clinic-booking (projeto filho)
- [ ] Criar repo com bootstrap do q1-agent-stack
- [ ] CLAUDE.md + CODEX.md + GEMINI.md específicos do projeto
- [ ] Skills healthcare no padrão SKILL.md
- [ ] Pipeline: Opus 5 (spec) → Sol (code) → Gemini (test/iterate)

---

## 📊 NÚMEROS FINAIS

| Métrica | Antes (q1-agent-stack) | Depois (Golden Trio) |
|---|---|---|
| Modelos | 1 (Gemini) | 3 (Opus 5 + Sol + Gemini 3.1 Pro) |
| Skills format | Custom (.md) | Universal (SKILL.md, 40+ platforms) |
| Skills disponíveis | 246+ | 500+ (com imports) |
| Cross-platform | Não | Sim (mesma skill roda em 3 agents) |
| Cost per task | ~$1.50 | ~$0.80 (routing inteligente) |
| Healthcare skills | 0 | 15+ (custom) |
| LGPD/compliance | Parcial | Completo (Opus 5 dedicated) |
| Agentic capability | Single-model | Tri-model orchestrated |
| Plugin ecosystem | Não | Sim (Codex marketplace) |
| Self-verification | Manual | Nativo (Opus 5 built-in) |

---

*Golden Trio Skills Extraction v1.0 — Q1 Digital*
*"Três mentes, um objetivo. Cada uma brilha onde as outras não alcançam."*
