local return_code="%(?..%B%F{magenta}─[%F{red}%?!%F{magenta}]%b%f)"

PS1='
%B%F{magenta}╓───[%F{white}%n%F{magenta}]─[%B%F{white}%m%F{magenta}]$(git_prompt_info)%b%f
%B%F{magenta}╙─[%F{white}%3~%F{magenta}]$return_code%B%F{magenta}>%b%f%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{magenta}─[%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{magenta}]%b%f%{$reset_color%}"
