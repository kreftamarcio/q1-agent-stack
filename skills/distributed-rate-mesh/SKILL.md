# Ultra Hard Dev Skill: Distributed Multi-Tenant Rate Mesh

## Overview
Controlador distribuído de vazão, alocação de tokens e roteamento de failover multi-provedor (Groq, Anthropic, Gemini, OpenAI) com tolerância a falhas.

## Core Rules
1. **Token-Bucket Concurrency**: Controle em tempo real de TPM (tokens por minuto) e RPM (requisições por minuto) por tenant e por modelo.
2. **Adaptive Backoff & Circuit Breaker**: Bloqueio automático de endpoints com latência excessiva ou erros 429/500, roteando tráfego para provedores secundários sem downtime.
3. **Deterministic Fair Sharing**: Garantia de alocação balanceada para múltiplos agentes concorrentes no mesmo cluster.

## Schema Definition (TypeScript & Zod)
```typescript
import { z } from 'zod';

export const RateLimitConfigSchema = z.object({
  tenantId: z.string().min(1),
  provider: z.enum(['GROQ', 'ANTHROPIC', 'GEMINI', 'OPENAI']),
  maxRpm: z.number().int().positive(),
  maxTpm: z.number().int().positive(),
  circuitBreakerThreshold: z.number().min(1).max(10).default(3),
});

export const RouteDecisionSchema = z.object({
  allowed: z.boolean(),
  targetProvider: z.string(),
  estimatedLatencyMs: z.number().nonnegative(),
  throttleDelayMs: z.number().nonnegative().default(0),
});
```
