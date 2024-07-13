{ pkgs , ... } :

# let
#   eid = import ./eid.nix { inherit pkgs; };
# in
{
  # GLOBALLY INSTALLED PACKAGES
  programs.light.enable = true;
  environment.systemPackages = with pkgs;
  [
    # Utilities
    git
    wget
    curl

    zip
    unzip
    unrar

    imv
    mpv

    htop
    light
    pamixer
    killall

    transmission
    transmission-gtk

    xdg-utils

    linux-firmware

    # Streaming
    obs-studio

    # pcscd
    # eid
    pcsc-tools

    # Terminals
    alacritty

    # Text editors
    neovim
    sublime4

    # Web browsers
    chromium
    firefox-bin

    # File browsers
    gnome.nautilus

    # Communication
    slack
    discord

    # Developer tools
    godot_4
    dhall
    docker
    insomnia

    # Graphics software
    gimp
    freecad
    blender
    inkscape
    librecad

    # Office
    libreoffice
    thunderbird

    # Nix
    nix-prefetch-git

    # Agda
    agda
    agda-pkg

    # Haskell
    ghc
    ghcid
    cabal2nix
    cabal-install

    # Virtualisation
    qemu
    quickemu
    # virtualbox
    # virtualboxHostModules
  ];
}
