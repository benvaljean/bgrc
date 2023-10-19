#!/bin/bash

# This script parse the output from magic-monty/bash-git-prompt/gitstatus.sh and ouptuts a string to be used as part of a shell prompt

function replaceSymbols() {
  # Disable globbing, so a * could be used as symbol here
  set -f

  if [[ -z ${GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING+x} ]]; then
    GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING=🏡
  fi

  local VALUE="${1//_AHEAD_/${GIT_PROMPT_SYMBOLS_AHEAD}}"
  local VALUE1="${VALUE//_BEHIND_/${GIT_PROMPT_SYMBOLS_BEHIND}}"
  local VALUE2="${VALUE1//_NO_REMOTE_TRACKING_/${GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING}}"

  echo "${VALUE2//_PREHASH_/${GIT_PROMPT_SYMBOLS_PREHASH}}"

  # reenable globbing symbols
  set +f
}

GIT_PROMPT_SYMBOLS_AHEAD="↑·"
GIT_PROMPT_SYMBOLS_BEHIND="↓·"
GIT_PROMPT_SYMBOLS_PREHASH=":"

#repo=$(git rev-parse --show-toplevel 2> /dev/null)
#if [[ ! -e "${repo}" ]] && [[ "${GIT_PROMPT_ONLY_IN_REPO-}" = 1 ]]; then
#  # we do not permit bash-git-prompt outside git repos, so nothing to do
#  #PS1="${OLD_GITPROMPT}"
#  exit
#fi

git_dir="$(git rev-parse --git-dir 2>/dev/null)"
[[ -z "${git_dir:+x}" ]] && exit 0


#local -a git_status_fields

function showprompt() {
    __GIT_STATUS_CMD=~/git/bgrc/gitstatus.sh

    while IFS=$'\n' read -r line; do git_status_fields+=("${line}"); done < <("${__GIT_STATUS_CMD}" 2>/dev/null)



    export GIT_BRANCH=$(replaceSymbols "${git_status_fields[0]}")
    local GIT_REMOTE="$(replaceSymbols "${git_status_fields[1]}")"

    local GIT_REMOTE_USERNAME_REPO="$(replaceSymbols "${git_status_fields[2]}")"

    if [[ "." == "${GIT_REMOTE_USERNAME_REPO}" ]]; then
    unset GIT_REMOTE_USERNAME_REPO
    fi
    local GIT_UPSTREAM_PRIVATE="${git_status_fields[3]}"
    local GIT_STAGED="${git_status_fields[4]}"
    local GIT_CONFLICTS="${git_status_fields[5]}"
    local GIT_CHANGED="${git_status_fields[6]}"
    local GIT_UNTRACKED="${git_status_fields[7]}"
    local GIT_STASHED="${git_status_fields[8]}"
    local GIT_CLEAN="${git_status_fields[9]}"

    if [[ $GIT_CLEAN == "1" ]]; then
        GIT_CLEAN_SYMBOL=💯
    else
        GIT_CLEAN_SYMBOL=😈
    fi

    if [[ $GIT_REMOTE == "_NO_REMOTE_TRACKING_" ]]; then
        REMOTE_PROMPT="LOCAL"
    elif [[ $GIT_REMOTE == "." ]]; then
        REMOTE_PROMPT=""
    fi

    COLOUR_MAGENTA='\[\e[0;35m\]'
    COLOUR_RESET='\[\033[m\]'

    if [[ $GIT_UNTRACKED == "0" ]]; then
        GIT_UNTRACKED_SHOWN=""
    else
        GIT_UNTRACKED_SHOWN=┅${GIT_UNTRACKED}
    fi
    if [[ $GIT_CHANGED == "0" ]]; then
        GIT_CHANGED_SHOWN=""
    else
        GIT_CHANGED_SHOWN=+${GIT_CHANGED}
    fi

    if [[ $GIT_STAGED == "0" ]]; then
        GIT_STAGED_SHOWN=""
    else
        GIT_STAGED_SHOWN=🚧${GIT_STAGED}
    fi
    if [[ $GIT_STASHED == "0" ]]; then
        GIT_STASHED_SHOWN=""
    else
        GIT_STASHED_SHOWN=📌${GIT_STASHED}
    fi
    if [[ $GIT_CONFLICTS == "0" ]]; then
        GIT_CONFLICTS_SHOWN=""
    else
        GIT_CONFLICTS_SHOWN=💁${GIT_CONFLICTS}
    fi

    prompt=${COLOUR_MAGENTA}⑂${GIT_BRANCH}${COLOUR_RESET}${GIT_REMOTE}${GIT_REMOTE_USERNAME_REPO}${GIT_UNTRACKED_SHOWN}${GIT_CHANGED_SHOWN}${GIT_STAGED_SHOWN}${GIT_STASHED_SHOWN}${GIT_CONFLICTS_SHOWN}${GIT_CLEAN_SYMBOL}
}

showprompt
echo "$prompt "

