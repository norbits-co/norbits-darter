# Review guide

For AI and human reviewers. The AI reviewer's prompt should point here.

## How to review
1. Start from the linked issue. For each acceptance criterion report: met / unmet / could not verify.
2. Review the whole PR against its base branch, not just the last commit: `git diff $(git merge-base origin/main HEAD)...HEAD`.
3. Prioritize, in order: defects and unmet requirements, invented or unapproved content, security, architecture violations (`docs/architecture.md`), test quality (`docs/testing.md`), accessibility (UI changes), conventions the tools cannot enforce.
4. Substantiate every finding: file and line, a concrete failure scenario, or command output. State confidence. No speculative or purely stylistic comments; formatters and linters own style.
5. State what you did not verify (commands not run, UI not viewed, manual checks remaining).
6. If the diff touches a sensitive area (see `.github/CODEOWNERS` and the forbidden actions in `AGENTS.md`), flag it for the human owner. Do not approve it.

## Project-specific checks
<!-- Fill in per project, e.g. content that must come from approved material, stack limits (no server features in a static export), accessibility, no private data in public content or storage. -->

## Issue and PR templates
Check that issues and PRs follow their templates strictly. Every section must be present. A section with nothing to say must say `N/A`, not be deleted or left empty. Extra points go under additional topic headings after the template sections. Report deviations as findings.

Also check that each PR has an assignee and a milestone. Report a missing one as a finding.

## Output format
- **Verdict:** approve / changes requested / needs human decision
- **Criteria results:** one line per acceptance criterion
- **Findings:** by severity, each with evidence
- **Not verified:** what remains

## Responding to review comments
Evaluate each comment technically: agree, disagree with a reason, or escalate to a human. Do not implement a suggestion blindly or agree just to be agreeable.
