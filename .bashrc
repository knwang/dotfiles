# ~/.bashrc
# vim:set ft=sh sw=2 sts=2:

# Store 10,000 history entries
export HISTSIZE=10000
# Don't store duplicates
export HISTCONTROL=erasedups
# Append to history file
shopt -s histappend

VISUAL=vim
EDITOR="$VISUAL"
LESS="FRX"
RI="--format ansi -T"
PSQL_EDITOR='vim -c"setf sql"'
CLICOLOR=1
LSCOLORS=gxgxcxdxbxegedabagacad

export VISUAL EDITOR LESS RI PSQL_EDITOR CLICOLOR LSCOLORS

bind 'set bind-tty-special-chars off'
bind '"\ep": history-search-backward'
bind '"\en": history-search-forward'
bind '"\C-w": backward-kill-word'

export HISTIGNORE="%*"
bind '"\C-q": "%-\n"'

[ -z "$PS1" ] || stty -ixon
[ -z "$PS1" ] || export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$(git_prompt_info '(%s)')$ "


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export CC=/usr/local/bin/gcc-4.2

# git_prompt_info accepts 0 or 1 arguments (i.e., format string)
# returns text to add to bash PS1 prompt (includes branch name)
git_prompt_info () {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  if [ -n "$g" ]; then
    local r
    local b
    local d
    local s
    # Rebasing
    if [ -d "$g/rebase-apply" ] ; then
      if test -f "$g/rebase-apply/rebasing" ; then
        r="|REBASE"
      fi
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    # Interactive rebase
    elif [ -f "$g/rebase-merge/interactive" ] ; then
      r="|REBASE-i"
      b="$(cat "$g/rebase-merge/head-name")"
    # Merging
    elif [ -f "$g/MERGE_HEAD" ] ; then
      r="|MERGING"
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    else
      if [ -f "$g/BISECT_LOG" ] ; then
        r="|BISECTING"
      fi
      if ! b="$(git symbolic-ref HEAD 2>/dev/null)" ; then
        if ! b="$(git describe --exact-match HEAD 2>/dev/null)" ; then
          b="$(cut -c1-7 "$g/HEAD")..."
        fi
      fi
    fi

    # Dirty Branch
    local newfile='?? '
    if [ -n "$ZSH_VERSION" ]; then
      newfile='\?\? '
    fi
    d=''
    s=$(git status --porcelain 2> /dev/null)
    [[ $s =~ "$newfile" ]] && d+='+'
    [[ $s =~ "M " ]] && d+='*'
    [[ $s =~ "D " ]] && d+='-'

    if [ -n "${1-}" ]; then
      printf "$1" "${b##refs/heads/}$r$d"
    else
      printf "(%s) " "${b##refs/heads/}$r$d"
    fi
  fi
}

gco () {
  if [[ $1 == '.' ]]; then
    git add -A
    git commit -m "CHECKING OUT CURRENT DIRECTORY" -q
    git reset HEAD^ -q
    git checkout .
  else
    git checkout "$@"
  fi
}

alias gaa='git add --all'
alias gap='git add -p'
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdh='git diff HEAD'
alias gl='git pull'
alias glod='git log --oneline --decorate'
alias gln="git ln | perl -ple 's/\*/sprintf(\"%2s\", \$n++)/e' | less"
alias gp='git push'
alias gpr='git pull --rebase'
alias grep='grep --color=auto --exclude="*~"'
alias gst='git status'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias reset-authors='git commit --amend --reset-author -C HEAD'
alias vi='vim'
alias ll='ls -l'

bettervim="/Applications/MacVim.app/Contents/MacOS/Vim"
[ -f "$bettervim" ] && alias vim="$bettervim"
[ -f "$HOME$bettervim" ] && alias vim="$HOME$bettervim"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


DEV_DIR="$HOME/dev"
cdd() {
  cd "$DEV_DIR/$1"
}
