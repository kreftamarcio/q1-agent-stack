#!/bin/bash
# ============================================================
# Q1 Digital — Vercel Skills Installer
# Installs: vercel-plugin (32 skills + 3 agents + 4 commands)
#           vercel-labs/agent-skills (9 skills)
# ============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

step() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

echo "══════════════════════════════════════════════════════"
echo "  Vercel Skills Installer for Q1 Digital"
echo "  (Antigravity + Gemini + ClickUp Integration)"
echo "══════════════════════════════════════════════════════"
echo ""

# ─── 1. Vercel Plugin Oficial (32 skills + 3 agents + 4 commands) ───
echo "── Step 1/2: Installing Vercel Plugin (Official) ──"
if command -v agy >/dev/null 2>&1; then
  agy plugin install https://github.com/vercel/vercel-plugin
  step "vercel-plugin installed (32 skills + 3 agents + 4 commands)"
else
  warn "Antigravity CLI (agy) not found."
  warn "Install Antigravity first, then run:"
  warn "  agy plugin install https://github.com/vercel/vercel-plugin"
  echo ""
  warn "Alternative: clone and link manually:"
  warn "  git clone https://github.com/vercel/vercel-plugin.git ~/.gemini/plugins/vercel-plugin"
fi

# ─── 2. Vercel Labs Agent Skills (9 skills via npx skills) ───
echo ""
echo "── Step 2/2: Installing vercel-labs/agent-skills ──"
npx skills add vercel-labs/agent-skills
step "vercel-labs/agent-skills installed (9 skills)"

echo ""
echo "══════════════════════════════════════════════════════"
echo "  ✅ Vercel Skills Installation Complete!"
echo "══════════════════════════════════════════════════════"
echo ""
echo "Installed:"
echo "  • vercel/vercel-plugin: 32 skills + 3 agents + 4 commands"
echo "  • vercel-labs/agent-skills: 9 skills"
echo "  • Total Vercel: 41 skills + 3 agents + 4 commands"
echo ""
echo "Key skills available:"
echo "  • ai-sdk (Vercel AI SDK: streaming, chat, tools)"
echo "  • ai-gateway (AI routing, caching, rate limiting)"
echo "  • vercel-storage (Blob, KV, Postgres, Supabase, Neon)"
echo "  • vercel-functions (Serverless + Edge)"
echo "  • deployments-cicd (deploy, rollback, promote)"
echo "  • auth (Clerk, NextAuth, Auth0, Better Auth)"
echo "  • next-forge (monorepo @repo/* packages)"
echo "  • workflow (Vercel Workflow SDK: durable functions)"
echo "  • shadcn (UI components)"
echo "  • vercel-firewall (WAF, DDoS protection)"
echo ""
echo "Commands:"
echo "  /bootstrap  — Setup new Vercel project"
echo "  /deploy     — Deploy to Vercel"
echo "  /env        — Manage environment variables"
echo "  /status     — Check deployment status"
echo ""
echo "Agents:"
echo "  ai-architect        — AI architecture on Vercel"
echo "  deployment-expert   — Deploy management"
echo "  performance-optimizer — Performance tuning"
echo ""
echo "Restart Antigravity CLI (agy) to load Vercel skills."
echo ""
