# MCP Architecture Layer

> Model Context Protocol: a norma que conecta Antigravity + Gemini ao ClickUp e GitHub.
> Todos os MCP servers rodam via Stdio (subprocesso local) ou SSE (remoto).

## Auditoria de Licenças

| Repositório | Licença | Uso Comercial |
|-------------|---------|---------------|
| oh-my-antigravity | MIT | ✅ Livre |
| agent-skills (Addy Osmani) | MIT | ✅ Livre |
| SuperAntigravity | MIT | ✅ Livre |
| ECC (Everything Claude Code) | MIT | ✅ Livre |
| antigravity-skills vault | MIT | ✅ Livre |
| Superpowers (obra) | MIT | ✅ Livre |
| Ruflo (agent swarms) | MIT | ✅ Livre |
| clickup-agentic-native | Apache 2.0 | ✅ Livre (manter NOTICE) |
| github-mcp-server (oficial) | MIT | ✅ Livre |
| hauptsacheNet/clickup-mcp | MIT | ✅ Livre |
| code-reasoning | MIT | ✅ Livre |
| git-mcp | MIT | ✅ Livre |
| context-mode | ELv2 | ⚠️ OK para uso interno, proibido revender como SaaS |

---

## Como o Gemini Processa MCP Tools

1. **Namespace:** Cada tool vira `mcp_{serverName}_{toolName}` (max 63 chars)
2. **Schema Sanitization:** Caracteres especiais viram `_`, refs circulares são achatados
3. **Checkpoint:** Antes de qualquer write, Gemini cria snapshot em `~/.gemini/history/<hash>`
4. **Context Hierarchy:** `~/.gemini/GEMINI.md` (global) > workspace > project > JIT contexts

## ⚠️ VULNERABILIDADE CRÍTICA: Gemini + Schemas Complexos

Gemini 3.x Pro tem intolerância a:
- `$ref` circulares em schemas JSON
- Arrays com aninhamento profundo (>3 níveis)
- Schemas que produzem "too many states"

**Sintoma:** Loop infinito, repete plano sem executar tools.

**Mitigação obrigatória:**
- Desativar Native Tool Calling quando possível
- Usar parsers XML no cliente MCP
- Limitar toolsets expostos (ex: `--toolsets repos,issues`)
- Configurar `MAX_RESPONSE_SIZE_MB` nos servers ClickUp

---

## MCP Servers: ClickUp (Escolha Estratégica)

### Tier 1: Para Desenvolvimento com Agentes de Código

