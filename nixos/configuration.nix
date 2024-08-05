# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./tmux.nix
    inputs.home-manager.nixosModules.default
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  boot = {
    plymouth.enable = true;
    initrd.kernelModules = [ "amdgpu" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [ "quiet" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Cairo";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

  hardware = {
    graphics.enable32Bit = true;
    pulseaudio.enable = false;
  };

  security.rtkit.enable = true;

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb.layout = "us";
      xkb.variant = "";
      displayManager.lightdm = {
        enable = true;
        greeters.slick = {
          enable = true;
          cursorTheme.package = pkgs.capitaine-cursors;
          cursorTheme.name = "capitaine-cursors";
          cursorTheme.size = 32;
          theme.package = pkgs.kanagawa-gtk-theme;
          theme.name = "Kanagawa-BL-LB";
        };
        background = lib.mkForce ./BackgroundBlur.png;
      };
      # displayManager.gdm = {
      #   enable = true;
      # };
    };
  };

  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  # systemd.services.greetd.serviceConfig = {
  #   Type = "idle";
  #   StandardInput = "tty";
  #   StandardOutput = "tty";
  #   StandardError = "journal"; # Without this errors will spam on screen
  #   # Without these bootlogs will spam on screen
  #   TTYReset = true;
  #   TTYVHangup = true;
  #   TTYVTDisallocate = true;
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shenawy = {
    isNormalUser = true;
    description = "Mohamed Elshenawy";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [
      #  thunderbird
    ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    backupFileExtension = "backup";
    users = {
      "shenawy" = import ./home.nix;
    };
  };

  # users.users.gdm.packages = with pkgs; [ capitaine-cursors ];

  programs = {
    dconf = {
      enable = true;
      profiles.gdm.databases = [
        {
          settings = {
            "org/gnome/desktop/interface" = {
              cursor-theme = "capitaine-cursors";
              cursor-size = lib.gvariant.mkInt32 32;
            };
          };
        }
      ];
    };

    hyprland.enable = true;
    hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    thunar.enable = true;
    zsh = {
      enable = true;
    };
  };

  users.users.shenawy.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    #Scripts
    (import ./tmux-sessionizer.nix { inherit pkgs; })
    # Language tools
    basedpyright
    nodePackages_latest.typescript-language-server
    nodePackages_latest.bash-language-server
    tailwindcss-language-server
    shfmt
    shellcheck
    gopls
    eslint_d
    prettierd
    clang-tools_18
    lua-language-server
    nil
    nixfmt-rfc-style
    asm-lsp
    cargo-nextest

    # Languages / Compilers
    nodejs
    rustup
    go
    gcc
    python3
    jdk

    # CLI tools
    cmatrix
    cava
    cbonsai
    pkg-config
    fdupes
    unzip
    unrar
    fastfetch
    mlocate
    zoxide
    gnumake
    cmake
    killall
    zsh-fzf-tab
    ripgrep
    wget
    eza
    bat
    netcat-gnu
    graphviz
    gnuplot
    riffdiff

    # Utils
    gtk2
    gtk3
    gtk4
    grim
    slurp
    wl-clipboard
    xclip

    # Apps
    eog
    evince
    hyprpaper
    google-chrome
    pavucontrol
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    image = ./Background.png;

    targets = {
      gnome.enable = true;
      lightdm.enable = true;
      gtk.enable = true;
      nixos-icons.enable = true;
    };
    cursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 32;
    };
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
    };
  };

  system.stateVersion = "24.05";
}
