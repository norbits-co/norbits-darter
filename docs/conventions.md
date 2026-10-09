# Conventions

## Required package.json scripts
Every project defines these names so CI and agents work the same everywhere. Map them to the stack's tools (ESLint/Biome, Prettier, tsc, Vitest/Jest, next/vite build).

| Script | Purpose |
| --- | --- |
| `format` | Auto-fix formatting (e.g. `prettier --write .`) |
| `format:check` | Fail if code is not formatted (e.g. `prettier --check .`) |
| `lint` | Static analysis (e.g. `eslint`) |
| `typecheck` | `tsc --noEmit` or equivalent |
| `test` | Unit/integration tests; runs once and exits (no watch mode, e.g. `vitest run`) |
| `build` | Production build |
| `verify` | Single entry point for developers, agents and CI: runs all of the above |

`verify` must stop at the first failure and keep the failing exit status, e.g. `"verify": "pnpm format:check && pnpm lint && pnpm typecheck && pnpm test && pnpm build"`. Do not swallow errors with `|| true` or pipes.

## Formatter and linter
Default: Prettier formats, ESLint lints. Swap for the stack's tools if it differs (Biome replaces both). Run `pnpm format` to fix formatting; `pnpm format:check` (part of `verify`) only checks.

Example scripts:
```json
"format": "prettier --write .",
"format:check": "prettier --check .",
"lint": "eslint"
```

Config files to add per project:
- `.prettierignore`: skip generated and hand-formatted files: `node_modules`, build output (`.next`, `out`, `build`, `coverage`), the lockfile, `ignored/`, and `*.md` (Prettier re-pads tables in hand-written docs and churns diffs).
- `eslint.config.*`: ESLint rules for the stack. Put `eslint-config-prettier` last so it turns off rules that conflict with Prettier.

Workflow and other YAML files are formatted too: run `pnpm format` after editing `.github/workflows/*.yml` so `format:check` passes.

## Code
Enforce formatting and style in the formatter/linter wherever possible. Document here only what tools cannot enforce.
- Accessible navigation, semantic HTML, alt text, mobile-first layouts, sensible image sizes, meaningful page titles, and basic metadata.
- Keep animations restrained and performant. Respect `prefers-reduced-motion`. Never autoplay audio.
- Treat photographs and information about people carefully. Publish only material and permissions provided or approved by the client. Never put private data in public collections or public storage URLs.
- Comments are terse fragments: one line saying what or why, not a full explanation. Start with a lowercase letter, name the variable or thing directly, and skip filler words (e.g. `// noindex unless ALLOW_INDEXING=true (production only)`). Same in YAML and other files.
- Keep deployment configuration documented without committing secrets.
<!-- Naming, file layout, error handling, component patterns. Add rules as agents make mistakes. -->

## Git and PRs
- Small PRs, one concern each.
- No unrelated changes or drive-by refactors.
- Branch from main (or dev when the project has a review branch); never push to main.
- Branch names follow `<type>/<person>-<rest-of-branch-name>`: lowercase, words separated by hyphens, e.g. `feat/<person>-add-login-page`. Types: `feat`, `bug`, `docs`, `chore`, `test`, `ci`, `refactor`, `release`.
- Do not delete branches, local or remote, including after a PR is merged. Keep them as history. Leave GitHub's "Automatically delete head branches" setting off, and do not run branch cleanup commands (`git branch -d`, `git push --delete`, `git town sync --prune`).
- Commit messages start with a lowercase letter, use the imperative mood, and have no trailing period, e.g. `add login page`.
- PR titles are `<type>: <summary>`, where `<type>` matches the branch type (branch `feat/<person>-add-login-page`, title `feat: add login page`). Use `bug:` for fixes, not `fix:`. Lowercase, imperative, no trailing period, because a squash merge uses the title as the commit message. Commit messages on the branch need no prefix.
- `.github/workflows/pr-checks.yml` fails a PR whose branch name or title breaks these rules (the `dev` branch is exempt for promotion PRs) or that has no assignee or milestone.
- PRs use the template and report acceptance-criteria results.
- Every PR has an assignee and a milestone, set when the PR is created. Assign the owner (`YOUR_GITHUB_USERNAME`) unless told otherwise, and use the open milestone. If no milestone fits, ask. Example: `gh pr create --assignee YOUR_GITHUB_USERNAME --milestone "<milestone title>"`.
- Issues and PRs follow their templates strictly: keep every section. If a section has nothing to say, write `N/A` (a short reason helps). Anything extra goes under additional topic headings after the template sections.

## Labels
Type labels match the branch types and are added automatically from the branch prefix (`.github/labeler.yml`). Size labels are added automatically from the number of lines changed, ignoring `pnpm-lock.yaml` (`.github/workflows/pr-labels.yml`). `task` is applied by the issue template and `release` marks release work. Create them once per repo; GitHub skips labels that don't exist, and the size job fails if a size label is missing.

| Label | Description | Color |
| --- | --- | --- |
| `feat` | New feature or page | `0e8a16` |
| `bug` | Something is broken | `d73a4a` |
| `docs` | Documentation only | `0075ca` |
| `chore` | Maintenance, tooling, dependencies | `cfd3d7` |
| `test` | Adding or changing tests | `fbca04` |
| `ci` | CI and workflow changes | `5319e7` |
| `refactor` | Code change with no behaviour change | `c5def5` |
| `release` | Release preparation and release notes | `ff9f1c` |
| `task` | A unit of work an agent or human can pick up | `bfdadc` |
| `size/XS` | 10 lines changed or fewer | `e6f4ea` |
| `size/S` | 11 to 50 lines changed | `cdeed6` |
| `size/M` | 51 to 200 lines changed | `fef2c0` |
| `size/L` | 201 to 500 lines changed | `f9d0c4` |
| `size/XL` | More than 500 lines changed; consider splitting the PR | `d93f0b` |

## Dependencies
- Prefer what is already installed.
- New dependency: explain why the existing stack is not enough.
