#!/usr/bin/env bash
#
# git_create_worktree.sh - Create a git worktree from a structured branch name
#
# Usage:
#   git_create_worktree.sh [-d directory] <long_branch> [delimiter] [head]
#
# Examples:
#   git_create_worktree.sh feature/my-task
#   git_create_worktree.sh fix/login-bug / develop
#   git_create_worktree.sh -d ../worktrees feature/my-task

set -euo pipefail

directory=.
directory_pending=false
arguments=()

for argument in "$@"; do
  if "$directory_pending"; then
    directory=$argument
    if [[ -z "$directory" ]]; then
      printf 'Directory must not be empty.\n' >&2
      exit 1
    fi
    directory_pending=false
    continue
  fi

  case "$argument" in
    -d)
      directory_pending=true
      ;;
    -*)
      printf 'Unknown option: %s\n' "$argument" >&2
      exit 1
      ;;
    *)
      arguments+=("$argument")
      ;;
  esac
done

if "$directory_pending"; then
  printf 'Option -d requires an argument.\n' >&2
  exit 1
fi

set -- "${arguments[@]}"

if [[ $# -lt 1 ]]; then
  echo "Usage: git_create_worktree.sh [-d directory] <long_branch> [delimiter] [head]" >&2
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

git worktree add -b "$long_branch" "${directory%/}/$short_branch" "$head"
