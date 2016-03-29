{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
    
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [ { 
    device = "/dev/sda2";
    name = "crypted";
  } ];

  fileSystems."/mnt/btrfs-root" = {
    device = "/dev/mapper/crypted";
    fsType = "btrfs";
    options = [ "subvol=/" ];
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
    wget vimHugeX sudo manpages gitAndTools.gitFull tmux binutils nix nix-repl

    haskellPackages.xmobar

    xfontsel
    xlsfonts

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

    dmenu
    gmrun
    feh
    xorg.xbacklight
    xscreensaver
    xclip
    clipit
    redshift
    pavucontrol
    trayer
    file zip unzip which
    python27Packages.docker_compose
  ];

  services.xserver = {
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
