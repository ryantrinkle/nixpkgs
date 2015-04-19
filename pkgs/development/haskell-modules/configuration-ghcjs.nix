{ pkgs, parent }:

with import ./lib.nix { inherit pkgs; };
let stdenv = pkgs.stdenv;
in
self: super: {

  mkDerivation = drv: super.mkDerivation (drv // { doHaddock = false; });

  # This is the list of packages that are built into a booted ghcjs installation
  # It can be generated with the command:
  # nix-shell '<nixpkgs>' -A pkgs.haskellPackages_ghcjs.ghc --command "ghcjs-pkg list | sed -n 's/^    \(.*\)-\([0-9.]*\)$/\1_\2/ p' | sed 's/\./_/g' | sed 's/-\(.\)/\U\1/' | sed 's/^\([^_]*\)\(.*\)$/\1 = null;/'"
  Cabal = null;
  aeson = null;
  array = null;
  async = null;
  attoparsec = null;
  base = null;
  binary = null;
  rts = null;
  bytestring = null;
  case-insensitive = null;
  containers = null;
  deepseq = null;
  directory = null;
  dlist = null;
  extensible-exceptions = null;
  filepath = null;
  ghc-prim = null;
  ghcjs-base = null;
  ghcjs-prim = null;
  hashable = null;
  integer-gmp = null;
  mtl = null;
  old-locale = null;
  old-time = null;
  parallel = null;
  pretty = null;
  primitive = null;
  process = null;
  scientific = null;
  stm = null;
  syb = null;
  template-haskell = null;
  text = null;
  time = null;
  transformers = null;
  unix = null;
  unordered-containers = null;
  vector = null;

  # happy is an executable only, and it will be used in the host, so we want the native binary
  happy = parent.happy;

  pqueue = overrideCabal super.pqueue (drv: {
    patchPhase = ''
      sed -i -e '12s|null|Data.PQueue.Internals.null|' Data/PQueue/Internals.hs
      sed -i -e '64s|null|Data.PQueue.Internals.null|' Data/PQueue/Internals.hs
      sed -i -e '32s|null|Data.PQueue.Internals.null|' Data/PQueue/Min.hs
      sed -i -e '32s|null|Data.PQueue.Max.null|' Data/PQueue/Max.hs
      sed -i -e '42s|null|Data.PQueue.Prio.Internals.null|' Data/PQueue/Prio/Min.hs
      sed -i -e '42s|null|Data.PQueue.Prio.Max.null|' Data/PQueue/Prio/Max.hs
    '';
  });

  reactive-banana = overrideCabal super.reactive-banana (drv: {
    patchPhase = ''
      cat >> src/Reactive/Banana/Switch.hs <<EOF
      instance Functor (AnyMoment Identity) where
        fmap = liftM
        
      instance Applicative (AnyMoment Identity) where
        pure = return
        (<*>) = ap
      EOF
    '';
  });

  transformers-compat = overrideCabal super.transformers-compat (drv: {
    configureFlags = [];
  });

  xml-types = dontHaddock super.xml-types;
  system-filepath = dontHaddock super.system-filepath;
  base16-bytestring = dontHaddock super.base16-bytestring;
  base64-bytestring = dontHaddock super.base64-bytestring;
  exceptions = dontHaddock super.exceptions;
  dependent-map = overrideCabal super.dependent-map (drv: {
    preConfigure = ''
      sed -i 's/^.*trust base.*$//' *.cabal
    '';
  });

  profunctors = overrideCabal super.profunctors (drv: {
    preConfigure = ''
      sed -i 's/^{-# ANN .* #-}//' src/Data/Profunctor/Unsafe.hs
    '';
  });

  "ghcjs-dom" = self.callPackage
    ({ mkDerivation, base, mtl, text, ghcjs-base
     }:
     mkDerivation {
       pname = "ghcjs-dom";
       version = "0.1.1.3";
       sha256 = "0pdxb2s7fflrh8sbqakv0qi13jkn3d0yc32xhg2944yfjg5fvlly";
       buildDepends = [ base mtl text ghcjs-base ];
       description = "DOM library that supports both GHCJS and WebKitGTK";
       license = stdenv.lib.licenses.mit;
       hydraPlatforms = stdenv.lib.platforms.none;
     }) {};

  haskell-src-meta = overrideCabal super.haskell-src-meta (drv: {
    sha256 = null;
    src = pkgs.fetchgit {
      url = git://github.com/bmillwood/haskell-src-meta;
      rev = "1d048974bd3027576e6217a390bd87448cd817b2";
      sha256 = "21cea526f04083b706bd738ccf92618711660818971622b5aa277407dcdec9f5";
    };
    version = "0.6.0.8";
    jailbreak = true;
  });

  "timezone-series" = self.callPackage
    ({ time, mkDerivation
     }:
    mkDerivation {
      pname = "timezone-series";
      version = "0.1.4";
      sha256 = "06p5v0dimhwmra100gwkhkz3ll492i2bvafw0qx2qzcxx4yxff40";
      buildDepends = [ time ];
      homepage = "http://projects.haskell.org/time-ng/";
      description = "Enhanced timezone handling for Data.Time";
      license = self.stdenv.lib.licenses.bsd3;
      platforms = self.ghc.meta.platforms;
      jailbreak = true; # Can't build correct version of time
    }) {};

  "timezone-olson" = self.callPackage
    ({ mkDerivation, base, binary, bytestring, extensible-exceptions
     , time, timezone-series
     }:
     mkDerivation {
       pname = "timezone-olson";
       version = "0.1.6";
       sha256 = "0gg1fq85km5d48966a267q6z0wwl1dz88xq88v0l1jlkwd9jsb0z";
       buildDepends = [
         base binary bytestring extensible-exceptions time timezone-series
       ];
       homepage = "http://projects.haskell.org/time-ng/";
       description = "A pure Haskell parser and renderer for binary Olson timezone files";
       license = self.stdenv.lib.licenses.bsd3;
       jailbreak = true; # Can't build correct version of time
     }) {};
/*
  "time_1_4_2" = self.callPackage
    ({ Cabal, deepseq, QuickCheck, test-framework
    , test-framework-quickcheck2, mkDerivation
     }:
    mkDerivation {
      pname = "time";
      version = "1.4.2";
      sha256 = "1kpsak2wka23c8591ry6i1d7hmd54s7iw5n6hpx48jhcxf1w199h";
      buildDepends = [ deepseq ];
      testDepends = [
        Cabal deepseq QuickCheck testFramework testFrameworkQuickcheck2
      ];
      homepage = "http://semantic.org/TimeLib/";
      description = "A time library";
      license = self.stdenv.lib.licenses.bsd3;
      platforms = self.ghc.meta.platforms;
    }) {};
*/
  "crypto-numbers" = self.callPackage
    ({ mkDerivation, byteable, crypto-random, HUnit, QuickCheck, test-framework
    , test-framework-hunit, test-framework-quickcheck2, vector
    }:
    mkDerivation {
      pname = "crypto-numbers";
      version = "0.2.2";
      sha256 = "1ia39al01hb65h23ql0mr5vwzj8slv98i7a22cix8p0b6an1w3vv";
      buildDepends = [ crypto-random vector ];
      testDepends = [
        byteable crypto-random HUnit QuickCheck test-framework
        test-framework-hunit test-framework-quickcheck2 vector
      ];
      homepage = "http://github.com/vincenthz/hs-crypto-numbers";
      description = "Cryptographic numbers: functions and algorithms";
      license = self.stdenv.lib.licenses.bsd3;
      platforms = self.ghc.meta.platforms;
    }) {};
}
