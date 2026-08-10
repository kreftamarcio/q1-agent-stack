#!/bin/bash
# ============================================================
# Q1 Digital — Project Bootstrap
# Run this inside ANY new repo to inject the full Q1 stack.
# Usage: curl -fsSL https://raw.githubusercontent.com/kreftamarcio/q1-agent-stack/main/bootstrap/init-project.sh | bash
# Or: q1-init (if aliased)
# ============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

step() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

echo ""
echo "══════════════════════════════════════════════════════"
echo "  Q1 Digital — Project Bootstrap"
echo "  Injecting full agent stack into this project"
echo "══════════════════════════════════════════════════════"
echo ""

STACK_REPO="https://raw.githubusercontent.com/kreftamarcio/q1-agent-stack/main"

# ─── 1. GEMINI.md (master agent config) ───
echo "── Injecting GEMINI.md ──"
curl -fsSL "$STACK_REPO/GEMINI.md" -o GEMINI.md
step "GEMINI.md created (anti-hallucination + loop rules + 7 agents)"

# ─── 2. Agents directory ───
echo ""
echo "── Injecting agents/ ──"
mkdir -p .gemini/agents
curl -fsSL "$STACK_REPO/agents/architect.md" -o .gemini/agents/q1-architect.md
curl -fsSL "$STACK_REPO/agents/developer.md" -o .gemini/agents/q1-developer.md
curl -fsSL "$STACK_REPO/agents/auditor.md" -o .gemini/agents/q1-auditor.md
curl -fsSL "$STACK_REPO/agents/debugger.md" -o .gemini/agents/q1-debugger.md
curl -fsSL "$STACK_REPO/agents/security.md" -o .gemini/agents/q1-security.md
curl -fsSL "$STACK_REPO/agents/deployer.md" -o .gemini/agents/q1-deployer.md
curl -fsSL "$STACK_REPO/agents/orchestrator.md" -o .gemini/agents/q1-orchestrator.md
step "7 loop agents installed to .gemini/agents/"

# ─── 3. Anti-hallucination skills ───
echo ""
echo "── Injecting anti-hallucination skills ──"
mkdir -p .gemini/skills/anti-hallucination-source-driven
mkdir -p .gemini/skills/anti-hallucination-adversarial-11
mkdir -p .gemini/skills/anti-hallucination-structured-output
mkdir -p .gemini/skills/anti-hallucination-doubt-driven
mkdir -p .gemini/skills/anti-hallucination-memory-anchor
mkdir -p .gemini/skills/anti-hallucination-clickup-brain
curl -fsSL "$STACK_REPO/skills/anti-hallucination-source-driven/SKILL.md" -o .gemini/skills/anti-hallucination-source-driven/SKILL.md
curl -fsSL "$STACK_REPO/skills/anti-hallucination-adversarial-11/SKILL.md" -o .gemini/skills/anti-hallucination-adversarial-11/SKILL.md
curl -fsSL "$STACK_REPO/skills/anti-hallucination-structured-output/SKILL.md" -o .gemini/skills/anti-hallucination-structured-output/SKILL.md
curl -fsSL "$STACK_REPO/skills/anti-hallucination-doubt-driven/SKILL.md" -o .gemini/skills/anti-hallucination-doubt-driven/SKILL.md
curl -fsSL "$STACK_REPO/skills/anti-hallucination-memory-anchor/SKILL.md" -o .gemini/skills/anti-hallucination-memory-anchor/SKILL.md
curl -fsSL "$STACK_REPO/skills/anti-hallucination-clickup-brain/SKILL.md" -o .gemini/skills/anti-hallucination-clickup-brain/SKILL.md
step "6 anti-hallucination skills installed"

# ─── 4. MCP config (project-level) ───
echo ""
echo "── Injecting MCP config ──"
curl -fsSL "$STACK_REPO/mcp_config.json" -o .gemini/mcp_config.json
step "MCP config (6 servers) installed"

# ─── 5. .env.example ───
echo ""
echo "── Creating .env.example ──"
if [ ! -f .env.example ]; then
  curl -fsSL "$STACK_REPO/.env.example" -o .env.example
  step ".env.example created"
else
  warn ".env.example already exists, skipping"
fi

# ─── 6. .gitignore update ───
echo ""
echo "── Updating .gitignore ──"
if [ -f .gitignore ]; then
  if ! grep -q ".env" .gitignore 2>/dev/null; then
    echo -e "\n# Secrets\n.env\n.env.local\n*.key" >> .gitignore
    step ".gitignore updated with secret patterns"
  else
    step ".gitignore already covers .env"
  fi
else
  echo -e "# Secrets\n.env\n.env.local\n*.key\n\n# Runtime\nnode_modules/\n.next/\n.vercel/\n__pycache__/\n\n# OS\n.DS_Store\nThumbs.db" > .gitignore
  step ".gitignore created"
fi

# ─── 7. Vercel project config ───
echo ""
echo "── Checking Vercel config ──"
if [ ! -f vercel.json ]; then
  cat > vercel.json << 'EOF'
{
  "framework": "nextjs",
  "buildCommand": "next build",
  "outputDirectory": ".next"
}
EOF
  step "vercel.json created (Next.js default)"
else
  step "vercel.json already exists"
fi

echo ""
echo "══════════════════════════════════════════════════════"
echo "  ✅ Project bootstrapped with Q1 Agent Stack!"
echo "══════════════════════════════════════════════════════"
echo ""
echo "This project now has:"
echo "  • GEMINI.md (anti-hallucination + loop engineering rules)"
echo "  • 7 loop agents (architect, developer, auditor, debugger, security, deployer, orchestrator)"
echo "  • 6 anti-hallucination skills"
echo "  • 6 MCP servers configured"
echo "  • Vercel deployment config"
echo ""
echo "Workflow:"
echo "  Mode Rápido:  /implement → /review → /git"
echo "  Mode Rigoroso: /oma:team-assemble → full loop (7 agents)"
echo ""
echo "Next steps:"
echo "  1. cp .env.example .env && fill tokens"
echo "  2. Open Antigravity in this directory"
echo "  3. Start: /oma:goal or /brainstorm"
echo ""