| Server | Lang | Melhor Para | Install |
|--------|------|-------------|--------|
| [hauptsacheNet/clickup-mcp](https://github.com/hauptsacheNet/clickup-mcp) | TypeScript | Leitura de context rico, imagens inline, orçamento de memória, pesquisa multilingue | `npx @hauptsachenet/clickup-mcp` |
| [clickup-agentic-native](https://github.com/zenzenzen/clickup-agentic-native) | Python | Dev-sync GitHub↔ClickUp, dry-run, MCP + CLI completo | `clickup-agent mcp` |

### Tier 2: Para Gestão e Operações em Massa

| Server | Lang | Melhor Para | Install |
|--------|------|-------------|--------|
| [DiversioTeam/clickup-mcp](https://github.com/DiversioTeam/clickup-mcp) | Python | Bulk ops, task chains, time tracking, templates | `uvx clickup-mcp` |
| [taazkareem/clickup-mcp-server](https://github.com/taazkareem/clickup-mcp-server) | TypeScript | Multi-tenant, 460⭐, workspaces paralelos | `npx clickup-mcp-server` |

### Tier 3: Especialistas

| Server | Lang | Melhor Para |
|--------|------|-------------|
| [smeric28/clickup-mcp](https://github.com/smeric28/clickup-mcp) | Node.js | Topologia profunda (spaces, folders, custom fields) |
| [Nazruden/clickup-mcp-server](https://github.com/Nazruden/clickup-mcp-server) | TypeScript | Segurança (encryption key), debug via MCP Inspector |
| [ashleykleynhans/clickup-mcp-server](https://github.com/ashleykleynhans/clickup-mcp-server) | Python | Criação transacional (task + subtasks em 1 op) |

### Configuração Recomendada (2 servers em paralelo)

```json
{
  "mcpServers": {
    "clickup-dev": {
      "command": "clickup-agent",
      "args": ["mcp"],
      "env": {
        "CLICKUP_API_KEY": "${CLICKUP_API_KEY}"
      }
    },
    "clickup-context": {
      "command": "npx",
      "args": ["@hauptsachenet/clickup-mcp"],
      "env": {
        "CLICKUP_API_KEY": "${CLICKUP_API_KEY}",
        "CLICKUP_PRIMARY_LANGUAGE": "pt-BR",
        "MAX_RESPONSE_SIZE_MB": "5"
      }
    }
  }
}
```

---

## MCP Servers: GitHub

### Server Oficial: [github/github-mcp-server](https://github.com/github/github-mcp-server) (32K⭐) — MIT

**Instalação local (Docker):**
```bash
docker pull ghcr.io/github/github-mcp-server
docker run -e GITHUB_PERSONAL_ACCESS_TOKEN="$GH_TOKEN" ghcr.io/github/github-mcp-server
```

**Instalação local (binário):**
```bash
go install github.com/github/github-mcp-server@latest
```

**Toolsets disponíveis (ativar seletivamente!):**

| Toolset | Função | Risco |
|---------|--------|-------|
| `repos` | Navegar branches, buscar código, ler arquivos | 🟢 Read-only |
| `issues` | Criar, editar, fechar issues | 🟡 Write |
| `pull_requests` | Criar PRs, review, merge | 🔴 Destrutivo |
| `actions` | Logs de CI/CD, re-run workflows | 🟡 Write |
| `code_security` | Dependabot alerts, CodeQL | 🟢 Read-only |

**Configuração MCP:**
```json
{
  "mcpServers": {
    "github": {
      "command": "github-mcp-server",
      "args": ["--toolsets", "repos,issues,pull_requests,code_security"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GH_TOKEN}"
      }
    }
  }
}
```

### Complementares GitHub (todos MIT)

| Server | Stars | Licença | Função |
|--------|-------|---------|--------|
| [git-mcp](https://github.com/idosal/git-mcp) | 8.3K | **MIT** | MCP remoto pra qualquer repo GitHub. Elimina alucinações de código fornecendo docs/README reais como contexto. Zero config, funciona como URL. |
| [codedb](https://github.com/justrach/codedb) | 1.3K | **MIT** | Code intelligence em Zig: tree, outline, symbol, search, edit, deps, snapshot. Compatível com Gemini. |
| [agentshield](https://github.com/affaan-m/agentshield) | 1K | **MIT** | Scanner de segurança para configs de agentes e MCP servers. GitHub Action incluso. |

> ❌ **REMOVIDO:** jcodemunch-mcp (licença comercial, uso proibido sem pagamento para freelancers/empresas)

---

## MCP Servers: Raciocínio e Thinking

| Server | Stars | Licença | Função |
|--------|-------|---------|--------|
| [code-reasoning](https://github.com/mettamatt/code-reasoning) | 257 | **MIT** | Fork do Sequential Thinking focado em code reasoning |
| [sequential-thinking-skill](https://github.com/thedotmack/sequential-thinking-skill) | 35 | MIT | Sequential Thinking como skill (sem MCP extra) |
| [deepthinking-mcp](https://github.com/danielsimonjr/deepthinking-mcp) | 3 | MIT | Combina sequential + Shannon + mathematical reasoning |

---

## MCP Servers: Automação e n8n

| Server | Função |
|--------|--------|
| [n8n-unified-mcp-server](https://github.com/anshwysmcbel2710/n8n-unified-mcp-server) | Ponte n8n ↔ LLM: SSE/STDIO, context-aware orchestration |
| [n8n-mcp-ai-agents](https://github.com/shivpranay5/n8n-mcp-ai-agents) | 20+ workflows multi-agente com MCP |

---

## Configuração Completa Final (settings.json do Gemini/Antigravity)

```json
{
  "mcpServers": {
    "context-mode": {
      "command": "context-mode"
    },
    "clickup-dev": {
      "command": "clickup-agent",
      "args": ["mcp"]
    },
    "clickup-context": {
      "command": "npx",
      "args": ["@hauptsachenet/clickup-mcp"],
      "env": {
        "CLICKUP_API_KEY": "${CLICKUP_API_KEY}",
        "CLICKUP_PRIMARY_LANGUAGE": "pt-BR",
        "MAX_RESPONSE_SIZE_MB": "5"
      }
    },
    "github": {
      "command": "github-mcp-server",
      "args": ["--toolsets", "repos,issues,pull_requests,code_security"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GH_TOKEN}"
      }
    },
    "git-mcp": {
      "command": "npx",
      "args": ["-y", "git-mcp"],
      "env": {
        "GITHUB_TOKEN": "${GH_TOKEN}"
      }
    },
    "code-reasoning": {
      "command": "npx",
      "args": ["-y", "@mettamatt/code-reasoning"]
    }
  },
  "hooks": {
    "BeforeTool": [
      {
        "matcher": "run_shell_command|read_file|read_many_files|grep_search|web_fetch|mcp__(?!.*context-mode)",
        "hooks": [{ "type": "command", "command": "context-mode hook gemini-cli beforetool" }]
      }
    ],
    "AfterTool": [
      { "matcher": "", "hooks": [{ "type": "command", "command": "context-mode hook gemini-cli aftertool" }] }
    ],
    "PreCompress": [
      { "matcher": "", "hooks": [{ "type": "command", "command": "context-mode hook gemini-cli precompress" }] }
    ],
    "SessionStart": [
      { "matcher": "", "hooks": [{ "type": "command", "command": "context-mode hook gemini-cli sessionstart" }] }
    ]
  }
}
```

---

## Fluxo Closed-Loop: ClickUp → GitHub → Deploy

```
┌────────────────────────────────────────────────────────────┐
│  1. TRIAGEM SEMÂNTICA                                       │
│  Gemini acessa clickup-context MCP                         │
│  search_tasks(priority: urgent, language: pt-BR)           │
└────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌────────────────────────────────────────────────────────────┐
│  2. PROCESSAMENTO DE EVIDÊNCIAS                             │
│  getTaskById (hauptsacheNet: imagens inline, budget)        │
│  context-mode sandbox: 56KB → 299B                         │
└────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌────────────────────────────────────────────────────────────┐
│  3. MAPEAMENTO NO CÓDIGO                                    │
│  github MCP: toolset=repos (read-only)                     │
│  git-mcp: docs/README reais como contexto (anti-alucinação)│
│  code-reasoning: sequential thinking sobre o bug            │
└────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌────────────────────────────────────────────────────────────┐
│  4. RESOLUÇÃO + CHECKPOINT                                   │
│  Gemini deduz patch, aplica via replace/write               │
│  Auto-checkpoint em ~/.gemini/history/<hash>                 │
│  /restore <file> se der errado                              │
└────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌────────────────────────────────────────────────────────────┐
│  5. AUTOMAÇÃO PÓS-RESOLUÇÃO (paralelo)                       │
│                                                            │
│  GitHub MCP:                    ClickUp MCP:               │
│  ├─ commit atômico              ├─ update_task (done)       │
│  ├─ create PR                   ├─ addComment (log)         │
│  └─ code_security scan          └─ time tracking            │
└────────────────────────────────────────────────────────────┘
```

---

## Rate Limits e Proteções

| API | Limite | Mitigação |
|-----|--------|----------|
| ClickUp | 100 req/min | Batch operations, instruções no GEMINI.md pra limitar iterações |
| GitHub | 5000 req/h (PAT) | git-mcp (contexto remoto sem clone), cache via context-mode |
| Gemini API | Varia por tier | Model routing (Pro→Flash→Lite), context-mode (98% reduction) |

---

## Segurança de Credenciais

**NUNCA** passar tokens via CLI args. Sempre via:
1. `.env` file (gitignored)
2. Variáveis de ambiente exportadas
3. OAuth browser-based (GitHub MCP server)

```bash
# .env (NUNCA commitar)
CLICKUP_API_KEY=pk_...
GITHUB_PERSONAL_ACCESS_TOKEN=ghp_...
```

---

## Inventário Total Atualizado

| Métrica | q1-agent-stack |
|---------|----------------|
| Skills | **246+** |
| Commands | **122+** |
| Agents | **74+** |
| MCP Tools | **42+** |
| MCP Servers | **6** (context-mode, clickup-dev, clickup-context, github, git-mcp, code-reasoning) |
| Licenças | **100% legal** (MIT/Apache 2.0/ELv2 uso interno) |
