#!/bin/bash
# ============================================================
# Q1 Digital — ECC Skills Installer for Antigravity + Gemini
# Cherry-picks the best ECC skills for ClickUp + Gemini workflow
# ============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

step() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

echo "══════════════════════════════════════════════════"
echo "  ECC Skills Installer for Q1 Digital"
echo "  (Antigravity + Gemini + ClickUp)"
echo "══════════════════════════════════════════════════"
echo ""

SKILLS_DIR="${HOME}/.gemini/antigravity/skills"
ECC_TEMP="/tmp/ecc-clone"

# Clone ECC
echo "Cloning ECC repository..."
if [ -d "$ECC_TEMP" ]; then
  rm -rf "$ECC_TEMP"
fi
git clone --depth 1 https://github.com/affaan-m/ECC.git "$ECC_TEMP"
step "ECC cloned"

# Create skills directory
mkdir -p "$SKILLS_DIR"

# ─── CORE: Project & Workflow ───
echo ""
echo "── Installing Core Workflow Skills ──"
SKILLS_CORE=(
  "project-flow-ops"
  "plan-orchestrate"
  "plan-canvas"
  "delivery-gate"
  "production-audit"
  "team-agent-orchestration"
  "github-ops"
  "dynamic-workflow-mode"
)
for skill in "${SKILLS_CORE[@]}"; do
  if [ -d "$ECC_TEMP/skills/$skill" ]; then
    cp -r "$ECC_TEMP/skills/$skill" "$SKILLS_DIR/"
    step "$skill"
  else
    warn "$skill not found, skipping"
  fi
done

# ─── COST OPTIMIZATION ───
echo ""
echo "── Installing Cost Optimization Skills ──"
SKILLS_COST=(
  "cost-tracking"
  "cost-aware-llm-pipeline"
  "context-budget"
  "strategic-compact"
  "token-budget-advisor"
  "prompt-optimizer"
  "connections-optimizer"
)
for skill in "${SKILLS_COST[@]}"; do
  if [ -d "$ECC_TEMP/skills/$skill" ]; then
    cp -r "$ECC_TEMP/skills/$skill" "$SKILLS_DIR/"
    step "$skill"
  else
    warn "$skill not found, skipping"
  fi
done

# ─── PERSISTENT MEMORY ───
echo ""
echo "── Installing Memory Skills ──"
SKILLS_MEMORY=(
  "unified-memory"
  "continuous-learning"
  "continuous-learning-v2"
  "knowledge-ops"
)
for skill in "${SKILLS_MEMORY[@]}"; do
  if [ -d "$ECC_TEMP/skills/$skill" ]; then
    cp -r "$ECC_TEMP/skills/$skill" "$SKILLS_DIR/"
    step "$skill"
  else
    warn "$skill not found, skipping"
  fi
done

# ─── SECURITY ───
echo ""
echo "── Installing Security Skills ──"
SKILLS_SECURITY=(
  "security-scan"
  "security-review"
  "security-bounty-hunter"
  "gateguard"
  "safety-guard"
)
for skill in "${SKILLS_SECURITY[@]}"; do
  if [ -d "$ECC_TEMP/skills/$skill" ]; then
    cp -r "$ECC_TEMP/skills/$skill" "$SKILLS_DIR/"
    step "$skill"
  else
    warn "$skill not found, skipping"
  fi
done

# ─── DEVELOPMENT (TypeScript/Next.js/React) ───
echo ""
echo "── Installing Development Skills ──"
SKILLS_DEV=(
  "react-patterns"
  "react-performance"
  "react-testing"
  "nextjs-turbopack"
  "frontend-patterns"
  "frontend-a11y"
  "backend-patterns"
  "api-design"
  "prisma-patterns"
  "docker-patterns"
  "error-handling"
  "git-workflow"
  "e2e-testing"
  "python-patterns"
  "fastapi-patterns"
  "tdd-workflow"
  "verification-loop"
  "coding-standards"
  "database-migrations"
  "deployment-patterns"
)
for skill in "${SKILLS_DEV[@]}"; do
  if [ -d "$ECC_TEMP/skills/$skill" ]; then
    cp -r "$ECC_TEMP/skills/$skill" "$SKILLS_DIR/"
    step "$skill"
  else
    warn "$skill not found, skipping"
  fi
done

# ─── MARKETING & BUSINESS ───
echo ""
echo "── Installing Marketing & Business Skills ──"
SKILLS_MARKETING=(
  "marketing-campaign"
  "seo"
  "social-publisher"
  "content-engine"
  "brand-voice"
  "market-research"
  "lead-intelligence"
  "investor-materials"
  "deep-research"
)
for skill in "${SKILLS_MARKETING[@]}"; do
  if [ -d "$ECC_TEMP/skills/$skill" ]; then
    cp -r "$ECC_TEMP/skills/$skill" "$SKILLS_DIR/"
    step "$skill"
  else
    warn "$skill not found, skipping"
  fi
done

