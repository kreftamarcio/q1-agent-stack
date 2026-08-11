# AGENTS.md — GPT-5.6 Sol (OpenAI Codex)

Este arquivo é lido automaticamente pelo OpenAI Codex CLI, GitHub Copilot Workspace, e outras tools que consomem AGENTS.md.
Modelo único: **gpt-5.6-sol**. Sem fallback.

Regras compartilhadas: ver **ENGINEERING.md**

---

## Stack

TypeScript strict, Next.js 15, React 19, Supabase, Vercel, n8n, Zod.

---

## Anti-Alucinação: Falhas Específicas do GPT-5.6 Sol

### 1. Confiança calibrada como certeza

Quando não sabe, responde com a mesma confiança de quando sabe. Não sinaliza incerteza.

**Defesa:**
- Tratar toda afirmação sobre API/método como hipótese até verificar
- Rodar `npm info <pkg>` antes de adicionar dependência
- Ler assinatura real do método no source antes de usar
- Se não verificável: marcar UNVERIFIED e não prosseguir

### 2. Pattern-matching de training data desatualizado

Tende a gerar código de versões anteriores (pages router, class components, Express antigo).

**Defesa:**
- Verificar versão em package.json ANTES de implementar
- Se Next.js >= 13: App Router, Server Components, Server Actions
- Se React >= 18: hooks only
- Regra: se o pattern não aparece na doc da versão instalada, não use

### 3. Completação pré-matura

Declara done após happy-path. Não testa edge cases espontaneamente.

**Defesa:**
- Checklist antes de done:
  - Input vazio testado
  - Input malformado testado
  - Erro de rede/timeout testado
  - Concurrent access considerado
  - Null/undefined em toda boundary
- Qualquer item faltando = NÃO done

### 4. Invenção de APIs com nomes plausíveis

Gera métodos que "parecem" existir mas não existem.

**Defesa:**
- Toda chamada verificada contra `node_modules/<pkg>/dist/index.d.ts`
- Ou docs oficiais via fetch
- Se método não aparece no .d.ts: NÃO EXISTE. Parar.

---

## Agentes

Ver `agents/` directory. 7 agentes operam em loop:
- architect (plan) → developer (code) → auditor (verify) → security (gate) → deployer (ship)
- debugger ativa quando developer falha 2x
- orchestrator dirige o fluxo
