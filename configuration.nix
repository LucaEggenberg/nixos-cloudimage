{ config, pkgs, lib, ... }: {
  proxmox.qemuConf = {
    name = "nixos-template";
    cores = 2;
    memory = 2048;
    bios = "ovmf";
  };

  proxmox.qemuExtraConf = {
    boot = "order=virtio0;net0";
    bootdisk = "virtio0";
  };

  proxmox.partitionTableType = "efi";
  proxmox.cloudInit.enable = true;

  services.qemuGuest.enable = true;
  services.cloud-init.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  boot.initrd.availableKernelModules = [ "virtio_pci" "virtio_scsi" ];
  boot.kernelModules = [ "virtio_pci" "virtio_scsi" ];

  services.openssh.enable = true;
  users.mutableUsers = true;
  users.allowNoPasswordLogin = true;

  system.stateVersion = "25.05";
}