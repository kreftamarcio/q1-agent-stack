#!/bin/bash
# ============================================================
# Q1 Digital — Complete Agent Stack Installer
# Installs: context-mode, oh-my-antigravity, agent-skills,
#           SuperAntigravity, antigravity-skills vault,
#           clickup-agentic-native, github-mcp-server, git-mcp,
#           code-reasoning, COG skills, loopkit skills
# ============================================================

set -e

echo "════════════════════════════════════════════════════════"
echo "  Q1 Digital — Complete Agent Stack Installer"
echo "════════════════════════════════════════════════════════"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

step() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

# ─── Prerequisites ───────────────────────────────────────────
echo "Checking prerequisites..."
command -v node >/dev/null 2>&1 || { echo "Node.js required. Install: https://nodejs.org"; exit 1; }
command -v npm >/dev/null 2>&1 || { echo "npm required."; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo "Python 3 required."; exit 1; }
step "Prerequisites OK (node $(node -v), npm $(npm -v), python3)"

# ─── 1. Context Mode (saves 98% tokens) ─────────────────────
echo ""
echo "── Step 1/9: Installing context-mode ──"
npm install -g context-mode
step "context-mode installed globally"

# ─── 2. Oh-My-Antigravity (multi-agent orchestration) ────────
echo ""
echo "── Step 2/9: Installing oh-my-antigravity ──"
if command -v agy >/dev/null 2>&1; then
  agy plugin install https://github.com/Joonghyun-Lee-Frieren/oh-my-antigravity
  step "oh-my-antigravity installed as Antigravity plugin"
else
  warn "Antigravity CLI (agy) not found. Install it first: https://antigravity.google"
  warn "Then run: agy plugin install https://github.com/Joonghyun-Lee-Frieren/oh-my-antigravity"
fi

# ─── 3. Agent Skills (Addy Osmani — SDLC lifecycle) ──────────
echo ""
echo "── Step 3/9: Installing agent-skills (Addy Osmani) ──"
if command -v agy >/dev/null 2>&1; then
  agy plugin install https://github.com/addyosmani/agent-skills.git
  step "agent-skills installed as Antigravity plugin"
else
  npx skills add addyosmani/agent-skills
  step "agent-skills installed via npx skills"
fi

# ─── 4. SuperAntigravity (Superpowers + SuperClaude) ─────────
echo ""
echo "── Step 4/9: Installing SuperAntigravity ──"
curl -fsSL https://raw.githubusercontent.com/derHaken/SuperAntigravity/main/install.sh | bash
step "SuperAntigravity installed (19 skills + 16 commands + 8 agents)"

# ─── 5. Antigravity Skills Vault (300+ skills) ───────────────
echo ""
echo "── Step 5/9: Installing antigravity-skills vault (core bundles) ──"
npx @rmyndharis/antigravity-skills install --bundle core-dev
npx @rmyndharis/antigravity-skills install --bundle security-core
npx @rmyndharis/antigravity-skills install typescript-pro
npx @rmyndharis/antigravity-skills install nextjs-app-router-patterns
npx @rmyndharis/antigravity-skills install react-modernization
npx @rmyndharis/antigravity-skills install fastapi-pro
npx @rmyndharis/antigravity-skills install api-design-principles
npx @rmyndharis/antigravity-skills install security-auditor
npx @rmyndharis/antigravity-skills install conductor-implement
npx @rmyndharis/antigravity-skills install context-driven-development
step "antigravity-skills vault: core-dev + security-core + 8 individual skills installed"

# ─── 6. ClickUp Agentic Native (ClickUp↔GitHub bridge) ──────
echo ""
echo "── Step 6/9: Installing clickup-agentic-native ──"
if command -v uv >/dev/null 2>&1; then
  git clone https://github.com/zenzenzen/clickup-agentic-native.git ~/.local/share/clickup-agent 2>/dev/null || true
  cd ~/.local/share/clickup-agent
  uv tool install . --python 3.12 --reinstall
  cd -
  step "clickup-agentic-native installed"
  warn "Run 'clickup-agent setup' to configure your API key"
