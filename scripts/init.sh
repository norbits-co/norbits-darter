#!/usr/bin/env bash
# set up a new project from the template: scripts/init.sh <stack>
set -euo pipefail

stack="${1:-}"

if [ -z "$stack" ] || [ ! -d "stacks/$stack" ]; then
  echo "usage: scripts/init.sh <stack>" >&2
  echo "stacks:" >&2
  for d in stacks/*/; do echo "  $(basename "$d")" >&2; done
  exit 1
fi

# stack files onto the project root, never overwriting existing files (optional)
if [ -d "stacks/$stack/overlay" ]; then
  cp -Rn "stacks/$stack/overlay/." .
fi

# stack ignore rules
cat "stacks/$stack/gitignore.additions" >> .gitignore

# ignored/ becomes local-only: uncomment it and drop the maintainer entries
sed -i 's|^# ignored/$|ignored/|' .gitignore
sed -i '/^# template maintainer/,/^$/d' .gitignore
sed -i '/^# tracked in the template/d' .gitignore

# local skeletons become the real files (kept if they already exist)
for example in ignored/*.example.md ignored/docs/*.example.md; do
  [ -e "$example" ] || continue
  target="${example%.example.md}.md"
  if [ -e "$target" ]; then rm "$example"; else mv "$example" "$target"; fi
done

# unused stacks and this script are no longer needed
cp "stacks/$stack/snippets.md" ignored/stack-snippets.md
rm -rf stacks scripts/init.sh
rmdir scripts 2>/dev/null || true

echo "done. next: follow the setup checklist in ignored/stack-snippets.md, then paste its blocks into AGENTS.md and docs/."
