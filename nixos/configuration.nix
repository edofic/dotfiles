{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "intel_idle.max_cstate=1" ];
  boot.initrd.luks.devices = [ {
    device = "/dev/sda2";
    name = "crypted";
  } ];

  fileSystems."/mnt/btrfs-root" = {
    device = "/dev/mapper/crypted";
    fsType = "btrfs";
    options = [ "subvol=/" ];
  };

  fileSystems."/tmp" = {
    fsType = "tmpfs";
  };

  networking = {
    hostName = "amaterasu";
    networkmanager.enable = true;
  };

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };


  time.timeZone = "Europe/Ljubljana";

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    nix
    nix-repl

    wget
    curl
    htop
    lsof
    tree
    binutils
    sudo
    manpages
    psmisc
    file
    zip
    unzip
    which
    lshw
    powertop
    iotop

    tmux
    vimHugeX
    gitAndTools.gitFull
    bashCompletion
    meld
    python27Packages.docker_compose

    vlc
    thunderbird
    firefox
    gimp
    libreoffice
    qbittorrent
    google-chrome
    google-chrome-beta

    evince
    pcmanfm
    gnome3.eog
    gnome3.file-roller
    gnome3.gnome-calculator
    gnome3.gnome-disk-utility
    gnome3.gnome-system-monitor
    gnome3.networkmanagerapplet

    haskellPackages.xmobar
    xfontsel
    xlsfonts
    dmenu
    gmrun
    scrot
    feh
    xorg.xbacklight
    xscreensaver
    xclip
    clipit
    redshift
    pavucontrol
    volumeicon
    trayer
    pmutils
    shared_mime_info
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
    ];
  };

  services = {
    xserver = {
      enable = true;
      layout = "us,si";
      xkbOptions = "caps:swapescape,grp:switch,eurosign:e";
      synaptics = {
        enable = true;
        twoFingerScroll = true;
        horizontalScroll = true;
        additionalOptions = ''
          Option "VertScrollDelta" "-58"
                            '';
      };
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
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
  system.stateVersion = "16.09";
}
