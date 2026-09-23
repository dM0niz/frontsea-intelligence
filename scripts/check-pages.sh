#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

required=(
  "index.html"
  "privacy/index.html"
  "CNAME"
)

for file in "${required[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing required page: $file" >&2
    exit 1
  fi
done

if ! grep -q "Privacy Policy" privacy/index.html; then
  echo "privacy/index.html does not contain expected Privacy Policy heading" >&2
  exit 1
fi

if ! grep -q "DRAFT" privacy/index.html && ! grep -q "Draft" privacy/index.html; then
  echo "privacy/index.html is missing draft legal-review notice" >&2
  exit 1
fi

echo "Page check passed: index.html and privacy/index.html present."
