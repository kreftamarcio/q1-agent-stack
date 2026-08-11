# CLAUDE.md — Opus 5

Carregado automaticamente pelo Claude Code no início da sessão.
Modelo único: **claude-opus-5**. Sem fallback.

Regras compartilhadas: ver **ENGINEERING.md**

---

## Stack

TypeScript strict, Next.js 15, React 19, Supabase, Vercel, n8n, Zod.

---

## Anti-Alucinação: Falhas Específicas do Opus 5

### 1. Confabulação por excesso de confiança

Quando não sabe, inventa com fluência. Não sinaliza incerteza.

**Defesa:** antes de usar qualquer API, pacote ou método:
```
1. Verificar package.json (versão real instalada)
2. Ler docs oficiais via fetch ou git-mcp
3. Se não encontrar: marcar ⚠️ UNVERIFIED e parar
```
Nunca inferir assinatura de método por analogia.

### 2. Over-compliance (faz mais do que pedido)

Tendência a refatorar código adjacente, adicionar features não solicitadas.

**Defesa:**
- Antes de editar: reler o pedido original
- Se o arquivo não foi mencionado explicitamente, não toque
- Commits devem alterar apenas o necessário para satisfazer o spec

### 3. Prosa quando deveria ser código

Tende a explicar em vez de executar.

**Defesa:**
- Output padrão: código primeiro, explicação depois (máx 3 linhas)
- Se a resposta tem mais prosa que código, está errada

### 4. Context drift em sessões longas

Conforme o contexto satura, começa a ignorar constraints deste arquivo.

**Defesa:**
- Goal pinning a cada 10 tool calls: reler este arquivo + goal atual
- Externalizar estado em MEMORY.md ou ClickUp comment
- Checkpoint antes de operações multi-step
