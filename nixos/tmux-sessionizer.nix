{ pkgs }:

pkgs.writeShellScriptBin "tmux-sessionizer" ''
  if (($# == 1)); then
  	selected=$1
  else
  	selected=$(find ~/projects -maxdepth 1 -not -path '*/.*' -type d | fzf)
  fi

  if [[ -z $selected ]]; then
  	exit 0
  fi

  selected_name=$(basename "$selected" | tr . _)
  tmux_running=$(pgrep -f ${pkgs.tmux}/bin/tmux)

  if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  	${pkgs.tmux}/bin/tmux new-session -s "$selected_name" -c "$selected"
  	exit 0
  fi

  if ! ${pkgs.tmux}/bin/tmux has-session -t="$selected_name" 2>/dev/null; then
  	${pkgs.tmux}/bin/tmux new-session -ds "$selected_name" -c "$selected"
  fi

  ${pkgs.tmux}/bin/tmux switch-client -t "$selected_name"
''
