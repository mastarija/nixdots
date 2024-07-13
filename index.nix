# Build system
# sudo nixos-rebuild switch -I nixos-config=index.nix

# Update packages
# sudo nix-channel --update
# sudo nixos-rebuild switch -I nixos-config=index.nix

# Garbage collect
# sudo nix-collect-garbage -d
# sudo nixos-rebuild switch -I nixos-config=index.nix

{ lib , pkgs , config , ... } :

{
  # ESSENTIAL SYSTEM MODULES
  imports =
  [
    ./boxes/think.nix

    ./parts/metal.nix
    ./parts/users.nix
    ./parts/power.nix
    ./parts/sound.nix
    ./parts/fonts.nix

    ./progs.nix
    ./progs/sway.nix
    ./progs/nvim.nix
    ./progs/shll.nix
    ./progs/crit.nix
  ];

  # SYSTEM
  system.stateVersion = "22.11";
  nixpkgs.config.allowUnfree = true;
  hardware.opengl.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_6_8;

  # VIRTUALISATION
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.draganddrop = true;
  # boot.kernelModules = [ "vboxdrv" "vboxnetflt" "vboxnetadp" ];

  # BIOS UPDATE
  services.fwupd.enable = true;

  # BOOT LOADER
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # LOCALISATION
  console.keyMap = "croat";
  time.timeZone = "Europe/Zagreb";
  i18n.defaultLocale = "en_US.UTF-8";

  # NIX PACKAGE MANAGER
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''experimental-features = nix-command flakes'';

  # CROSS DESKTOP GROUP CONFIG (XDG)
  xdg.mime.enable = true;
  xdg.mime.defaultApplications =
  {
    "application/pdf" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
  };
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.config.common.default = [ "*" ];

  environment.sessionVariables.NODE_OPTIONS = "--max-old-space-size=8192";

  # USB MOUNTING
  services.udev.enable = true;
  services.udev.extraRules =
  ''
    # USB AUTO MOUNT
    ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN{program}+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /media"

    # Smartcard Reader Permissions
    # SUBSYSTEM=="usb", ATTR{idVendor}=="058f", ATTR{idProduct}=="9540", GROUP="plugdev", MODE="0660"
  '';

  # SHENNANIGANS
  nixpkgs.config.permittedInsecurePackages =
  [ "openssl-1.1.1w"
    "imagemagick-6.9.12-68"
  ];

  # HOSTS
  networking.extraHosts =
  ''
    127.0.0.1 www.reddit.com
    127.0.0.1 www.youtube.com
  '';
}
