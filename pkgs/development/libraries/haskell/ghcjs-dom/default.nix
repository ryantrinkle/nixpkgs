{ cabal, fetchgit, ghcjsBase, mtl, text }:

cabal.mkDerivation (self: {
  pname = "ghcjs-dom";
  version = "0.1.1.3";
  src = fetchgit {
    url = git://github.com/ryantrinkle/ghcjs-dom.git;
    rev = "90b52182ab3d2ca5cbed7b2fbb33fa06f280771e";
    sha256 = "949a661516206252b36dc817c07ababb7f50a389661d838f0fee0be15085aff9";
  };
  buildDepends = [ ghcjsBase mtl text ];
  meta = {
    description = "DOM library that supports both GHCJS and WebKitGTK";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
