PROMPT_STYLE="dual" # ascii, arrows, rounded, legos, flames, cubes, ninja, dual or classic

COLOR_ROOT="%F{red}"
COLOR_USER="%F{blue}"
COLOR_NORMAL="%F{white}"

ICO_DIRTY=" "
ICO_AHEAD=" ↑"
ICO_BEHIND=" ↓"
ICO_DIVERGED=" ↕"

# allow functions in the prompt
setopt PROMPT_SUBST
autoload -Uz colors && colors

# colors for permissions
if [ "$EUID" -ne "0" ]; then # if user is not root
	USER_LEVEL="${COLOR_USER}"
else # root!
	USER_LEVEL="${COLOR_ROOT}"
fi

# git prompt
GIT_PROMPT() {
  test=$(git rev-parse --is-inside-work-tree 2> /dev/null)
  if [ ! "$test" ]
  then
    case "$PROMPT_STYLE" in
      ascii)
        echo "$reset_color%F{blue}▒░"
      ;;
      arrows)
        echo "$reset_color%F{blue}"
      ;;
      rounded)
        echo "$reset_color%F{blue}"
      ;;
      legos)
        echo "$reset_color%F{blue} "
      ;;
      flames)
        echo "$reset_color%F{blue} "
      ;;
      cubes)
        echo "$reset_color%F{blue} "
      ;;
    esac
    return
  fi
  ref=$(git name-rev --name-only HEAD | sed 's!remotes/!!;s!undefined!merging!' 2> /dev/null)
  dirty="" && [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && dirty=$ICO_DIRTY
  stat=$(git status | sed -n 2p)
  case "$stat" in
    *ahead*)
      stat=$ICO_AHEAD
    ;;
    *behind*)
      stat=$ICO_BEHIND
    ;;
    *diverged*)
      stat=$ICO_DIVERGED
    ;;
    *)
      stat=""
    ;;
  esac
  case "$PROMPT_STYLE" in
    ninja)
      echo "${COLOR_NORMAL}${ref}${dirty}${stat}"
    ;;
    ascii)
      echo "%{$bg[magenta]%}%F{blue}▒░ %B%F{black}${ref}${dirty}${stat} $reset_color%F{magenta}▒░"
    ;;
    arrows)
      echo "%{$bg[magenta]%}%F{blue} %B%F{black}${ref}${dirty}${stat} $reset_color%F{magenta}"
    ;;
    rounded)
      echo "%{$bg[magenta]%}%F{blue} %B%F{black}${ref}${dirty}${stat} $reset_color%F{magenta}"
    ;;
    legos)
      echo "%{$bg[magenta]%}%F{blue}  %B%F{black}${ref}${dirty}${stat} $reset_color%F{magenta} "
    ;;
    flames)
      echo "%{$bg[magenta]%}%F{blue}  %B%F{black}${ref}${dirty}${stat} $reset_color%F{magenta} "
    ;;
    cubes)
      echo "%{$bg[magenta]%}%F{blue}  %B%F{black}${ref}${dirty}${stat} $reset_color%F{magenta} "
    ;;
    *)
    echo "${USER_LEVEL}─[${COLOR_NORMAL}"${ref}${dirty}${stat}"${USER_LEVEL}]"
    ;;
  esac
}
case "$PROMPT_STYLE" in
# ascii
ascii)
PROMPT='
%{$bg[blue]%} %F{black}%B%40<...<%~%<< $(GIT_PROMPT)$reset_color%f '
;;
# arrows
arrows)
PROMPT='
%{$bg[blue]%} %F{black}%B%40<...<%~%<< $(GIT_PROMPT)$reset_color%f '
;;
# rounded
rounded)
PROMPT='
%{$bg[blue]%} %F{black}%B%40<...<%~%<< $(GIT_PROMPT)$reset_color%f '
;;
# legos
legos)
PROMPT='
%{$bg[blue]%} %F{black}%B%40<...<%~%<< $(GIT_PROMPT)$reset_color%f '
;;
# flames
flames)
PROMPT='
%{$bg[blue]%} %F{black}%B%40<...<%~%<< $(GIT_PROMPT)$reset_color%f '
;;
# cubes
cubes)
PROMPT='
%{$bg[blue]%} %F{black}%B%40<...<%~%<< $(GIT_PROMPT)$reset_color%f '
;;
# ninja
ninja)
PROMPT='
%F{white}
        ▟▙${USER_LEVEL}%B%40<...<%~%<<   %F{white}$(GIT_PROMPT) %F{white}
▟▒${USER_LEVEL}░░░░░░░%F{white}▜▙▜████████████████████████████████▛
▜▒${USER_LEVEL}░░░░░░░%F{white}▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
        ▜▛%b%f '
;;
# dual line
dual)
PROMPT='
${USER_LEVEL}┌────%B[${COLOR_NORMAL}%40<...<%~%<<${USER_LEVEL}]$(GIT_PROMPT)
${USER_LEVEL}└─%b%f '
;;
# classic
*)
PROMPT='
${USER_LEVEL}%B[${COLOR_NORMAL}%40<...<%~%<<${USER_LEVEL}]$(GIT_PROMPT)%b%f '
;;
esac
