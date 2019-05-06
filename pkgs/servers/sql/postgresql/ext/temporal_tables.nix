{ stdenv, fetchFromGitHub, cmake, postgresql, openssl }:

stdenv.mkDerivation rec {
  name = "temporal_tables-${version}";
  version = "1.2.0";

  nativeBuildInputs = [ ];
  buildInputs = [ postgresql ];

  src = fetchFromGitHub {
    owner  = "arkhipov";
    repo   = "temporal_tables";
    rev    = "refs/tags/v${version}";
    sha256 = "1bcw4q5xj6f6jki9s35wd8489s6xfbsrlfqmc625y6w3wb2725dv";
  };

  installPhase = ''
    mkdir -p $out/bin   # for buildEnv to setup proper symlinks
    install -D *.so -t $out/lib/
    ls
    install -D ./*.control ./*.sql -t $out/share/extension
  '';

  meta = with stdenv.lib; {
    description = "";
    homepage    = https://pgxn.org/dist/temporal_tables;
    maintainers = with maintainers; [ ryantrinkle ];
    platforms   = postgresql.meta.platforms;
    license     = licenses.bsd3;
  };
}
