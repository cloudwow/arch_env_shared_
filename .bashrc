# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export EDITOR="emacs -nw"
export EDITOR="emacs"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# sync history at every prompt
PROMPT_COMMAND="history -a; history -n"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
#include dot file in expansions
shopt -s dotglob

# command that is the name of a directory cd's into that dir
shopt -s autocd
shopt -s cmdhist # save multi-line commands in history as single line
#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.aliases-personal ]; then
    . ~/.aliases-personal
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



# Add a new alias to your saved environment on the fly.
aa() {
    echo "alias $1='$2'" >> /root/.aliases-personal
    source ~/.aliases-personal
    echo "'$1' is now aliased to '$2'"
}

#NICE COMMAND PROMPT
# PS1="\e[0;33m[\W]\e[0;34m$ \e[m"
PS1="\[\e[;31m\][\W]\$ \[\e[m\]"

if [ -d "$HOME/.bin" ] ;
then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
then PATH="$HOME/.local/bin:$PATH"
fi
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.emacs.d/bin
PATH=$PATH:$HOME/Android/Sdk/tools/bin
PATH=$PATH:$HOME/Android/Sdk/build-tools/33.0.0

export JAVA_HOME="$(dirname $(dirname $(realpath $(which javac))))"
# dart
export PATH="$PATH":"$HOME/.pub-cache/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64:/opt/cuda/extras/CUPTI/lib64"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/david/workspace/one/python_env/lib/python3.10/site-packages/tensorrt"
export CUDA_HOME=/opt/cuda


export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/libcusparse_lt/lib64"
#
export OPENSSL_LIB_DIR="/usr/lib/openssl-1.0"
export OPENSSL_INCLUDE_DIR="/usr/include/openssl-1.0"

# show colors to prove we have 24 bit color
show_colors()
{
awk -v term_cols="${width:-$(tput cols || echo 80)}" 'BEGIN{
    s="/\\";
    for (colnum = 0; colnum<term_cols; colnum++) {
        r = 255-(colnum*255/term_cols);
        g = (colnum*510/term_cols);
        b = (colnum*255/term_cols);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum%2+1,1);
    }
    printf "\n";
}'
}
show_colors
printf "\nHello David.\n\n"

#show starship prompt.  install starship to make this work
eval "$(starship init bash)"
. "$HOME/.cargo/env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/david/google-cloud-sdk/path.bash.inc' ]; then . '/home/david/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/david/google-cloud-sdk/completion.bash.inc' ]; then . '/home/david/google-cloud-sdk/completion.bash.inc'; fi

export CM_LAUNCHER=rofi
export CM_OUTPUT_CLIP=1


export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable

export PATH="$PATH:/home/david/.dotnet/tools"
export PATH="$PATH:/home/david/workspace/Rekordo/src/backend/cli/bin/Debug/net8.0"

# pnpm
export PNPM_HOME="/home/david/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export DOTNET_CLI_TELEMETRY_OPTOUT=true
export LD_LIBRARY_PATH=/home/david/.local/lib/arch-mojo:$LD_LIBRARY_PATH
