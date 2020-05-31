{ config, lib, pkgs, ... }:

let extrapkgs = pkgs.callPackage ./extras/all.nix {};
in

{
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
      package = pkgs.pulseaudioFull;
    };
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
    };
    cpu.intel.updateMicrocode = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  time.timeZone = "Europe/Ljubljana";

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
}
