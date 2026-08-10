# ECC (Everything Claude Code) — Integration Guide

> 182 skills, 68 commands, 48 agents. Optimized for cost reduction, persistent memory, and security scanning.
> Repository: https://github.com/affaan-m/ECC (239K⭐)

## Installation

### Option 1: Full clone (recommended for max coverage)
```bash
git clone https://github.com/affaan-m/ECC.git ~/.ecc
cd ~/.ecc && npm install
bash install.sh
```

### Option 2: Cherry-pick skills for Antigravity
```bash
# Clone ECC
git clone https://github.com/affaan-m/ECC.git /tmp/ecc

# Copy selected skills to Antigravity global skills directory
mkdir -p ~/.gemini/antigravity/skills

# Core workflow skills
cp -r /tmp/ecc/skills/project-flow-ops ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/cost-tracking ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/security-scan ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/security-review ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/tdd-workflow ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/verification-loop ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/unified-memory ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/continuous-learning ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/context-budget ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/strategic-compact ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/autonomous-loops ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/team-agent-orchestration ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/plan-orchestrate ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/delivery-gate ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/production-audit ~/.gemini/antigravity/skills/

# Development skills (TypeScript/Next.js/React focus)
cp -r /tmp/ecc/skills/react-patterns ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/react-performance ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/react-testing ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/nextjs-turbopack ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/frontend-patterns ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/frontend-a11y ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/backend-patterns ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/api-design ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/prisma-patterns ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/docker-patterns ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/error-handling ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/git-workflow ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/e2e-testing ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/python-patterns ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/fastapi-patterns ~/.gemini/antigravity/skills/

# Marketing & Business skills
cp -r /tmp/ecc/skills/marketing-campaign ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/seo ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/social-publisher ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/content-engine ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/brand-voice ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/market-research ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/lead-intelligence ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/investor-materials ~/.gemini/antigravity/skills/

# Design & UI skills
cp -r /tmp/ecc/skills/design-system ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/liquid-glass-design ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/frontend-design-direction ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/make-interfaces-feel-better ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/dashboard-builder ~/.gemini/antigravity/skills/

# AI/Agent skills
cp -r /tmp/ecc/skills/agentic-engineering ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/autonomous-agent-harness ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/cost-aware-llm-pipeline ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/prompt-optimizer ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/mcp-server-patterns ~/.gemini/antigravity/skills/

# Orchestration skills
cp -r /tmp/ecc/skills/orch-add-feature ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/orch-build-mvp ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/orch-fix-defect ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/orch-refine-code ~/.gemini/antigravity/skills/
cp -r /tmp/ecc/skills/orch-pipeline ~/.gemini/antigravity/skills/

# Cleanup
rm -rf /tmp/ecc
```

### Option 3: Copy GEMINI.md to project
```bash
cp ~/.ecc/.gemini/GEMINI.md ~/your-project/.gemini/GEMINI.md
```

---

## Skills Selecionadas para ClickUp + Antigravity + Gemini

### 🎯 PROJETO & WORKFLOW (integram com ClickUp)

| Skill | O que faz | Uso com ClickUp |
|-------|-----------|----------------|
| `project-flow-ops` | Triage de issues/PRs, classificação (merge/port/close/park) | Synca classificação com status do ClickUp via dev-sync |
| `plan-orchestrate` | Decomposição de features em tasks atômicas | Gera subtasks no ClickUp automaticamente |
| `plan-canvas` | Planejamento visual com dependências | Mapeia dependências pra taskboard do ClickUp |
| `delivery-gate` | Quality gate antes de ship | Atualiza checklist no ClickUp antes de mover pra "done" |
| `production-audit` | Auditoria pré-produção | Cria checklist de auditoria no ClickUp |
| `team-agent-orchestration` | Coordenação multi-agente | Cada agente reporta progresso como comment no ClickUp |
| `github-ops` | Operações GitHub (PRs, issues, branches) | dev-sync bidirecional com ClickUp |

### 💰 REDUÇÃO DE CUSTO (otimiza Gemini API)

| Skill | O que faz | Economia |
|-------|-----------|----------|
| `cost-tracking` | Monitora consumo de tokens por sessão | Visibilidade de gasto |
| `cost-aware-llm-pipeline` | Pipeline que minimiza chamadas caras | Roteia tarefas simples pro Flash/Lite |
| `context-budget` | Gerencia orçamento de context window | Evita overflow + compaction |
| `strategic-compact` | Compactação inteligente de contexto | Preserva o que importa, descarta ruído |
| `token-budget-advisor` | Aconselha sobre uso de tokens | Sugere quando usar ferramentas locais vs LLM |
| `prompt-optimizer` | Otimiza prompts pra mínimo de tokens | Reduz custo mantendo qualidade |
| `connections-optimizer` | Otimiza conexões e chamadas | Menos round-trips |

