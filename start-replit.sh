#!/usr/bin/env bash

set -Exeuo pipefail

if ! test -f .git; then
	git init
fi

if ! test -f .gitignore; then
	cat <<'EOF' >.gitignore
EOF
	git add .gitignore
fi

if ! test -f flake.nix; then
	cat <<'EOF' >flake.nix
{ pkgs }: {
  deps = [
  ];
}
EOF
	git add flake.nix
fi

if ! test -f replit.nix; then
	ln -s flake.nix replit.nix
	git add replit.nix
fi

git commit -m "chore: initialise repo for replit"

gh repo create --public --source=. --remote=origin --push
