{ config, pkgs, ... }:

let extrapkgs = pkgs.callPackage ./extras/all.nix {};
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration-desktop.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];
  };

  networking = {
    hostName = "amaterasu";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        20001
        27036 27037 # steam
      ];
      allowedUDPPorts = [
        27031 27032 27033 27034 27035 27036
      ];
    };
  };

  hardware = {
    pulseaudio = {
      enable = true;
      # support32Bit = true;
      package = pkgs.pulseaudioFull;
      # configFile = pkgs.writeText "default.pa" ''
      #   load-module module-bluetooth-policy
      #   load-module module-bluetooth-discover
      #   ## module fails to load with
      #   ##   module-bluez5-device.c: Failed to get device path from module arguments
      #   ##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
      #   # load-module module-bluez5-device
      #   # load-module module-bluez5-discover
      # '';
    };
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
      # extraConfig = "
      #   [General]
      #   Enable=Source,Sink,Media,Socket
      # ";
    };
    cpu.intel.updateMicrocode = true;
  };


  time.timeZone = "Europe/Ljubljana";

  nix.package = pkgs.nixUnstable;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  environment.systemPackages = with pkgs; [
    bashCompletion
    binutils
    cabal-install
    cabal2nix
    clipit
    curl
    dmenu
    elmPackages.elm
    evince
    extrapkgs.margarinetools
    feh
    file
    ghc
    gimp
    gitAndTools.gitFull
    gmrun
    gnome3.eog
    gnome3.file-roller
    gnome3.gnome-bluetooth
    gnome3.gnome-calculator
    gnome3.gnome-disk-utility
    gnome3.gnome-system-monitor
    gnome3.networkmanagerapplet
    gnumake
    go
    guitarix
    htop
    inotify-tools
    iotop
    jack2Full
    jq
    libreoffice
    lm_sensors
    lshw
    lsof
    lz4
    manpages
    meld
    mtr
    nix
    nix-prefetch-git
    pavucontrol
    pcmanfm
    pmutils
    powertop
    psmisc
    docker_compose
    qbittorrent
    redshift
    rsync
    sbt
    scrot
    shared_mime_info
    sshuttle
    steam
    sudo
    thunderbird
    tig
    tmux
    trayer
    tree
    unzip
    vimHugeX
    vlc
    volumeicon
    wget
    which
    wrk
    xmobar
    xclip
    xfontsel
    xlsfonts
    xorg.xbacklight
    xorg.xev
    xorg.xkill
    xscreensaver
    zip
    zlib
  ];


  programs = {
    bash.enableCompletion = true;
    zsh.enable = true;
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      inconsolata
      symbola
      ubuntu_font_family
      unifont
      vistafonts
      powerline-fonts
    ];
  };

  services = {
    logind = {
      extraConfig = ''
        HandlePowerKey=ignore
      '';
    };

    fstrim.enable = true;

    blueman.enable = true;

    xserver = {
      enable = true;
      layout = "us,si";
      xkbOptions = "caps:swapescape,grp:switch,eurosign:e,keypad:pointerkeys";
      synaptics = {
        enable = true;
        twoFingerScroll = true;
        horizontalScroll = true;
        additionalOptions = ''
          Option "VertScrollDelta" "-58"
          Option "HorizScrollDelta" "-58"
                            '';
      };
      libinput.enable = false;
      desktopManager = {
        # gnome3.enable = true;
        xfce.enable = true;
      };
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };
      videoDrivers = [ "nvidia" ];
    };

    redshift = {
      enable = true;
      temperature = {
        day = 6400;
        night = 4600;
      };
    };

    cron = {
      enable = true;
      systemCronJobs = [
        "*/5 * * * * root	timesnap.sh /mnt/btrfs-root __root/home timesnaps__home__5_min 300"
        "@reboot nvidia-settings --assign CurrentMetaMode=\"nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }\""
        "@reboot nvidia-settings --assign=\"AllowFlipping=0\""
      ];
    };

    printing.enable = true;

    dbus.enable = true;
    gvfs.enable = true;

    udev.extraRules = ''
      # This rule is needed for basic functionality of the controller in Steam and keyboard/mouse emulation
      SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"

      # This rule is necessary for gamepad emulation; make sure you replace 'pgriffais' with a group that the user that runs Steam belongs to
      KERNEL=="uinput", MODE="0660", GROUP="pgriffais", OPTIONS+="static_node=uinput"

      # Valve HID devices over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0666"

      # Valve HID devices over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0666"

      # DualShock 4 over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"

      # DualShock 4 wireless adapter over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ba0", MODE="0666"

      # DualShock 4 Slim over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0666"

      # DualShock 4 over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0666"

      # DualShock 4 Slim over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*054C:09CC*", MODE="0666"

      # Nintendo Switch Pro Controller over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="2009", MODE="0666"

      # Nintendo Switch Pro Controller over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*057E:2009*", MODE="0666"
    '';
  };

  xdg.portal.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    virtualbox.host.enable = true;
  };

  location = {
    # Ljubljana
    latitude = 46.0;
    longitude = 14.5;
  };


  users.extraUsers.andraz = {
    home = "/home/andraz";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "audio" "docker" "networkmanager" "vboxusers" "wheel" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "20.03";
}