else
  warn "uv not found. Install: curl -LsSf https://astral.sh/uv/install.sh | sh"
  warn "Then: git clone https://github.com/zenzenzen/clickup-agentic-native.git && uv tool install ."
fi

# ─── 7. GitHub MCP Server + git-mcp ───────────────────────
echo ""
echo "── Step 7/9: Installing GitHub MCP Server + git-mcp ──"
if command -v go >/dev/null 2>&1; then
  go install github.com/github/github-mcp-server@latest
  step "github-mcp-server installed via Go"
else
  warn "Go not found. Install github-mcp-server via Docker instead:"
  warn "  docker pull ghcr.io/github/github-mcp-server"
  warn "Or install Go: https://go.dev/dl/"
fi
# git-mcp runs via npx (no global install needed)
step "git-mcp available via npx (no install needed)"
step "code-reasoning available via npx (no install needed)"

# ─── 8. Context-mode plugin for Antigravity CLI ──────────────
echo ""
echo "── Step 8/9: Registering context-mode with Antigravity CLI ──"
if command -v agy >/dev/null 2>&1; then
  agy plugin install https://github.com/mksglu/context-mode/tree/main/configs/antigravity-cli
  step "context-mode registered as Antigravity CLI plugin"
else
  warn "Antigravity CLI not found, skipping plugin registration"
fi

# ─── 9. Loop + Harness Skills (COG + loopkit) ────────────────
echo ""
echo "── Step 9/9: Installing Loop Engineering + Harness Skills ──"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/install-loop-harness.sh" ]; then
  bash "$SCRIPT_DIR/install-loop-harness.sh"
else
  warn "install-loop-harness.sh not found. Run it separately."
fi

# ─── Copy configs ────────────────────────────────────────────
echo ""
echo "── Copying configuration files ──"

mkdir -p ~/.gemini
if [ ! -f ~/.gemini/settings.json ]; then
  cp "$SCRIPT_DIR/settings.json" ~/.gemini/settings.json
  step "settings.json copied to ~/.gemini/ (6 MCP servers + hooks)"
else
  warn "~/.gemini/settings.json exists. Merge from $SCRIPT_DIR/settings.json"
fi

if [ ! -f ~/.gemini/GEMINI.md ]; then
  cp "$SCRIPT_DIR/GEMINI.md" ~/.gemini/GEMINI.md
  step "GEMINI.md copied to ~/.gemini/ (global agent config)"
else
  warn "~/.gemini/GEMINI.md exists. Review $SCRIPT_DIR/GEMINI.md for updates"
fi

echo ""
echo "════════════════════════════════════════════════════════"
echo "  ✅ Complete Installation Done!"
echo "════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  1. Export tokens: export GH_TOKEN=ghp_... && export CLICKUP_API_KEY=pk_..."
echo "  2. Run 'clickup-agent setup' to configure ClickUp"
echo "  3. Run 'clickup-agent doctor --live-auth' to verify"
echo "  4. Restart Antigravity CLI (agy) to load all plugins"
echo "  5. Test: /oma:status or /oma:doctor"
echo ""
echo "Installed stack:"
echo "  • context-mode (98% token savings)"
echo "  • oh-my-antigravity (14 sub-agents, 30+ commands)"
echo "  • agent-skills (24 SDLC skills, /spec → /ship)"
echo "  • SuperAntigravity (19 auto-trigger skills + TDD)"
echo "  • antigravity-skills vault (300+ domain skills)"
echo "  • clickup-agentic-native (ClickUp↔GitHub MCP bridge)"
echo "  • github-mcp-server (repos, issues, PRs, security)"
echo "  • git-mcp (anti-hallucination via real docs)"
echo "  • code-reasoning (sequential thinking)"
echo "  • COG skills (loop-engineering, closed-loop)"
echo "  • loopkit (53 harness skills)"
echo ""
echo "MCP Servers: 6 | Skills: 305+ | Commands: 122+ | Agents: 74+"
echo ""
