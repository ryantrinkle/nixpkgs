{ cabal, primitive, fetchgit }:

cabal.mkDerivation (self: {
  pname = "ghcjs-prim";
  version = "0.1.0.0";
  src = fetchgit {
    url = git://github.com/ryantrinkle/ghcjs-prim.git;
    rev = "6b43cfd0fdb6ddc1af9c479a978668b42c0e5415";
    sha256 = "09edce4c695356ea00495b667285afa0896d0dc0465828671489f49fc5ce5e0d";
  };
  buildDepends = [ primitive ];
})
