{ config , pkgs , ... }:

{
  services.autorandr.enable = true;
  # services.autorandr.defaultTarget = "";
  services.xserver =
  {
    enable = true;
    layout = "hr";

    libinput =
    {
      enable = true;
      touchpad.scrollMethod = "twofinger";
      touchpad.naturalScrolling = false;
      touchpad.horizontalScrolling = true;
      touchpad.accelSpeed = "-0.1";
    };

    # synaptics.enable = true;

    desktopManager =
    {
      xterm.enable = false;
    };

    displayManager =
    {
      defaultSession = "none+i3";
    };

    windowManager.i3 =
    {
      enable = true;
      package = pkgs.i3-gaps;
      configFile = ./i3wm/config;

      extraPackages = with pkgs;
      [
        dmenu
        i3lock
        i3status
        i3blocks
      ];
    };
  };

  environment = 
  {
    pathsToLink =
    [
      "/libexec"
    ];
  };
}
