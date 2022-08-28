{ pkgs , ... }:

{
  # To hash passwords use: mkpasswd -m sha-512

  users.mutableUsers = false;

  users.users.root = {
    uid = 0;
    group = "root";
    createHome = true;
    hashedPassword = "$6$GUhkgZlM1X.QqGKc$YrLRx.GXrjfGJdMxVZFPA4VhnFE0jBVvC5ulB9UxHlnYAkjpTK6YWKX74bTNgagvDMsN3DxjanA7Y5RfvTShW/";
  };

  users.users.mastarija = {
    uid = 1000;
    group = "users";
    createHome = true;
    extraGroups = [ "wheel" "audio" ];
    isNormalUser = true;
    hashedPassword = "$6$GUhkgZlM1X.QqGKc$YrLRx.GXrjfGJdMxVZFPA4VhnFE0jBVvC5ulB9UxHlnYAkjpTK6YWKX74bTNgagvDMsN3DxjanA7Y5RfvTShW/";
  };
}
