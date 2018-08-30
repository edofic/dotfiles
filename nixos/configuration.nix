{ config, pkgs, ... }:

let extrapkgs = pkgs.callPackage ./extras/all.nix {};
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelParams = [ "intel_idle.max_cstate=1" ];
  };

  networking = {
    hostName = "amaterasu";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 20001 ];
    };
  };

  hardware = {
    pulseaudio = {
      enable = true;
      # support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth.enable = true;
    cpu.intel.updateMicrocode = true;
  };


  time.timeZone = "Europe/Ljubljana";

  nix.package = pkgs.nixUnstable;

  nixpkgs.config = {
    allowUnfree = true;
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
    jack1
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
    python27Packages.docker_compose
    qbittorrent
    racer
    redshift
    reflex
    rsync
    rustup
    sbt
    scala
    scrot
    shared_mime_info
    sshuttle
    steam
    sudo
    taffybar
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
      desktopManager.gnome3 = {
        enable = true;
      };
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.taffybar
        ];
      };
      windowManager.default = "xmonad";
      config = ''
        Section "Device"
                Identifier "Intel Graphics"
                Driver   "intel"
                Option "TearFree" "true"
        EndSection
      '';
    };

    redshift = {
      enable = true;

      # Ljubljana
      latitude = "46";
      longitude = "14.5";

      temperature = {
        day = 6400;
        night = 4600;
      };
    };

    cron = {
      enable = true;
      systemCronJobs = [
        "*/5 * * * * root	timesnap.sh /mnt/btrfs-root __root/home timesnaps__home__5_min 300"
      ];
    };

    printing.enable = true;

    dbus.enable = true;
    gnome3.gvfs.enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    virtualbox.host.enable = true;
  };


  users.extraUsers.andraz = {
    home = "/home/andraz";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "audio" "docker" "networkmanager" "vboxusers" "wheel" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";
}
