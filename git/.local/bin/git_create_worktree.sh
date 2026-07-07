#!/usr/bin/env bash
#
# git_create_worktree.sh - Create a git worktree from a structured branch name
#
# Usage:
#   git_create_worktree.sh <long_branch> [delimiter] [head]
#
# Examples:
#   git_create_worktree.sh feature/my-task
#   git_create_worktree.sh fix/login-bug / develop

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: git_create_worktree.sh <long_branch> [delimiter] [head]" >&2
  exit 1
fi

long_branch=$1
delimiter=${2:-/}
head=${3:-master}
short_branch=${long_branch#*"$delimiter"}

if [[ "$short_branch" == "$long_branch" || -z "$short_branch" ]]; then
  echo "Branch '$long_branch' must contain delimiter '$delimiter'." >&2
  exit 1
fi

git worktree add -b "$long_branch" "./$short_branch" "$head"
