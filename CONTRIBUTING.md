# 🤝 Contributing

How to work on this project. Details live in [`docs/conventions.md`](docs/conventions.md) and [`AGENTS.md`](AGENTS.md).

## 👋 Getting Started

1. **Setup:** clone, `pnpm install`, `pnpm dev`
2. **Agent config:** read `AGENTS.md`; Claude Code picks it up via `CLAUDE.md`
3. **Task workflow:** pick an issue (acceptance criteria required), plan, implement, then read the summary
4. **Verification:** run `pnpm verify` and check the UI in the browser
5. **Review:** run an independent review pass ([`docs/review.md`](docs/review.md), e.g. a fresh agent session or `/code-review`) before asking a human
6. **PR:** use the template, report each acceptance criterion's result, attach evidence, list remaining limitations

## 🌿 Branch Strategy

```txt
<type>/<person>-<rest>        e.g. feat/<person>-add-login-page
```

Types: `feat`, `bug`, `docs`, `chore`, `test`, `ci`, `refactor`, `release`.

Branch names are lowercase with hyphens.

## 🔄 Workflow

1. Branch from `main` (or `dev` when the project has a review branch)
2. Open a PR using the template, titled `<type>: <summary>` (e.g. `feat: add login page`). The type matches the branch type, and `bug:` is used for fixes
3. Ensure all CI checks pass:
   - ✅ format
   - ✅ lint
   - ✅ typecheck
   - ✅ build
   - ✅ branch name, PR title, type and size labels
4. If the project has a `dev` review branch, `dev` is promoted into `main` for releases

## 👀 PR Previews

PR previews are manual. Before opening a PR, ask the owner and anyone else working on it whether they want a preview. If yes, trigger one the way the project's hosting does (see `ignored/docs/deployment.md`).

## 📌 Rules

- 🚫 Never push to `main`
- 🌿 Never delete branches, even after merge
- 🔐 Workflows, `CODEOWNERS`, `AGENTS.md` and `.claude/` need code-owner approval
- 📝 Commit messages and PR titles are lowercase, with no trailing period
- 🧪 Run `pnpm verify` before opening a PR

<br />

<div align="center">

`NORBITS / EST. 2026 / GLOBAL 🌍`

</div>
