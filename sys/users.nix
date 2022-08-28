let
  crypt = import ( ../sec/crypt.nix );
in

{ pkgs , ... }:

{
  # To hash passwords use: mkpasswd -m sha-512

  users.mutableUsers = false;

  users.users.root = {
    uid = 0;
    group = "root";
    createHome = true;
    hashedPassword = crypt.passRoot;
  };

  users.users.mastarija = {
    uid = 1000;
    group = "users";
    createHome = true;
    extraGroups = [ "wheel" "audio" ];
    isNormalUser = true;
    hashedPassword = crypt.passMastarija;
  };
}
