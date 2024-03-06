if status is-interactive
end

alias v="nvim"
alias :q="tmux kill-server"
alias t="tmux"
alias clean='sudo pacman -Rcs $(pacman -Qdtq)'
alias sync="sudo pacman -Syyu"
alias get="sudo pacman -S"
alias remove="sudo pacman -R"
alias ls="exa"
alias cat="bat"
alias air="~/go/bin/air"

set -g fish_key_bindings fish_vi_key_bindings
set fish_greeting

zoxide init --cmd cd fish | source
bind \cf 'tmux-sessionizer'

bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste
