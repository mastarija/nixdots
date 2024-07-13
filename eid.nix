{ pkgs }: pkgs.stdenv.mkDerivation rec {
  name = "eidhr";
  src = pkgs.fetchurl
    {
      url = "https://eid.hr/datastore/filestore/10/eidmiddleware_v3.7.4_amd64.deb";
      hash = "sha256-aWAvwtGrFH2HUNkzLW1WqukIy4NemN9Vrb/DMGYGf5Y=";
    };

  nativeBuildInputs = with pkgs; [ dpkg openssl pcre libp11 autoPatchelfHook libsForQt5.full cups pcsclite makeWrapper ];

  unpackPhase = "dpkg-deb -x $src unpack";

  installPhase =
    ''
      cp -r unpack/ $out/
    '';

  postFixup =
    ''
      wrapProgram $out/usr/lib/akd/eidmiddleware/Client \
        --prefix PATH \
        --set EIDCLIENT_PATH $out/usr/lib/akd/eidmiddleware/Client \
        --out $out/bin/eidclient
    '';
}
