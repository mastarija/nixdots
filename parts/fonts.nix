{ pkgs , ... } :

{
  fonts.packages = with pkgs;
  [
    ibm-plex
    corefonts
    vistafonts
    font-awesome
    monoid
    hasklig
    fira-code
    cascadia-code
    google-fonts
  ];
}
