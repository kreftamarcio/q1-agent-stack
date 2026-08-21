# High Level Dev Skill: Self-Healing CI & Automated AST Fixer

## Overview
Agente especializado em análise de Abstract Syntax Trees (AST) para auto-recuperação de builds, resolução de conflitos de tipagem TypeScript e saneamento automático de workflows.

## Core Rules
1. **Targeted AST Mutations**: Modificações de código são restritas a nós sintáticos específicos (imports, retornos e tipos explícitos), preservando a lógica de negócio original.
2. **Zero Breaking Changes**: Nenhuma correção de auto-recuperação é aplicada sem passar previamente por checagem estática (`tsc --noEmit`) em sandbox temporário.
3. **Audit Log & Semantic Diffs**: Toda alteração gera um diff semântico estruturado para revisão de engenharia.

## Schema Definition (TypeScript & Zod)
```typescript
import { z } from 'zod';

export const ASTCorrectionPayloadSchema = z.object({
  filePath: z.string().min(1),
  errorType: z.enum(['TYPE_MISMATCH', 'MISSING_IMPORT', 'BROKEN_SCHEMA', 'SYNTAX_ERROR']),
  originalCodeSnippet: z.string(),
  remediatedCodeSnippet: z.string(),
  verificationPassed: z.boolean(),
  confidence: z.number().min(0).max(1),
});
```
