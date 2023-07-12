#  ___  __  _  _ ___  ___
# |_  /' _/| || | _ \/ _/
#  / /`._`.| >< | v / \__
# |___|___/|_||_|_|_\\__/
#

autoload -Uz compinit; compinit
autoload -U +X bashcompinit; bashcompinit
autoload -Uz colors; colors
autoload -Uz vcs_info; vcs_info
zmodload -i zsh/complist

zstyle ':completion:*' completer _complete _approximate _oldlist _expand _ignored _match _correct _prefix
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' expand prefix
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' substitute 1
zstyle ':completion:*' original true
zstyle ':completion:*' verbose true
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$ZSH_CACHEDIR"

#zstyle ':completion:*:vim:*' file-sort mtime
zstyle ':completion:*:vim:*' file-sort modification
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories group-order
zstyle ':completion:*:messages' format '%B%F{red}--%f%F{yellow} %d%f %F{red}--%f%b'
zstyle ':completion:*:warnings' format '%B%F{red}--%f%F{yellow} No Matches Found%f %F{red}--%f%b'
zstyle ':completion:*:descriptions' format '%B%F{red}--%f%F{yellow} %d%f %F{red}--%f%b'
zstyle ':completion:*:corrections' format '%B%F{red}--%f%F{yellow} %d (errors: %e)%f %F{red}--%f%b'
zstyle ':completion:*:default' select-prompt '%B%F{red}--%f%F{yellow} Match %M    %P%f %F{red}--%f%b'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats '%B%F{green}%s: %b%f'
zstyle ':vcs_info:git*' actionformats '%B%F{green}%s: %b%f'

zstyle :compinstall filename '~/.zshrc'

HISTFILE=$ZSH_DIR/zsh_history
HISTSIZE=5000
SAVEHIST=5000

case $TERM in
    xterm*)
        precmd() {
            print -Pn "\e]0;%~\a"
            vcs_info
        }
        ;;
esac

setopt autocd extendedglob auto_menu auto_list no_auto_remove_slash nohashdirs completealiases append_history nomatch hist_ignore_all_dups complete_in_word interactivecomments always_to_end prompt_subst globdots share_history numeric_glob_sort rm_star_wait no_clobber
unsetopt beep menu_complete flowcontrol
bindkey -M menuselect '^@' accept-and-infer-next-history
bindkey -v
# End of lines configured by zsh-newuser-install
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Aliases
source $ZSH_DIR/aliases.zsh

# Functions
source $ZSH_DIR/functions.zsh

# Plugins
source $ZSH_PLUGINDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGINDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_PLUGINDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
#source $ZSH_PLUGINDIR/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $ZSH_DIR/syntax.zsh

# Prompt
eval "$(starship init zsh)"
#source $ZSH_THEMEDIR/agnoster-gaps.zsh
#source $ZSH_THEMEDIR/minimal.zsh
#source $ZSH_THEMEDIR/right.zsh
#source $ZSH_THEMEDIR/ninja.zsh

source ~/.config/fzf/fzf.zsh
