# High Level Dev Skill: Zero-Leak Semantic Memory Router

## Overview
Protocolo avançado de roteamento semântico e injeção de contexto de alta densidade sem vazamento de segredos, PII ou alucinação de dados cadastrais.

## Core Rules
1. **Context Boundary Enforcement**: O roteador semântico valida escopos de permissão e isolamento de tenant antes de injetar memórias no contexto de LLMs.
2. **Secret Scrubbing (AST Level)**: Toda entrada textual passa por sanitização estrita para remoção de chaves de API, credenciais e tokens sensíveis antes de qualquer vetorização ou persistência.
3. **Deterministic Retrieval Check**: O retorno semântico exige um score mínimo de similaridade com penalidade exponencial para memórias sem âncora de data ou fonte explícita.

## Schema Definition (TypeScript & Zod)
```typescript
import { z } from 'zod';

export const MemoryAnchorSchema = z.object({
  sourceId: z.string().min(1),
  sourceType: z.enum(['CLICKUP_DOC', 'CLICKUP_TASK', 'GITHUB_REPO', 'INTERNAL_STORE']),
  timestamp: z.string().datetime(),
  confidenceScore: z.number().min(0).max(1),
  verified: z.boolean(),
});

export const SemanticMemoryPayloadSchema = z.object({
  contextKey: z.string().min(1),
  content: z.string().min(1),
  anchor: MemoryAnchorAnchorSchema,
  sanitized: z.literal(true),
});
```

## Integration
- Projetado para o ecossistema C-Suite AI e MCP da Q1 Digital.
- Execução isolada com tipagem estrita no runtime do Node 20+.
