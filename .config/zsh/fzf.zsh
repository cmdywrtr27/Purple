# Setup fzf
# ---------
if [[ ! "$PATH" == */home/josh/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/josh/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/josh/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/josh/.fzf/shell/key-bindings.zsh"
