{ config, lib, pkgs, ... }:

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
}
