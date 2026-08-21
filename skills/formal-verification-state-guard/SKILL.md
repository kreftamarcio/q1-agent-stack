# Ultra Hard Dev Skill: Formal Verification & Invariant State Guard

## Overview
Engine determinística de checagem formal e invariantes em tempo de execução para fluxos agênticos críticos. Bloqueia corrupção de estado, inconsistência de dados transacionais e mutações não autorizadas.

## Core Rules
1. **Invariant Assertion**: Antes e depois de cada chamada de tool ou mutação de contexto, o estado do agente é validado contra asserções matemáticas e tipos estritos.
2. **Atomic Rollback**: Se qualquer invariante falhar, a transação agêntica sofre rollback imediato com emissão de log auditável e isolamento do nó.
3. **Formal Pre/Post Conditions**: Toda tool registrada define pré-condições necessárias e pós-condições garantidas via contratos Zod.

## Schema Definition (TypeScript & Zod)
```typescript
import { z } from 'zod';

export const InvariantRuleSchema = z.object({
  id: z.string().min(1),
  name: z.string().min(1),
  assertionType: z.enum(['PRE_CONDITION', 'POST_CONDITION', 'STATE_IMMUTABILITY']),
  severity: z.enum(['CRITICAL', 'BLOCKING', 'WARNING']),
  evaluate: z.function().args(z.record(z.any())).returns(z.boolean()),
});

export const GuardedExecutionResultSchema = z.object({
  executionId: z.string().uuid(),
  status: z.enum(['PASSED', 'FAILED_ROLLBACK', 'REJECTED']),
  violatedInvariants: z.array(z.string()),
  timestamp: z.string().datetime(),
});
```

## Security & Compliance
- Licença permissiva (MIT / Apache 2.0).
- Zero chamadas externas desnecessárias.
- Validação estrita em tempo de execução no runtime Node 20+.
