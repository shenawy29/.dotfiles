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

  nix.extraOptions = ''
    trusted-users = root shenawy
  '';

  virtualisation.docker.enable = true;

  nixpkgs = {
    config.allowUnfree = true;
    # config.android_sdk.accept_license = true;
  };

  boot = {
    tmp.cleanOnBoot = true;
    plymouth.enable = true;
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [ "quiet" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = false;

    loader.grub = {
      efiSupport = true;
      device = "nodev";
      enable = true;
      useOSProber = true;
    };

    loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
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

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        amdvlk
      ];
    };
    pulseaudio.enable = false;
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  services = {
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "shenawy";
        };
        default_session = initial_session;
      };
    };

    locate = {
      enable = true;
      package = pkgs.mlocate;
      localuser = null;
    };

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
      displayManager.lightdm.enable = false;
    };
  };

  # Don't forget to set a password with ‘passwd’.
  users.users.shenawy = {
    isNormalUser = true;
    description = "Mohamed Elshenawy";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "corectrl"
    ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    backupFileExtension = "backup";
    users = {
      "shenawy" = {
        imports = [
          ./home.nix
        ];
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
    menus.enable = true;
    mime.enable = true;
    icons.enable = true;
    autostart.enable = true;
  };

  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      flake = "/etc/nixos/";
    };

    file-roller.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    corectrl = {
      enable = true;
      gpuOverclock.enable = true;
      gpuOverclock.ppfeaturemask = "0xffffffff";
    };
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
    gamemode.enable = true;
    hyprland = {
      enable = true;
      systemd.setPath.enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh = {
      enable = true;
    };
  };

  users.users.shenawy.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    # Scripts
    (import ./tmux-sessionizer.nix { inherit pkgs; })
    # Language tools
    sqls

    buf

    vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    eslint_d
    prettierd
    tailwindcss-language-server

    bash-language-server
    shfmt
    shellcheck

    gopls

    llvmPackages_19.clang-tools
    clang
    cmake-language-server
    cmake-lint

    lua-language-server
    stylua

    nil
    nixfmt-rfc-style

    python312Packages.autopep8
    basedpyright

    cargo-nextest
    zls

    dockerfile-language-server-nodejs
    docker-compose-language-service

    # Languages / Compilers
    protobuf
    nodejs
    rustup
    go
    gcc
    zig
    python3
    flutter
    jdk

    # CLI tools
    delta
    fd
    ntfs3g
    wasm-pack
    lshw
    btop
    man-pages
    man-pages-posix
    stdmanpages
    sysstat
    cmatrix
    playerctl
    jq
    rhythmbox
    cbonsai
    fdupes
    unzip
    p7zip
    unrar
    fastfetch
    pfetch
    zoxide
    gnumake
    cmake
    killall
    zsh-fzf-tab
    ripgrep
    eza
    bat
    netcat-gnu
    graphviz
    gnuplot
    vim

    # Utils
    cage
    devenv
    xorg.xhost
    grim
    slurp
    wl-clipboard
    xclip

    # Apps
    gnome-disk-utility
    gparted
    kooha
    obs-studio
    qbittorrent
    celluloid
    wofi
    eog
    evince
    google-chrome
    pavucontrol
    fragments
  ];

  system.stateVersion = "24.05";
}
