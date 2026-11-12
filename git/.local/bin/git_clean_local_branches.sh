#!/usr/bin/env bash

# Examples of call:
# git_clean_local_branches.sh
# => targets origin as the remote reference
#
# git_clean_local_branches.sh my-remote
# => targets my-remote as the remote reference
#
# git_clean_local_branches.sh --confirm [my-remote]
# => asks for confirmation before deleting each branch (-c also works)

remote=origin
confirm=false
remote_set=false

for argument in "$@"; do
    case "$argument" in
        -c|--confirm)
            confirm=true
            ;;
        -*)
            printf 'Unknown option: %s\n' "$argument" >&2
            exit 1
            ;;
        *)
            if "$remote_set"; then
                printf 'Specify only one remote.\n' >&2
                exit 1
            fi
            remote=$argument
            remote_set=true
            ;;
    esac
done

# update remote branches and prune all remote references that do not exist anymore
git fetch "$remote" --prune || exit $?

# identify all branches that are "gone" (aka deleted in remote)
mapfile -t branches < <(git branch -vv | rg 'gone]' | awk '!/^[+*]/ {print $1}')

if ! "$confirm"; then
    if ((${#branches[@]})); then
        git branch -d "${branches[@]}"
    fi
    exit $?
fi

status=0
for branch in "${branches[@]}"; do
    if read -r -p "Delete branch '$branch'? [y/N] " answer; then
        case "$answer" in
            [yY]|[yY][eE][sS])
                git branch -d "$branch" || status=$?
                ;;
        esac
    fi
done
exit "$status"
