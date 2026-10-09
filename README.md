# Darter by NorBits

![License](https://img.shields.io/badge/License-Apache%202.0-D22128?style=for-the-badge&logo=apache&logoColor=white&labelColor=D22128)
![Node](https://img.shields.io/badge/Node-5FA04E?style=for-the-badge&logo=nodedotjs&logoColor=white)
![pnpm](https://img.shields.io/badge/pnpm-F69220?style=for-the-badge&logo=pnpm&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white)

## 🧭 Overview

Starter template for Norbits and personal projects following agentic AI, meant to become a GitHub template repository. It carries the workflow that worked in real repos: a short `AGENTS.md`, `docs/` for the details, strict PR and branch rules, one `pnpm verify` entry point shared by developers, agents and CI, and a locked-down `@claude` workflow.

The root is stack-agnostic. Stack-specific files live in `stacks/<name>/` and are applied once with `scripts/init.sh`.

## 📦 Stacks

| Stack | Status |
| --- | --- |
| `nextjs-static` | Ready. Next.js App Router, TypeScript, Tailwind CSS, static export, Render. Extracted from a working project. |
| `tauri-vite-rust` | Planned. Built when the first Tauri project starts, so it is tested on a real project. |

Each stack folder has `overlay/` (files copied onto the root), `gitignore.additions`, `snippets.md` (text to paste into `AGENTS.md` and `docs/`) and its own README.

## 🚀 Starting a new project

Use this repo as a GitHub template (or clone it), then run the init script from the project root with one of the stacks above. For example, with `nextjs-static`:

```bash
git clone <this-repo-url> my-project
cd my-project
rm -rf .git && git init    # start fresh history
bash scripts/init.sh <stack>    # e.g. nextjs-static
```

The script:
- copies the stack's `overlay/` onto the root if it has one (existing files are never overwritten),
- appends the stack's ignore rules to `.gitignore`,
- uncomments `ignored/` so tasks, notes and deployment details stay local, and turns the `ignored/*.example.md` skeletons into `ignored/TODO.md`, `ignored/NOTES.md` and `ignored/docs/deployment.md`,
- saves the stack's `snippets.md` to `ignored/stack-snippets.md`, and removes `stacks/` and itself.

Then scaffold the framework with the stack's own tool (for `nextjs-static`, `pnpm create next-app`), follow the setup checklist at the top of `ignored/stack-snippets.md`, paste its blocks into `AGENTS.md` and `docs/`, and fill in the `<!-- -->` placeholders. Swap, rewrite or delete files as the project needs, including this `README.md`, which should become the new project's README.

## 🗂️ Layout

```
AGENTS.md                  # agent brief (short; details in docs/)
CLAUDE.md                  # references AGENTS.md
CONTRIBUTING.md            # branch, PR and review workflow
SECURITY.md                # how to report vulnerabilities (fill in the contact)
CODE_OF_CONDUCT.md         # Contributor Covenant 2.1
CHANGELOG.md               # Keep a Changelog
LICENSE                    # Apache 2.0
NOTICE                     # copyright holder
.env.example               # documented env vars, no real values
.node-version              # Node version for fnm and CI
.agents/skills/            # canonical skills (Codex reads this)
.claude/skills             # symlink -> ../.agents/skills (Claude Code reads this)
.claude/settings.json      # Claude Code project settings (attribution off, default output style)
.claude/output-styles/     # "Reviewable" output style: concise, result-first replies
.github/
    workflows/             # ci, claude, pr-checks, pr-labels
    ISSUE_TEMPLATE/        # task.yml, bug.yml, config.yml (blank issues off)
    PULL_REQUEST_TEMPLATE.md
    CODEOWNERS
    labeler.yml            # branch prefix -> label (used by pr-labels.yml)
docs/                      # architecture, conventions, deployment, release, review, scope, skills, testing
ignored/                   # *.example.md skeletons; local and git-ignored in projects
stacks/                    # one folder per stack (removed by init)
scripts/init.sh            # applies a stack (removed by init)
```

A stack can add an `overlay/` of files a scaffolder doesn't generate (`nextjs-static` has none). Scaffold the framework yourself, then follow the stack's setup checklist in `ignored/stack-snippets.md`.

## ⚙️ Per-project setup

1. Replace the owner handle `dwainXDL` with your GitHub username in `.github/CODEOWNERS` and `SECURITY.md`, and `YOUR_GITHUB_USERNAME` in `AGENTS.md` and `docs/conventions.md`. Adjust the placeholder paths in `CODEOWNERS`.
2. Fill in `AGENTS.md` and `docs/` placeholders. Replace the contact email `contact@norbits.co` with your own in `SECURITY.md` and `CODE_OF_CONDUCT.md`, and the copyright holder (NorBits) in `LICENSE` and `NOTICE`.
3. Map the required scripts (see `docs/conventions.md`) to the stack's tools. Add `.prettierrc`, `.prettierignore` and an ESLint config with `eslint-config-prettier` last (see `docs/conventions.md`). Set `.node-version` (read by fnm and CI), and enable the Playwright steps in `ci.yml` once Playwright is configured.
4. Create a branch ruleset for `main` (require PR, code-owner approval, and the required checks `checks`, `naming`, `metadata`, `type` and `size`). GitHub only offers checks that have run before, so open one PR first.
5. In the repo settings, add the repo description (About box, same style as your other repos) and turn on secret scanning with push protection (Code security).
6. Optional: the `@claude` workflow ships as `.github/workflows/claude.yml`. Keep it and run `/install-github-app` in Claude Code to connect the GitHub app, or delete the file. It needs a Claude credential stored as a repo secret (`ANTHROPIC_API_KEY` or `CLAUDE_CODE_OAUTH_TOKEN`; the file uses the token, so switch its `with:` input if you use an API key). It is already locked down: only collaborators with write access can trigger it, minimal `GITHUB_TOKEN` permissions, one run per thread, the action pinned to a commit SHA, and `claude_args` limits. Keep production secrets out of agent-triggered workflows. The PR footer the Action adds is separate: `.claude/settings.json` only covers local Claude Code sessions.
7. Set up skills (symlink, which to install, provenance): see `docs/skills.md`.
8. Create the GitHub labels (`feat`, `bug`, `docs`, `chore`, `test`, `ci`, `refactor`, `release`, `task`, `size/XS` to `size/XL`) using the names, descriptions and colors in `docs/conventions.md`. GitHub skips labels that don't exist, and the size job fails if one is missing.
9. Create the project's folder structure up front, then record it in `docs/architecture.md` under Structure.

Releases are manual: see `docs/release.md`.

## 🧹 Keep only what you use

The core assumes Node, pnpm and TypeScript. Delete or replace anything that doesn't apply, so nothing stale confuses agents or CI.

| If the project... | Delete or change |
| --- | --- |
| Doesn't use Node | Delete `.node-version`. Replace the Node/pnpm steps in `ci.yml`, the commands in `AGENTS.md`, and the required scripts in `docs/conventions.md`. |
| Uses a different package manager | Change the pnpm steps in `ci.yml` and the commands in `AGENTS.md` and `docs/conventions.md`. |
| Has no browser UI / Playwright | Leave the commented Playwright steps in `ci.yml` disabled, or delete them. |
| Uses only one agent (Claude Code or Codex) | Keep just the matching skills folder. |
| Is solo (no teammates) | Trim Getting Started in `CONTRIBUTING.md` and the ownership paths in `CODEOWNERS`. |
| Has no sensitive areas like auth or payments | Remove those paths from `CODEOWNERS` and `docs/architecture.md`, but keep the forbidden-actions list in `AGENTS.md`. |

Keep `AGENTS.md`, the issue and PR templates, and `docs/review.md` in every project.

## 🔒 Private documents

Recommended: keep private documents (client contracts, legal papers, credentials-adjacent notes) **outside every repo**, e.g. `~/Documents/<project>/`. Nothing opened in the project, by any AI tool, can then reach them.

If they must live in the repo, use `ignored/private-docs/` (git-ignored once `ignored/` is enabled) and know the limits:
- Add a `permissions.deny` rule such as `Read(./ignored/private-docs/**)` to `.claude/settings.json`; it blocks Claude Code's file tools only. Shell commands (`cat`, `grep`) can bypass it unless the sandbox's filesystem restrictions are on.
- Other AI tools (Codex, Cursor, Copilot) use their own ignore config (e.g. `.cursorignore`). Set each one separately.
- Telling agents in `AGENTS.md` not to read the folder is guidance, not enforcement.

## 👋 Teammate onboarding

New teammates follow the Getting Started steps in [CONTRIBUTING.md](CONTRIBUTING.md): setup, agent config, task workflow, verification, separate review and PR.

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the branch, PR and review workflow, and [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md). Report vulnerabilities privately as described in [SECURITY.md](SECURITY.md).

## 📄 License

Licensed under the [Apache License 2.0](LICENSE). Projects created from this template should replace `LICENSE` with their own.

<br />

<div align="center">

`NORBITS / EST. 2026 / GLOBAL 🌍`

</div>
