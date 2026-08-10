#!/bin/bash
# ============================================================
# Q1 Digital — Agent Stack Installer
# Installs: context-mode, oh-my-antigravity, agent-skills,
#           SuperAntigravity, antigravity-skills vault,
#           clickup-agentic-native
# ============================================================

set -e

echo "══════════════════════════════════════════════════"
echo "  Q1 Digital — Agent Stack Installer"
echo "══════════════════════════════════════════════════"
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
echo "── Step 1/6: Installing context-mode ──"
npm install -g context-mode
step "context-mode installed globally"

# ─── 2. Oh-My-Antigravity (multi-agent orchestration) ────────
echo ""
echo "── Step 2/6: Installing oh-my-antigravity ──"
if command -v agy >/dev/null 2>&1; then
  agy plugin install https://github.com/Joonghyun-Lee-Frieren/oh-my-antigravity
  step "oh-my-antigravity installed as Antigravity plugin"
else
  warn "Antigravity CLI (agy) not found. Install it first: https://antigravity.google"
  warn "Then run: agy plugin install https://github.com/Joonghyun-Lee-Frieren/oh-my-antigravity"
fi

# ─── 3. Agent Skills (Addy Osmani — SDLC lifecycle) ──────────
echo ""
echo "── Step 3/6: Installing agent-skills (Addy Osmani) ──"
if command -v agy >/dev/null 2>&1; then
  agy plugin install https://github.com/addyosmani/agent-skills.git
  step "agent-skills installed as Antigravity plugin"
else
  npx skills add addyosmani/agent-skills
  step "agent-skills installed via npx skills"
fi

# ─── 4. SuperAntigravity (Superpowers + SuperClaude) ─────────
echo ""
echo "── Step 4/6: Installing SuperAntigravity ──"
curl -fsSL https://raw.githubusercontent.com/derHaken/SuperAntigravity/main/install.sh | bash
step "SuperAntigravity installed (19 skills + 16 commands + 8 agents)"

# ─── 5. Antigravity Skills Vault (300+ skills) ───────────────
echo ""
echo "── Step 5/6: Installing antigravity-skills vault (core bundles) ──"
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
echo "── Step 6/6: Installing clickup-agentic-native ──"
if command -v uv >/dev/null 2>&1; then
  git clone https://github.com/zenzenzen/clickup-agentic-native.git ~/.local/share/clickup-agent
  cd ~/.local/share/clickup-agent
  uv tool install . --python 3.12 --reinstall
  cd -
  step "clickup-agentic-native installed"
  warn "Run 'clickup-agent setup' to configure your API key"
  warn "Run 'clickup-agent doctor --live-auth' to verify"
else
  warn "uv not found. Install: curl -LsSf https://astral.sh/uv/install.sh | sh"
  warn "Then clone and install clickup-agentic-native manually:"
  warn "  git clone https://github.com/zenzenzen/clickup-agentic-native.git"
  warn "  cd clickup-agentic-native && uv tool install . --python 3.12"
fi

# ─── 7. Context-mode plugin for Antigravity CLI ──────────────
echo ""
echo "── Bonus: Registering context-mode with Antigravity CLI ──"
if command -v agy >/dev/null 2>&1; then
  agy plugin install https://github.com/mksglu/context-mode/tree/main/configs/antigravity-cli
  step "context-mode registered as Antigravity CLI plugin"
fi

# ─── Copy configs ────────────────────────────────────────────
echo ""
echo "── Copying configuration files ──"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Gemini CLI settings
mkdir -p ~/.gemini
if [ ! -f ~/.gemini/settings.json ]; then
  cp "$SCRIPT_DIR/settings.json" ~/.gemini/settings.json
  step "Gemini CLI settings.json copied to ~/.gemini/"
else
  warn "~/.gemini/settings.json already exists. Merge manually from $SCRIPT_DIR/settings.json"
fi

# GEMINI.md to home for global use
if [ ! -f ~/.gemini/GEMINI.md ]; then
  cp "$SCRIPT_DIR/GEMINI.md" ~/.gemini/GEMINI.md
  step "GEMINI.md copied to ~/.gemini/ (global)"
else
  warn "~/.gemini/GEMINI.md already exists. Review $SCRIPT_DIR/GEMINI.md for updates"
fi

echo ""
echo "══════════════════════════════════════════════════"
echo "  ✅ Installation complete!"
echo "══════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  1. Run 'clickup-agent setup' to configure ClickUp API key"
echo "  2. Run 'clickup-agent doctor --live-auth' to verify"
echo "  3. Restart Antigravity CLI (agy) to load all plugins"
echo "  4. Test with: /oma:status or /oma:doctor"
echo "  5. Copy GEMINI.md to your project roots for project-specific config"
echo ""
echo "Installed stack:"
echo "  • context-mode (98% token savings)"
echo "  • oh-my-antigravity (14 sub-agents, 30+ commands)"
echo "  • agent-skills (24 SDLC skills, /spec → /ship)"
echo "  • SuperAntigravity (19 auto-trigger skills + TDD)"
echo "  • antigravity-skills vault (300+ domain skills)"
echo "  • clickup-agentic-native (ClickUp↔GitHub MCP bridge)"
echo ""
