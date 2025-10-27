# nixos-cloudimage

## Usage
1. On Nix System
```bash
nix build .#nixos-cloudinit
```

```bash
scp result/vzdump-qemu-nixos-template.vma.zst root@p-prmx-1:/var/lib/vz/dump/
```

2. On proxmox
```bash
qmrestore /var/lib/vz/dump/vzdump-qemu-nixos-template.vma.zst 9001 --storage local-zfs
```

```bash
qm set 9001 --bios ovmf --efidisk0 local-zfs:1,efitype=4m,pre-enrolled-keys=0
```

```bash
qm template 9001
```
