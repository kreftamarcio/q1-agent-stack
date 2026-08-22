# Ultra Hard Dev Skill: N8N Deterministic Workflow & Payload Guard

## Overview
Protocolo determinístico para validação e execução de workflows no n8n. Garante integridade de webhooks, tipagem estrita de nós (Zod), idempotência transacional e blindagem contra payloads corrompidos ou alucinados.

## Core Rules
1. **Zero Unvalidated Webhooks**: Todo webhook recebido ou despachado pelo n8n passa por schema gate estrito (Zod). Payloads fora do schema são rejeitados com HTTP 422 e log estruturado.
2. **Idempotent Execution Key**: Execuções utilizam hash criptográfico (`sha256(payload + timestamp_bucket)`) para impedir reprocessamento de webhooks duplicados.
3. **Dead-Letter Queue (DLQ) & Circuit Breaker**: Nós com falhas repetidas (HTTP 429/500) ativam circuit breaker e desviam o payload para fila de quarentena sem interromper a esteira principal.
4. **Deterministic Sub-Node Routing**: Rotas condicionais (If/Switch) exigem verificação exata de tipo, impedindo casting implícito de dados (`string` vs `number`).

## Schema Definition (TypeScript & Zod)
```typescript
import { z } from 'zod';

export const N8NWebhookHeaderSchema = z.object({
  'x-idempotency-key': z.string().min(16),
  'x-signature': z.string().min(32),
  'content-type': z.literal('application/json'),
});

export const N8NExecutionPayloadSchema = z.object({
  workflowId: z.string().min(1),
  executionId: z.string().min(1),
  timestamp: z.string().datetime(),
  nodeInputs: z.record(z.unknown()),
  retryCount: z.number().int().min(0).max(3).default(0),
});

export const N8NExecutionResultSchema = z.object({
  success: z.boolean(),
  executionId: z.string().min(1),
  outputData: z.record(z.unknown()).optional(),
  errorCode: z.string().optional(),
  circuitBreakerTripped: z.boolean().default(false),
});
```

## Compliance & Security
- 100% aderente a licenças permissivas (MIT / Apache 2.0).
- Zero dados sensíveis expostos em logs de execução.
- Compatível nativamente com instâncias n8n auto-hospedadas e Vercel Serverless.
