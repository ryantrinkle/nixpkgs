{ cabal, glib, gtk, x11 }:

cabal.mkDerivation (self: {
  pname = "gtk-traymanager";
  version = "0.1.4";
  sha256 = "0dprxds49ljn0n94ca423gvh5ks2jmb4qx3lkqwpxqbcp0j8il7p";
  buildDepends = [ glib gtk ];
  pkgconfigDepends = [ gtk x11 ];
  meta = {
    homepage = "http://github.com/travitch/gtk-traymanager";
    description = "A wrapper around the eggtraymanager library for Linux system trays";
    license = self.stdenv.lib.licenses.lgpl21;
    platforms = self.ghc.meta.platforms;
  };
})
