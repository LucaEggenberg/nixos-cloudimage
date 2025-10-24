{ config, pkgs, lib, ... }: {
  proxmox.qemuConf = {
    name = "nixos-template";
    cores = 2;
    memory = 2048;
    bios = "seabios";
  };

  proxmox.cloudInit.enable = true;

  services.qemuGuest.enable = true;
  services.qemuGuestAgent.enable = true;

  services.openssh.settings = {
    enable = true;
    PermitRootLogin = "no";
    PasswordAuthentication = false;
  };

  users.mutableUsers = false;
  system.stateVersion = "25.05";
}