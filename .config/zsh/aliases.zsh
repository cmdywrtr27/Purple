#        _ _
#   __ _| (_) __ _ ___  ___ ___
#  / _` | | |/ _` / __|/ _ / __|
# | (_| | | | (_| \__ |  __\__ \
#  \__,_|_|_|\__,_|___/\___|___/
#

alias rm="echo 'Maybe try trash-put? Or TP'"
alias recon="openbox --reconfigure && echo 'Openbox reloaded!'"
alias flex="jfetch"

alias mirrors="sudo reflector --verbose --country "United States" --age 12 --latest 20 --fastest 20 --number 20 --threads 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"

alias music="/home/josh/.local/bin/rxvt -g 93x13 -e ncmpcpp"
alias figlet="figlet -o -t -f ogre"
alias debian="ssh docker@192.168.1.118"
alias wifi="nmtui"
alias aedit="$EDITOR $ZSH_DIR/aliases.zsh"
alias fedit="$EDITOR $ZSH_DIR/functions.zsh"
alias vedit="$EDITOR $HOME/.vimrc"
alias calias="cat $ZSH_DIR/aliases.zsh"
#alias tmux="tmux -2"
alias fix_keys="sudo pacman-key --init && sudo pacman-key --populate archlinux && sudo pacman-key --refresh-keys"
alias please="sudo !!"
alias tp="trash-put"
alias gc="git clone"
alias config="/usr/bin/git --git-dir=$HOME/Dotfiles/ --work-tree=$HOME"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias dc="docker-compose"
alias sr="sudo reboot"
alias ss="sudo shutdown -h now"
alias sp="sudo pacman -S --noconfirm"
#alias cleanup="sudo pacman -rns $(pacman -qtdq)"
#alias diff="diff-so-fancy"
alias x="exit"
alias bk="cd -"
alias load="xrdb -load ~/.Xresources"
alias merge="xrdb -merge ~/.Xresources"
alias update_grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias l="exa -al --header --icons --color=always --sort=name"
alias ll="exa -al --header --icons --color=always --group-directories-first"
alias la="exa -al --header --icons --color=always --time-style=long-iso --accessed --sort=accessed"
alias lc="exa -al --header --icons --color=always --time-style=long-iso --created --sort=created"
alias ls="exa -al --header --icons --color=always --sort=size"
alias ld="exa -al --header --icons --color=always --sort=date"
alias lt="exa -al --header --icons --color=always --sort=type"
alias lm="exa -al --header --icons --color=always --sort=modified"
alias lx="exa -al --header --icons --color=always --sort=extension"
alias lg="exa -al --header --icons --color=always --sort=name --group-directories-first"
alias lr="exa -alr --header --icons --color=always --sort=name --group-directories-first"
alias l.="exa -al --header --icons --color=always --sort=name | grep -E '^\.'"

alias vi="vim"
alias icon="sudo gtk-update-icon-cache /usr/share/icons/* && gtk-update-icon-cache $HOME/.icons/*"
alias font="fc-cache -f -v"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
#alias pgrep="ps aux | grep"
alias cp="cp -iv"
alias mv="mv -iv"
alias wget="wget -c"
alias ip="ip -c"

alias enable_vbox="sudo modprobe vboxdrv vboxnetadp vboxnetflt vboxpci"
alias disable_vbox="sudo modprobe -r vboxdrv vboxnetadp vboxnetflt vboxpci"

alias mpd_start="systemctl start mpd.service --user"
alias mpd_stop="systemctl stop mpd.service --user"
alias mute="amixer -D pulse set Master 1+ mute"
alias unmute="amixer -D pulse set Master 1+ unmute"

alias ym="youtube-dl -xic --audio-format mp3 --add-metadata"
alias yt="youtube-dl -xic --add-metadata"
alias ytmp3="youtube-dl -x --audio-format mp3"

alias pingg="curl ipinfo.io/ip && ping -c 5 -q google.com"
alias speed_test="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"

alias el="expressvpn list all"
alias ed="expressvpn disconnect"
alias ec="expressvpn connect $1"
alias es="expressvpn status"
alias er="~/.local/bin/smartvpn"

alias hfd="huggingface-cli download"

#alias gcl="git clone --depth 1"
#alias gi="git init"
#alias ga="git add"
#alias gc="git commit -m"
#alias gp="git push origin master"
