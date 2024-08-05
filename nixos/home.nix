{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "shenawy";
  home.homeDirectory = "/home/shenawy";

  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.sessionPath = [ "/usr/local/bin" ];
  home.packages = [
    # pkgs.hello
    pkgs.opam
  ];

  gtk = {
    enable = true;
    # theme.package = pkgs.kanagawa-gtk-theme;
    # theme.name = "Kanagawa-BL-LB";
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-black";
    };
    cursorTheme = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 32;
    };
  };

  # services.hyprpaper = {
  #   enable = true;
  #   settings = {
  #     preload = "~/Pictures/Background.png";
  #     wallpaper = "HDMI-A-1, ~/Pictures/Background.png";
  #     splash = false;
  #   };
  # };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;
    xwayland.enable = true;
    settings = {
      "$mainMod" = "ALT";
      "$terminal" = "wezterm";
      "$fileManager" = "thunar";
      "$browser" = "google-chrome-stable";
      "$menu" = "wofi --show drun";
      "$gnome-schema" = "org.gnome.desktop.interface";

      env = [
        "XCURSOR_SIZE,32"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.2, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      decoration = {
        rounding = 8;
        active_opacity = 1;

        blur = {
          enabled = true;
          size = 7;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";
      };

      monitor = ",preferred,auto,auto";

      general = {
        gaps_in = 3;
        gaps_out = 13;
        border_size = 1;
        # "col.active_border" = "rgba(e4d0a8ee) rgba(e4d0a8ee) 45deg";
        # "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      input = {
        kb_options = "grp:win_space_toggle";
        kb_layout = "us,eg";
        kb_variant = "";
        kb_model = "";
        kb_rules = "";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = "no";
        };

        sensitivity = 0;
      };
      bind = [
        "$mainMod, Z, exec, shutdown -h now"
        '', Print, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.wl-clipboard}/bin/wl-copy''
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod SHIFT, E, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, B, exec, $browser"
        "$mainMod, V, togglefloating"
        "$mainMod, D, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, U, togglesplit"
        "$mainMod, M, centerwindow"
        "$mainMod, T, togglegroup"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "ALT SHIFT, H, movewindow, l"
        "ALT SHIFT, L, movewindow, r"
        "ALT SHIFT, K, movewindow, u"
        "ALT SHIFT, J, movewindow, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, F, fullscreen"
      ];

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures = {
        workspace_swipe = "off";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "opacity 0.95, class: wezterm"
        "opacity 0.95, class: kitty"
        "opacity 0.95, class: thunar"
        "noblur, class:^(?!wezterm)$"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };

    extraConfig = ''
      bind=ALT,R,submap,resize
      submap=resize
      binde=,l,resizeactive,15 0
      binde=,h,resizeactive,-15 0
      binde=,k,resizeactive,0 -15
      binde=,j,resizeactive,0 15
      bind = ALT, Z, exec, hyperctl dispatch exit
      bind=,escape,submap,reset 
      submap=reset

      exec-once=[workspace 1] ${pkgs.wezterm}/bin/wezterm -e tmux new -s projects -c ./projects 'source ~/.zshrc; ${pkgs.neovim}/bin/nvim; $SHELL'
      exec-once=${pkgs.waybar}/bin/waybar
      exec-once=${pkgs.hyprpaper}/bin/hyprpaper
    '';
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shenawy/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.opam = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.opam;
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";
      editor = "nvim";
    };
  };

  programs.waybar = {
    enable = true;
    style = lib.mkForce ''
      * {
        min-height: 0;
        margin: 0;
      }

      #waybar {
        background: rgba(0, 0, 0, 0);
        background: #161620;
        font-size: 13px;
        font-family: "JetBrainsMono Nerd Font";
        /* color: #eeeeef; */
      }

      #workspaces button {
        padding-left: 10px;
        padding-right: 15px;
        color: #c8caf5;
      }

      #workspaces button.active {
        color: #e6c384;
      }

      #custom-powermenu,
      #cpu,
      #temperature,
      #memory,
      #workspaces,
      #clock,
      #window,
      #pulseaudio,
      #custom-updates {
        padding: 0px 8px;
        background-color: rgba(0, 0, 0, 0);
      }

      #window {
        color: #c8caf5;
      }

      #custom-updates {
        color: #1788e4;
      }

      #custom-powermenu {
        color: #e82424;
        padding-right: 11px;
        margin-right: 8px;
      }

      #scratchpad {
        color: #cffafe;
        padding-right: 4px;
        padding-left: 4px;
      }

      #pulseaudio {
        color: #98bb6c;
        padding-right: 14px;
      }

      #cpu {
        color: #7e9cd8;
      }

      #temperature {
        color: #98c379;
      }

      #memory {
        color: #ffa066;
      }

      #network {
        color: #c678dd;
        min-width: 200px;
      }

      #clock {
        color: #c8caf5;
      }

      #memory:hover {
        background-color: rgba(255, 160, 102, 0.12);
      }

      #custom-powermenu:hover {
        background-color: rgba(232, 36, 36, 0.12);
      }

      #pulseaudio:hover {
        background-color: rgba(152, 187, 108, 0.12);
      }

      #cpu:hover {
        background-color: rgba(126, 156, 216, 0.12);
      }

      #memory,
      #pulseaudio,
      #custom-powermenu,
      #cpu {
        transition: 0.10s;
        border-radius: 4px;
      }
    '';

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        modules-left = [
          "hyprland/workspaces"
          "custom/updates"
          "tray"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "clock"
          "cpu"
          "memory"
          "pulseaudio"
          "custom/powermenu"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "-99" = "";
            "default" = "";
          };
        };
        memory = {
          "format" = " {}%";
          "tooltip" = "false";
        };
        cpu = {
          "format" = " {usage}%";
          "tooltip" = "false";
        };
        "custom/powermenu" = {
          format = "";
          tooltip = false;
          on-click = "exec shutdown -h now";
        };
        clock = {
          # format = "{ =%d %B %Y, %A, %I =%M %p}";
          format = "{:%Y-%m-%d, %I:%M %p}";
          interval = 60;
          tooltip = false;
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
            ];
          };
          scroll-step = 1;
          on-click = "pavucontrol";
        };
      };
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh;
      source ~/.p10k.zsh


      bindkey -s ^f "tmux-sessionizer\n"
      bindkey "^H" backward-delete-char
      bindkey "^?" backward-delete-char
    '';
    shellAliases = {
      v = "nvim";
      cat = "bat";
      cd = "z";
      switch = "sudo nixos-rebuild switch --flake /etc/nixos#default";
      conf = "sudoedit /etc/nixos/configuration.nix";
      home = "sudoedit /etc/nixos/home.nix";
    };
  };

  programs.bat = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git-credential-oauth.enable = true;

  programs.git = {
    enable = true;
    userName = "Mohamed Elshenawy";
    userEmail = "alshenawy10203022@gmail.com";
    # extraConfig = {
    #   credential.helper = "oauth";
    # };
  };

  # home.pointerCursor = {
  #   gtk.enable = true;
  #   x11.enable = true;
  #   package = pkgs.capitaine-cursors;
  #   name = "capitaine-cursors";
  #   size = 24;
  # };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require("wezterm")

      local act = wezterm.action

      local config = wezterm.config_builder()

      config.color_scheme = "Kanagawa (Gogh)"

      config.enable_wayland = false

      config.enable_tab_bar = false

      config.window_padding = {
          left = 5,
          right = 5,
          top = 5,
          bottom = 5,
      }

      config.window_close_confirmation = "NeverPrompt"

      local copy_mode = nil

      if wezterm.gui then
          copy_mode = wezterm.gui.default_key_tables().copy_mode
          table.insert(copy_mode, {
              key = "L",
              mods = "SHIFT",
              action = act.CopyMode("MoveToEndOfLineContent"),
          })

          table.insert(copy_mode, {
              key = "H",
              mods = "SHIFT",
              action = act.CopyMode("MoveToStartOfLineContent"),
          })
      end

      config.key_tables = {
          copy_mode = copy_mode,
      }

      config.force_reverse_video_cursor = true

      config.cell_width = 0.85

      config.front_end = "WebGpu"

      config.font = wezterm.font("JetBrains Mono")

      config.warn_about_missing_glyphs = false

      config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

      return config
    '';
  };
}
