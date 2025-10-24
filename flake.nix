{
  description = "NixOS cloud-init image for Proxmox";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixos-generators.url = "github:nix-community/nixos-generators";
  };

  outputs = { self, nixpkgs, nixos-generators, ... }: {
    packages.x86_64-linux.nixos-cloudinit = nixos-generators.nixos-generate {
      system = "x86_64-linux";
      format = "qcow2";
      modules = [ ./cloudinit.nix ];
    };
  };
}
