# Release process

Releases and production deploys are manual and human-approved (see Forbidden actions in `AGENTS.md`). Agents prepare the release PR; the owner tags, publishes and deploys.

## Versioning
Semantic Versioning (`MAJOR.MINOR.PATCH`), tags prefixed with `v` (e.g. `v1.2.0`). Before `1.0.0`, minor versions may include breaking changes; say so in the changelog.

## Changelog
`CHANGELOG.md` follows Keep a Changelog. Add user-visible changes under `## [Unreleased]` in the PR that makes them (Added, Changed, Deprecated, Removed, Fixed, Security). Docs-only and CI-only changes can be left out.

## Steps
1. Make sure `main` is green and the milestone's work is merged.
2. Branch from `main`: `release/<person>-prepare-v1-2-0` (branch names allow only lowercase letters, digits and hyphens).
3. In that branch: move `[Unreleased]` entries under a new `## [1.2.0] - YYYY-MM-DD` heading, add the compare link at the bottom, and bump the version in the stack's manifest (`package.json`, `Cargo.toml`, `tauri.conf.json`, ...).
4. Open a PR titled `release: prepare v1.2.0` (assignee and milestone as usual) and run `pnpm verify`.
5. After merge, the owner tags `main` (`git tag -a v1.2.0 -m "v1.2.0"`, `git push origin v1.2.0`) and creates the GitHub release from that tag with "Generate release notes".
6. Deploy production manually, following the project's deployment notes (`ignored/docs/deployment.md`), then close the milestone.

## Hotfixes
Branch from the release tag or `main`, use a `bug/` branch and PR, then repeat steps 3 to 6 with a patch version.
