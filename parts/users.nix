{ ... } :

{
  users.mutableUsers = false;

  users.users.root =
  {
    uid = 0;
    group = "root";
    createHome = true;
    hashedPassword = "$6$4BGJ2RCJEAsDPggF$2sWx0xjbmtFCMFq27y3/xMAH83cQu8x/XXUUVF4A.Rv9H4VbR935CbIvsVg.W9FXMWo4Y4IfBXxgEpZNp7DEc/";
  };

  users.users.mastarija =
  {
    uid = 1000;
    group = "users";
    createHome = true;
    extraGroups = [ "wheel" "audio" "video" ];
    hashedPassword = "$6$4BGJ2RCJEAsDPggF$2sWx0xjbmtFCMFq27y3/xMAH83cQu8x/XXUUVF4A.Rv9H4VbR935CbIvsVg.W9FXMWo4Y4IfBXxgEpZNp7DEc/";
    isNormalUser = true;
  };

  users.extraGroups.vboxusers.members = [ "mastarija" ];
}
