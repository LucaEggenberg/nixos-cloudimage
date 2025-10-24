{ config, pkgs, lib, ... }: {
  proxmox.qemuConf = {
    name = "nixos-template";
    cores = 2;
    memory = 2048;
    bios = "seabios";
  };

  proxmox.cloudInit.enable = true;
  services.qemuGuest.enable = true;

  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
  };

  users.mutableUsers = true;
  users.allowNoPasswordLogin = true;
  system.stateVersion = "25.05";
}