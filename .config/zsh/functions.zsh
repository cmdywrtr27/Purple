#   __                  _   _
#  / _|_   _ _ __   ___| |_(_) ___  _ __  ___
# | |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
#

# Font information (fontq Inconsolata)
fontq() {
    fc-list | grep -i $1
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
#    if [[ ${#TRANSLATED} != 0 ]]; then
#        echo "\"${1}\" in ${TRANSLATED}"
#    else
#        echo "Sorry, I can not translate \"${1}\" to ${2}"
#    fi
#}

#translate() {
#    wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'
#}

translate() {
    wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/';
}

shebang() {
    if i=$(which $1);
    then
        printf '#!/bin/bash %s\n\n' $1 > $2 && chmod 755 $2 && vim + $2 && chmod 755 $2;
    else
        echo "'which' could not find $1, is it in your \$PATH?";
    fi;
    # in case the new script is in path, this throw out the command hash table and
    # start over  (man zshbuiltins)
    rehash
}

# # Define a word (define selfish)

# define() {
#     lynx -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 3 -w "*" | sed 's/;/ -/g' | cut -d- -f1 > /tmp/templookup.txt
#     if [[ -s  /tmp/templookup.txt ]]; then
#         until ! read response
#             do
#             echo "${response}"
#             done < /tmp/templookup.txt
#         else
#             echo "Sorry, the term \"${1} \" wasn't found"
#     fi
# trash-put /tmp/templookup.txt
# }

define() {
    local word="$1"
    local api_key="a877abdd13mshcddd6651b164d45p1ae42ejsn5b826f14361b"
    if [[ -z "$word" ]]; then
        notify-send -u low -i ~/.icons/Custom/info.png "     Usage: define <word>"
        return 1
    fi
        local response=$(curl -s "https://wordsapiv1.p.rapidapi.com/words/${word}" \
        -H "X-RapidAPI-Host: wordsapiv1.p.rapidapi.com" \
        -H "X-RapidAPI-Key: $api_key")
    local definition=$(echo "$response" | jq -r '.results[0].definition')
    if [[ -n "$definition" ]]; then
        notify-send -u low -i ~/.icons/Custom/info.png "     Definition of '$word': $definition"
    else
        notify-send -u low -i ~/.icons/Custom/info.png "     Sorry, '$word' not found!"
    fi
}

# Extract tar and zip files (unwrap "filename")
unwrap() {
    if [[ -f $1 ]]; then
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
            *)           echo "'$1' cannot be unwrapped" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# man() {
#     LESS_TERMCAP_md=$'\e[01;31m' \
#     LESS_TERMCAP_me=$'\e[0m' \
#     LESS_TERMCAP_us=$'\e[01;32m' \
#     LESS_TERMCAP_ue=$'\e[0m' \
#     LESS_TERMCAP_so=$'\e[45;93m' \
#     LESS_TERMCAP_se=$'\e[0m' \
#     command man "$@"
# }

# man() {
#     LESS_TERMCAP_md=$'\e[01;31m' \
#     LESS_TERMCAP_me=$'\e[0m' \
#     LESS_TERMCAP_se=$'\e[0m' \
#     LESS_TERMCAP_so=$'\e[01;44;33m' \
#     LESS_TERMCAP_ue=$'\e[0m' \
#     LESS_TERMCAP_us=$'\e[01;32m' \
#     command man "$@"
# }

# Copy and go (cpcd "filename")
cpcd() {
    if [[ -d "$2" ]]; then
        cp $1 $2 && cd $2
    else
        cp $1 $2
    fi
}

# Move and go (mvcd "filename")
mvcd() {
    if [[ -d "$2" ]]; then
        mv $1 $2 && cd $2
    else
        mv $1 $2
    fi
}

# Create and go (mkdircd "directory name")
mkdircd() {
    mkdir -p "$1" && cd "$1"
}

# Directory size (size "directory name")
size() {
    local directory="${1:-$PWD}"
    local size
    size=$(du -sh "$directory" 2> /dev/null | cut -f1)

    if [[ -n $size ]]; then
        echo "$fg[yellow]Size of $fg[white]'$directory': $fg[green]$size"
    else
        echo "$fg[red]Failed to retrieve size of $fg[white]'$directory'."
    fi
}

# Backup files (bak "filename")
bak() {
    cp $1 ${1}-`date +%Y-%m-%d_%H:%M:%S`.bak ;
}

# List files after changing directories
chpwd() {
    exa -l --grid --icons --color=always --sort=name --no-user --no-permissions --no-filesize --no-time
}

# Update your Arch Linux machine
update() {
    figlet "updating mirrors ..."
    sudo reflector --verbose --country "United States" --age 12 --latest 20 --fastest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
    sleep 0.2
    figlet "updating repos ..."
    sudo pacman -Sy
    sleep 0.2
    yay -Sy
    sleep 0.2
    figlet "updating system ..."
    yay -Syu --noconfirm && yay -Qqe > ~/.arch_pkgs.txt
}

# Put a clock in top right corner (show-time)
show-time() {
    while sleep 1;
    do
        tput sc
        tput cup 0 $(($(tput cols)-29))
        date
        tput rc
    done &
}

# Create an executable file with a shebang (script <name>)
script() {
    cd ~/.local/bin
    touch $1
    echo "#!/bin/bash\n
    \n

    " > $1
    chmod +x $1
    vim ~/.local/bin/$1
}
