#!/bin/bash
# ============================================================
# Q1 Digital — Loop Engineering + Harness + Graph Skills
# Installs: COG second-brain skills, loopkit skills
# ============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

step() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
err() { echo -e "${RED}[✗]${NC} $1"; }

echo "══════════════════════════════════════════════════════"
echo "  Loop Engineering + Harness + Graph Skills Installer"
echo "══════════════════════════════════════════════════════"
echo ""

SKILLS_DIR="${HOME}/.gemini/antigravity/skills"
mkdir -p "$SKILLS_DIR"

# ─── 1. COG Second Brain (Loop Engineering + Closed-Loop Harness) ───
echo ""
echo "── Step 1/2: COG Second Brain (loop + harness skills) ──"
COG_TEMP="/tmp/cog-clone"
if [ -d "$COG_TEMP" ]; then rm -rf "$COG_TEMP"; fi

git clone --depth 1 https://github.com/huytieu/COG-second-brain.git "$COG_TEMP" 2>/dev/null

if [ ! -d "$COG_TEMP/skills" ]; then
  err "COG clone failed or skills dir missing"
  exit 1
fi

COG_SKILLS=(
  "loop-engineering"
  "closed-loop"
  "review-cockpit"
  "no-ai-slop"
  "product-ui-taste"
  "ultragoal"
  "scout"
  "auto-research"
  "comprehensive-analysis"
  "generate-prd"
  "knowledge-consolidation"
  "content-factory"
  "harvest"
  "memory-hygiene"
)

for skill in "${COG_SKILLS[@]}"; do
  if [ -d "$COG_TEMP/skills/$skill" ]; then
    cp -r "$COG_TEMP/skills/$skill" "$SKILLS_DIR/"
    step "COG: $skill"
  else
    warn "COG: $skill not found, skipping"
  fi
done

# Copy COG GEMINI.md as reference
if [ -f "$COG_TEMP/GEMINI.md" ]; then
  cp "$COG_TEMP/GEMINI.md" "${HOME}/.gemini/cog-reference-gemini.md"
  step "COG GEMINI.md saved as reference"
fi

rm -rf "$COG_TEMP"
step "COG cleanup done"

# ─── 2. Loopkit (53 battle-tested harness skills) ───
echo ""
echo "── Step 2/2: Loopkit (harness + verification skills) ──"
LOOPKIT_TEMP="/tmp/loopkit-clone"
if [ -d "$LOOPKIT_TEMP" ]; then rm -rf "$LOOPKIT_TEMP"; fi

git clone --depth 1 https://github.com/Archive228/loopkit.git "$LOOPKIT_TEMP" 2>/dev/null

if [ ! -d "$LOOPKIT_TEMP/skills" ]; then
  err "Loopkit clone failed or skills dir missing"
  exit 1
fi

LOOPKIT_SKILLS=(
  "eval-harness"
  "adversarial-verify"
  "subagent-fanout"
  "model-routing"
  "self-eval-bias"
  "hitl-escalate"
  "verification-before-completion"
  "systematic-debugging"
  "spec-first"
  "write-failing-test-first"
  "context-budget"
  "progress-reading-protocol"
  "harness-stripping"
  "evaluator-calibration"
  "owasp-review"
  "secret-scan"
  "dependency-audit"
  "contract-test"
  "coverage-gaps"
  "bisect-regression"
  "flaky-hunter"
  "decision-record"
  "clean-commits"
  "reduce-nesting"
  "kill-dead-code"
  "simplify"
  "migration-writer"
  "schema-diff"
  "sql-review"
  "input-validation"
  "authz-check"
  "prompt-caching"
  "read-the-trace"
  "tool-restraint"
  "active-memory-reminder"
  "sprint-contract"
  "planner-spec-expand"
  "pr-from-diff"
  "changelog-from-diff"
  "readme-audit"
  "revert-surgical"
  "rebase-safely"
  "shift-notes"
  "a11y-pass"
  "design-system"
  "loading-empty-error-states"
  "broken-window-check"
  "structured-output"
  "feature-list-json"
  "pdf-ingestion"
  "suggest-next-features"
  "using-loopkit"
  "init-script-contract"
)

for skill in "${LOOPKIT_SKILLS[@]}"; do
  if [ -d "$LOOPKIT_TEMP/skills/$skill" ]; then
    cp -r "$LOOPKIT_TEMP/skills/$skill" "$SKILLS_DIR/"
    step "Loopkit: $skill"
  else
    warn "Loopkit: $skill not found, skipping"
  fi
done

# Copy loopkit AGENTS.md and hooks
if [ -f "$LOOPKIT_TEMP/AGENTS.md" ]; then
  cp "$LOOPKIT_TEMP/AGENTS.md" "${HOME}/.gemini/loopkit-agents-reference.md"
  step "Loopkit AGENTS.md saved as reference"
fi

rm -rf "$LOOPKIT_TEMP"
step "Loopkit cleanup done"

echo ""
echo "══════════════════════════════════════════════════════"
echo "  ✅ Loop + Harness + Graph Skills Installed!"
echo "══════════════════════════════════════════════════════"
echo ""
echo "Installed:"
echo "  • COG: ${#COG_SKILLS[@]} skills (loop-engineering, closed-loop, etc)"
echo "  • Loopkit: ${#LOOPKIT_SKILLS[@]} skills (harness, verification, etc)"
echo "  • Total new skills: $((${#COG_SKILLS[@]} + ${#LOOPKIT_SKILLS[@]}))"
echo ""
echo "Key capabilities added:"
echo "  • Loop Engineering (COG patterns: ReAct, Reflexion, Plan-Execute-Verify)"
echo "  • Closed-Loop Harness (V-Model: worker never self-grades)"
echo "  • Adversarial Verification (red-team your own output)"
echo "  • Subagent Fanout (graph fork: parallel sub-agents)"
echo "  • 5-layer Termination (verifier + cap + budget + no-progress + human)"
echo "  • Anti-slop Gate (rejects generic/hallucinated output)"
echo ""
echo "Restart Antigravity CLI to load new skills."
echo ""
