{ cabal, primitive, fetchgit }:

cabal.mkDerivation (self: {
  pname = "ghcjs-prim";
  version = "0.1.0.0";
  src = fetchgit {
    url = git://github.com/ryantrinkle/ghcjs-prim.git;
    rev = "1d622ffecace0f56a73b7d32b71865d83fa2d496";
    sha256 = "609feced378a33dd62158b693876528da5293b86c38be7759002e4e09024cbdd";
  };
  buildDepends = [ primitive ];
})
