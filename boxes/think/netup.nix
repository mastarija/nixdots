{ ... } :

{
  # HOST NAME
  networking.hostName = "NixBox";

  # WIRELESS
  networking.wireless.enable = true;
  networking.wireless.interfaces = [ "wlp2s0" ];

  # NETWORKING
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;
  networking.interfaces.enp1s0f0.useDHCP = true;

  # SAVED WIFI NETWORKS
  networking.wireless.networks =
  {
    D303F9 =
    {
      psk = "q1o0ow7y95";
    };

    ISKONOVAC-70bc9d =
    {
      psk = "ISKON2848504841";
    };

    DumDum =
    {
      psk = "DumDumPassword";
    };
  };
}
