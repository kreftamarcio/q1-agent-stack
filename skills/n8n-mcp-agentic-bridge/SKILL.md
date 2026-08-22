# High Level Dev Skill: N8N-MCP Agentic Bridge

## Overview
Ponte padronizada entre workflows do n8n e servidores MCP (Model Context Protocol). Permite que agentes e sub-grafos do n8n invoquem ferramentas de infraestrutura com validação de tipos e controle de concorrência.

## Core Rules
1. **Strict Tool Call Mapping**: Toda chamada de ferramenta via n8n para o ecossistema MCP é traduzida para contratos JSON-RPC 2.0 determinísticos.
2. **Token & Rate Mesh Gating**: O nó interceptor do n8n consulta o rate mesh antes do despacho para evitar estouro de cotas e erros de timeout em LLMs.
3. **Safe Memory Context Handoff**: Parâmetros de contexto e memória semântica repassados pelo n8n passam por sanitização prévia contra prompt injection.

## Schema Definition (TypeScript & Zod)
```typescript
import { z } from 'zod';

export const N8NMCPToolInvocationSchema = z.object({
  toolName: z.string().min(1),
  serverTarget: z.enum(['q1-core-mcp', 'github-mcp', 'clickup-mcp', 'storage-mcp']),
  arguments: z.record(z.unknown()),
  timeoutMs: z.number().int().positive().default(15000),
});

export const N8NMCPResponseSchema = z.object({
  status: z.enum(['SUCCESS', 'TOOL_ERROR', 'TIMEOUT']),
  data: z.unknown(),
  sanitized: z.literal(true),
  executionTimeMs: z.number().nonnegative(),
});
```

## Integration
- Integração plug-and-play para pipelines n8n, WhatsApp API e C-Suite AI da Q1 Digital.
