# Q1 Digital — Project Bootstrap System

> Todo novo repositório criado herda automaticamente o stack completo Q1.
> SaaS, landing page, site, app, API: todos operam no mesmo nível.

## Como Usar

### Opção 1: One-liner (curl)

Dentro de qualquer repo novo:

```bash
curl -fsSL https://raw.githubusercontent.com/kreftamarcio/q1-agent-stack/main/bootstrap/init-project.sh | bash
```

### Opção 2: Alias permanente

Adicione ao `~/.bashrc` ou `~/.zshrc`:

```bash
alias q1-init='curl -fsSL https://raw.githubusercontent.com/kreftamarcio/q1-agent-stack/main/bootstrap/init-project.sh | bash'
```

Depois, em qualquer repo novo:

```bash
mkdir meu-projeto && cd meu-projeto && git init
q1-init
```

### Opção 3: Via ClickUp + Antigravity

No Antigravity, quando começar um novo projeto:

```
/oma:team-assemble "Bootstrap new project [NOME]"
→ architect decomposes into: bootstrap + first feature
→ orchestrator runs init-project.sh
→ developer starts first node
```

## O que o Bootstrap Injeta

```
seu-projeto/
├── GEMINI.md                          ← Master config (14KB, anti-hallucination)
├── .gemini/
│   ├── agents/
│   │   ├── q1-architect.md             ← PLANNER
│   │   ├── q1-developer.md             ← EXECUTOR  
│   │   ├── q1-auditor.md               ← VERIFIER
│   │   ├── q1-debugger.md              ← REFACTORER
│   │   ├── q1-security.md              ← GUARD
│   │   ├── q1-deployer.md              ← SHIPPER
│   │   └── q1-orchestrator.md          ← DIRECTOR
│   ├── skills/
│   │   ├── anti-hallucination-source-driven/
│   │   ├── anti-hallucination-adversarial-11/
│   │   ├── anti-hallucination-structured-output/
│   │   ├── anti-hallucination-doubt-driven/
│   │   ├── anti-hallucination-memory-anchor/
│   │   └── anti-hallucination-clickup-brain/
│   └── mcp_config.json                 ← 6 MCP servers
├── .env.example                        ← Tokens necessários
├── .gitignore                          ← Protege secrets
└── vercel.json                         ← Deploy config
```

## Depois do Bootstrap

O Antigravity ao abrir o projeto:
1. Lê `GEMINI.md` (config global + anti-hallucination protocol)
2. Detecta `.gemini/agents/` (7 agentes Q1 disponíveis)
3. Detecta `.gemini/skills/` (6 skills anti-hallucination ativam por contexto)
4. Detecta `.gemini/mcp_config.json` (6 MCP servers conectam)
5. Skills globais já instaladas (~/.gemini/antigravity/skills/) complementam

## 2 Modos de Operação

### Modo Rápido (tasks S, hotfixes, ajustes)

```
/implement → /review → /git
```

Gemini opera como developer + auditor num único fluxo.
Bom pra: fix de 1 arquivo, componente simples, ajuste de estilo.

### Modo Rigoroso (features M/L, produção, SaaS)

```
/oma:team-assemble "[descrição da feature]"
→ Monta time: architect + developer + auditor + security + deployer
→ Orchestrator gerencia o loop
→ Cada node do DAG passa por: implement → verify → deploy
```

Bom pra: features novas, módulos inteiros, qualquer coisa que vai pra produção.

## Integração com ClickUp Brain

O ClickUp Brain opera em paralelo:
- **Sprint planning:** Brain prioriza backlog, tu confirma
- **Triagem:** Brain classifica bugs/features, Antigravity implementa
- **Status sync:** dev-sync mantém ClickUp ↔ GitHub alinhados
- **Escalação:** Quando agentes bloqueiam, ClickUp comment + assign pra humano

Usar as regras de `anti-hallucination-clickup-brain` SEMPRE que interagir com Brain.

## Integração com Vercel

- Todo projeto já nasce com `vercel.json`
- Deploy via q1-deployer: preview → test → promote
- Performance gate: LCP < 2.5s, CLS < 0.1
- Security gate: headers + WAF + no exposed secrets
- US$ 2.400 de créditos Vercel for Startups disponíveis

## Upgrade

Quando o q1-agent-stack for atualizado:

```bash
# Re-rodar no projeto pra pegar updates
q1-init
```

O script sobrescreve GEMINI.md, agents, skills, e mcp_config. Não toca em código do projeto.
