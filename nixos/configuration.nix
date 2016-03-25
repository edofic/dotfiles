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

    tmux
    vimHugeX
    gitAndTools.gitFull
    meld
    python27Packages.docker_compose

    vlc
    thunderbird
    firefox
    google-chrome-beta

    gnome3.eog
    gnome3.file-roller
    gnome3.gnome-calculator
    gnome3.gnome-disk-utility
    gnome3.gnome-system-monitor
    gnome3.nautilus
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
    trayer
  ];

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

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  users.extraUsers.andraz = {
    home = "/home/andraz";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "audio" "docker" "networkmanager" "wheel" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";
}