### 🧠 MEMÓRIA PERSISTENTE

| Skill | O que faz |
|-------|----------|
| `unified-memory` | Sistema de memória unificado entre sessões |
| `continuous-learning` | Aprende de cada sessão e aplica nas próximas |
| `continuous-learning-v2` | Versão avançada com feedback loops |
| `knowledge-ops` | Gestão de base de conhecimento |

### 🔒 SEGURANÇA & COMPLIANCE

| Skill | O que faz |
|-------|----------|
| `security-scan` | Varredura automática de vulnerabilidades no código |
| `security-review` | Review de segurança com foco em OWASP |
| `security-bounty-hunter` | Busca ativa de vulnerabilidades |
| `gateguard` | Gate de segurança antes de deploy |
| `safety-guard` | Guarda contra outputs inseguros |
| `hipaa-compliance` | Compliance HIPAA (se necessário) |

### 🚀 DESENVOLVIMENTO (teu stack: TS/Next.js/React)

| Skill | O que faz |
|-------|----------|
| `react-patterns` | Padrões React modernos (hooks, composition) |
| `react-performance` | Otimização de performance React |
| `react-testing` | Testes unitários/integração React |
| `nextjs-turbopack` | Next.js com Turbopack, App Router |
| `frontend-patterns` | Padrões frontend gerais |
| `frontend-a11y` | Acessibilidade frontend |
| `backend-patterns` | Padrões backend Node.js |
| `api-design` | Design de APIs REST/GraphQL |
| `prisma-patterns` | Prisma ORM patterns |
| `docker-patterns` | Containerização |
| `error-handling` | Tratamento de erros robusto |
| `git-workflow` | Git workflow otimizado |
| `e2e-testing` | Testes end-to-end |
| `python-patterns` | Python (n8n custom nodes) |
| `fastapi-patterns` | FastAPI (APIs Python) |
| `tdd-workflow` | Test-Driven Development completo |
| `verification-loop` | Loop de verificação contínua |

### 📊 MARKETING & BUSINESS

| Skill | O que faz |
|-------|----------|
| `marketing-campaign` | Campanhas completas de marketing |
| `seo` | Otimização SEO |
| `social-publisher` | Publicação em redes sociais (Social Claw) |
| `content-engine` | Motor de conteúdo |
| `brand-voice` | Voz da marca consistente |
| `market-research` | Pesquisa de mercado |
| `lead-intelligence` | Inteligência de leads |
| `investor-materials` | Materiais para investidores |

### 🎨 DESIGN & UI

| Skill | O que faz |
|-------|----------|
| `design-system` | Design system completo |
| `liquid-glass-design` | Efeito Liquid Glass (mencionado no áudio) |
| `frontend-design-direction` | Direção de design frontend |
| `make-interfaces-feel-better` | UX/UI polish |
| `dashboard-builder` | Construção de dashboards |

### 🤖 AI & AGENTES

| Skill | O que faz |
|-------|----------|
| `agentic-engineering` | Engenharia de agentes |
| `autonomous-agent-harness` | Construção de harnesses autônomos |
| `autonomous-loops` | Loops autônomos de execução |
| `cost-aware-llm-pipeline` | Pipelines LLM com custo otimizado |
| `mcp-server-patterns` | Padrões pra construir MCP servers |

### 🎭 ORQUESTRAÇÃO (workflows completos)

| Skill | O que faz |
|-------|----------|
| `orch-build-mvp` | Orquestra construção de MVP completo |
| `orch-add-feature` | Orquestra adição de feature |
| `orch-fix-defect` | Orquestra correção de defeito |
| `orch-refine-code` | Orquestra refatoração |
| `orch-pipeline` | Pipeline de orquestração geral |

---

## Agents do ECC Mais Relevantes

### Para Desenvolvimento
| Agent | Função |
|-------|--------|
| `architect` | Arquitetura de sistemas |
| `code-architect` | Arquitetura de código |
| `code-reviewer` | Review de código |
| `code-explorer` | Exploração de codebase |
| `code-simplifier` | Simplificação de código |
| `typescript-reviewer` | Review específico TypeScript |
| `react-reviewer` | Review específico React |
| `react-build-resolver` | Resolve erros de build React |
| `fastapi-reviewer` | Review FastAPI |
| `python-reviewer` | Review Python |
| `build-error-resolver` | Resolve erros de build gerais |
| `tdd-guide` | Guia TDD |

