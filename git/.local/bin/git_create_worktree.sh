#!/usr/bin/env bash
#
# git_create_worktree.sh - Create a git worktree from a structured branch name
#
# USAGE:
#   git_create_worktree.sh <long_branch> [delimiter] [head]
#
# ARGUMENTS:
#   long_branch   Full branch name using a delimiter-separated structure
#                 (e.g. "feature/my-task"). Used as the new branch name.
#   delimiter     Character separating the branch type from the short name.
#                 Defaults to "/".
#   head          Base commit/branch to create the worktree from.
#                 Defaults to "master".
#
# DESCRIPTION:
#   Splits <long_branch> on the delimiter to derive:
#     - type:         The prefix segment (e.g. "feature", "fix")
#     - short_branch: The suffix segment used as the worktree directory name
#
#   Then runs:
#     git worktree add -b <long_branch> ./<short_branch> <head>
#
# EXAMPLES:
#   git_create_worktree.sh feature/my-task
#     -> Creates branch "feature/my-task" in worktree directory "./my-task"
#        based off "master"
#
#   git_create_worktree.sh fix/login-bug / develop
#     -> Creates branch "fix/login-bug" in worktree directory "./login-bug"
#        based off "develop"

set -e

long_branch=$1
delimiter=${2:-/}
head=${3:-master}

# Extract the type prefix (e.g. "feature") and the short branch name (e.g. "my-task")
type=$(echo "$long_branch" | cut -d "$delimiter" -f 1)
short_branch=$(echo "$long_branch" | cut -d "$delimiter" -f 2)

# Create a new worktree with a new branch, placed in a directory named after the short branch
git worktree add -b $long_branch ./$short_branch $head
