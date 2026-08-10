---
name: anti-hallucination-clickup-brain
description: Rules for using ClickUp Brain (ClickUp's built-in AI) without hallucinations. Structures prompts to Brain to get accurate, task-grounded responses. Use whenever interacting with ClickUp Brain for task management, summaries, or code generation.
---

# Anti-Hallucination: ClickUp Brain Protocol

> **ClickUp Brain has access to your workspace data. Use that advantage. Ground every request in specific tasks, docs, and context.**

## The Problem with Brain Hallucinations

ClickUp Brain can hallucinate when:
- Asked vague questions without task context
- Asked to generate code without seeing the actual codebase
- Asked to summarize tasks it doesn't have full context on
- Asked to make decisions without explicit criteria

## Anti-Hallucination Rules for Brain

### Rule 1: Always Reference Specific Tasks

```
❌ BAD: "What should I work on next?"
✅ GOOD: "Based on task [TASK-ID] dependencies and my current sprint, what's the highest priority unblocked task?"

❌ BAD: "Write me a login page"
✅ GOOD: "Based on the spec in task [TASK-ID], generate the login page following the acceptance criteria listed in the task description"

❌ BAD: "Summarize the project status"
✅ GOOD: "List all tasks in [LIST-NAME] with status 'in progress' or 'review', grouped by assignee, with their due dates"
```

### Rule 2: Provide Acceptance Criteria in the Prompt

Don't let Brain guess what "done" means:

```
Generate a Next.js API route for [feature].

Acceptance criteria (from task [TASK-ID]):
- Must validate input with Zod
- Must return proper error codes (400, 401, 500)
- Must log to structured logger
- Must have TypeScript types for request/response
- Must include unit test

Do NOT generate anything outside these criteria.
```

### Rule 3: Ask Brain to Cite Its Sources

Brain has access to docs, tasks, and comments. Make it cite:

```
Answer this question and cite which task/doc/comment you found the answer in:
[your question]

If you cannot find the answer in workspace data, say "NOT FOUND IN WORKSPACE" instead of guessing.
```

### Rule 4: Validate Brain's Output Against Task Data

After Brain generates something:
1. Check if the task it references actually exists
2. Check if the status it reports matches reality
3. Check if the dates it mentions are correct
4. Check if the assignees it names are real

```
⚠️ Brain said task X is "done" but actual status is "in progress".
Do NOT trust Brain summaries without checking the task directly.
```

### Rule 5: Use Brain for Search, Not Generation

Brain is BEST at:
- Finding tasks by description ("which task covers the auth flow?")
- Searching comments for decisions ("when did we decide to use Supabase?")
- Listing tasks by status/assignee/date
- Cross-referencing task dependencies

Brain is WORST at:
- Generating code without seeing the actual codebase
- Making architectural decisions without explicit criteria
- Estimating timelines without historical data
- Writing specs without task context

### Rule 6: Structure Prompts as Queries, Not Wishes

```
❌ WISH: "Help me plan the next sprint"
✅ QUERY: "List all tasks in [SPACE] with status 'to do', priority 'high' or 'urgent', 
         that have no blockers. Sort by due date. I need to pick 5 for this week's sprint."

❌ WISH: "What's the bug about?"
✅ QUERY: "Read task [TASK-ID] description, all comments, and linked subtasks. 
         Summarize: 1) what's broken, 2) reproduction steps, 3) proposed fix if any."
```

### Rule 7: Cross-Validate with Antigravity

When Brain gives you an answer about code:
1. Open the actual file in Antigravity
2. Verify Brain's claim against the real code
3. If discrepancy: trust the CODE, not Brain

When Brain gives you an answer about tasks:
1. Load the task via `clickup-agent context load --task-id <ID>`
2. Verify status, assignee, dates against Brain's claim
3. If discrepancy: trust the API response, not Brain

## Prompt Templates for Brain (anti-hallucination)

### Template: Task Breakdown
```
Based on task [TASK-ID] description and acceptance criteria:
1. List each acceptance criterion as a subtask
2. For each subtask, estimate complexity (S/M/L)
3. Identify dependencies between subtasks
4. Suggest execution order (topological)

Do NOT add subtasks that aren't in the acceptance criteria.
Do NOT invent requirements.
```

### Template: Code Review Request
```
Review the changes in PR #[number] against task [TASK-ID] requirements:
1. Does each change trace to a requirement?
2. Are there changes NOT covered by the task spec?
3. Are acceptance criteria met based on the diff?

Cite specific lines and requirements. Do NOT give generic feedback.
```

### Template: Sprint Status
```
For sprint [DATE RANGE] in [SPACE/LIST]:
1. List completed tasks (status: done/closed) with completion dates
2. List in-progress tasks with % estimate and blockers
3. List overdue tasks with days overdue
4. List unstarted tasks that are past their start date

Use ONLY actual task data. Do NOT estimate completion % if not tracked.
```

### Template: Decision Search
```
Search all comments and docs in [SPACE] for decisions about [TOPIC].
For each decision found:
- Quote the exact comment/doc text
- Link to the task/doc it came from
- Note the date and who said it

If no decision found, say "NO DECISION RECORDED" — do not infer.
```

## Verification

- [ ] Every Brain prompt references specific task IDs
- [ ] Acceptance criteria provided in prompt (not left to Brain's imagination)
- [ ] Brain asked to cite sources from workspace data
- [ ] Brain output validated against actual task/code state
- [ ] Brain used for search/retrieval, not unconstrained generation
- [ ] Prompts structured as specific queries, not vague wishes
- [ ] Cross-validation with Antigravity for any code-related claims
