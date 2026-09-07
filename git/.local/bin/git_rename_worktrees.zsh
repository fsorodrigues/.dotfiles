#!/usr/bin/env zsh

emulate -L zsh
setopt err_return pipe_fail

typeset -A worktrees
local search=${1:-}
local field location=''

if [[ -z $search ]]; then
  print -u2 -- "Usage: $0 <search-string>"
  exit 1
fi

while IFS= read -r -d '' field; do
  case $field in
    'worktree '*)
      location=${field#worktree }
      ;;
    'branch '*)
      [[ ${location:l} == *${search:l}* ]] && worktrees[$location]=${field#branch refs/heads/}
      ;;
    detached)
      [[ ${location:l} == *${search:l}* ]] && worktrees[$location]='(detached)'
      ;;
  esac
done < <(git worktree list --porcelain -z)

for location in ${(ok)worktrees}; do
  branch=$worktrees[$location]
  [[ $branch == '(detached)' ]] && continue

  new_name=${branch##*/}
  new_location=${location:h}/$new_name

  if [[ $location == $new_location ]]; then
    print -r -- "skip unchanged: $location"
    continue
  fi

  print -r -- "move $location -> $new_location"
  git worktree move -- "$location" "$new_location"
done
