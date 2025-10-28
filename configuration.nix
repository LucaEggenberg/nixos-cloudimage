{ config, pkgs, lib, ... }: {
  environment.systemPackages = [ pkgs.cloud-init ];

  # proxmox config
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

  # virtualization & cloudinit
  services.qemuGuest.enable = true;

  services.cloud-init = {
    enable = true;
    network.enable = true;

    config = ''
      datasource_list: [ NoCloud, ConfigDrive ]

      system_info:
        distro: nixos
        network:
          renderers: [ 'networkd' ]
        default_user:
          name: nix

      users:
        - default

      ssh_pwauth: false

      chpasswd:
        expire: false

      cloud_init_modules:
        - migrator
        - seed_random
        - growpart
        - resizefs
      cloud_config_modules:
        - disk_setup
        - mounts
        - ssh
      cloud_final_modules: []
    '';
  };

  # ssh & user
  services.openssh.enable = true;
  users.mutableUsers = true;
  users.allowNoPasswordLogin = true;

  users.users.nix = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "default user";
    
  };

  security.sudo = {
    wheelNeedsPassword = false;
    extraRules = [
      {
        users = [ "nix" ];
        commands = [{
          command = "/run/current-system/sw/bin/switch-to-configuration";
          options = [ "NOPASSWD" ];
        }];
      }
    ];
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" "nix" ];
    require-sigs = false;
  };

  # boot config
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  boot.initrd.availableKernelModules = [
    "sr_mod"
    "cdrom"
    "isofs"
    "virtio_pci"
    "virtio_blk"
    "virtio_scsi"
  ];

  boot.kernelModules = [ "sr_mod" "cdrom" "isofs" ];

  # networking
  systemd.network.enable = true;
  networking.dhcpcd.enable = false;
  networking.useDHCP = false;

  system.stateVersion = "25.05";
}