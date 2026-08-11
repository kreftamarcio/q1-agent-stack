# GEMINI.md — Gemini 3.1 Pro

Carregado automaticamente pelo Antigravity CLI no início da sessão.
Modelo único: **gemini-3.1-pro**. Sem fallback.

Regras compartilhadas: ver **ENGINEERING.md**

**Pré-requisitos:** context-mode instalado com hooks configurados em `~/.gemini/settings.json` (ver `settings.json` neste repo).

---

## Stack

TypeScript strict, Next.js 15, React 19, Supabase, Vercel, n8n, Zod.

---

## MCP Servers (6)

| Server | Função |
|--------|--------|
| context-mode | Sandbox de outputs grandes, redução de tokens |
| clickup-dev | Operações em tasks (create/update/sync) |
| clickup-context | Leitura rica (imagens, busca multilingual) |
| github | Repos, issues, PRs, security scans |
| git-mcp | Docs reais como contexto (anti-alucinação) |
| code-reasoning | Raciocínio sequencial estruturado |

---

## Anti-Alucinação: Falhas Específicas do Gemini 3.1 Pro

### 1. Loop infinito em schemas complexos

Quando MCP tools têm schemas com $ref circulares ou arrays aninhados >3 níveis, repete o plano sem executar.

**Defesa:**
- Limitar toolsets por sessão (`--toolsets repos,issues`)
- MAX_RESPONSE_SIZE_MB = 5 nos servers ClickUp
- Se detectar repetição sem ação: parar, reduzir scope, retry com menos tools

### 2. Pula verificação quando "parece certo"

Após implementar, tende a declarar done sem rodar tests.

**Defesa:**
- NENHUM nó é done sem output de verificador externo
- Verificador = test pass + build clean + lint clean (os 3)
- Self-report de "funciona" não conta

### 3. Context drift após compactação

Após context-mode comprimir a sessão, pode esquecer regras.

**Defesa:**
- Hooks de SessionStart recarregam este arquivo (requer context-mode + settings.json)
- PreCompress cria snapshot do estado
- Goal pinning a cada 10 tool calls
- Externalizar decisões em ClickUp comments

### 4. Imports inexistentes

Importa de paths que "fazem sentido" mas não existem no projeto.

**Defesa:**
- Antes de importar: verificar com ls/glob que o arquivo existe
- Antes de usar pacote: verificar package.json
- Antes de usar método: ler .d.ts ou docs via git-mcp

---

## Context Optimization

- Outputs grandes: context-mode sandbox
- Busca: ctx_search com FTS5 (BM25)
- Batch: ctx_batch_execute para múltiplos comandos em 1 call
- Persistência: hooks restauram estado após compactação
