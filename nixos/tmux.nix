{ config, pkgs, ... }:

let
  kanagawa = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "kanagawa";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "Nybkox";
      repo = "tmux-kanagawa";
      rev = "b3193f0ae851e2eb6a18b95b1da80c572c7f6dbc";
      sha256 = "sha256-koQa2v52F4eKw0WqOtYeD4yIV39u0TliunV/GlO3nHM=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    keyMode = "vi";
    baseIndex = 1;
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      tmuxPlugins.cpu
      tmuxPlugins.battery
      tmuxPlugins.catppuccin
      kanagawa
    ];
    extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      set-option -g status-position bottom

      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm' 
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      set -s escape-time 0
      setw -g pane-base-index 1

      set-option -g detach-on-destroy off

      set -g prefix C-w
      unbind C-b
      bind-key C-w send-prefix

      unbind %
      bind \\ split-window -h

      unbind '"'
      bind - split-window -v

      unbind r

      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      setw -g mouse on

      unbind -T copy-mode-vi MouseDragEnd1Pane

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      bind -T copy-mode-vi H send-keys -X start-of-line
      bind -T copy-mode-vi L send-keys -X end-of-line

      # set -g @catppuccin_flavor 'mocha'

      # Configure the catppuccin plugin
      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_window_status_style "rounded"

      # Load catppuccin
      # run '${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux'

      # Make the status line pretty and add some modules
      # set -g status-right-length 100
      # set -g status-left-length 100
      # set -g status-left ""
      # set -g status-right "#{E:@catppuccin_status_application}"
      # set -agF status-right "#{E:@catppuccin_status_cpu}"
      # set -ag status-right "#{E:@catppuccin_status_session}"
      # set -ag status-right "#{E:@catppuccin_status_uptime}"
      # set -agF status-right "#{E:@catppuccin_status_battery}"

      # run-shell '${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux'
      # run '${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux'

      # run '${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux'
      # run-shell '${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux'


      set -g @kanagawa-plugins  " "
      set -g @kanagawa-show-powerline true
      set -g @kanagawa-show-fahrenheit false
      set -g @kanagawa-show-left-sep 
      set -g @kanagawa-show-right-sep 
      set -g @kanagawa-left-icon-padding 0
      set -g @kanagawa-show-flags true
      set -g @kanagawa-show-left-icon session
      set -g @kanagawa-ignore-window-colors true
      run-shell '${kanagawa}/share/tmux-plugins/kanagawa/kanagawa.tmux'

      setw -g pane-border-status bottom
      setw -g pane-border-format '#{pane_current_path}'

      set -g window-style "bg=#1f1f28"
      set -g window-active-style "bg=#1f1f28"

      bind-key R run-shell 'tmux source-file /etc/tmux.conf > /dev/null;'
    '';
  };
}
