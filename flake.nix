{
  description = "NixOS cloud-init image for Proxmox";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, nixos-generators, ... }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.nixos-cloudinit = pkgs.nixos {
      inherit system;
      modules = [ 
        "${nixpkgs}/nixos/modules/virtualisation/proxmox-image.nix"
        ./configuration.nix
      ];
    };
  };
}
