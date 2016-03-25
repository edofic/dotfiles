# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0eba1f77-81ca-4d42-b60f-0cfc72203e2f";
      fsType = "btrfs";
      options = [ "subvol=__nix" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0AD9-F113";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.maxJobs = 4;
}