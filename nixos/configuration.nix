{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./common.nix
    ];

  hardware.cpu.intel.updateMicrocode = true;

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
  };
}
