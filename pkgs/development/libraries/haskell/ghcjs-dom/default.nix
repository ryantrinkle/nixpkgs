{ cabal, fetchgit, ghcjsBase, mtl, text }:

cabal.mkDerivation (self: {
  pname = "ghcjs-dom";
  version = "0.1.1.3";
  src = fetchgit {
    url = git://github.com/xionite/ghcjs-dom.git;
    rev = "2d5a0aa64454f2c084b1a7c53cadb59b274d1386";
    sha256 = "8450b1a0de67cf6bb6c304c244e211331da8f5befdf92c089498c4394c14fcc2";
  };

  buildDepends = [ ghcjsBase mtl text ];
  meta = {
    description = "DOM library that supports both GHCJS and WebKitGTK";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
