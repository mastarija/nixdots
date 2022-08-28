let
  crypt = import ( ../sec/crypt.nix );
in

{ pkgs , ... }:

{
  environment.systemPackages = with pkgs;
  [
    git
    git-crypt
    gnupg
    feh
    mpv
    ghc
    htop
    wget
    helix
    neovim
    ffmpeg
    firefox
    nixos-option
    alacritty
    home-manager
    cabal-install
    microsoft-edge
    haskellPackages.Agda
    pinentry
    pinentry-qt
    pinentry-curses

    slack
    insomnia
    sublime4

    (
      writeScriptBin "camera" "mpv --profile=low-latency --untimed /dev/video0"
    )

    (
      writeScriptBin "mirror" "mpv --profile=low-latency --untimed --vf=hflip /dev/video0"
    )

    (
      weechat.override
      {
        configure = { availablePlugins, ... }:
        {
          init =
            ''
              /server add libera irc.libera.chat
              /set irc.server.libera.nicks "mastarija"
              /set irc.server.libera.username "mastarija"
              /set irc.server.libera.autoconnect on
              /set irc.server.libera.sasl_username "mastarija"
              /set irc.server.libera.sasl_password "${crypt.passIRC}"
              /set irc.server.libera.autojoin "#agda,#nixos,#haskell"
              /connect libera
            '';
        };
      }
    )
  ];
}
