{ pkgs , ... } :

{
  # STARTUP

  /*
    Enables the greeted. A minimal login daemon / manager.
  */
  services.greetd.enable = true;

  /*
    Starts the sway session automatically on boot without the need for logging
    in.
  */
  services.greetd.settings = rec
  {
    initial_session =
    {
      user = "mastarija";
      command = "dbus-run-session ${pkgs.sway}/bin/sway";
    };
    default_session = initial_session;
  };

  # SWAY

  /*
    A compatibility layer for X applications.
  */
  programs.xwayland.enable = true;

  programs.sway.enable = true;
  programs.sway.extraSessionCommands =
  ''
  '';
  programs.sway.extraPackages = with pkgs;
  [
    wev

    mako
    grim
    sway-contrib.grimshot

    waybar
    swaybg
    kanshi
    bemenu
    wofi

    wl-clipboard
  ];

  # ENVIRONMENT

  /*
    Enables the Ozone Wayland support for Chrome and some Electron apps.
  */
  environment.sessionVariables =
  {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "sway";
    XDG_CURRENT_DESKTOP = "sway";
  };

  /*
    Stores the provided configuration files in appropriate locations.
  */
  environment.etc."sway/config".source = ./sway/config;
  environment.etc."xdg/kanshi".source = ./sway/kanshi/config;
  environment.etc."xdg/waybar/config".source = ./sway/waybar/config.json;
  environment.etc."xdg/waybar/style.css".source = ./sway/waybar/style.css;
}
