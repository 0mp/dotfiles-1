export ZSH=$HOME/.oh-my-zsh

ZSH_CUSTOM="$HOME/.zsh-custom"
ZSH_THEME="stevebob"

plugins=(git cargo rust archlinux z)

export PATH="$HOME/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.local/sbin:$PATH"
export EDITOR=vim
export VISUAL=vim

alias tmp='pushd `mktemp -d`'

if hash keychain 2>/dev/null; then
    eval `keychain --quiet --eval --agents ssh id_rsa`
fi

fpath+=~/.zfunc

source $ZSH/oh-my-zsh.sh

export I3_MOD_KEY=Mod4

if test -f $HOME/.profile; then
    source $HOME/.profile
fi

export CARGO_INCREMENTAL=0

OPAM_ZSH=$HOME/.opam/opam-init/init.zsh
if test -f $OPAM_ZSH; then
    # OPAM configuration
    . $OPAM_ZSH > /dev/null 2> /dev/null || true
fi

export RUST_SRC_PATH=$HOME/src/rust/src

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