### Para Segurança
| Agent | Função |
|-------|--------|
| `security-reviewer` | Review de segurança completo |
| `silent-failure-hunter` | Caça falhas silenciosas |

### Para Projeto
| Agent | Função |
|-------|--------|
| `planner` | Planejamento de execução |
| `chief-of-staff` | Coordenação executiva |
| `loop-operator` | Opera loops autônomos |
| `performance-optimizer` | Otimiza performance |
| `marketing-agent` | Marketing automático |
| `seo-specialist` | SEO especializado |

---

## Commands do ECC Mais Relevantes

### Workflow
| Command | Função |
|---------|--------|
| `/plan` | Planejar implementação |
| `/plan-canvas` | Planejamento visual |
| `/plan-prd` | Gerar PRD |
| `/feature-dev` | Desenvolvimento de feature completo |
| `/project-init` | Iniciar projeto |
| `/quality-gate` | Gate de qualidade |
| `/security-scan` | Varredura de segurança |
| `/code-review` | Review de código |
| `/test-coverage` | Análise de cobertura de testes |

### Orquestração Multi-Agente
| Command | Função |
|---------|--------|
| `/orch-build-mvp` | Build MVP completo com agentes |
| `/orch-add-feature` | Adicionar feature orquestrado |
| `/orch-fix-defect` | Fix orquestrado |
| `/orch-refine-code` | Refatoração orquestrada |
| `/multi-plan` | Planejamento multi-agente |
| `/multi-execute` | Execução multi-agente |
| `/multi-frontend` | Frontend multi-agente |
| `/multi-backend` | Backend multi-agente |

### Cost & Memory
| Command | Função |
|---------|--------|
| `/cost-report` | Relatório de custos |
| `/model-route` | Rotear pra modelo ideal |
| `/save-session` | Salvar sessão |
| `/resume-session` | Retomar sessão |
| `/checkpoint` | Salvar checkpoint |
| `/learn` | Aprender da sessão |

### Marketing & SEO
| Command | Função |
|---------|--------|
| `/marketing-campaign` | Campanha completa |
| `/promote` | Promoção de conteúdo |

---

## Como Funciona com ClickUp + Antigravity

### Fluxo Integrado:

```
1. ClickUp Task criada (via Brain ou manual)
   │
2. clickup-agent context load --task-id <ID> --profile handoff
   │
3. Antigravity carrega GEMINI.md + ECC skills relevantes
   │
4. /oma:team-assemble (monta time baseado na task)
   │
5. Agents ECC executam:
   ├─ architect: define boundaries
   ├─ planner: decompõe em subtasks
   ├─ typescript-reviewer: review durante dev
   ├─ security-reviewer: scan antes de PR
   └─ loop-operator: mantém loop autônomo
   │
6. clickup-agent run dev-sync (synca com ClickUp)
   │
7. delivery-gate verifica qualidade
   │
8. clickup-agent run set-status --status "done"
```

### Model Routing do ECC (otimização de custo com Gemini):

| Tarefa | Modelo Gemini | Razão |
|--------|---------------|-------|
| Planejamento, review, arquitetura | gemini-3.1-pro | Raciocínio profundo |
| Implementação, execução | gemini-3-flash | Rápido e barato |
| Quick fixes, formatação | gemini-3.1-flash-lite | Ultra-rápido, custo mínimo |
| Análise de segurança | gemini-3.1-pro | Precisão crítica |
| SEO, marketing content | gemini-3-flash | Bom o suficiente, rápido |

### Memória Persistente (como funciona):

1. `unified-memory`: Mantém MEMORY.md atualizado entre sessões
2. `continuous-learning`: Extrai padrões de cada sessão
3. `/save-session` + `/resume-session`: Preserva estado completo
4. `context-mode` (MCP): Session continuity via SQLite + FTS5
5. ClickUp comments: Decision logs persistem como comments nas tasks

---

## Resumo de Números

| Métrica | ECC | Total no q1-agent-stack |
|---------|-----|------------------------|
| Skills | 182 | 246+ |
| Commands | 68 | 122+ |
| Agents | 48 | 74+ |
| MCP Tools | — | 31+ |

---

## Scripts de Setup Rápido

Ver `install-ecc.sh` neste repo.
