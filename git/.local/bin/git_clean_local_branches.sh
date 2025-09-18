#!/usr/bin/env bash

# Examples of call:
# git_clean_local_branches.sh
# => targets origin as the remote reference
#
# git_clean_local_branches.sh my-remote
# => targets my-remote as the remote reference

remote=${1:-origin}

# update remote branches and prune all remote references that do not exist anymore
git fetch $remote --prune

# identify all branches that are "gone" (aka deleted in remote)
git branch -vv | rg 'gone]' | awk '{print $1}' | xargs git branch -d

