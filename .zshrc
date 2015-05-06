ZSH=$HOME/.oh-my-zsh
ZSH_THEME="knwang"
plugins=(git brew osx vagrant wd gem z)
source $ZSH/oh-my-zsh.sh

# User configuration

homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

EDITOR='vim'

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
alias vim='mvim -v'
alias ll='ls -l'

alias r='rails'
alias rs='bin/rspec'
alias g='git'
alias h='heroku'
alias hc='heroku run console -a'
alias hlog='heroku logs -t -a'
alias m='middleman'

mux() {
  if [ ! -z $1 ]
  then
    cd ~/dev/$1
    tmux new -A -s $1
  else
    tmux new -A -s `basename $(pwd)`
  fi
}


export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export BUNDLER_EDITOR="vim"
eval "$(rbenv init -)"

function title {
  if [[ "$DISABLE_AUTO_TITLE" == "true" ]] || [[ "$EMACS" == *term* ]]; then
    return
  fi
  if [[ "$TERM" == screen* ]]; then
    print -Pn "\ek$1:q\e\\" #set screen hardstatus, usually truncated at 20 chars
  elif [[ "$TERM" == xterm* ]] || [[ $TERM == rxvt* ]] || [[ $TERM == ansi ]] || [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    # print -Pn "\e]1;$1:q\a" #set window name
    # print -Pn "\e]1;$1:q\a" #set icon (=tab) name
    print -Pn "\e]1;Terminal\a"  # for videos
  fi
}

if [ -f ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi
