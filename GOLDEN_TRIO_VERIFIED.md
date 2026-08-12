# Q1 Digital — Golden Trio (VERIFICADO)

> **Todos os dados abaixo foram auditados contra fontes oficiais em 12/08/2026.**
> Fontes: platform.claude.com, developers.openai.com, ai.google.dev, artificialanalysis.ai, benchlm.ai
> Autor: Marcio Krefta — Q1 Digital

---

## Os 3 Melhores Modelos (Agosto 2026)

### Claude Opus 5 — `claude-opus-5`

| Dado | Valor | Fonte |
|------|-------|-------|
| Preço input | $5.00 / MTok | platform.claude.com/docs/pricing |
| Preço output | $25.00 / MTok | platform.claude.com/docs/pricing |
| Context window | 1,000,000 tokens (fixo, sem variante menor) | platform.claude.com/docs/whats-new-opus-5 |
| Max output | 128,000 tokens | platform.claude.com/docs/whats-new-opus-5 |
| Thinking | ON by default | platform.claude.com/docs/whats-new-opus-5 |
| Effort levels | low / medium / high / xhigh / max | platform.claude.com |
| Lançamento | 24 Jul 2026 | anthropic.com/news/claude-opus-5 |
| Intelligence Index | 60.7 (#1 global) | artificialanalysis.ai/articles/opus-5 |
| SWE-bench Pro | 79.2% (+10pts vs Opus 4.8) | anthropic.com/news/claude-opus-5 |
| ARC-AGI-3 | 30.2% (record) | Claude Opus 5 System Card |
| AA Coding Index | 78.0 (#1) | benchlm.ai/benchmarks/aacodingindex |
| Coding Agent Index v1.3 | 67 (empatado #1 com Sol) | artificialanalysis.ai/agents/coding-agents |
| GDPval-AA v2 | 1861 Elo (#1) | artificialanalysis.ai/articles/opus-5 |

**Capacidades nativas:**
- Self-verification (verifica próprio output antes de entregar)
- Subagent delegation dinâmica (cria sub-agents on-the-fly)
- Agentic narration (narra ações em tempo real)
- Long-horizon coherence (50+ steps sem drift)
- Mid-conversation tool changes

---

### GPT-5.6 Sol — `gpt-5.6-sol`

| Dado | Valor | Fonte |
|------|-------|-------|
| Preço input | $5.00 / MTok | developers.openai.com/api/docs/pricing |
| Preço output | $30.00 / MTok | developers.openai.com/api/docs/pricing |
| Context window | 1,050,000 tokens | developers.openai.com/api/docs/models/gpt-5.6-sol |
| Max output | 128,000 tokens | developers.openai.com |
| Reasoning | default / max (toggle) | developers.openai.com |
| Lançamento | 9 Jul 2026 (GA) | openai.com/index/gpt-5-6 |
| Intelligence Index | 58.9 (#3 global) | artificialanalysis.ai/articles/gpt-5-6-has-landed |
| TerminalBench 2.1 | 88.8% | lushbinary.com (cross-referenced) |
| AA Coding Index | 77.4 (#2) | benchlm.ai/benchmarks/aacodingindex |
| Coding Agent Index v1.3 | 67 (empatado #1 com Opus 5) | artificialanalysis.ai/agents/coding-agents |
| Token efficiency | 41-66% menos tokens que GPT-5.5 | developers.openai.com/api/docs/guides/prompt-guidance-gpt-5p6 |

**Capacidades nativas:**
- Frontend aesthetics (design judgment: layout, visual hierarchy)
- Codex harness (plan-act-verify loop autônomo)
- Lean prompts = melhor resultado (comprovado: +10-15% eval scores)
- Plugin architecture (skills + MCP + lifecycle hooks)
- Multi-agent subagents com path addressing

**CORREÇÃO:** Na época do lançamento (Jul 9), Sol liderava o Coding Agent Index sozinho (80pts). Após Opus 5 (Jul 24), ambos estão **empatados em 67** no Index v1.3. No AA Coding Index mais recente: Opus 5 (78.0) lidera marginalmente sobre Sol (77.4).

---

### Gemini 3.1 Pro — `gemini-3.1-pro-preview`

| Dado | Valor | Fonte |
|------|-------|-------|
| Preço input (≤200K) | $2.00 / MTok | ai.google.dev/gemini-api/docs/pricing, benchr.org |
| Preço input (>200K) | $4.00 / MTok ⚠️ ATENÇÃO: dobra acima de 200K | benchr.org, convly.ai, crazyrouter.com |
| Preço output (≤200K) | $12.00 / MTok | ai.google.dev |
| Preço output (>200K) | $18.00 / MTok | tokencost.app, crazyrouter.com |
| Context caching | $0.20 / MTok | ai.google.dev |
| Context window | 1,000,000 tokens (multimodal) | ai.google.dev/gemini-api/docs/models |
| Max output | 65,536 tokens | ai.google.dev |
| Thinking levels | low / medium / high | ai.google.dev |
| Lançamento | 19 Fev 2026 | blog.google |
| ARC-AGI-2 | 77.1% (2x+ vs Gemini 3 Pro) | benchr.org, ARC Prize verified |
| LiveCodeBench | 88.5 (#2 global) | thevibefather.com |
| GPQA Diamond | 94.3% | benchr.org |
| SWE-bench Verified | 75.6% | thevibefather.com |
| Multimodal | Texto, imagem, vídeo, áudio, PDF, código | ai.google.dev |

**CORREÇÃO:** O pricing do Gemini 3.1 Pro é **tiered**. Prompts acima de 200K tokens custam o DOBRO ($4/$18 vs $2/$12). Isso impacta uso de context cheio (1M). Para prompts ≤200K tokens o custo é excelente. Acima disso, calcule com o tier mais alto.

**Capacidades nativas:**
- Multimodal nativo (imagem + vídeo + áudio + texto num prompt)
- Context caching (90%+ economia em chamadas repetidas)
- Google Search grounding nativo
- Code execution sandbox built-in
- Function calling robusto (multi-step)
- Vibe coding (prototipagem rápida)

---

## Routing Table (Verificado)

| Tarefa | Modelo | Razão verificada |
|--------|--------|------------------|
| Arquitetura, planning, PRD | Opus 5 | #1 Intelligence Index, self-verification |
| Security, compliance, LGPD | Opus 5 | Adversarial review nativo |
| Code review profundo | Opus 5 | Thinking + doubt-driven |
| Implementação, TDD | Sol | Token-efficient, Codex harness |
| Frontend, UI | Sol | Design judgment nativo |
| Deploy, CI/CD | Sol | TerminalBench #1 |
| Research, prototyping | Gemini 3.1 Pro | Custo baixo (≤200K), multimodal |
| Content, marketing | Gemini 3.1 Pro | Volume, iteração rápida |
| Triage, routing | Gemini 3.1 Pro | Rápido, function calling |

---

## Comparação de Custo (ESTIMATIVA — projeção, não dado real)

> ⚠️ Os números abaixo são **projeções** baseadas em uso hipotético de um projeto SaaS médio.
> Custos reais dependem de: volume de tasks, tamanho dos prompts, effort levels, caching.

| Modelo | Preço/MTok (in/out) | Melhor pra |
|--------|---------------------|------------|
| Opus 5 | $5 / $25 | Decisões de alto valor (poucas, caras) |
| Sol | $5 / $30 | Bulk de coding (muitas, eficientes) |
| Gemini 3.1 Pro | $2 / $12 (≤200K) | Volume + prototipagem (muitas, baratas) |

**Regra de ouro:** Se o output pode ser verificado por test/build, use Sol. Se precisa de julgamento profundo, use Opus 5. Se precisa de velocidade/volume/multimodal, use Gemini.

---

## Coding Leadership (Agosto 2026 — Auditado)

```
AA Coding Index (benchlm.ai, Aug 2026):
  #1 Claude Opus 5:  78.0%
  #2 GPT-5.6 Sol:    77.4%
  #3 GPT-5.6 Terra:  76.7%

Coding Agent Index v1.3 (artificialanalysis.ai, Aug 2026):
  #1 Claude Code + Opus 5 (xhigh): 67
  #1 Codex + GPT-5.6 Sol (max):    67  (EMPATADOS)
  #3 OpenCode + Muse Spark 1.1:    54
  #4 Cursor CLI + GPT-5.5:         46
  #5 Gemini CLI + Gemini 3.1 Pro:  30

Intelligence Index (artificialanalysis.ai, Aug 2026):
  #1 Claude Opus 5:  60.7
  #2 Claude Fable 5: 59.9
  #3 GPT-5.6 Sol:    58.9
  #4 Kimi K3:        57.1
  #5 Opus 4.8:       55.7
```

---

## Dados do ECC (⚠️ NECESSITA VERIFICAÇÃO INDEPENDENTE)

> O `ECC_INTEGRATION.md` no repo afirma "239K★". Este número NÃO foi verificado
> independentemente. O top repo do GitHub (build-your-own-x) tem 533K stars.
> 239K seria top 5 global. Trate este dado como **não confirmado** até verificação manual.

---

## Fallback Chain

```
Opus 5 indisponível → Sol (reasoning: max)
Sol indisponível   → Opus 5 (effort: medium)
Gemini indisponível → GPT-5.6 Luna ($0.20/$1.20 MTok)
Todos indisponíveis → Queue task, notificar via WhatsApp
```

---

## Audit Log

| Data | Ação | Resultado |
|------|------|----------|
| 2026-08-11 | Criação inicial (Brain Max) | Dados de benchmark incluídos |
| 2026-08-11 | Auditoria contra fontes oficiais | 2 imprecisões + 1 omissão detectadas |
| 2026-08-12 | Correções aplicadas | Sol "#1" → "empatado #1"; Gemini pricing tiered; custos marcados como projeção |
| 2026-08-12 | Antigravity removeu arquivos originais | Restaurado com dados verificados |

---

*Golden Trio Verified v2.0 — Q1 Digital*
*"Source-driven. Doubt-driven. Zero alucinação."*
