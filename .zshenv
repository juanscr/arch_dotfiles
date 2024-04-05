# XDG Compliance
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf;"
export ASPELL_CONF="${ASPELL_CONF} personal $XDG_CONFIG_HOME/aspell/en.pws;"
export ASPELL_CONF="${ASPELL_CONF} repl $XDG_CONFIG_HOME/aspell/en.prepl;"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass

export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var

export PYLINTHOME="$XDG_CACHE_HOME"/pylint

export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config

# QT5 variables
export QT_QPA_PLATFORMTHEME=qt5ct

# Configuration for other ZSH config file
export ZDOTDIR="$XDG_CONFIG_HOME/zsh/"

# Path chages
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$HOME/.local/share/bin
export PATH=$PATH:$HOME/.cabal/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/cargo/bin

