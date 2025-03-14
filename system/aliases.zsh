#!/bin/sh
# modern make
if which mmake >/dev/null 2>&2; then
    alias make='mmake'
fi

# eza is a better ls tool
if which eza >/dev/null 2>&1; then
    alias ls='eza'
    alias l='eza -la --git'
    alias la='eza -laa --git'
    alias ll='eza -l --git'
else
    if [ "$(uname -s)" = "Darwin" ]; then
        alias ls="ls -FG"
    else
        alias ls="ls -F --color"
    fi
    alias l="ls -lAh"
    alias la="ls -A"
    alias ll="ls -l"
fi

alias grep="grep --color=auto"
# alias duf="du -sh * | sort -hr"
alias less="less -r"

# quick hack to make watch work with aliases
alias watch='watch '

# open, pbcopy and pbpaste on linux
if [ "$(uname -s)" != "Darwin" ]; then
    if [ -z "$(command -v pbcopy)" ]; then
        if [ -n "$(command -v xclip)" ]; then
            alias pbcopy="xclip -selection clipboard"
            alias pbpaste="xclip -selection clipboard -o"
        elif [ -n "$(command -v xsel)" ]; then
            alias pbcopy="xsel --clipboard --input"
            alias pbpaste="xsel --clipboard --output"
        fi
    fi
    if [ -e /usr/bin/xdg-open ]; then
        alias open="xdg-open"
    fi
fi


# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
# if $(gls &>/dev/null)
# then
#   alias ls="gls -F --color"
#   alias l="gls -lAh --color"
#   alias ll="gls -l --color"
#   alias la='gls -A --color'
#   alias lsa="gls -lah -F --color"
#   alias lt="gls -lAh --color --time-style=long-iso"
# fi
