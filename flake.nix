{
  description = "NixOS cloud-init image for Proxmox";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }: 
  let
    system = "x86_64-linux";
  in {
    packages.${system}.nixos-cloudinit = (nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ 
        "${nixpkgs}/nixos/modules/virtualisation/proxmox-image.nix"
        ./configuration.nix
      ];
    }).config.system.build.VMA;
  };
}
