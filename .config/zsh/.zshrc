# ============ ALIASES ============ #
# Editor
alias nvim="nvim --listen /tmp/nvim.pipe"
alias n="nvim"

# Latex
alias lmk="latexmk -pdf -output-directory=build"
alias lmks="lmk -shell-escape"

# Allows for using alias with sudo
alias sudo="sudo "

# Edit files with sudo privileges
alias se='SUDO_EDITOR="nvim" sudoedit'

# Ls with icons
alias ls='exa --icons --ignore-glob="__pycache__" --group-directories-first'
alias la='exa --icons --group-directories-first -lah'

# Autoremove equivalent
alias autoremove='pacman -Qtdq | sudo pacman -Rns -'

# Compression related commands
alias untar='tar xf'

# Movies related stuff
alias movie-mode='xset s off -dpms && remotemouse'
alias movie-mode-off='xset s 3600 3600 && killall remotemouse RemoteMouse'

# Update python
awkCom='{ match ($0, ".*==", a); gsub ("=", "", a[0]); print a[0] }'
instCom='xargs -n1 pip install --upgrade'
alias uppy='pip list --outdated --format=freeze | awk "$awkCom" | $instCom'

# ==== Coloring ==== #
alias grep='grep --color=auto'

# ==== XDG Compliance ==== #
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

# ==== Git ==== #
alias dfiles='/usr/bin/git --git-dir=$HOME/programs/arch_qtile_dotfiles --work-tree=$HOME'

# Function which calls git, if inside a repository or my dotfiles alias
# otherwise.
function gitd() {
  if ! git rev-parse --git-dir &>/dev/null
  then
    dfiles "$@"
  else
    git "$@"
  fi
}

# Function that pulls an specific branch from git.
function pullCheck() {
  branch=$(gitd branch -l | awk '/^\*.*/{ print $2 }')
  gitd checkout $1 && gitd pull
  gitd checkout $branch &>/dev/null
}

alias ga='gitd add'
alias gb='gitd branch'
alias gc='gitd checkout'
alias gca='gitd commit -a'
alias gcl='git clone'
alias gcm='gitd commit -m'
alias gd='gitd diff'
alias gp='gitd push'
alias gpc='pullCheck '
alias gpl='gitd pull'
alias gr='gitd rm'
alias grs='gitd restore --staged'
alias gs='gitd status'

# Generate video of commits
flags1='--auto-skip-seconds 1 --file-idle-time 0 --seconds-per-day 1'
flags2='-y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264'
flags3='-preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0'
alias gitvideo='gource $flags1 -1920x1080 -o - | ffmpeg $flags2 $flags3'

# Pacman update
alias drop-caches='sudo paccache -rk3; yay -Sc --aur --noconfirm'
alias update-all='export TMPFILE="$(mktemp)"; \
    sudo true && \
    rate-mirrors --save=$TMPFILE --entry-country=CO arch --max-delay=21600 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
      && drop-caches \
      && yay -Syyu --noconfirm'

# ==== Keybindings ==== #
# Function for interactive shell
function is_interactive_shell() {
  [[ "$-" =~ "i" ]]
}

# === Prompt === #
# VCS Info loading for git information
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '('$branch') '
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

# Prompt
GREEN="%F{#50FA7B}"
BLUE="%F{#BD93F9}"
RESET="%f"
PS1="%B${GREEN}\$(git_branch_name)${RESET}${BLUE}%1d ${RESET}%b> "

# History parameters
HISTFILE="$XDG_CONFIG_HOME/zsh/.zshhistory"
HISTSIZE=2000
SAVEHIST=1000
setopt extendedglob notify

# Private aliases
if [ -f "$ZDOTDIR/.secure_aliases" ]; then
    source $ZDOTDIR/.secure_aliases
fi


# SSH Agent autostart
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi


# Autocompletion
zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"
autoload -Uz compinit bashcompinit
compinit
bashcompinit

# AWS completion
complete -C '/usr/bin/aws_completer' aws

# Plugin for better completion
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_MANUAL_REBIND="manual"
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Plugin for syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Fix for root bind warning
# http://gurdiga.com/blog/2018/04/14/bind-warning-line-editing-not-enabled/
if is_interactive_shell; then
  bindkey "\ew" forward-word
  bindkey "\eb" backward-word
  bindkey "\eh" backward-char
  bindkey "\el" forward-char
  bindkey "\e$" end-of-line
  bindkey "\e0" beginning-of-line
  bindkey "\en" next-history
  bindkey "\ep" previous-history
  bindkey '^ ' autosuggest-accept
fi