# ─── DESIGN & UI ───
echo ""
echo "── Installing Design & UI Skills ──"
SKILLS_DESIGN=(
  "design-system"
  "liquid-glass-design"
  "frontend-design-direction"
  "make-interfaces-feel-better"
  "dashboard-builder"
  "frontend-slides"
)
for skill in "${SKILLS_DESIGN[@]}"; do
  if [ -d "$ECC_TEMP/skills/$skill" ]; then
    cp -r "$ECC_TEMP/skills/$skill" "$SKILLS_DIR/"
    step "$skill"
  else
    warn "$skill not found, skipping"
  fi
done

# ─── AI & AGENTS ───
echo ""
echo "── Installing AI & Agent Skills ──"
SKILLS_AI=(
  "agentic-engineering"
  "autonomous-agent-harness"
  "autonomous-loops"
  "cost-aware-llm-pipeline"
  "mcp-server-patterns"
  "agent-harness-construction"
  "agent-self-evaluation"
  "eval-harness"
)
for skill in "${SKILLS_AI[@]}"; do
  if [ -d "$ECC_TEMP/skills/$skill" ]; then
    cp -r "$ECC_TEMP/skills/$skill" "$SKILLS_DIR/"
    step "$skill"
  else
    warn "$skill not found, skipping"
  fi
done

# ─── ORCHESTRATION ───
echo ""
echo "── Installing Orchestration Skills ──"
SKILLS_ORCH=(
  "orch-add-feature"
  "orch-build-mvp"
  "orch-fix-defect"
  "orch-refine-code"
  "orch-pipeline"
  "orch-change-feature"
)
for skill in "${SKILLS_ORCH[@]}"; do
  if [ -d "$ECC_TEMP/skills/$skill" ]; then
    cp -r "$ECC_TEMP/skills/$skill" "$SKILLS_DIR/"
    step "$skill"
  else
    warn "$skill not found, skipping"
  fi
done

# ─── Copy Agents ───
echo ""
echo "── Installing ECC Agents ──"
AGENTS_DIR="${HOME}/.gemini/antigravity/agents"
mkdir -p "$AGENTS_DIR"

AGENTS=(
  "architect.md"
  "code-architect.md"
  "code-reviewer.md"
  "code-explorer.md"
  "code-simplifier.md"
  "typescript-reviewer.md"
  "react-reviewer.md"
  "react-build-resolver.md"
  "fastapi-reviewer.md"
  "python-reviewer.md"
  "build-error-resolver.md"
  "security-reviewer.md"
  "silent-failure-hunter.md"
  "planner.md"
  "chief-of-staff.md"
  "loop-operator.md"
  "performance-optimizer.md"
  "marketing-agent.md"
  "seo-specialist.md"
  "tdd-guide.md"
  "harness-optimizer.md"
)
for agent in "${AGENTS[@]}"; do
  if [ -f "$ECC_TEMP/agents/$agent" ]; then
    cp "$ECC_TEMP/agents/$agent" "$AGENTS_DIR/"
    step "Agent: $agent"
  else
    warn "Agent $agent not found, skipping"
  fi
done

# ─── Copy ECC GEMINI.md ───
echo ""
echo "── Installing ECC GEMINI.md baseline ──"
if [ -f "$ECC_TEMP/.gemini/GEMINI.md" ]; then
  cp "$ECC_TEMP/.gemini/GEMINI.md" "${HOME}/.gemini/ecc-baseline-gemini.md"
  step "ECC GEMINI.md saved as ecc-baseline-gemini.md (reference)"
fi

# Cleanup
rm -rf "$ECC_TEMP"
step "Cleaned up temp files"

echo ""
echo "══════════════════════════════════════════════════"
echo "  ✅ ECC Skills Installation Complete!"
echo "══════════════════════════════════════════════════"
echo ""
echo "Installed to: $SKILLS_DIR"
echo ""
echo "Skills installed by category:"
echo "  • Core Workflow: ${#SKILLS_CORE[@]} skills"
echo "  • Cost Optimization: ${#SKILLS_COST[@]} skills"
echo "  • Memory: ${#SKILLS_MEMORY[@]} skills"
echo "  • Security: ${#SKILLS_SECURITY[@]} skills"
echo "  • Development: ${#SKILLS_DEV[@]} skills"
echo "  • Marketing: ${#SKILLS_MARKETING[@]} skills"
echo "  • Design: ${#SKILLS_DESIGN[@]} skills"
echo "  • AI & Agents: ${#SKILLS_AI[@]} skills"
echo "  • Orchestration: ${#SKILLS_ORCH[@]} skills"
echo "  • Agents: ${#AGENTS[@]} agents"
echo ""
echo "Total: ~75 skills + 21 agents from ECC"
echo ""
echo "Combined with existing q1-agent-stack:"
echo "  246+ skills | 122+ commands | 74+ agents | 31+ MCP tools"
echo ""
echo "Restart Antigravity CLI (agy) to load new skills."
echo ""
