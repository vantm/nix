{ pkgs, outputs, ... }:
{
  boot.isContainer = false;

  users.users.root.password = "root";
  services.getty.autologinUser = "root";

  system.stateVersion = outputs.stateVersion;

  virtualisation.vmVariant = {
    virtualisation.memorySize = 2048;
    virtualisation.cores = 2;
  };

  imports = [ <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix> ];

  virtualisation.qemu.options = [
    "-device virtio-vga"
  ];
}
