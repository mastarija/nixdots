let
  crypt = import ( ../sec/crypt.nix );
in

{ config , pkgs , ... }:

{ 

  # Initial system version
  system.stateVersion = "21.11";

  # Global setup
  nixpkgs.config.allowUnfree = true;
  hardware.cpu.intel.updateMicrocode = true;

  boot.extraModprobeConfig = "options snd_hda_intel enable=0,1";

  # Necessary imports
  imports =
  [
    ./metal.nix
    ./users.nix
    ./tools.nix
    ./tools/i3wm.nix
    ./tools/nvim.nix
    ./tools/crit.nix
  ];

  # Fonts
  fonts.fonts = with pkgs;
  [
    vistafonts
    cascadia-code
  ];

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Sound system
  sound.enable = true;
  sound.mediaKeys.enable = true;
  sound.mediaKeys.volumeStep = "5%";
  security.rtkit.enable = true;

  # Autorandr
  services.autorandr =
  {
    enable = true;
    defaultTarget = "mobile";
    hooks =
    {
      postswitch =
      {
        change-background = "feh --no-fehbg --bg-fill ~/.background-image";
      };
    };
    profiles = 
    {
      mobile =
      {
        fingerprint =
        {
          eDP-1 = "00ffffffffffff0006af3c2a0000000000170104951f117802bbf5945554902723505400000001010101010101010101010101010101ce1d56e250001e302616360035ad100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343058544e30322e41200a00d2";
        };
        config =
        {
          eDP-1 =
          {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1366x768";
            rate = "60.06";
          };
        };
      };

      docked =
      {
        fingerprint =
        {
          eDP-1 = "00ffffffffffff0006af3c2a0000000000170104951f117802bbf5945554902723505400000001010101010101010101010101010101ce1d56e250001e302616360035ad100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343058544e30322e41200a00d2";
          HDMI-2 = "00ffffffffffff00410c54c1ce240000341e010380301b782ac7b5a756539c27105054bfef00d1c0b30095008180814081c001010101023a801871382d40582c4500dc0c1100001e2a4480a07038274030203500dc0c1100001a000000fc0050484c2032323356370a202020000000fd00324c1e5311000a20202020202001c902031ef14b101f051404130312021101230907078301000065030c0010008c0ad08a20e02d10103e9600dc0c11000018011d007251d01e206e285500dc0c1100001e8c0ad08a20e02d10103e9600dc0c110000188c0ad090204031200c405500dc0c110000180000000000000000000000000000000000000000000000000049";
        };
        config =
        {
          eDP-1 =
          {
            enable = false;
          };
          HDMI-2 =
          {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
            rate = "60.00";
          };
        };
      };
    };
  };

  # Internationalization
  console.keyMap = "croat";
  time.timeZone = "Europe/Zagreb";
  i18n.defaultLocale = "en_US.UTF-8";

  # Networking
  networking.hostName = "NixBox";
  networking.wireless.enable = true;
  networking.wireless.interfaces = [ "wlp1s0" ];

  networking.useDHCP = false;
  networking.interfaces.wlp1s0.useDHCP = true;
  networking.interfaces.enp0s25.useDHCP = true;

  # Shell
  environment.loginShellInit =
  ''
    autorandr -c
  '';

  environment.interactiveShellInit =
  ''
    alias camera='mpv --profile=low-latency --untimed /dev/video0'
  '';

  # To generate `pskRaw` do:
  # wpa_passphrase <ESSID> <PSK>
  networking.wireless.networks = {
    DumDum =
    {
      psk = crypt.passDumDum;
    };

    D303F9 =
    {
      pskRaw = crypt.passD303F9;
    };
  };

  # GPG stuff
  programs.gnupg.agent =
  {
    enable = true;
    pinentryFlavor = "curses";
  };
}
