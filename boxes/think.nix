{ pkgs , ... } :

{
  imports =
  [ ./think/netup.nix
  ];

  # BOOT OPTIONS
  boot.initrd.kernelModules = [ "amdgpu" ];

  services.pcscd.enable = true;
}
