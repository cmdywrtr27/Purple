export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERMINAL=alacritty
export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox
export FZF_DEFAULT_OPS="--extended"
export PAGER=most
export MANPAGER="nvim +Man!"
#export MANPAGER='/bin/zsh -c "vim -Rn -c \"set buftype=nofile showtabline=0 ft=man ts=4 nomod nolist nornu nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export LESSHISTFILE=$XDG_CACHE_HOME/less_history
export LESSHISTSIZE=500

export ZSH_CACHE_DIR=~/.cache/zsh
export ZDOTDIR=~/.config/zsh
export ZSH_THEMES=$ZDOTDIR/themes
export ZSH_PLUGINS=$ZDOTDIR/plugins

export SCRIPTS=~/.local/bin
export PATH=$HOME/.local/bin:$PATH
export GOPATH=~/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#export TERM=xterm-256color

export QT_QPA_PLATFORMTHEME=qt5ct
