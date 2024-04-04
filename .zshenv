# Configuration for other ZSH config file
export ZDOTDIR="$XDG_CONFIG_HOME/zsh/"

# ISCOBOL
export ISCOBOL=/home/juanscr/programs/isCOBOL2019R2
export ISCOBOL_JDK_ROOT=/usr/lib/jvm/java-8-openjdk
export LD_LIBRARY_PATH=$ISCOBOL/native/lib
export PATH=$ISCOBOL/bin:$PATH

# Path chages
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$HOME/.local/share/bin
export PATH=$PATH:$HOME/.cabal/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/cargo/bin

# Other variables
export BROWSER="/usr/bin/chromium"
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
export npm_config_prefix="$HOME/.local"

