# Snippets for this stack

## Setup checklist (not a paste block)
Run the scaffolder yourself, then apply these on top of what it generates:
- [ ] Scaffold with `pnpm create next-app` (App Router, TypeScript, Tailwind, ESLint, `src/` directory). Don't overwrite the template's root files.
- [ ] `package.json` scripts, with these exact names (see `docs/conventions.md`):
  - `dev`: `next dev`
  - `build`: `next build`
  - `start`: `next start`
  - `lint`: `eslint`
  - `format`: `prettier --write .`
  - `format:check`: `prettier --check .`
  - `typecheck`: `next typegen && tsc --noEmit`
  - `verify`: `pnpm format:check && pnpm lint && pnpm typecheck && pnpm build`
  - `test`: not set up yet. Add a runner (e.g. Vitest with `vitest run`) and extend `verify` with it.
- [ ] Dev dependencies to add: `prettier`, `prettier-plugin-tailwindcss` (loaded in `.prettierrc`) and `eslint-config-prettier`.
- [ ] `eslint.config.mjs`: add `eslint-config-prettier/flat` as the last entry in the config array, after `eslint-config-next`.
- [ ] `.prettierignore`: add `node_modules`, `.next`, `out`, `build`, `coverage`, `pnpm-lock.yaml`, `next-env.d.ts`, `ignored`, and `*.md` (docs are not formatted).
- [ ] `next.config.ts`: `output: "export"` and unoptimized images, for the Render Static Site.
- [ ] Run `pnpm install` once and commit `pnpm-lock.yaml`.

## Paste blocks
Paste each block into the file named in its heading, replacing the placeholder comment.

## AGENTS.md: Architecture
- Next.js App Router, TypeScript, Tailwind CSS; static export (`output: 'export'`) deployed as a Render Static Site. Details and limits: `docs/architecture.md`.

## AGENTS.md: Testing requirements
- Test the production static build (`out/`).

## AGENTS.md: Planning, scope and review
- Render PR previews are manual; ask the owner before opening a PR (see `docs/conventions.md`).

## AGENTS.md: Definition of done
- The static production build succeeds.

## docs/architecture.md: Stack
- Next.js App Router, TypeScript, Tailwind CSS. Semantic HTML and CSS for ordinary effects.
- **Static export:** `output: 'export'`, deployable as a Render **Static Site** (`out/` after `next build`). There are no request-time Next.js server features: no Server Actions, request-dependent route handlers, Draft Mode, or built-in server-side form processing.

## docs/architecture.md: Structure
- `src/app/`: App Router. `layout.tsx` (root layout), `page.tsx` (Home), `globals.css` (Tailwind).
- `src/lib/`: shared helpers.
- `public/`: static assets.
- `next.config.ts`: static export config (`output: "export"`, unoptimized images).
- `out/` and `.next/`: build output, git-ignored.

## docs/architecture.md: Sensitive areas
`next.config.ts`, `config/production*`, and any `src/auth/`, `src/payments/`, `migrations/` once they exist.

## docs/conventions.md: Git and PRs
- Render PR previews are manual to save build minutes. Before opening a PR, ask the owner and anyone else working on it whether they want a preview. If yes, add `[render preview]` to the PR title (e.g. `feat: add login page [render preview]`) or the `render-preview` label.

## docs/review.md: Project-specific checks
- Static-export compatibility: no Server Actions, request-dependent route handlers, Draft Mode, or server-side form handling.
- Accessibility: semantic HTML, keyboard navigation, alt text, `prefers-reduced-motion` respected.

## docs/skills.md: intro
This project is Next.js/React, so the Vercel React and web-design skills apply here.

## .github/CODEOWNERS
```
# Hosting and production config (static export, Render, headers/indexing)
/next.config.*        @YOUR_GITHUB_USERNAME
/config/production*   @YOUR_GITHUB_USERNAME
```

## .github/workflows/ci.yml
`pnpm verify` already runs `pnpm build`, which is the static export, so a passing `checks` job proves the site builds for Render.
