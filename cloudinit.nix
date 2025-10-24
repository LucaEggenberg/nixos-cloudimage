{ config, pkgs, ... }: {
  imports = [ <nixpkgs/nixos/modules/virtualisation/cloud-init.nix> ];

  services.cloud-init.enable = true;
  services.qemuGuest.enable = true;
  services.qemuGuestAgent.enable = true;

  services.openssh = {
    enable = true;
    PasswordAuthentication = false;
    PermitRootLogin = "no";
  };

  networking = {
    useDHCP = true;
    hostName = "nixos-cloudinit-template";
  };
  
  users.mutableUsers = false;
  system.stateVersion = "25.05";
}
