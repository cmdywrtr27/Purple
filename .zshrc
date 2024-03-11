#          _
#  _______| |__  _ __ ___
# |_  / __| '_ \| '__/ __|
#  / /\__ | | | | | | (__
# /___|___|_| |_|_|  \___|
#

autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload -Uz colors && colors
autoload -Uz add-zsh-hook vcs_info
zmodload -i zsh/complist

zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' expand prefix
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' list-colors $(dircolors)
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose true
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' rehash true

zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories group-order
zstyle ':completion::*:-tilde-:*:*' group-order named-directories users
zstyle ':completion:*:vim:*' file-patterns '%p:globbed-files'
zstyle ':completion:*:vim:*' file-sort modification
zstyle ':completion:*:messages' format '%B%F{#ffcb6b}--%F{#f07178} %d %F{#ffcb6b}--%f%b'
zstyle ':completion:*:warnings' format '%B%F{#ffcb6b}--%F{#f07178} No Matches Found %F{#ffcb6b}--%f%b'
zstyle ':completion:*:descriptions' format "%B%F{#ffcb6b}-- %F{#f07178}%d %F{#ffcb6b}--%f%b"
zstyle ':completion:*:corrections' format "%B%F{#ffcb6b}-- %F{#f07178}%d %F{#ffcb6b}-- %F{#f07178}(errors %e)%f%b"
zstyle ':completion:*:default' list-prompt "%B%F{#ffcb6b}-- %F{#f07178}%S%M matches%s %F{#ffcb6b}--%f%b"
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

zstyle -e ':completion:*:approximate:*' \
        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/2))numeric)'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats '%B%F{#777777}(%b)%b%f'
zstyle ':vcs_info:git*' actionformats '%B%F{#777777}(%s)-[%b|%a]%u%c-%b%f'

zstyle :compinstall filename '~/.zshrc'

HISTFILE=$ZDOTDIR/zsh_history
HISTSIZE=5000
SAVEHIST=5000

setopt autocd extendedglob auto_menu auto_list no_auto_remove_slash nohashdirs completealiases append_history nomatch hist_ignore_all_dups complete_in_word interactivecomments always_to_end prompt_subst globdots share_history numeric_glob_sort
unsetopt beep menu_complete flowcontrol
bindkey -M menuselect '^o' accept-and-infer-next-history
bindkey -v
# End of lines configured by zsh-newuser-install
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Window title
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd() {
      vcs_info
      print -Pn "\e]0;%~\a"
    }
    preexec() {
      print -Pn "\e]0;$1\a"
    }
    ;;
  screen|screen-256color)
    precmd() {
      vcs_info
      print -Pn "\e]83;$1\a"
      print -Pn "\e]0;%L %~\a"
    }
    preexec() {
      print -Pn "\e]83;$1\a"
      print -Pn "\e]0;%L %~\a"
    }
    ;;
esac

[ -f $ZDOTDIR/fzf.zsh ] && . $ZDOTDIR/fzf.zsh
[ -f $ZDOTDIR/git.zsh ] && . $ZDOTDIR/git.zsh
[ -f $ZDOTDIR/aliases.zsh ] && . $ZDOTDIR/aliases.zsh
[ -f $ZDOTDIR/functions.zsh ] && . $ZDOTDIR/functions.zsh

. $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
. $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

eval "$(starship init zsh)"
#. $ZDOTDIR/themes/agnoster-gaps.zsh
#. $ZDOTDIR/themes/lines.zsh
#. $ZDOTDIR/themes/minimal.zsh
#. $ZDOTDIR/themes/right.zsh
#. $ZDOTDIR/themes/ninja.zsh
#. $ZDOTDIR/themes/agkozak.zsh
#. $ZDOTDIR/themes/prompt.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/josh/.miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/josh/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/josh/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/josh/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
