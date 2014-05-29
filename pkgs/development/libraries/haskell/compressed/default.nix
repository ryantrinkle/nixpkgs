{ cabal, comonad, fingertree, hashable, keys, pointed, reducers
, semigroupoids, semigroups, unorderedContainers
}:

cabal.mkDerivation (self: {
  pname = "compressed";
  version = "3.10";
  sha256 = "1y290n421knfh8k8zbcabhw24hb13xj9pkxx4h4v15yji97p5mcw";
  buildDepends = [
    comonad fingertree hashable keys pointed reducers semigroupoids
    semigroups unorderedContainers
  ];
  meta = {
    homepage = "http://github.com/ekmett/compressed/";
    description = "Compressed containers and reducers";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
