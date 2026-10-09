# Testing

## What must be tested
- Map every acceptance criterion to suitable evidence. Meaningful behaviour needs an automated test. Inspection, browser evidence or screenshots are fine where a new automated test adds little (e.g. a layout criterion or a docs change).
- Bug fixes: a regression test that fails without the fix.
- Tests assert the intended requirement, not whatever the code currently does. A test must fail if the requested behaviour breaks.

## Test layers
<!-- Unit / integration / e2e: what each covers and where it lives (e.g. colocated *.test.ts, e2e/ for Playwright). -->

## Critical scenarios
<!-- The flows that must never break (login, checkout, data export...). Each needs an automated test. -->
- Primary navigation works by keyboard and on mobile.
- Missing content shows a clearly marked placeholder, never invented text.

## Commands
- `pnpm test`: unit/integration tests
- `pnpm test:e2e`: browser tests (add when Playwright is set up)

## Rules
- Flaky tests: never retry until green. Quarantining a test requires an owner, a linked issue, a reason, and a restoration condition (e.g. "fix by <date>" or "after #123 merges"). Without all four, the failure stays in the gate.
- Never weaken or delete a test just to get CI green. You may correct or replace an outdated test when the approved requirement changed: explain why in the PR and keep meaningful coverage. If it is unclear whether the test or the code is wrong, ask a human.
- UI changes: verify in the browser (mobile and desktop) and attach screenshots to the PR.
- Database changes: test against a disposable database, never production data.

## Manual checks
Automated verification is the default. List here what still needs a human, and report in the PR which manual checks remain:
- Appearance on real phones, and accessibility (keyboard, screen reader basics).
- Sign-off on content, branding and assets, if the project has a client.
- Preview site is not indexed (robots / `noindex`) and its stable URL works.
- Production rollout and DNS.
