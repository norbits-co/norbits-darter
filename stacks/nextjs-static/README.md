# Stack: Next.js static export

Next.js App Router, TypeScript, Tailwind CSS, pnpm, static export (`output: "export"`) deployed as a Render Static Site. Extracted from a working project.

## What is here
- No `overlay/`: everything `create-next-app` generates is left to the scaffolder, and the rest is in the checklist.
- `gitignore.additions`: appended to `.gitignore`.
- `snippets.md`: a setup checklist for what to change after scaffolding (scripts, dev dependencies, ESLint, `.prettierignore`, `next.config.ts`), plus text to paste into `AGENTS.md`, `docs/` and `.github/CODEOWNERS`. Init saves it to `ignored/stack-snippets.md`.

## Notes
- Static export means no request-time server features: no Server Actions, request-dependent route handlers or Draft Mode.
- Not included yet (open in the source project): `loading.tsx`, `error.tsx`, `not-found.tsx`, react-compiler, and a favicon.
