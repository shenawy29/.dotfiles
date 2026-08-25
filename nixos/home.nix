{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  # xdg-nvfilechooser = inputs.nv-portal.packages.${pkgs.system}.default;

  xdg-nvfilechooser-dev = pkgs.runCommand "xdg-nvfilechooser-dev" { } ''
    mkdir -p $out/share/dbus-1/services
    mkdir -p $out/share/xdg-desktop-portal/portals

    cat > $out/share/dbus-1/services/org.freedesktop.impl.portal.xdg-nvfilechooser.service << EOF
    [D-BUS Service]
    Name=org.freedesktop.impl.portal.desktop.xdg-nvfilechooser
    Exec=/home/shenawy/projects/xdg-nvfilechooser/target/debug/xdg-nvfilechooser
    SystemdService=xdg-nvfilechooser.service
    EOF

    cat > $out/share/xdg-desktop-portal/portals/xdg-nvfilechooser.portal << EOF
    [portal]
    DBusName=org.freedesktop.impl.portal.desktop.xdg-nvfilechooser
    Interfaces=org.freedesktop.impl.portal.FileChooser
    UseIn=hyprland
    EOF
  '';
in

{

  home.username = "shenawy";
  home.homeDirectory = "/home/shenawy";

  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.sessionPath = [
    "/usr/local/bin"
    "/home/shenawy/.local/bin/"
    "/home/shenawy/.cargo/bin/"
    "/home/shenawy/go/bin/"
    "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.kanagawa-gtk-theme.overrideAttrs (old: {
        version = "0-unstable-2025-10-15";

        src = pkgs.fetchFromGitHub {
          owner = "Fausto-Korpsvart";
          repo = "Kanagawa-GKT-Theme";
          rev = "55ca4ba249eba21f861b9866b71ab41bb8930318";
          hash = "sha256-UdMoMx2DoovcxSp/zBZ3PRv/Qpj+prd0uPm1gmdak2E=";
        };

        nativeBuildInputs = [
          pkgs.gtk3
          pkgs.jdupes
          pkgs.sassc
        ];

        buildInputs = [
          pkgs.gnome-themes-extra
        ];

        propagatedUserEnvPkgs = [
          pkgs.gtk-engine-murrine
        ];

        dontDropIconThemeCache = true;

        postPatch = ''
          find -name "*.sh" -print0 | while IFS= read -r -d ''' file; do
            patchShebangs "$file"
          done
        '';

        installPhase = ''
          runHook preInstall

          name= HOME="$TMPDIR" ./themes/install.sh  --tweaks macos --dest $out/share/themes

          jdupes --quiet --link-soft --recurse $out/share

          runHook postInstall
        '';
      });
      name = "Kanagawa-Dark";
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # iconTheme = {
    #   package = pkgs.kanagawa-icon-theme.overrideAttrs (old: {
    #     pname = "kanagawa-icon-theme";
    #     version = "0-unstable-2025-07-28";
    #
    #     src = pkgs.fetchFromGitHub {
    #       owner = "Fausto-Korpsvart";
    #       repo = "Kanagawa-GKT-Theme";
    #       rev = "55ca4ba249eba21f861b9866b71ab41bb8930318";
    #       hash = "sha256-UdMoMx2DoovcxSp/zBZ3PRv/Qpj+prd0uPm1gmdak2E=";
    #     };
    #
    #     nativeBuildInputs = [
    #       pkgs.gtk3
    #     ];
    #
    #     propagatedBuildInputs = [
    #       pkgs.hicolor-icon-theme
    #     ];
    #
    #     dontDropIconThemeCache = true;
    #
    #     installPhase = ''
    #       runHook preInstall
    #
    #       mkdir -p $out/share/icons
    #       cp -a icons/* $out/share/icons
    #       for theme in $out/share/icons/*; do
    #         gtk-update-icon-cache -f $theme
    #       done
    #
    #       runHook postInstall
    #     '';
    #
    #     meta = with lib; {
    #       description = "Icon theme for the Kanagawa colour palette";
    #       homepage = "https://github.com/Fausto-Korpsvart/Kanagawa-GKT-Theme";
    #       license = licenses.gpl3Only;
    #       maintainers = with maintainers; [ iynaix ];
    #       platforms = platforms.linux;
    #     };
    #   });
    #   name = "Kanagawa";
    # };

    cursorTheme = {
      package = inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default;
      name = "BreezX-RosePine-Linux";
      size = 32;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = [
        xdg-nvfilechooser-dev
        # xdg-nvfilechooser
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-hyprland
      ];

      config = {
        hyprland = {
          default = [
            "hyprland"
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.FileChooser" = [ "xdg-nvfilechooser" ];
        };
      };
    };

    desktopEntries."NeoVim" = {
      name = "NeoVim";
      terminal = false;
      exec = ''hyprctl dispatch exec -- "[float] wezterm -e nvim %u"'';
      categories = [
        "Utility"
        "TextEditor"
      ];
      icon = "nvim";
      type = "Application";
      mimeType = [
        "text/english"
        "text/plain"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
        "application/x-shellscript"
        "text/x-c"
        "text/x-c++"
      ];
    };
  };

  services = {
    mpris-proxy.enable = true;
    wayle = {
      enable = true;
      autoInstallDependencies = true;

      settings = {
        bar = {
          location = "bottom";
          scale = 0.8;

          button-icon-size = 0.85;
          button-icon-padding = 0.7;
          button-label-size = 0.9;
          button-label-padding = 0.7;
          button-gap = 0.7;
          module-gap = 0.35; # was implicitly 0.5, gap between modules on the bar
          padding = 0.25; # internal top/bottom padding of the bar itself

          layout = [
            {
              monitor = "*";
              left = [
                "dashboard"
                "keyboard-input"
                "netstat"
                "media"
                "cava"
                "hyprland-workspaces"
              ];
              center = [ "clock" ];
              right = [
                "notifications"
                "cpu"
                "ram"
                "microphone"
                "volume"
                "weather"
                "bluetooth"
                "systray"
                "power"
              ];
            }
          ];
        };

        osd = {
          enabled = true;
          position = "bottom";
          duration = 2500;
          monitor = "primary";
          margin = 150;
          border = true;
          layer = "overlay";
        };

        modules = {
          media = {
            icon-type = "application-mapped";
            format = "{{ title }} - {{ artist }}";
            label-max-length = 20;
            border-show = false;
            icon-color = "auto";
            icon-bg-color = "blue";
            label-color = "blue";
            button-bg-color = "bg-surface-elevated";
            left-click = "dropdown:media";

            player-icons = {
              "*spotify*" = "si-spotify-symbolic";
            };

            player-priority = [
              "*spotify*"
              "*google-chrome*"
            ];
          };

          weather = {
            provider = "open-meteo";
            location = "Port Said,EG";
            units = "metric";
            format = "{{ temp }}{{ temp_unit }}";
            icon-name = "ld-sun-symbolic";
            border-show = false;
            icon-color = "auto";
            icon-bg-color = "accent";
            label-color = "accent";
            button-bg-color = "bg-surface-elevated";
            left-click = "dropdown:weather";
          };

          hyprland-workspaces = {
            min-workspace-count = 5;
            monitor-specific = true;
            show-special = true;
            urgent-show = true;
            urgent-mode = "workspace";
            display-mode = "icon";
            label-use-name = false;
            numbering = "absolute";
            divider = " ";
            app-icons-show = false;
            app-icons-dedupe = true;
            app-icons-fallback = "ld-app-window-symbolic";
            app-icons-empty = "tb-minus-symbolic";
            icon-gap = 0.3;
            workspace-padding = 0.5;
            icon-size = 1.0;
            label-size = 1.0;
            workspace-ignore = [ ];
            active-indicator = "background";
            active-color = "accent";
            occupied-color = "fg-muted";
            empty-color = "fg-subtle";
            container-bg-color = "bg-surface-elevated";
            border-show = false;
            border-color = "border-default";
            workspace-map = { };
            app-icon-map = { };
          };

          notifications = {
            icon-name = "ld-bell-symbolic";
            icon-unread = "ld-bell-dot-symbolic";
            icon-dnd = "ld-bell-off-symbolic";
            border-show = false;
            border-color = "green";
            icon-show = true;
            icon-color = "auto";
            icon-bg-color = "green";
            label-show = true;
            label-color = "green";
            label-max-length = 0;
            button-bg-color = "bg-surface-elevated";
            left-click = "dropdown:notification";
            right-click = "wayle notify dnd";
            middle-click = "";
            scroll-up = "";
            scroll-down = "";
            blocklist = [ ];
            icon-source = "automatic"; # automatic|mapped|application
            popup-position = "top-right";
            popup-max-visible = 5;
            popup-stacking-order = "newest-first";
            popup-duration = 5000;
            popup-hover-pause = true;
            popup-margin-x = 0;
            popup-margin-y = 0;
            popup-gap = 8;
            popup-monitor = "primary";
            popup-layer = "overlay";
            popup-close-behavior = "dismiss"; # dismiss|remove
            popup-shadow = true;
            popup-urgency-bar = "low"; # low|normal|critical|none
            thresholds = [
              {
                above = 5;
                icon-color = "status-warning";
                label-color = "status-warning";
              }
              {
                above = 20;
                icon-color = "status-error";
                label-color = "status-error";
              }
            ];
          };

          battery = {
            level-icons = [
              "md-battery_android_0-symbolic"
              "md-battery_android_frame_1-symbolic"
              "md-battery_android_frame_2-symbolic"
              "md-battery_android_frame_3-symbolic"
              "md-battery_android_frame_4-symbolic"
              "md-battery_android_frame_5-symbolic"
              "md-battery_android_frame_6-symbolic"
              "md-battery_android_frame_full-symbolic"
            ];
            charging-icon = "md-battery_android_frame_bolt-symbolic";
            alert-icon = "md-battery_android_alert-symbolic";
            border-show = false;
            border-color = "yellow";
            icon-show = true;
            icon-color = "auto";
            icon-bg-color = "yellow";
            label-show = true;
            label-color = "yellow";
            format = "{{ percent }}%";
            label-max-length = 0;
            button-bg-color = "bg-surface-elevated";
            left-click = "dropdown:battery";
            right-click = "";
            middle-click = "";
            scroll-up = "";
            scroll-down = "";
            thresholds = [
              {
                below = 40;
                icon-color = "status-warning";
              }
              {
                below = 20;
                icon-color = "status-error";
                label-color = "status-error";
              }
            ];
          };

          brightness = {
            level-icons = [
              "ld-sun-dim-symbolic"
              "ld-sun-medium-symbolic"
              "ld-sun-symbolic"
            ];
            border-show = false;
            border-color = "yellow";
            icon-show = true;
            icon-color = "auto";
            icon-bg-color = "yellow";
            label-show = true;
            label-color = "yellow";
            format = "{{ percent }}%";
            label-max-length = 0;
            button-bg-color = "bg-surface-elevated";
            left-click = "dropdown:brightness";
            right-click = "";
            middle-click = "";
            scroll-up = "";
            scroll-down = "";
            thresholds = [
              {
                below = 20;
                icon-color = "status-warning";
                label-color = "status-warning";
              }
            ];
          };

          bluetooth = {
            disabled-icon = "ld-bluetooth-off-symbolic";
            disconnected-icon = "ld-bluetooth-symbolic";
            connected-icon = "ld-bluetooth-connected-symbolic";
            searching-icon = "ld-bluetooth-searching-symbolic";
            border-show = false;
            border-color = "blue";
            icon-show = true;
            icon-color = "auto";
            icon-bg-color = "blue";
            label-show = true;
            label-color = "blue";
            label-max-length = 15;
            button-bg-color = "bg-surface-elevated";
            left-click = "dropdown:bluetooth";
            right-click = "";
            middle-click = "";
            scroll-up = "";
            scroll-down = "";
          };

          network = {
            wifi-disabled-icon = "cm-wireless-disabled-symbolic";
            wifi-acquiring-icon = "cm-wireless-acquiring-symbolic";
            wifi-offline-icon = "cm-wireless-offline-symbolic";
            wifi-connected-icon = "cm-wireless-connected-symbolic";
            wifi-signal-icons = [
              "cm-wireless-signal-weak-symbolic"
              "cm-wireless-signal-ok-symbolic"
              "cm-wireless-signal-good-symbolic"
              "cm-wireless-signal-excellent-symbolic"
            ];
            wired-connected-icon = "cm-wired-symbolic";
            wired-acquiring-icon = "cm-wired-acquiring-symbolic";
            wired-disconnected-icon = "cm-wired-disconnected-symbolic";
            border-show = false;
            border-color = "accent";
            icon-show = true;
            icon-color = "auto";
            icon-bg-color = "accent";
            label-show = true;
            label-color = "accent";
            label-max-length = 15;
            button-bg-color = "bg-surface-elevated";
            left-click = "dropdown:network";
            right-click = "";
            middle-click = "";
            scroll-up = "";
            scroll-down = "";
          };

          volume = {
            level-icons = [
              "ld-volume-symbolic"
              "ld-volume-1-symbolic"
              "ld-volume-2-symbolic"
            ];
            icon-muted = "ld-volume-x-symbolic";
            border-show = false;
            border-color = "accent";
            icon-show = true;
            icon-color = "auto";
            icon-bg-color = "accent";
            label-show = true;
            label-color = "accent";
            format = "{{ percent }}%";
            label-max-length = 0;
            button-bg-color = "bg-surface-elevated";
            left-click = "dropdown:audio";
            right-click = "";
            middle-click = "wayle audio output-mute";
            scroll-up = "";
            scroll-down = "";
            dropdown-app-icons = "mapped"; # mapped|native
            thresholds = [
              {
                above = 100;
                icon-color = "status-warning";
                label-color = "status-warning";
              }
              {
                above = 130;
                icon-color = "status-error";
                label-color = "status-error";
              }
            ];
          };

          microphone = {
            icon-active = "ld-mic-symbolic";
            icon-muted = "ld-mic-off-symbolic";
            border-show = false;
            border-color = "green";
            icon-show = true;
            icon-color = "auto";
            icon-bg-color = "green";
            label-show = true;
            label-color = "green";
            label-max-length = 0;
            button-bg-color = "bg-surface-elevated";
            left-click = "dropdown:audio";
            right-click = "";
            middle-click = "wayle audio input-mute";
            scroll-up = "";
            scroll-down = "";
            thresholds = [
              {
                above = 70;
                icon-color = "status-warning";
                label-color = "status-warning";
              }
              {
                above = 90;
                icon-color = "status-error";
                label-color = "status-error";
              }
            ];
          };

          idle-inhibit = {
            startup-duration = 60; # minutes, 0 = indefinite
            icon-inactive = "tb-coffee-off-symbolic";
            icon-active = "tb-coffee-symbolic";
            format = "{{ state }}";
            border-show = false;
            border-color = "green";
            icon-show = true;
            icon-color = "auto";
            icon-bg-color = "green";
            label-show = true;
            label-color = "green";
            label-max-length = 0;
            button-bg-color = "bg-surface-elevated";
            left-click = "wayle idle toggle --indefinite";
            right-click = "wayle idle toggle";
            middle-click = "";
            scroll-up = "";
            scroll-down = "";
          };

          power = {
            icon-name = "ld-power-symbolic";
            border-show = false;
            border-color = "red";
            icon-color = "auto";
            icon-bg-color = "red";
            left-click = "";
            right-click = "";
            middle-click = "";
            scroll-up = "";
            scroll-down = "";
          };

          systray = {
            icon-scale = 1.0;
            item-gap = 0.25;
            internal-padding = 0.5;
            blacklist = [ ];
            overrides = [ ];
            border-show = false;
            border-color = "border-accent";
            button-bg-color = "bg-surface-elevated";
          };

          keyboard-input = {
            format = "{{ alias }}";
            icon-name = "ld-keyboard-symbolic";
            border-show = false;
            border-color = "yellow";
            icon-show = true;
            icon-color = "auto";
            icon-bg-color = "yellow";
            label-show = true;
            label-color = "yellow";
            label-max-length = 0;
            button-bg-color = "bg-surface-elevated";
            left-click = "";
            right-click = "";
            middle-click = "";
            scroll-up = "";
            scroll-down = "";
            layout-alias-map = {
              "English (US)" = "EN";
            };
          };

          cpu = {
            poll-interval-ms = 2000;
            temp-sensor = "auto"; # or a sensors label like "Tctl"
            format = "{{ percent }}%";
            icon-name = "ld-cpu-symbolic";
            border-show = false;
            border-color = "blue";
            icon-show = true;
            icon-color = "auto";
            icon-bg-color = "blue";
            label-show = true;
            label-color = "blue";
            label-max-length = 0;
            button-bg-color = "bg-surface-elevated";
            left-click = "";
            right-click = "";
            middle-click = "";
            scroll-up = "";
            scroll-down = "";
            thresholds = [
              {
                above = 70;
                icon-color = "status-warning";
                label-color = "status-warning";
              }
              {
                above = 90;
                icon-color = "status-error";
                label-color = "status-error";
              }
            ];
          };

          ram = {
            poll-interval-ms = 5000;
            format = "{{ percent }}%";
            icon-name = "ld-memory-stick-symbolic";
            border-show = false;
            border-color = "green";
            icon-show = true;
            icon-color = "auto";
            icon-bg-color = "green";
            label-show = true;
            label-color = "green";
            label-max-length = 0;
            button-bg-color = "bg-surface-elevated";
            left-click = "";
            right-click = "";
            middle-click = "";
            scroll-up = "";
            scroll-down = "";
            thresholds = [
              {
                above = 80;
                icon-color = "status-warning";
                label-color = "status-warning";
              }
              {
                above = 95;
                icon-color = "status-error";
                label-color = "status-error";
              }
            ];
          };
        };

        styling = {
          theme-provider = "wayle"; # static palette, not matugen/pywal/wallust

          palette = {
            # Kanagawa Wave
            bg = "#1F1F28"; # sumiInk1
            surface = "#2A2A37"; # sumiInk2
            elevated = "#363646"; # sumiInk3

            fg = "#DCD7BA"; # fujiWhite
            fg-muted = "#727169"; # fujiGray

            primary = "#7E9CD8"; # crystalBlue (accent)

            red = "#C34043"; # autumnRed
            yellow = "#E6C384"; # carpYellow
            green = "#76946A"; # autumnGreen
            blue = "#7E9CD8"; # crystalBlue
          };
        };
      };
    };

    hyprpaper = {
      enable = true;
      settings = {
        splash = false;

        wallpaper = [
          {
            monitor = "HDMI-A-1";
            path = "/home/shenawy/Pictures/gowall/4asvoroxwvf51.png";
            fit_mode = "cover";
          }
        ];
      };
    };

    swaync = {
      enable = true;
      # settings = {
      #   "positionX" = "right";
      #   "positionY" = "top";
      #   "control-center-positionX" = "none";
      #   "control-center-positionY" = "none";
      #   "control-center-margin-top" = 8;
      #   "control-center-margin-bottom" = 8;
      #   "control-center-margin-right" = 8;
      #   "control-center-margin-left" = 8;
      #   "control-center-width" = 500;
      #   "control-center-height" = -1;
      #   "fit-to-screen" = false;
      #   "layer-shell-cover-screen" = true;
      #
      #   "layer-shell" = true;
      #   "layer" = "overlay";
      #   "control-center-layer" = "overlay";
      #   "cssPriority" = "user";
      #   "notification-body-image-height" = 100;
      #   "notification-body-image-width" = 200;
      #   "notification-inline-replies" = true;
      #   "timeout" = 10;
      #   "timeout-low" = 5;
      #   "timeout-critical" = 0;
      #   "notification-window-width" = 500;
      #   "keyboard-shortcuts" = true;
      #   "image-visibility" = "always";
      #   "transition-time" = 200;
      #   "hide-on-clear" = true;
      #   "hide-on-action" = true;
      #   "script-fail-notify" = true;
      #
      #   "widgets" = [
      #     "inhibitors"
      #     "dnd"
      #     "mpris"
      #     "notifications"
      #   ];
      #
      #   "widget-config" = {
      #     "notifications" = {
      #       "vexpand" = false;
      #     };
      #     "inhibitors" = {
      #       "text" = "Inhibitors";
      #       "button-text" = "Clear All";
      #       "clear-all-button" = true;
      #     };
      #     "title" = {
      #       "text" = "Notifications";
      #       "clear-all-button" = false;
      #       "button-text" = "Clear All";
      #     };
      #     "dnd" = {
      #       "text" = "Do Not Disturb";
      #     };
      #     "label" = {
      #       "max-lines" = 5;
      #       "text" = "Label Text";
      #     };
      #     "mpris" = {
      #       "autohide" = true;
      #     };
      #   };
      #
      # };
      settings = {
        positionX = "right";
        positionY = "top";
        cssPriority = "user";

        layer = "overlay";
        control-center-layer = "top";
        layer-shell = true;

        control-center-width = 630;
        control-center-height = 950;
        control-center-margin-top = 8;
        control-center-margin-right = 8;
        control-center-margin-left = 0;

        notification-window-width = 600;
        notification-icon-size = 50;
        notification-body-image-height = 200;
        notification-body-image-width = 200;

        timeout = 4;
        timeout-low = 2;
        timeout-critical = 6;

        fit-to-screen = false;
        keyboard-shortcuts = true;
        image-visibility = "when-available";
        transition-time = 100;
        hide-on-clear = false;
        hide-on-action = false;
        text-empty = "No Notifications";
        script-fail-notify = true;

        notification-visibility = {
          example-name = {
            state = "muted";
            urgency = "Low";
            app-name = "Spotify";
          };
        };

        widgets = [
          "buttons-grid"
          "mpris"
          "volume"
          "backlight"
          "dnd"
          "title"
          "notifications"
        ];

        widget-config = {
          mpris = {
            image-size = 70;
            image-radius = 0;
          };

          volume = {
            label = " 󰕾 ";
            expand-button-label = " ";
            collapse-button-label = " ";
            show-per-app = true;
            show-per-app-icon = true;
            show-per-app-label = false;
          };

          backlight = {
            label = "󰃟 ";
          };

          dnd = {
            text = "Do Not Disturb";
          };

          title = {
            text = "Notifications";
            clear-all-button = true;
            button-text = "";
          };

          buttons-grid = {
            actions = [
              {
                label = " ";
                type = "toggle";
                active = true;
                command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
                update-command = "sh -c '[[ $(nmcli r wifi) == \"enabled\" ]] && echo true || echo false'";
              }
              # {
              #   label = "󰂯";
              #   type = "toggle";
              #   active = true;
              #   command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && rfkill unblock bluetooth || rfkill block bluetooth'";
              #   update-command = "sh -c \"rfkill list bluetooth | grep -q \"Soft blocked: no\" && echo true || echo false\"";
              # }
              {
                label = " ";
                type = "toggle";
                active = false;
                command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == false ]] && pactl set-source-mute @DEFAULT_SOURCE@ 1 || pactl set-source-mute @DEFAULT_SOURCE@ 0'";
                update-command = "sh -c '[[ $(pactl get-source-mute @DEFAULT_SOURCE@) == *yes* ]] && echo false || echo true'";
              }
              {
                label = " ";
                type = "toggle";
                active = false;
                command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && pactl set-sink-mute @DEFAULT_SINK@ 1 || pactl set-sink-mute @DEFAULT_SINK@ 0'";
                update-command = "sh -c '[[ $(pactl get-sink-mute @DEFAULT_SINK@) == *yes* ]] && echo true || echo false'";
              }
              {
                label = "󰸉 ";
                command = "~/.config/colors/Themer/Wallpaper.sh";
              }
              {
                label = "󰋖";
                command = "~/Scripts/keybinds_hint.sh";
              }
            ];
          };
        };
      };
      style = ''
        @define-color bg-base         #1f1f28;
        @define-color bg-surface      #1f1f28;
        @define-color bg-overlay      #2a2a37;
        @define-color fg-main         #dcd7ba;
        @define-color fg-muted        #2a2a37;
        @define-color fg-strong       #d4c787;
        @define-color accent-primary  #7e9cd8;
        @define-color accent-hover    #6a9589;
        @define-color accent-active   #6581b8;
        @define-color border-color    #29526E;
        @define-color shadow-color    rgba(0, 0, 0, 0.45);
        @define-color danger-color    #e46876;
        @define-color warning-color   #ff9e3b;
        @define-color info-color      #7fb4ca;
        @define-color success-color   #98bb6c;

        * {
            outline: none;
            font-family: "CaskaydiaCove Nerd Font";
            font-size: 21px;
            text-shadow: none;
            color: @fg-main;
            background-color: transparent;
            background: transparent;
        }

        .control-center {
            background-color: alpha(@bg-base, 0.8);
            border: 3px solid @border-color;
            padding: 7px;
        }
        /* For Webkit-based browsers (used by SwayNC) */
        .notification-list-container::-webkit-scrollbar {
            width: 0px; /* Hide the scrollbar */
        }

        /* Also for Firefox, though not necessary for SwayNC */
        .notification-list-container {
            scrollbar-width: none; /* Hide the scrollbar for Firefox */
        }

        .control-center .notification-row .notification-background {
            border-radius: 15px;
            margin-top: 5px;
        }

        .notification {
            background-color: @bg-base;
            border: 2px solid @border-color;
        }

        .notification > *:last-child > * {
            margin: 5px;
        }

        .summary { font-size: 1rem; }
        .time    { font-size: 0.8rem; }
        .body    { font-size: 1rem; }

        .notification-content {
            padding: 15px 10px 10px 20px;
        }

        .notification-action > button,
        .notification-action > label {
            padding: unset;
            margin: unset;
            font-size: 1rem;
            font-weight: normal;
        }

        .notification.critical {
            background-color: alpha(@danger-color, 0.5);
        }
        .notification.low,
        .notification.normal {
            background-color: alpha(@bg-surface, 0.5);
        }

        .close-button {
            background-color: alpha(@accent-primary, 0.8);
            box-shadow: 0 0 3px 0 @shadow-color;
        }
        .close-button:hover {
            background-color: alpha(@accent-hover, 0.8);
        }

        .notification-group-header,
        .notification-group-icon {
            font-size: 0.9rem;
        }

        .notification-group-collapse-button,
        .notification-group-close-all-button {
            background-color: @accent-primary;
        }
        .notification-group-collapse-button:hover {
            background-color: alpha(@accent-hover, 0.8);
        }
        .notification-group-close-all-button:hover {
            background-color: alpha(@accent-active, 0.8);
        }

        scale trough {
            margin: 0rem 1rem;
            background-color: @accent-primary;
            min-height: 4px;
            min-width: 70px;
        }

        trough slider {
            background: @accent-active;
        }
        trough slider:hover {
            background: @accent-hover;
        }
        trough highlight {
            background: @accent-hover;
        }

        tooltip {
            background-color: @accent-primary;
        }

        /*** Widgets ***/
        .widget-buttons-grid {
            background: @bg-base;
            font-size: 2rem;
            padding: 10px 10px 10px;
        }
        .widget-buttons-grid > flowbox > flowboxchild > button {
            background: @accent-primary;
            box-shadow: 0px 0px 10px alpha(@bg-overlay, 0.8);
            border-radius: 12px;
            min-width: 60px;
            min-height: 30px;
            padding: 6px;
            margin: 0 3px 0;
            transition: all .5s ease;
        }
        .widget-buttons-grid > flowbox > flowboxchild > button:hover {
            background: @accent-hover;
        }
        .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked {
            background: @accent-active;
        }
        .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked:hover {
            background: alpha(@accent-hover, 0.8);
        }

        /* MPRIS widget */
        @define-color mpris-album-art-overlay @bg-base;

        .widget-mpris .widget-mpris-player {
            padding: 16px;
            margin: 16px 20px;
            background-color: @mpris-album-art-overlay;
            border-radius: 12px;
            box-shadow: 0px 0px 10px @shadow-color;
        }
        .widget-mpris .widget-mpris-player .widget-mpris-album-art {
            border-radius: 12px;
            box-shadow: 0px 0px 10px @shadow-color;
        }
        .widget-mpris .widget-mpris-player .widget-mpris-title {
            font-weight: bold;
            font-size: 1.1rem;
            margin: 0px 8px 8px 8px;
        }
        .widget-mpris .widget-mpris-player .widget-mpris-subtitle {
            font-size: 1rem;
        }
        .widget-mpris > box > button:hover {
            background: alpha(@accent-hover, 0.6);
        }

        /* Volume widget */
        .widget-volume {
            padding: 6px 5px 5px 5px;
            margin: unset;
            font-size: 1rem;
        }
        .widget-volume > box > button {
            border: none;
        }
        .per-app-volume {
            padding: 4px 8px 8px 8px;
            margin: 0px 8px 8px 8px;
        }

        /* Backlight widget */
        .widget-backlight {
            padding: 0 0 3px 16px;
            margin: unset;
            font-size: 1rem;
        }

        /* DND widget */
        .widget-dnd {
            font-weight: bold;
            padding: 20px 15px 15px;
            font-size: 1rem;
        }
        .widget-dnd > switch {
            border-radius: 100px;
            background: @accent-primary;
            border: none;
            box-shadow: none;
            padding: 3px;
        }
        .widget-dnd > switch:checked {
            background: @accent-active;
        }
        .widget-dnd > switch slider {
            background: @bg-base;
            border-radius: 12px;
            min-width: 18px;
            min-height: 18px;
        }

        /* Title widget */
        .widget-title {
            font-weight: bold;
            padding: 15px;
        }
        .widget-title > label {
            font-size: 1.1rem;
        }
        .widget-title > button {
            background: @accent-primary;
            border: none;
            border-radius: 100px;
            padding: 0px 8px;
            transition: all .7s ease;
        }
        .widget-title > button:hover {
            background: alpha(@accent-active, 0.8);
            box-shadow: 0 0 10px 0 @shadow-color;
        }


        /* Hide ALL scrollbars (vertical and horizontal) */
        scrollbar,
        scrollbar.vertical,
        scrollbar.horizontal,
        scrollbar slider,
        scrollbar trough {
            all: unset;
            background: transparent;
            border: none;
            width: 0 !important;
            height: 0 !important;
            min-width: 0 !important;
            min-height: 0 !important;
        }

        /* Also hide scrollbar overlays (GTK overlay scrollbars) */
        scrollbar, scrollbar * {
            opacity: 0 !important;
        }
      '';
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;
    xwayland.enable = true;
    # plugins = [
    #   pkgs.hyprlandPlugins.hyprbars
    # ];
    settings = {
      "$mainMod" = "ALT";
      "$terminal" = "wezterm";
      "$fileManager" = "nautilus";
      "$browser" = "google-chrome";
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
          size = 8;
          passes = 1;
        };

        shadow = {
          enabled = true;
          range = 300;
          render_power = 4;
          color = "rgba(1a1a1aaf)";
          offset = "0 40";
          scale = "0.9";
        };

      };

      monitor = ",preferred,auto,auto";

      general = {
        gaps_in = 3;
        gaps_out = 13;
        border_size = 2;
        layout = "dwindle";
        allow_tearing = false;
        "col.active_border" = "0xFFDCD7BA";
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
        # '', Print, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.wl-clipboard}/bin/wl-copy''

        ", PRINT, exec, hyprshot -m window"
        "$mainMod, PRINT, exec, hyprshot -m region"

        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod SHIFT, E, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, B, exec, $browser"
        "$mainMod, V, togglefloating"
        "$mainMod, D, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, U, layoutmsg, togglesplit"
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

      # dwindle = {
      #   pseudotile = "yes";
      #   preserve_split = "yes";
      # };

      # gestures = {
      #   workspace_swipe = "off";
      # };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      windowrule = [
        "opacity 0.95, match:class com.mitchellh.ghostty|xdg-desktop-portal-gtk|org.gnome.Nautilus|org.wezfurlong.wezterm"
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

      exec-once=[workspace 1] wezterm start --cwd ~/projects -- $SHELL -c 'nvim; exec $SHELL';
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
    NVIM_CODELLDB_PATH = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb";
    NVIM_PYTHON_PATH = pkgs.python3.withPackages (ps: with ps; [ debugpy ]);
    JS_DEBUG = "${pkgs.vscode-js-debug}";
  };

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.btop = {
    enable = true;
  };

  programs.wofi = {
    enable = true;
  };

  programs.sqls = {
    enable = true;
  };

  programs.cava = {
    enable = true;
  };

  programs.opam = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      customCommands = [
        {
          key = "V";
          context = "files";
          description = "Diff focused file or directory";
          command = "nvim -c 'DiffviewOpen HEAD -- {{.SelectedPath}}'";
          output = "terminal";
        }
      ];
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";
      editor = "nvim";
    };
    gitCredentialHelper.enable = true;
  };

  systemd.user.services.xdg-nvfilechooser = {
    Unit = {
      Description = "XDG Neovim filechooser backend";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "/home/shenawy/projects/xdg-nvfilechooser/target/debug/xdg-nvfilechooser";
      Restart = "on-failure";
      RestartSec = "3s";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # programs.waybar = {
  #   enable = true;
  #   systemd.enable = true;
  #   settings = {
  #     mainBar = {
  #       "layer" = "top";
  #       "position" = "bottom";
  #       "modules-left" = [
  #         "hyprland/workspaces"
  #       ];
  #       "modules-center" = [
  #         "custom/music"
  #       ];
  #       "modules-right" = [
  #         "pulseaudio"
  #         # "bluetooth"
  #         "clock"
  #         "tray"
  #         "hyprland/language"
  #         "custom/lock"
  #         "custom/power"
  #         "custom/notification"
  #       ];
  #       "hyprland/workspaces" = {
  #         "on-click" = "activate";
  #         "on-scroll-up" = "hyprctl dispatch workspace e-1";
  #         "on-scroll-down" = "hyprctl dispatch workspace e+1";
  #         "format" = "{icon}";
  #         "all-outputs" = true;
  #         "format-icons" = {
  #           "1" = "";
  #           "2" = "";
  #           "3" = "";
  #           "default" = "";
  #         };
  #       };
  #       "tray" = {
  #         "icon-size" = 21;
  #         "spacing" = 10;
  #       };
  #
  #       "custom/music" = {
  #         "format" = "  {}";
  #         "escape" = true;
  #         "interval" = 5;
  #         "tooltip" = false;
  #         "exec" = "playerctl metadata --format='{{ title }}'";
  #         "on-click" = "playerctl play-pause";
  #         "max-length" = 50;
  #       };
  #       "clock" = {
  #         "timezone" = "Egypt";
  #         "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
  #         "format-alt" = " {:%d/%m/%Y}";
  #         "format" = " {:%I:%M %p}";
  #       };
  #       "pulseaudio" = {
  #         "format" = "{icon} {volume}%";
  #         "format-muted" = "";
  #         "format-icons" = {
  #           "default" = [
  #             ""
  #             ""
  #             " "
  #           ];
  #         };
  #         "on-click" = "pwvucontrol";
  #       };
  #       "custom/lock" = {
  #         "tooltip" = false;
  #         "on-click" = "hyprlock &";
  #         "format" = "";
  #       };
  #       "custom/power" = {
  #         "tooltip" = false;
  #         "on-click" = "shutdown -h now";
  #         "format" = "⏻";
  #       };
  #       "custom/notification" = {
  #         tooltip = false;
  #         format = "{} {icon}";
  #         "format-icons" = {
  #           notification = "󱅫";
  #           none = "";
  #           "dnd-notification" = " ";
  #           "dnd-none" = "󰂛";
  #           "inhibited-notification" = " ";
  #           "inhibited-none" = "";
  #           "dnd-inhibited-notification" = " ";
  #           "dnd-inhibited-none" = " ";
  #         };
  #         "return-type" = "json";
  #         "exec-if" = "which swaync-client";
  #         exec = "swaync-client -swb";
  #         "on-click" = "sleep 0.1 && swaync-client -t -sw";
  #         "on-click-right" = "sleep 0.1 && swaync-client -d -sw";
  #         escape = true;
  #       };
  #
  #       "hyprland/language" = {
  #         "format" = " {}";
  #         "format-en" = "en";
  #         "format-ar" = "ar";
  #         "keyboard-name" = "usb-keyboard-usb-keyboard";
  #         "on-click" = "hyprctl switchxkblayout usb-keyboard-usb-keyboard next";
  #       };
  #
  #     };
  #   };
  #   style = ''
  #     @define-color rosewater rgba(245, 224, 220, 1.0);
  #     @define-color flamingo rgba(242, 205, 205, 1.0);
  #     @define-color pink rgba(245, 194, 231, 1.0);
  #     @define-color mauve rgba(149, 127, 184, 1.0);
  #     @define-color red rgba(232, 36, 36, 1.0);
  #     @define-color maroon rgba(210, 126, 153, 1.0);
  #     @define-color peach rgba(255, 160, 102, 1.0);
  #     @define-color yellow rgba(230, 195, 132, 1.0);
  #     @define-color green rgba(152, 187, 108, 1.0);
  #     @define-color teal rgba(148, 226, 213, 1.0);
  #     @define-color sky rgba(126, 156, 216, 1.0);
  #     @define-color sapphire rgba(127, 180, 202, 1.0);
  #     @define-color blue rgba(156, 171, 202, 1.0);
  #     @define-color blue_wave rgba(45, 79, 103, 1);
  #     @define-color lavender rgba(147, 138, 169, 1.0);
  #     @define-color text rgba(220, 215, 186, 1.0);
  #     @define-color subtext1 rgba(186, 194, 222, 1.0);
  #     @define-color subtext0 rgba(166, 173, 200, 1.0);
  #     @define-color overlay2 rgba(147, 153, 178, 1.0);
  #     @define-color overlay1 rgba(127, 132, 156, 1.0);
  #     @define-color overlay0 rgba(108, 112, 134, 1.0);
  #     @define-color surface2 rgba(88, 91, 112, 1.0);
  #     @define-color surface1 rgba(69, 71, 90, 1.0);
  #     @define-color surface0 rgba(42, 42, 55, 1.0);
  #     @define-color base rgba(30, 30, 46, 1.0);
  #     @define-color mantle rgba(24, 24, 37, 1.0);
  #     @define-color crust rgba(17, 17, 27, 1.0);
  #
  #     @define-color rosewater_hover rgba(245, 224, 220, 0.40);
  #     @define-color flamingo_hover rgba(242, 205, 205, 0.40);
  #     @define-color pink_hover rgba(245, 194, 231, 0.40);
  #     @define-color mauve_hover rgba(149, 127, 184, 0.40);
  #     @define-color red_hover rgba(232, 36, 36, 0.40);
  #     @define-color maroon_hover rgba(210, 126, 153, 0.40);
  #     @define-color peach_hover rgba(255, 160, 102, 0.40);
  #     @define-color yellow_hover rgba(230, 195, 132, 0.40);
  #     @define-color green_hover rgba(152, 187, 108, 0.40);
  #     @define-color teal_hover rgba(148, 226, 213, 0.40);
  #     @define-color sky_hover rgba(126, 156, 216, 0.40);
  #     @define-color sapphire_hover rgba(127, 180, 202, 0.40);
  #     @define-color blue_hover rgba(156, 171, 202, 0.40);
  #     @define-color blue_wave_hover rgba(45, 79, 103, 0.40);
  #     @define-color lavender_hover rgba(147, 138, 169, 0.40);
  #     @define-color text_hover rgba(220, 215, 186, 0.40);
  #     @define-color subtext1_hover rgba(186, 194, 222, 0.40);
  #     @define-color subtext0_hover rgba(166, 173, 200, 0.40);
  #     @define-color overlay2_hover rgba(147, 153, 178, 0.40);
  #     @define-color overlay1_hover rgba(127, 132, 156, 0.40);
  #     @define-color overlay0_hover rgba(108, 112, 134, 0.40);
  #     @define-color surface2_hover rgba(88, 91, 112, 0.40);
  #     @define-color surface1_hover rgba(69, 71, 90, 0.40);
  #     @define-color surface0_hover rgba(42, 42, 55, 0.40);
  #     @define-color base_hover rgba(30, 30, 46, 0.40);
  #     @define-color mantle_hover rgba(24, 24, 37, 0.40);
  #     @define-color crust_hover rgba(17, 17, 27, 0.40);
  #
  #
  #     * {
  #       font-family: "FiraCode Nerd Font";
  #       font-size: 15px;
  #       margin: 0;
  #       min-height: 0;
  #     }
  #
  #     #waybar {
  #       background: transparent;
  #       color: @text;
  #     }
  #
  #     #workspaces {
  #       border-radius: 1rem;
  #       background-color: @surface0;
  #       margin-left: 1rem;
  #     }
  #
  #     #workspaces button {
  #       color: @lavender;
  #       border-radius: 1rem;
  #     }
  #
  #     #workspaces button.active {
  #       color: @sky;
  #       border-radius: 1rem;
  #     }
  #
  #     #workspaces button:hover {
  #       color: @sapphire;
  #       border-radius: 1rem;
  #     }
  #
  #     #custom-music,
  #     #tray,
  #     #backlight,
  #     #clock,
  #     #battery,
  #     #pulseaudio,
  #     #custom-lock,
  #     #language,
  #     #bluetooth,
  #     #custom-power,
  #     #custom-notification {
  #       background-color: @surface0;
  #       padding: 0.5rem 0.8rem;
  #       margin: 0px 0px;
  #     }
  #
  #     #clock:hover {
  #       background-color: @blue_hover;
  #       border-radius: 0px 1rem 1rem 0px;
  #       margin-right: 1rem;
  #     }
  #
  #     #clock {
  #       transition: all 0.1s linear;
  #       color: @blue;
  #       border-radius: 0px 1rem 1rem 0px;
  #       margin-right: 1rem;
  #     }
  #
  #     #custom-lock:hover {
  #       padding-right: 1.5rem;
  #       padding-left: 1.5rem;
  #       background-color: @green_hover;
  #     }
  #
  #     #custom-lock {
  #       padding-right: 1.5rem;
  #       padding-left: 1.5rem;
  #       transition: all 0.1s linear;
  #       color: @green;
  #     }
  #
  #     #battery {
  #       color: @green;
  #     }
  #
  #     #battery.charging {
  #       color: @green;
  #     }
  #
  #     #battery.warning:not(.charging) {
  #       color: @red;
  #     }
  #
  #     #bluetooth {
  #       transition: all 0.1s linear;
  #       color: @blue_wave;
  #     }
  #
  #     #bluetooth:hover {
  #       background-color: @blue_wave_hover;
  #     }
  #
  #     #pulseaudio:hover {
  #       background-color: @maroon_hover;
  #       border-radius: 1rem 0px 0px 1rem;
  #       margin-left: 0px;
  #     }
  #
  #     #pulseaudio {
  #       transition: all 0.1s linear;
  #       color: @maroon;
  #       border-radius: 1rem 0px 0px 1rem;
  #       margin-left: 0px;
  #     }
  #
  #     #custom-music {
  #       color: @mauve;
  #       border-radius: 1rem;
  #     }
  #
  #     #language:hover {
  #       background-color: @peach_hover;
  #     }
  #
  #     #language {
  #       transition: all 0.1s linear;
  #       border-radius: 1rem 0px 0px 1rem;
  #       color: @peach;
  #     }
  #
  #     #custom-notification:hover {
  #       background-color: rgba(45, 79, 103, 0.40);
  #       margin-right: 1rem;
  #       border-radius: 1rem;
  #     }
  #
  #     #custom-notification {
  #       transition: all 0.1s linear;
  #       color: rgba(45, 79, 103, 1.0) ;
  #       margin-right: 1rem;
  #       border-radius: 1rem;
  #     }
  #
  #     #custom-notification {
  #       color: #2d4f67;
  #       margin-right: 1rem;
  #       border-radius: 1rem;
  #     }
  #
  #     #custom-power:hover {
  #       background-color: @red_hover;
  #       margin-right: 1rem;
  #       border-radius: 0px 1rem 1rem 0px;
  #       padding-right: 1.5rem;
  #       padding-left: 1.5rem;
  #     }
  #
  #     #custom-power {
  #       transition: all 0.1s linear;
  #       color: @red;
  #       margin-right: 1rem;
  #       border-radius: 0px 1rem 1rem 0px;
  #       padding-right: 1.5rem;
  #       padding-left: 1.5rem;
  #     }
  #
  #     #tray {
  #       margin-right: 2rem;
  #       border-radius: 1rem;
  #     }
  #
  #     #workspaces button.urgent {
  #       color: @red;
  #     }
  #   '';
  # };

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
    dotDir = "${config.xdg.configHome}/zsh";
    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
      }
    ];
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    initContent = ''
      export MANPAGER='nvim +Man!'
      export MANWIDTH='205'
      export FZF_DEFAULT_OPTS='--bind=ctrl-k:up,ctrl-j:down'

      setopt interactivecomments
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh;
      source ~/.p10k.zsh

      # bindkey -s ^f "tmux-sessionizer\n"
      bindkey "^H" backward-delete-char
      bindkey "^?" backward-delete-char

      # bindkey -v

      # function vi-yank-xclip {
      #     zle vi-yank
      #     echo "$CUTBUFFER" | xclip -i
      # }

      # zle -N vi-yank-xclip
      # bindkey -M vicmd 'y' vi-yank-xclip
    '';
    shellAliases = {
      notes = ''
        nvim /tmp/notes.md

        if [[ -f /tmp/notes.md ]]; then
            rm /tmp/notes.md
        fi
      '';
      v = "nvim";
      cat = "bat";
      cd = "z";
      clean = "nh clean all";
      switch = "nh os switch /etc/nixos";
      flake = "sudoedit /etc/nixos/flake.nix";
      conf = "sudoedit /etc/nixos/configuration.nix";
      home = "sudoedit /etc/nixos/home.nix";
      open = "xdg-open";
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

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    signing.format = null;
    settings = {
      user.name = "Mohamed Elshenawy";
      user.email = "alshenawy10203022@gmail.com";

      alias = {
        adog = "log --all --decorate --oneline --graph --abbrev-commit --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
        diffview = "!nvim -c DiffviewOpen";
      };
      credential = {
        helper = "manager";
        credentialStore = "cache";
      };
      signing.format = "null";

      diff.tool = "diffview";
      difftool.diffview.cmd = ''nvim "$LOCAL" "$REMOTE" +"DiffviewOpen file "$LOCAL" "$REMOTE"'';
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.opencode = {
    enable = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 32;
  };
}
