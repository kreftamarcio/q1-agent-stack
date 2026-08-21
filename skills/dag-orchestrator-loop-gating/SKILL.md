# Ultra Hard Dev Skill: Formal DAG Orchestrator & Loop Gating

## Overview
Protocolo determinístico para orquestração de pipelines e grafos acíclicos dirigidos (DAGs) em arquiteturas multi-agente. Impede loops infinitos, resolve concorrência com idempotência e aplica validação de contrato de estado em tempo de execução.

## Core Rules
1. **Zero Unchecked Cycles**: Todo grafo de execução deve possuir limite rígido de profundidade de recursão (`max_depth = 5`) e validação topológica de dependências antes da execução.
2. **State Immutability**: Estados intermediários gerados por agentes devem ser propagados via snapshots imutáveis com checksum criptográfico (SHA-256).
3. **Contract Gating**: Nenhuma transição de nó no grafo é autorizada sem validação Zod do payload de saída do nó anterior.
4. **Idempotency Guarantee**: Cada nó de execução aceita `idempotency_key` obrigatório, impedindo reexecuções de efeitos colaterais em retentativas.

## Schema Definition (TypeScript & Zod)
```typescript
import { z } from 'zod';

export const DAGNodeSchema = z.object({
  id: z.string().uuid(),
  name: z.string().min(1),
  dependencies: z.array(z.string().uuid()),
  maxRetries: z.number().int().min(0).max(3).default(1),
  timeoutMs: z.number().int().positive().default(30000),
  payloadSchema: z.record(z.any()),
});

export const DAGExecutionPlanSchema = z.object({
  planId: z.string().uuid(),
  nodes: z.array(DAGNodeSchema),
  strictQuorum: z.boolean().default(true),
  executionState: z.enum(['PENDING', 'RUNNING', 'COMPLETED', 'FAILED']),
});
```

## Security & Compliance
- MIT / Apache 2.0 compatible.
- Zero external unverified network calls.
- Totalmente compatível com MCP servers e Antigravity.
