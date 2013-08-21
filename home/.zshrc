
###############################################################################
# Basic shell settings

# Set the console color theme, if available
if [[ -e $HOME/bin/color-theme ]]; then
  . $HOME/bin/color-theme
fi

# Configure history file
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS
setopt appendhistory

# Set some random shell options
setopt autocd
unsetopt beep notify

# Oh My Zsh
if [[ -d /usr/share/oh-my-zsh ]]; then
  ZSH=/usr/share/oh-my-zsh
fi
if [[ -d $HOME/.oh-my-zsh ]]; then
  ZSH=$HOME/.oh-my-zsh
fi

if [[ ! -z "$ZSH" ]]; then
  ZSH_THEME="gentoo"
  DISABLE_AUTO_UPDATE="true"
  DISABLE_CORRECTION="true"
  plugins=(archlinux git bundler colored-man gem rake rbenv)
  source $ZSH/oh-my-zsh.sh
fi

###############################################################################
# Path settings

# TeX: pick up OS X TeXLive binary path
if [ -d /usr/local/texbin ]; then
  export PATH="/usr/local/texbin:$PATH"
fi

# Haskell Platform: find cabal binaries if installed
if [ -d $HOME/.cabal ]; then
  export PATH="$HOME/.cabal/bin:$PATH"
fi

# Always let home-directory binaries override everything
if [ -d $HOME/bin ]; then
  export PATH="$HOME/bin:$PATH"
fi

###############################################################################
# Configuration for other programs/systems

LANG=en_US.UTF-8
EDITOR=nano
LESSHISTFILE=-

if [ `uname -s` = "Darwin" ]; then
  # Disable mail checking and resource-fork copying, only on OS X
  export MAILPATH=""
  export COPYFILE_DISABLE=true
elif [ `uname -o` = "Cygwin" ]; then
  # Set some environment variables on Windows
  export TMP=/tmp
  export TEMP=/tmp
  export TMPDIR=/tmp

  # Enable SSH authentication through Pageant
  if [ -z "$SSH_AUTH_SOCK" -a -x /usr/local/bin/ssh-pageant ]; then
    eval $(/usr/local/bin/ssh-pageant -q)
  fi
  trap logout HUP
fi

###############################################################################
# Aliases for daily use

alias quit=exit

# Alias the various ways to open documents in accord with their file
# associations
if command -v xdg-open >/dev/null 2>&1; then
  alias open=xdg-open
elif command -v exo-open >/dev/null 2>&1; then
  alias open=exo-open
elif command -v kde-open >/dev/null 2>&1; then
  alias open=kde-open
elif command -v gvfs-open >/dev/null 2>&1; then
  alias open=gvfs-open
elif command -v gnome-open >/dev/null 2>&1; then
  alias open=gnome-open
elif command -v cygstart >/dev/null 2>&1; then
  alias open=cygstart
fi
alias start=open

# Dropbox: find all "conflicts", which just show up in the filesystem
alias db-conflicts='find -L ~/Dropbox \( -path "*.dropbox*" -prune \) -o \( -name "*conflicted*" -print \)'

# Development directories
dev() { cd ~/Development/$1; }
devm() { cd ~/Development/$1/master; }
_dev() { _files -W ~/Development -/; }
compdef _dev dev
compdef _dev devm

# Fast Dropbox access
db() { cd ~/Dropbox/Charles/$1; }
_db() { _files -W ~/Dropbox/Charles -/; }
compdef _db db
