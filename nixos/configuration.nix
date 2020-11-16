{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./common.nix
    ];

    hardware = {
      cpu.intel.updateMicrocode = true;
    };



  services = {
    xserver = {
      synaptics = {
        enable = true;
        twoFingerScroll = true;
        horizontalScroll = true;
        additionalOptions = ''
          Option "VertScrollDelta" "-58"
          Option "HorizScrollDelta" "-58"
        '';
      };
      config = ''
        Section "Device"
                Identifier "Intel Graphics"
                Driver   "intel"
                Option "TearFree" "true"
        EndSection
      '';
    };

    udev.extraRules = ''
      # Allow 'video' group uses to alter brightness
      SUBSYSTEM=="backlight", ACTION=="add", \
        RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness", \
        RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    '';
  };
}
