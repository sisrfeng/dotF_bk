#!/usr/bin/env zsh

# lwf改过变量名，todo：检查一遍
# dir: directory
# hst: histor

# In both cases the history is  always saved to both
# the global history  and the dir history, so the toggle state will not effect the saved histories.
#
#-------------------------------------------------------------------------------
# Configuration
#-------------------------------------------------------------------------------
#
# HISTORY_BASE a global variable that defines the base dir in which the
# dir histories are stored

#-------------------------------------------------------------------------------
# configuration, the base under which the dir histories are stored
#-------------------------------------------------------------------------------

[[ -z $HISTORY_BASE ]] && HISTORY_BASE="$HOME/.dir_history"
[[ -z $HISTORY_START_WITH_GLOBAL ]] && HISTORY_START_WITH_GLOBAL=false


function per-dir-history-toggle() {
    if [[ $_per_dir_hst_is_global == true ]]; then
        _per-dir-hst-set-dir-history
        _per_dir_hst_is_global=false
        print -n "\nusing local history"
    else
        _per-dir-hst-set-global-history
        _per_dir_hst_is_global=true
        print -n "\nusing global history"
    fi
    zle .push-line
    zle .accept-line
}

autoload per-dir-history-toggle
zle -N per-dir-history-toggle
# toggle global/dir history used for searching - ctrl-G by default
bindkey '^G' per-dir-history-toggle

#-------------------------------------------------------------------------------
# implementation details
#-------------------------------------------------------------------------------

_per_dir_hst_dir="$HISTORY_BASE${PWD:A}/history"

function _per-dir-hst-change-dir() {
    _per_dir_hst_dir="$HISTORY_BASE${PWD:A}/history"
    mkdir -p ${_per_dir_hst_dir:h}
    if [[ $_per_dir_hst_is_global == false ]]; then
        #save to the global history
        fc -AI $HISTFILE
        #save history to previous file
        local prev="$HISTORY_BASE${OLDPWD:A}/history"
        mkdir -p ${prev:h}
        fc -AI $prev

        #discard previous dir's history
        local original_histsize=$HISTSIZE
        HISTSIZE=0
        HISTSIZE=$original_histsize

        #read history in new file
        if [[ -e $_per_dir_hst_dir ]]; then
            fc -R $_per_dir_hst_dir
        fi
    fi
}

function _per-dir-hst-addhistory() {
    # respect hist_ignore_space
    if [[ -o hist_ignore_space ]] && [[ "$1" == \ * ]]; then
            true
    else
            print -Sr -- "${1%%$'\n'}"
            # instantly write history if set options require it.
            if [[ -o share_history ]] || \
                 [[ -o inc_append_history ]] || \
                 [[ -o inc_append_history_time ]]; then
                    fc -AI $HISTFILE
                    fc -AI $_per_dir_hst_dir
            fi
            fc -p $_per_dir_hst_dir
    fi
}

function _per-dir-hst-precmd() {
    if [[ $_per_dir_hst_initialized == false ]]; then
        _per_dir_hst_initialized=true

        if [[ $HISTORY_START_WITH_GLOBAL == true ]]; then
            _per-dir-hst-set-global-history
            _per_dir_hst_is_global=true
        else
            _per-dir-hst-set-dir-history
            _per_dir_hst_is_global=false
        fi
    fi
}

function _per-dir-hst-set-dir-history() {
    fc -AI $HISTFILE
    local original_histsize=$HISTSIZE
    HISTSIZE=0
    HISTSIZE=$original_histsize
    if [[ -e "$_per_dir_hst_dir" ]]; then
        fc -R "$_per_dir_hst_dir"
    fi
}

function _per-dir-hst-set-global-history() {
    fc -AI $_per_dir_hst_dir
    local original_histsize=$HISTSIZE
    HISTSIZE=0
    HISTSIZE=$original_histsize
    if [[ -e "$HISTFILE" ]]; then
        fc -R "$HISTFILE"
    fi
}

mkdir -p ${_per_dir_hst_dir:h}

#add functions to the exec list for chpwd and zshaddhistory
autoload -U add-zsh-hook
add-zsh-hook chpwd _per-dir-hst-change-dir
add-zsh-hook zshaddhistory _per-dir-hst-addhistory
add-zsh-hook precmd _per-dir-hst-precmd

# set initialized flag to false
_per_dir_hst_initialized=false
