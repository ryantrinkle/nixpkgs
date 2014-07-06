{ cabal, primitive, fetchgit }:

cabal.mkDerivation (self: rec {
  pname = "ghcjs-prim";
  version = "0.1.0.0";
  src = fetchgit {
    url = git://github.com/ghcjs/ghcjs-prim.git;
    rev = "d76c61208c44e3673539e029ecc59e270170ed13";
    sha256 = "bec4ddd7c309659fcafac9019382195db682238a4e32d08a47d8a0f788edc157";
  };
  isLibrary = true;
  jailbreak = true;
  noHaddock = true;
  buildDepends = [ primitive ];
  meta = {
    homepage = "https://github.com/ghcjs/ghcjs-prim";
    description = "";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.jwiegley ];
  };
})
