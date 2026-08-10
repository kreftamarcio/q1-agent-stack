# Vercel Skills — Complete Integration

> 32 skills + 3 agents + 4 commands do plugin oficial da Vercel.
> Integrado com Antigravity (Gemini) + ClickUp Brain pra operação global.

## Instalação

```bash
# Plugin oficial Vercel (32 skills + 3 agents + 4 commands)
agy plugin install https://github.com/vercel/vercel-plugin

# vercel-labs skills adicionais
npx skills add vercel-labs/agent-skills
```

## As 32 Skills Oficiais (por prioridade)

### Priority 10 (crítica)
| Skill | Função |
|-------|--------|
| `knowledge-update` | Atualiza knowledge graph do agente sobre Vercel |

### Priority 9 (core workflow)
| Skill | Função |
|-------|--------|
| `workflow` | Vercel Workflow SDK (`@vercel/workflow`): durable functions, step functions |

### Priority 8 (features críticas)
| Skill | Função |
|-------|--------|
| `access-protected-vercel-deployment` | Acesso a deploys protegidos via OIDC/bypass |
| `ai-sdk` | Vercel AI SDK: useChat, useCompletion, streaming, tools |
| `bootstrap` | Setup de projetos: .env, db:push, vercel link, auth |
| `chat-sdk` | Bots: Slack, Teams, Discord, Telegram, GitHub, Linear |
| `eve` | Vercel EVE: agent channels, evals, agent-runs |
| `vercel-functions` | Serverless + Edge Functions, route handlers |

### Priority 7 (infraestrutura)
| Skill | Função |
|-------|--------|
| `ai-gateway` | AI Gateway: routing, caching, rate limiting |
| `env-vars` | Environment variables: pull, add, rm, ls |
| `microfrontends` | Micro-frontends architecture |
| `vercel-firewall` | WAF, DDoS protection |
| `vercel-services` | Todos os serviços Vercel (local dev) |
| `vercel-storage` | Blob, KV, Postgres, Edge Config, Supabase, Prisma, Neon, Upstash |
| `verification` | Verificação de deploys (dev servers) |

### Priority 6 (patterns)
| Skill | Função |
|-------|--------|
| `auth` | Clerk, Auth0, Descope, NextAuth, Better Auth |
| `cdn-caching` | CDN cache purge/invalidate |
| `deployments-cicd` | CI/CD: deploy, promote, rollback, GitHub Actions |
| `next-cache-components` | Cache de componentes Next.js |
| `next-forge` | next-forge monorepo (@repo/* packages) |
| `next-upgrade` | Upgrade Next.js com codemods |
| `routing-middleware` | Middleware, rewrites, redirects |
| `runtime-cache` | Cache em runtime (@vercel/functions) |
| `shadcn` | shadcn/ui: init, add, components |

### Priority 5 (base)
| Skill | Função |
|-------|--------|
| `nextjs` | Next.js core: App Router, Pages, Turbopack |
| `vercel-connect` | Vercel Connect: integrações e channels |

### Priority 4 (suporte)
| Skill | Função |
|-------|--------|
| `react-best-practices` | React components TSX patterns |
| `turbopack` | Turbopack: `next dev --turbo` |
| `vercel-agent` | GitHub workflows pra Vercel agent deploys |
| `vercel-cli` | CLI completa: deploy, dev, env, inspect |
| `vercel-sandbox` | Vercel Sandbox: execução segura |

### Priority 3
| Skill | Função |
|-------|--------|
| `marketplace` | Vercel Marketplace: integrations |

---

## 3 Agents Vercel

| Agent | Especialidade |
|-------|---------------|
| `ai-architect` | Arquitetura AI: AI SDK, Gateway, streaming, tools |
| `deployment-expert` | Deploys: preview, production, rollback, promote |
| `performance-optimizer` | Performance: CDN, cache, edge, ISR, Core Web Vitals |

## 4 Commands Vercel

| Command | Função |
|---------|--------|
| `/bootstrap` | Bootstrap de novo projeto Vercel |
| `/deploy` | Deploy pro Vercel |
| `/env` | Gestão de environment variables |
| `/status` | Status do deploy atual |

---

## Skills Extras (vercel-labs/agent-skills)

| Skill | Função |
|-------|--------|
| `deploy-to-vercel` | Deploy automatizado via agente |
| `vercel-cli-with-tokens` | CLI com auth tokens pra automação |
| `vercel-optimize` | Otimização de projetos Vercel |
| `react-best-practices` | React patterns (Vercel-approved) |
| `react-view-transitions` | View Transitions API |
| `web-design-guidelines` | Guidelines de web design |
| `composition-patterns` | Component composition |
| `react-native-skills` | React Native |
| `writing-guidelines` | Escrita técnica |

---

## Integração: Vercel + Antigravity + ClickUp

### Workflow de Deploy Global

```
1. ClickUp Task (feature request)
   │
2. ClickUp Brain: triagem + priorização
   │
3. Antigravity (Gemini): implementação
   │  ├─ source-driven: fetch Next.js docs via git-mcp
   │  ├─ ai-sdk skill: implementa streaming/chat
   │  ├─ vercel-storage: configura Blob/KV/Postgres
   │  ├─ auth skill: configura Clerk/NextAuth
   │  └─ shadcn skill: UI components
   │
4. Verificação:
   │  ├─ adversarial-verify (11-shortcut check)
   │  ├─ verification skill: `next dev` + `next build`
   │  └─ performance-optimizer agent: Core Web Vitals
   │
5. Deploy:
   │  ├─ /deploy command → Vercel preview
   │  ├─ deployment-expert agent: verifica preview
   │  └─ deployments-cicd: promote to production
   │
6. Pós-deploy:
   │  ├─ clickup-agent run set-status --status "done"
   │  ├─ clickup-agent run dev-sync (link deploy URL)
   │  └─ cdn-caching: invalidate se necessário
```

### Como cada ferramenta opera:

| Fase | Antigravity (Gemini) | ClickUp Brain | Vercel |
|------|---------------------|---------------|--------|
| Planejamento | /spec + /plan | Triagem, priorização, deps | - |
| Implementação | Código + TDD | Work-log, decision-log | - |
| Build | `next build` via verification skill | - | Turbopack |
| Deploy | /deploy command | Status update | Preview + Production |
| Monitor | - | Sprint status | Performance metrics |
| Hotfix | adversarial-verify + /build | Escalation via comment | Rollback + redeploy |

### Ambiente de Produção (Vercel Créditos)

- US$ 2.400 em créditos Vercel (Vercel for Startups)
- Usar `vercel-storage` skill pra Postgres/Blob (incluso nos créditos)
- Usar `ai-gateway` skill pra AI routing (economiza tokens Gemini)
- Usar `cdn-caching` skill pra ISR + edge caching
- Usar `vercel-firewall` pra WAF em produção

---

## Licenças

| Repo | Licença | Status |
|------|---------|--------|
| vercel/vercel-plugin | Apache 2.0 | ✅ Livre |
| vercel-labs/agent-skills | MIT | ✅ Livre |
| better-design (MCP) | MIT | ✅ Livre |

---

## Números Totais do Stack (com Vercel)

| Métrica | Antes | Agora |
|---------|-------|-------|
| Skills totais | ~280 | **321+** |
| Skills Vercel | 0 | **41** |
| Agents totais | 74+ | **77+** |
| Commands totais | 122+ | **126+** |
| MCP Servers | 6 | **6** (Vercel opera via plugin, não MCP) |
