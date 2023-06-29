#  ___ _   _ _  _  ___ _____ ___ ___  _  _ ___
# | __| | | | \| |/ __|_   _|_ _/ _ \| \| / __|
# | _|| |_| | .` | (__  | |  | | (_) | .` \__ \
# |_|  \___/|_|\_|\___| |_| |___\___/|_|\_|___/
#

# Font information (fontq Inconsolata)
fontq() {
    fc-list | rg -i $1
}

# Weather by zip code or city name (weather 90210 or weather Beverly Hills)
weather() {
    declare -a WEATHERARRAY
    WEATHERARRAY=( `lynx -dump "http://www.google.com/search?hl=en&lr=&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&q=weather+${1}&btnG=Search" | grep -A 5 -m 1 "Weather for"`)
        echo ${WEATHERARRAY[@]}
}

# Translate a word (translate car french)
#translate() {
#    TRANSLATED=`lynx -dump "http://dictionary.reference.com/browse/${1}" | grep -i -m 1 -w "${2}:" | sed 's/^[ \t]*//;s/[ \t]*$//'`
#    if [ ${#TRANSLATED} != 0 ]; then
#        echo "\"${1}\" in ${TRANSLATED}"
#    else
#        echo "Sorry, I can not translate \"${1}\" to ${2}"
#    fi
#}

# Define a word (define selfish)
define() {
    lynx -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 3 -w "*" | sed 's/;/ -/g' | cut -d- -f1 > /tmp/templookup.txt
    if [ -s  /tmp/templookup.txt ]; then
        until ! read response
            do
            echo "${response}"
            done < /tmp/templookup.txt
        else
            echo "Sorry, the term \"${1} \" wasn't found"
    fi
rm -f /tmp/templookup.txt
}

# Extract tar and zip files (extract "filename")
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xvjf $1 ;;
            *.tar.gz)    tar xvzf $1 ;;
            *.bz2)       bunzip2 $1 ;;
            *.rar)       rar x $1 ;;
            *.gz)        gunzip $1 ;;
            *.tar)       tar xvf $1 ;;
            *.tbz2)      tar xvjf $1 ;;
            *.tgz)       tar xvzf $1 ;;
            *.zip)       unzip $1 ;;
            *.Z)         uncompress $1 ;;
            *.7z)        7z x $1 ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Copy and go (cpg "filename")
cpg() {
    if [ -d "$2" ]; then
        cp $1 $2 && cd $2
    else
        cp $1 $2
    fi
}

# Move and go (mvg "filename")
mvg() {
    if [ -d "$2" ]; then
        mv $1 $2 && cd $2
    else
        mv $1 $2
    fi
}

# Create and go (mkdirr "directory name")
mkdirg() {
    mkdir -p "$1" && cd "$1"
}

# Colored man pages (man "term")
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;40;35m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;33m") \
		man "$@"
}

# Directory size (dirsize "directory name")
dirsize() {
    local directory="${1:-$PWD}"
    local size
    size=$(du -sh "$directory" 2> /dev/null | cut -f1)

    if [ -n $size ]; then
        echo "Size of $directory: $size"
    else
        echo "Failed to retrieve size of $directory."
    fi
}

# Backup files (bu "filename")
bu() {
    cp $1 ${1}-`date +%Y-%m-%d_%H:%M:%S`.bak ;
}

# List files after changing directories
chpwd() {
    exa --header --long --all --grid --icons --color=always --git --sort=name --no-user --no-time --no-filesize --no-permissions
}

# Update your Arch Linux machine
update() {
echo "Updating mirrors..."
sudo reflector --age 6 --latest 10 --fastest 10 --sort rate --protocol https --save /etc/pacman.d/mirrorlist
echo "Updating repos"
sudo pacman -Syyy
yay -Syyy
echo "Updating system"
sudo pacman -Syu --noconfirm
yay -Syu --noconfirm && yay -Qqe > ~/Documents/arch_packages.lst
}

# Run with sudo (strg+x,s)
run-with-sudo() {
    LBUFFER="sudo $LBUFFER"
}
zle -N run-with-sudo
bindkey '^Xs' run-with-sudo

# Top ten memory hogs (memtop)
memtop() {
    ps -eorss,args | gsort -nr | gpr -TW$COLUMNS | ghead
}
zle -N memtop

# Show newest files (newest)
newest() {
    find . -type f -printf '%TY-%Tm-%Td %TT %p\n' | grep -v cache | grep -v ".hg" | grep -v ".git" | sort -r | less
}

# Rename all files in a directory
massmove() {
    ls > ls; paste ls ls > ren; vi ren; sed 's/^/mv /' ren|bash; rm ren ls
}

# Put a clock in top right corner (what-time-is-it)
what-time-is-it() {
    while sleep 1;
    do
        tput sc
        tput cup 0 $(($(tput cols)-29))
        date
        tput rc
    done &
}

# Create new script with shebang and make it executable (shebang "filename")
shebang() {
    if i=$(which $1);
    then
        printf '#!/usr/bin/env %s\n\n' $1 > $2 && chmod 755 $2 && vim + $2 && chmod 755 $2;
    else
        echo "'which' could not find $1, is it in your \$PATH?";
    fi;
    rehash
}

# Translate via Google Language Tools (translate "word")
translate() {
    wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'
}
