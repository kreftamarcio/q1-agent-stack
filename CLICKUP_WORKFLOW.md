# ClickUp ↔ GitHub Workflow

## Setup

1. Get your ClickUp Personal API Token: Settings → Apps → Generate
2. Run: `clickup-agent setup` (enter token + workspace ID)
3. Verify: `clickup-agent doctor --live-auth`

## Daily Workflow

### Starting a task
```bash
# Load task context
clickup-agent context load --task-id <ID> --profile handoff

# Set status to in-progress
clickup-agent run set-status --task-id <ID> --status "in progress"

# Assign to yourself
clickup-agent run assign-me --task-id <ID>
```

### During development
```bash
# Sync branch with task
clickup-agent run dev-sync --task-id <ID> --branch feature/my-feature

# Log decisions
clickup-agent run decision-log --task-id <ID> --decision "Using Zustand over Redux for state"

# Add work log
clickup-agent run work-log --task-id <ID> --checklist action-items --add-item "Implement auth flow"
```

### Completing a task
```bash
# Full sync
clickup-agent run catch-up-docs --task-id <ID> --mode bidirectional

# Update status
clickup-agent run set-status --task-id <ID> --status "review"

# Comment with PR link
clickup-agent run comment --task-id <ID> --text "PR ready: https://github.com/kreftamarcio/repo/pull/1"
```

## GitHub Actions Integration

Copy `examples/github-actions-dev-sync.yml` to `.github/workflows/` in your repos.
Set `CLICKUP_API_KEY` as a repository secret.

This auto-syncs PR events to ClickUp tasks.

## MCP Integration with Antigravity

The MCP server exposes all commands as tools:
```json
{
  "mcpServers": {
    "clickup-agent": {
      "command": "clickup-agent",
      "args": ["mcp"]
    }
  }
}
```

Once registered, your Antigravity agent can:
- Search tasks by natural language
- Create/update tasks during /oma:team-exec
- Sync branches automatically during /git
- Log decisions during architecture discussions
- Load context before starting any task
