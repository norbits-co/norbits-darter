# Skills

## Rules
- **Keep about 6-8 skills active.** Every skill's description sits in the agent's context. Add one only to fix a repeated problem, and note why in the provenance table. Remove skills that are not triggered.
- Install per project only what that project needs. Not everything below belongs in every repo.
- Third-party skills are instructions the agent will follow. Read them before installing, pin to a commit, and record provenance.
- Tool-specific hooks and metadata still need adapting per agent (Claude Code vs Codex).

## Where skills live
Both agents are used, so skills must be visible to both.
- Canonical copy: `.agents/skills/<name>/SKILL.md` (Codex reads this).
- Claude Code reads `.claude/skills/`. Make it a relative symlink to the canonical folder (run once per repo):
  ```
  mkdir -p .agents/skills .claude
  ln -s ../.agents/skills .claude/skills
  ```
- Third-party skills: `npx skills add <owner/repo> -a claude-code -a codex` (vercel-labs/skills) installs one canonical copy and symlinks it for each agent. Afterwards check that the skill appears in both folders; project-scope installs have had a bug where the `.claude/skills` link was not created.
- Symlinks need care on Windows checkouts. If a teammate is on Windows, use the copy mode (`--copy`) or a sync script instead.

## Catalog

| Skill | Source | Use it when | Projects | Status |
| --- | --- | --- | --- | --- |
| verification-before-completion | Superpowers | Before claiming any task is done. Merge with our own "verify task" skill instead of keeping both. | All | Start set |
| receiving-code-review | Superpowers | When acting on AI or human review comments, so comments are evaluated and not blindly applied. | All | Start set |
| systematic-debugging | Superpowers | Bugs, failing tests, CI failures. Forces root cause before a fix. | All | Start set |
| to-tickets | Matt Pocock | Turning a plan, spec or conversation into issues. Adapt the output to the fields in `.github/ISSUE_TEMPLATE/task.yml`. | Any project with tracked issues | Start set |
| writing-for-agents | Matt Pocock | When writing or editing `AGENTS.md`, `CLAUDE.md` or skills. Read once; do not keep active. | Meta | Read once |
| webapp-testing | Anthropic | Exercising the running app in a browser. Adapt for TypeScript Playwright and fold into the Playwright setup. | Projects with a web UI | Adapt |
| frontend-design | Anthropic | New UI where no design system or client design exists. Skip when brand or design references exist (it pushes for distinctive design). | Personal / greenfield | Per project |
| vercel-react-best-practices | Vercel | React or Next.js performance and pattern reviews. | React / Next.js only | Per project |
| web-design-guidelines | Vercel | UI and accessibility audit; candidate frontend/accessibility reviewer. | React / Next.js UI | Evaluate |

### Built in to Claude Code (no install)
| Skill | Use it when |
| --- | --- |
| `/code-review` | On a PR or diff before a human looks at it. |
| `/security-review` | When changes touch auth, permissions, data exposure or dependencies. |
| `/simplify` | After implementation, before opening the PR, to clean up reuse and complexity. |

### To build ourselves
| Skill | What it does |
| --- | --- |
| prepare-task | Inspect repo, find ambiguities, propose acceptance criteria and a plan. |
| verify-task | Check each criterion, run `pnpm verify`, exercise UI/API, report what is unverified. |
| prepare-pr | Inspect final diff, remove unrelated changes, summarize behaviour, attach evidence. |
| weekly-review | Read-only `gh` queries for cycle time, PRs merged without human edits, review comments per PR and cost; fills in the weekly review. |
| mistake-to-rule | After an agent error, proposes the one-line addition to `AGENTS.md` or a skill for approval. |
| migration-review | Checklist for DB changes: destructive operations, rollback path, data preservation. Flags for a human; never approves. |
| refine-issue (optional) | Turns a vague request into `task.yml` fields. Only if `to-tickets` is not enough. |

## Provenance
Record every third-party skill here when it is installed. Pin the commit.

| Skill | Upstream URL | Commit / version | License | Local modifications | Added | Why |
| --- | --- | --- | --- | --- | --- | --- |
| | | | | | | |

Upstream repos to start from (commit and license not yet recorded):
- Superpowers: https://github.com/obra/superpowers
- Matt Pocock: https://github.com/mattpocock/skills
- Anthropic: https://github.com/anthropics/skills
- Vercel: check https://github.com/vercel-labs/skills and its agent-skills repo for the current source
