# XDG Compliance
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

export JUPYTER_PLATFORM_DIRS="$XDG_CONFIG_HOME"/jupyter

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf;"
export ASPELL_CONF="${ASPELL_CONF} personal $XDG_CONFIG_HOME/aspell/en.pws;"
export ASPELL_CONF="${ASPELL_CONF} repl $XDG_CONFIG_HOME/aspell/en.prepl;"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass

export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config

export PYLINTHOME="$XDG_CACHE_HOME"/pylint

export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export npm_config_prefix="$HOME/.local"

export R_HOME_USER="$XDG_CONFIG_HOME/R"
export R_PROFILE_USER="$XDG_CONFIG_HOME/R/profile"
export R_HISTFILE="$XDG_CONFIG_HOME/R/history"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"

# Other variables
export BROWSER="/usr/bin/chromium"
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

# Configuration for other ZSH config file
export ZDOTDIR="$XDG_CONFIG_HOME/zsh/"

# Path chages
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$HOME/.local/share/bin
export PATH=$PATH:$HOME/.cabal/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/cargo/bin

# ISCOBOL
export ISCOBOL=/home/juanscr/programs/isCOBOL2019R2
export ISCOBOL_JDK_ROOT=/usr/lib/jvm/java-8-openjdk
export LD_LIBRARY_PATH=$ISCOBOL/native/lib
export PATH=$ISCOBOL/bin:$PATH

