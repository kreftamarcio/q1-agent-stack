# Vercel Skills

Skills de deploy e infraestrutura Vercel. Instaladas via `./install-vercel.sh`.

---

## Fontes

| Fonte | Licença | Skills | Agents | Commands |
|-------|---------|--------|--------|----------|
| vercel/vercel-plugin | MIT | 32 | 3 | 4 |
| vercel-labs/agent-skills | MIT | 9 | 0 | 0 |
| **Total** | | **41** | **3** | **4** |

---

## Skills Disponíveis (após install)

| Skill | Propósito | Quando usar |
|-------|----------|-------------|
| **ai-sdk** | Vercel AI SDK: streaming, chat, tools | Qualquer feature com LLM |
| **ai-gateway** | AI routing, caching, rate limiting | Multi-model routing em produção |
| **vercel-storage** | Blob, KV, Postgres, Supabase, Neon | Persistência de dados |
| **vercel-functions** | Serverless + Edge Functions | API routes, webhooks |
| **deployments-cicd** | Deploy, rollback, promote | CI/CD pipeline |
| **auth** | Clerk, NextAuth, Auth0, Better Auth | Autenticação (OTP no q1-clinic-booking) |
| **next-forge** | Monorepo @repo/* packages | Projetos multi-app |
| **workflow** | Vercel Workflow SDK: durable functions | Background jobs, filas |
| **shadcn** | UI components (Radix + Tailwind) | Interface do paciente |
| **vercel-firewall** | WAF, DDoS protection | Segurança em produção |

---

## Agents

| Agent | Função |
|-------|--------|
| ai-architect | Arquitetura AI na Vercel (model routing, streaming) |
| deployment-expert | Gestão de deploys (preview, production, rollback) |
| performance-optimizer | Performance tuning (edge, caching, ISR, PPR) |

---

## Commands

| Command | O que faz |
|---------|----------|
| `/bootstrap` | Setup de novo projeto Vercel |
| `/deploy` | Deploy pra Vercel |
| `/env` | Gerenciar environment variables |
| `/status` | Checar status do deploy |

---

## Uso no q1-clinic-booking

| Necessidade | Skill Vercel | Detalhe |
|---|---|---|
| Deploy frontend paciente | deployments-cicd | Preview + production |
| API routes (OTP, booking) | vercel-functions | Edge pra baixa latência |
| Cache de horários | vercel-storage (KV) | TTL curto pra disponibilidade |
| Proteção contra abuso | vercel-firewall | Rate limit no OTP |
| UI de agendamento | shadcn | Componentes acessíveis |
| Background jobs | workflow | Envio de lembretes via WhatsApp |
| AI features futuras | ai-sdk + ai-gateway | Chatbot de triagem |

---

## Instalação

```bash
./install-vercel.sh
```

Requer Antigravity CLI (`agy`) instalado. Se não disponível, clone manual:
```bash
git clone https://github.com/vercel/vercel-plugin.git ~/.gemini/plugins/vercel-plugin
npx skills add vercel-labs/agent-skills
```
