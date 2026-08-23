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
    inputs.home-manager.nixosModules.default
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # nix.extraOptions = ''
  #   trusted-users = root shenawy
  # '';

  virtualisation.docker.enable = true;

  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      swtpm.enable = true;
    };

  };

  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  boot = {
    tmp.cleanOnBoot = true;
    plymouth.enable = true;
    initrd.kernelModules = [
      "amdgpu"
      "kvm-amd"
    ];

    kernelModules = [
      "kvm-intel"
      "hid-nintendo"
      "v4l2loopback"
    ];

    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];

    extraModprobeConfig = ''
      # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
      # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
      # https://github.com/umlaeute/v4l2loopback
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';

    kernelParams = [
      "quiet"
      # "amdgpu.ppfeaturemask=0xfff7ffff"
    ];

    kernel.sysctl."kernel.yama.ptrace_scope" = 0;

    kernelPackages = pkgs.linuxPackages_latest;

    # loader = {
    #   systemd-boot = {
    #     enable = true;
    #     edk2-uefi-shell.enable = true;
    #   };
    # };

    # loader.grub = {
    #   efiSupport = true;
    #   device = "nodev";
    #   enable = true;
    #   useOSProber = true;
    # };

    # loader.efi = {
    #   canTouchEfiVariables = true;
    #   efiSysMountPoint = "/boot";
    # };

    loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        default = "saved";
      };
    };
  };

  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      nerd-fonts.fira-code
    ];
  };

  fileSystems."/home/shenawy/data" = {
    device = " /dev/disk/by-uuid/6226BB984646BB60";
    fsType = "ntfs";
    options = [
      "nofail"
      "users"
      "x-gvfs-show"
      # "gid=100"
      # "umask=0002"
      # "user"
      # "u+rwx"
      # "g+rwx"
      # "o+rwx"
    ];
  };

  networking.hostName = "nixos";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      3000
      4321
      5000
      8000
      8080
      8081
    ];

  };

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

  hardware = {
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          # Shows battery charge of connected devices on supported
          # Bluetooth adapters. Defaults to 'false'.
          Experimental = true;
          # When enabled other devices can connect faster to us, however
          # the tradeoff is increased power consumption. Defaults to
          # 'false'.
          FastConnectable = true;
        };
        Policy = {
          # Enable all controllers when they are found. This includes
          # adapters present on start as well as adapters that are plugged
          # in later on. Defaults to 'true'.
          AutoEnable = true;
        };
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # xdg = {
  #   mime.enable = true;
  #
  #   portal = {
  #     enable = true;
  #     wlr.enable = true;
  #     xdgOpenUsePortal = true;
  #     extraPortals = [
  #       fzfPortal
  #       pkgs.xdg-desktop-portal-gnome
  #       pkgs.xdg-desktop-portal-gtk
  #       pkgs.xdg-desktop-portal-wlr
  #       pkgs.xdg-desktop-portal-hyprland
  #     ];
  #
  #     config = {
  #       Hyprland = {
  #         default = [
  #           "fzf"
  #           "hyprland"
  #           "gtk"
  #         ];
  #         "org.freedesktop.impl.portal.FileChooser" = [ "fzf" ];
  #       };
  #     };
  #   };
  # };

  services = {
    dbus = {
      implementation = "broker";
    };

    hypridle.enable = true;
    blueman.enable = true;

    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/start-hyprland";
          user = "shenawy";
        };
        default_session = initial_session;
      };
    };

    locate = {
      enable = true;
      package = pkgs.mlocate;
    };

    gvfs.enable = true;

    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;

      wireplumber.extraConfig."11-bluetooth-policy" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };
      };

      # only one working
      extraConfig.pipewire."91-virtual-mic" = {
        "context.objects" = [
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "virtual_mic";
              "node.description" = "VirtualMic";
              "media.class" = "Audio/Source/Virtual";
              "audio.position" = "FL,FR";
            };
          }
        ];
      };

    };
  };

  # Don't forget to set a password with ‘passwd’.
  users.users.shenawy = {
    isNormalUser = true;
    description = "Mohamed Elshenawy";
    extraGroups = [
      "libvirtd"
      "dialout"
      "networkmanager"
      "wheel"
      "docker"
      "corectrl"
      "adbusers"
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

  programs = {
    spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        enable = true;

        experimentalFeatures = true;

        enabledExtensions = with spicePkgs.extensions; [
          fullAppDisplay
          adblock
          hidePodcasts
          powerBar
          popupLyrics
          shuffle

          {
            src =
              pkgs.fetchFromGitHub {
                owner = "Spikerko";
                repo = "spicy-lyrics";
                rev = "2de7a609bdead1ade90addde2b1d551d4b87e87a";
                hash = "sha256-VEMxk9Hjtuh5fRYt0LzOhkd34sr2i6e6FFM55FJHz98=";
              }
              + "/builds";
            # The actual file name of the extension usually ends with .js
            name = "spicy-lyrics.mjs";
          }
        ];

        enabledCustomApps = with spicePkgs.apps; [
          localFiles
          newReleases
          lyricsPlus
          ncsVisualizer
        ];

        enabledSnippets = with spicePkgs.snippets; [
          pointer
        ];

        theme = spicePkgs.themes.hazy;
      };

    obs-studio = {
      enable = true;
      enableVirtualCamera = true;

      plugins = with pkgs.obs-studio-plugins; [
        input-overlay
        droidcam-obs
        obs-pipewire-audio-capture
      ];
    };

    lazygit = {
      enable = true;
    };

    direnv = {
      enable = true;
    };

    localsend = {
      enable = true;
      openFirewall = true;
    };

    nh = {
      enable = true;
      clean.enable = true;
      flake = "/etc/nixos/";
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.setPath.enable = true;
      withUWSM = true;
    };

    hyprlock.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    zsh = {
      enable = true;
    };
    droidcam.enable = true;
  };

  users.users.shenawy.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    (pkgs.callPackage ./pkgs/kulala/default.nix { })
    (pkgs.callPackage ./pkgs/pt/default.nix { })
    emacs
    vulkan-tools
    # glxgears
    powershell

    sqlite

    crosspipe
    v4l-utils
    neovide
    wezterm
    fontforge-gtk
    woff2
    # Scripts
    # Language tools
    yaml-language-server
    jdt-language-server
    svelte-language-server
    tinymist

    mdx-language-server
    marksman

    buf

    vscode-langservers-extracted
    vtsls
    prettierd
    tailwindcss-language-server

    vscode-js-debug

    bash-language-server
    shfmt
    shellcheck

    go-swag

    golangci-lint
    gopls
    delve

    clang-tools
    gdb

    neocmakelsp
    cmake-format
    cmake-lint

    lua-language-server
    selene
    stylua

    nixd
    nixfmt

    ruff

    basedpyright

    cargo-nextest

    zls

    dockerfile-language-server
    docker-compose-language-service
    docker-compose
    hadolint

    astro-language-server

    # Languages / Compilers
    jdk
    lombok
    maven

    capnproto
    capnproto-rust
    protobuf

    nodejs

    dotnet-sdk_10
    roslyn-ls
    rustup
    go
    gcc
    clang
    zig
    python314
    python314Packages.debugpy

    # CLI tools
    nest-cli
    virt-viewer
    virt-manager

    dig
    asciinema
    cloc
    yt-dlp
    lsof
    trashy
    qemu
    # spotdl
    # slsk-batchdl
    # nicotine-plus

    parallel-full
    file
    imagemagick
    tree-sitter
    hyperfine
    fd
    lshw
    man-pages
    man-pages-posix
    stdmanpages
    sysstat
    cmatrix
    playerctl
    jq
    cbonsai
    unzip
    p7zip
    unrar
    fastfetch
    zoxide
    gnumake
    cmake
    ninja
    ripgrep
    eza
    bat
    netcat-gnu
    socat
    graphviz
    gnuplot
    cava
    vim

    # Utils
    showmethekey
    alsa-utils
    tealdeer
    navi
    usbutils
    pulseaudio
    inotify-tools
    hyprcursor
    hyprshot
    hyprpicker
    hyprsysteminfo
    hyprsunset
    python313Packages.pylatexenc
    ffmpeg
    ffmpegthumbnailer
    xdg-utils
    ntfs3g
    libnotify
    libimobiledevice
    ifuse
    git-filter-repo
    git-credential-manager
    devenv
    xhost
    grim
    slurp
    wl-clipboard

    # Apps
    libreoffice
    anki-bin
    easyeffects

    (pkgs.gimp-with-plugins.override {
      plugins = with pkgs.gimpPlugins; [
        gmic
      ];
    })

    readest
    wireshark
    file-roller

    nautilus
    gnome-disk-utility
    gnome-boxes # VM management
    dnsmasq # VM networking
    phodav # (optional) Share files with guest VMs
    gparted
    qbittorrent
    celluloid
    eog
    evince
    google-chrome
    pwvucontrol
  ];

  system.stateVersion = "24.05";

}
