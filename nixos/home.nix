{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "shenawy";
  home.homeDirectory = "/home/shenawy";

  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.sessionPath = [
    "/usr/local/bin"
    "/home/shenawy/.local/bin/"
    "/home/shenawy/.cargo/bin/"
    "/home/shenawy/go/bin/"
  ];

  gtk = {
    enable = true;
    theme.package = pkgs.kanagawa-gtk-theme;
    theme.name = "Kanagawa-BL";
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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.portal.xdgOpenUsePortal = true;

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "/etc/nixos/Background.png";
      wallpaper = "HDMI-A-1, /etc/nixos/Background.png";
      splash = false;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;
    xwayland.enable = true;
    settings = {
      "$mainMod" = "ALT";
      "$terminal" = "ghostty";
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

      };

      monitor = ",preferred,auto,auto";

      general = {
        gaps_in = 3;
        gaps_out = 13;
        border_size = 1;
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
        "opacity 0.95, class: ghostty"
        # "opacity 0.95, class: wezterm"
        "opacity 0.95, class: kitty"
        "opacity 0.95, class: thunar"
        # "noblur, class:^(?!wezterm)$"
        "noblur, class:^(?!ghostty)$"
        "noblur, class: harmonia"
        "noshadow, class: harmonia"
        "noborder, class: harmonia"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };

    # exec-once=[workspace 1] ghostty -e tmux new -s projects -c ./projects 'source ~/.zshrc; ${pkgs.neovim}/bin/nvim; $SHELL'

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

      exec-once=[workspace 1] ghostty -e tmux new -s projects -c ./projects 'nvim; zsh;'
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
    GTK_THEME = "Kanagawa-BL";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.opam = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.opam;
  };

  programs.hyprlock = {
    enable = true;
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
    style = ''
      @define-color rosewater #f5e0dc;
      @define-color flamingo #f2cdcd;
      @define-color pink #f5c2e7;
      @define-color mauve #957fb8;
      @define-color red #e82424;
      @define-color maroon #d27e99;
      @define-color peach #ffa066;
      @define-color yellow #e6c384;
      @define-color green #98bb6c;
      @define-color teal #94e2d5;
      @define-color sky #7e9cd8;
      @define-color sapphire #7fb4ca;
      @define-color blue #9cabca;
      @define-color lavender #938aa9;
      @define-color text #dcd7ba;
      @define-color subtext1 #bac2de;
      @define-color subtext0 #a6adc8;
      @define-color overlay2 #9399b2;
      @define-color overlay1 #7f849c;
      @define-color overlay0 #6c7086;
      @define-color surface2 #585b70;
      @define-color surface1 #45475a;
      @define-color surface0 #2a2a37;
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;

      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 15px;
        margin: 0;
        min-height: 0;
      }

      #waybar {
        background: transparent;
        color: @text;
      }

      #workspaces {
        border-radius: 1rem;
        background-color: @surface0;
        margin-left: 1rem;
      }

      #workspaces button {
        color: @lavender;
        border-radius: 1rem;
      }

      #workspaces button.active {
        color: @sky;
        border-radius: 1rem;
      }

      #workspaces button:hover {
        color: @sapphire;
        border-radius: 1rem;
      }


      #custom-music,
      #tray,
      #backlight,
      #clock,
      #battery,
      #pulseaudio,
      #custom-lock,
      #language,
      #custom-power {
        background-color: @surface0;
        padding: 0.5rem 0.8rem;
        margin: 0px 0px;
      }

      #clock {
        color: @blue;
        border-radius: 0px 1rem 1rem 0px;
        margin-right: 2rem;
      }

      #custom-lock {
        color: @green;
      }

      #battery {
        color: @green;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }

      #backlight {
        color: @yellow;
      }

      #backlight,
      #battery {
        border-radius: 0;
      }

      #pulseaudio {
        color: @maroon;
        border-radius: 1rem 0px 0px 1rem;
        margin-left: 0px;
      }

      #custom-music {
        color: @mauve;
        border-radius: 1rem;
      }

      #language {
        border-radius: 1rem 0px 0px 1rem;
        color: @peach;
      }

      #custom-power {
        color: @red;
        margin-right: 1rem;
        border-radius: 0px 1rem 1rem 0px;
        padding-right: 1.5rem;
        padding-left: 1.5rem;
      }

      #tray {
        margin-right: 2rem;
        border-radius: 1rem;
      }

      #workspaces button.urgent {
        color: @red;
      }
    '';

    settings = {
      mainBar = {

        "layer" = "top";
        "position" = "bottom";
        "modules-left" = [
          "hyprland/workspaces"
        ];
        "modules-center" = [
          "custom/music"
        ];
        "modules-right" = [
          "pulseaudio"
          "clock"
          "tray"
          "hyprland/language"
          "custom/lock"
          "custom/power"
        ];
        "hyprland/workspaces" = {
          "on-click" = "activate";
          "on-scroll-up" = "hyprctl dispatch workspace e-1";
          "on-scroll-down" = "hyprctl dispatch workspace e+1";
          "format" = "{icon}";
          "all-outputs" = true;
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "default" = "";
          };
        };
        "tray" = {
          "icon-size" = 21;
          "spacing" = 10;
        };
        "custom/music" = {
          "format" = "  {}";
          "escape" = true;
          "interval" = 5;
          "tooltip" = false;
          "exec" = "playerctl metadata --format='{{ title }}'";
          "on-click" = "playerctl play-pause";
          "max-length" = 50;
        };
        "clock" = {
          "timezone" = "Egypt";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = " {:%d/%m/%Y}";
          "format" = " {:%H:%M}";
        };
        "pulseaudio" = {
          # "scroll-step"= 1; // %; can be a float
          "format" = "{icon} {volume}%";
          "format-muted" = "";
          "format-icons" = {
            "default" = [
              ""
              ""
              " "
            ];
          };
          "on-click" = "pavucontrol";
        };
        "custom/lock" = {
          "tooltip" = false;
          "on-click" = "hyprlock &";
          "format" = "";
        };
        "custom/power" = {
          "tooltip" = false;
          "on-click" = "shutdown -h now";
          "format" = "⏻";
        };
        "hyprland/language" = {
          "format" = " {}";
          "format-en" = "en";
          "format-ar" = "ar";
          "interval" = 1;
          "keyboard-name" = "u";
          "on-click" = "hyprctl switchxkblayout u next";
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
    tmux.enableShellIntegration = true;
  };

  programs.zsh = {
    plugins = [
      {
        name = "zsh-system-clipboard";
        src = pkgs.zsh-system-clipboard;
        file = "share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh";
      }
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
      export MANPAGER='nvim +Man!'
      export MANWIDTH='205'
      export FZF_DEFAULT_OPTS='--bind=ctrl-k:up,ctrl-j:down'

      setopt interactivecomments
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh;
      source ~/.p10k.zsh


      bindkey -s ^f "tmux-sessionizer\n"
      bindkey "^H" backward-delete-char
      bindkey "^?" backward-delete-char

      bindkey -v

      # Yank to the system clipboard
      # This shit ain't working

      # function vi-yank-xclip {
      #     zle vi-yank
      #     echo "$CUTBUFFER" | xclip -i
      # }

      # zle -N vi-yank-xclip
      # bindkey -M vicmd 'y' vi-yank-xclip

      eval "$(direnv hook zsh)"
    '';
    shellAliases = {
      notes = "nvim /dev/null -c 'set filetype=markdown'";
      v = "nvim";
      cat = "bat";
      cd = "z";
      clean = "nh clean all";
      switch = "nh os switch /etc/nixos";
      conf = "sudoedit /etc/nixos/configuration.nix";
      home = "sudoedit /etc/nixos/home.nix";
    };
  };

  programs.bat = {
    enable = true;
    themes = {
      kanagawa = {
        src = pkgs.fetchFromGitHub {
          owner = "rebelot";
          repo = "kanagawa.nvim";
          rev = "e5f7b8a804360f0a48e40d0083a97193ee4fcc87";
          sha256 = "sha256-FnwqqF/jtCgfmjIIR70xx8kL5oAqonrbDEGNw0sixoA=";
        };
        file = "extras/kanagawa.tmTheme";
      };
    };
    config = {
      theme = "kanagawa";
    };
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
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 32;
  };

  programs.alacritty = {
    enable = true;
  };
  # programs.wezterm = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   extraConfig = ''
  #     local wezterm = require("wezterm")
  #
  #     local act = wezterm.action
  #
  #     local config = wezterm.config_builder()
  #
  #     config.color_scheme = "Kanagawa (Gogh)"
  #
  #     config.enable_wayland = false
  #
  #     config.enable_tab_bar = false
  #
  #     config.window_padding = {
  #         left = 5,
  #         right = 5,
  #         top = 5,
  #         bottom = 5,
  #     }
  #
  #     config.audible_bell = "Disabled"
  #
  #     config.window_close_confirmation = "NeverPrompt"
  #
  #     local copy_mode = nil
  #
  #     if wezterm.gui then
  #         copy_mode = wezterm.gui.default_key_tables().copy_mode
  #         table.insert(copy_mode, {
  #             key = "L",
  #             mods = "SHIFT",
  #             action = act.CopyMode("MoveToEndOfLineContent"),
  #         })
  #
  #         table.insert(copy_mode, {
  #             key = "H",
  #             mods = "SHIFT",
  #             action = act.CopyMode("MoveToStartOfLineContent"),
  #         })
  #     end
  #
  #     config.key_tables = {
  #         copy_mode = copy_mode,
  #     }
  #
  #     config.force_reverse_video_cursor = true
  #
  #     config.cursor_blink_rate = 0
  #
  #     config.cell_width = 0.85
  #
  #     config.front_end = "WebGpu"
  #
  #     config.font = wezterm.font("JetBrains Mono")
  #
  #     config.warn_about_missing_glyphs = false
  #
  #     config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
  #
  #     return config
  #   '';
  # };
  programs.kitty.enable = true;
}
