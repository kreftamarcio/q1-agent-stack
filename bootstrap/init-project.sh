#!/bin/bash
# ============================================================
# Q1 Digital — Project Bootstrap
# Run this inside ANY new repo to inject the full Q1 stack.
# Supports: Antigravity, Claude Code, Codex, Cursor, Copilot
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
echo "  Q1 Digital — Project Bootstrap (Multi-IDE)"
echo "  Antigravity + Claude Code + Codex + Cursor + Copilot"
echo "══════════════════════════════════════════════════════"
echo ""

STACK_REPO="https://raw.githubusercontent.com/kreftamarcio/q1-agent-stack/main"

# ─── 1. Multi-IDE Config Files ───
echo "── Injecting IDE configs ──"
curl -fsSL "$STACK_REPO/GEMINI.md" -o GEMINI.md
curl -fsSL "$STACK_REPO/CLAUDE.md" -o CLAUDE.md
curl -fsSL "$STACK_REPO/AGENTS.md" -o AGENTS.md
step "GEMINI.md (Antigravity) + CLAUDE.md (Claude Code) + AGENTS.md (Codex/Copilot)"

# Cursor rules
mkdir -p .cursor/rules
curl -fsSL "$STACK_REPO/.cursor/rules/q1-stack.mdc" -o .cursor/rules/q1-stack.mdc
step ".cursor/rules/q1-stack.mdc (Cursor)"

# ─── 2. Agents directory (Antigravity format) ───
echo ""
echo "── Injecting 7 loop agents ──"
mkdir -p .gemini/agents
curl -fsSL "$STACK_REPO/agents/architect.md" -o .gemini/agents/q1-architect.md
curl -fsSL "$STACK_REPO/agents/developer.md" -o .gemini/agents/q1-developer.md
curl -fsSL "$STACK_REPO/agents/auditor.md" -o .gemini/agents/q1-auditor.md
curl -fsSL "$STACK_REPO/agents/debugger.md" -o .gemini/agents/q1-debugger.md
curl -fsSL "$STACK_REPO/agents/security.md" -o .gemini/agents/q1-security.md
curl -fsSL "$STACK_REPO/agents/deployer.md" -o .gemini/agents/q1-deployer.md
curl -fsSL "$STACK_REPO/agents/orchestrator.md" -o .gemini/agents/q1-orchestrator.md
step "7 agents installed to .gemini/agents/"

# ─── 3. Anti-hallucination skills ───
echo ""
echo "── Injecting anti-hallucination skills ──"
SKILLS=("source-driven" "adversarial-11" "structured-output" "doubt-driven" "memory-anchor" "clickup-brain")
for skill in "${SKILLS[@]}"; do
  mkdir -p ".gemini/skills/anti-hallucination-${skill}"
  curl -fsSL "$STACK_REPO/skills/anti-hallucination-${skill}/SKILL.md" -o ".gemini/skills/anti-hallucination-${skill}/SKILL.md"
done
step "6 anti-hallucination skills installed"

# ─── 4. MCP config ───
echo ""
echo "── Injecting MCP config ──"
curl -fsSL "$STACK_REPO/mcp_config.json" -o .gemini/mcp_config.json
step "6 MCP servers configured"

# ─── 5. .env.example ───
echo ""
if [ ! -f .env.example ]; then
  curl -fsSL "$STACK_REPO/.env.example" -o .env.example
  step ".env.example created"
else
  warn ".env.example already exists"
fi

# ─── 6. .gitignore ───
if [ ! -f .gitignore ]; then
  echo -e "# Secrets\n.env\n.env.local\n*.key\n\n# Runtime\nnode_modules/\n.next/\n.vercel/\n__pycache__/\n\n# OS\n.DS_Store\nThumbs.db" > .gitignore
  step ".gitignore created"
else
  if ! grep -q ".env" .gitignore 2>/dev/null; then
    echo -e "\n# Secrets\n.env\n.env.local\n*.key" >> .gitignore
    step ".gitignore updated"
  fi
fi

# ─── 7. Vercel config ───
if [ ! -f vercel.json ]; then
  echo '{"framework":"nextjs","buildCommand":"next build","outputDirectory":".next"}' > vercel.json
  step "vercel.json created"
fi

echo ""
echo "══════════════════════════════════════════════════════"
echo "  ✅ Project bootstrapped! (Multi-IDE)"
echo "══════════════════════════════════════════════════════"
echo ""
echo "IDE support:"
echo "  • Antigravity/Gemini → reads GEMINI.md + .gemini/"
echo "  • Claude Code        → reads CLAUDE.md + agents/"
echo "  • Codex/Copilot      → reads AGENTS.md"
echo "  • Cursor             → reads .cursor/rules/q1-stack.mdc"
echo ""
echo "Next steps:"
echo "  1. cp .env.example .env && fill tokens"
echo "  2. npm install"
echo "  3. Open your IDE in this directory"
echo "  4. Antigravity: /oma:team-assemble"
echo "     Claude Code: use agents/ for subagent spawning"
echo "     Cursor: rules auto-apply on all TS/TSX files"
echo ""
