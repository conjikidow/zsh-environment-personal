if [[ $OSTYPE == "linux-gnu" ]]; then
    source $ZDOTDIR/zshrc_ubuntu.sh
    source $ZDOTDIR/zshrc_utokyo.sh
elif [[ $OSTYPE == "darwin" ]]; then
    source $ZDOTDIR/zshrc_macos.sh
fi

source $ZDOTDIR/zshrc_common.sh
