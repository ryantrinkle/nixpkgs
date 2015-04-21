{ pkgs }:

with import ./lib.nix { inherit pkgs; };

let /* haddockSrc = pkgs.fetchgit {
      url = git://github.com/haskell/haddock.git;
      rev = "89fc5605c865d0e0ce5ed7e396102e678426533b";
      sha256 = "c89aba9760af93ebc8e083921c78ceae1069612bba1b0859f8b974178005f5c0";
    }; */

    fixGtk2hs = subdir: version: pkg: overrideCabal pkg (drv: {
      sha256 = null;
      src = "${pkgs.fetchgit {
        url = git://github.com/gtk2hs/gtk2hs;
        rev = "49a90b1f586c7fafcc0b92258a6edbd9a1998edc";
        sha256 = "0af7859db84d00649a23be800c2f2bc378baa22a3c56b141d27420ccc3c3ec62";
      }}/${subdir}";
      inherit version;
    });
    forceGhcPkg = pkg: overrideCabal pkg (drv: {
      configureFlags = (drv.configureFlags or []) ++ [ "--ghc-pkg-option=--force" ];
    });

in

self: super: {

  # Suitable LLVM version.
  llvmPackages = pkgs.llvmPackages_35;

  # Disable GHC 7.10.x core libraries.
  array = null;
  base = null;
  binary = null;
  bin-package-db = null;
  bytestring = null;
  Cabal = null;
  containers = null;
  deepseq = null;
  directory = null;
  filepath = null;
  ghc-prim = null;
  haskeline = null;
  hoopl = null;
  hpc = null;
  integer-gmp = null;
  pretty = null;
  process = null;
  rts = null;
  template-haskell = null;
  terminfo = null;
  time = null;
  transformers = null;
  unix = null;
  xhtml = null;

  # should be fixed in versions > 0.6
  pandoc-citeproc = overrideCabal super.pandoc-citeproc (drv: {
    patches = [
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc-citeproc/commit/4e4f9c2.patch";
         sha256 = "18b08k56g5q4zz6jxczkrddblyn52vmd0811n1icfdpzqhgykn4p";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc-citeproc/commit/34cc147.patch";
         sha256 = "09vrdvg5w14qckn154zlxvk6i2ikmmhpsl9mxycxkql3rl4dqam3";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc-citeproc/commit/8242c70.patch";
         sha256 = "1lqpwxzz2www81w4mym75z36bsavqfj67hyvzn20ffvxq42yw7ry";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc-citeproc/commit/e59f88d.patch";
         sha256 = "05699hj3qa2vrfdnikj7rzmc2ajrkd7p8yd4cjlhmqq9asq90xzb";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc-citeproc/commit/ae6ca86.patch";
         sha256 = "19cag39k5s7iqagpvss9c2ny5g0lwnrawaqcc0labihc1a181k8l";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc-citeproc/commit/f5a9fc7.patch";
         sha256 = "08lsinh3mkjpz3cqj5i1vcnzkyl07jp38qcjcwcw7m2b7gsjbpvm";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc-citeproc/commit/780a554.patch";
         sha256 = "1kfn0mcp3vp32c9w8gyz0p0jv0xn90as9mxm8a2lmjng52jlzvy4";
      })
   ];
  });

  # should be fixed in versions > 1.13.2
  pandoc = overrideCabal super.pandoc (drv: {
    patches = [
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/693f9ab.patch";
         sha256 = "1niyrigs47ia1bhk6yrnzf0sq7hz5b7xisc8ph42wkp5sl8x9h1y";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/9c68017.patch";
         sha256 = "0zccb6l5vmfyq7p8ii88fgggfhrff32hj43f5pp3w88l479f1qlh";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/dbe1b38.patch";
         sha256 = "0d80692liyjx2y56w07k23adjcxb57w6vzcylmc4cfswzy8agrgy";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/5ea3856.patch";
         sha256 = "1z15lc0ix9fv278v1xmfw3a6gl85ydahgs8kz61sfvh4jdiacabw";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/c80c9ac.patch";
         sha256 = "0fk3j53zx0x88jmh0ism0aghs2w5qf87zcp9cwbfcgg5izh3b344";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/8b9bded.patch";
         sha256 = "0f1dh1jmhq55mlv4dawvx3ck330y82qmys06bfkqcpl0jsyd9x1a";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/e4c7894.patch";
         sha256 = "1rfdaq6swrl3m9bmbf6yhqq57kv3l3f4927xya3zq29dpvkmmi4z";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/2a6f68f.patch";
         sha256 = "0sbh2x9jqvis9ln8r2dr6ihkjdn480mjskm4ny91870vg852228c";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/4e3281c.patch";
         sha256 = "0zafhxxijli2mf1h0j7shp7kd7fxqbvlswm1m8ikax3aknvjxymi";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/cd5b1fe.patch";
         sha256 = "0nxq7c0gpdiycgdrcj3llbfwxdni6k7hqqniwsbn2ha3h03i8hg1";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/ed7606d.patch";
         sha256 = "0gchm46ziyj7vw6ibn3kk49cjzsc78z2lm8k7892g79q2livlc1f";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/b748833.patch";
         sha256 = "03gj4qn9c5zyqrxyrw4xh21xlvbx9rbvw6gh8msgf5xk53ibs68b";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/10d5398.patch";
         sha256 = "1nhp5b07vywk917bfap6pzahhqnwvvlbbfg5336a2nvb0c8iq6ih";
      })
      (pkgs.fetchpatch {
         url = "https://github.com/jgm/pandoc/commit/f18ceb1.patch";
         sha256 = "1vxsy5fn4nscvim9wcx1n78q7yh05x0z8p812csi3v3z79lbabhq";
      })
    ];
    # jailbreak-cabal omits part of the file
    # https://github.com/peti/jailbreak-cabal/issues/9
    postPatch = ''
      sed -i '420i\ \ \ \ \ \ \ \ \ \ \ \ buildable: False' pandoc.cabal
    '';
  });

  # see: https://github.com/jaspervdj/hakyll/issues/343
  hakyll = overrideCabal super.hakyll (drv: {
    buildDepends = drv.buildDepends ++ [ self.time-locale-compat ];
    patches = [
      (pkgs.fetchpatch {
         url = "https://github.com/jaspervdj/hakyll/pull/344.patch";
         sha256 = "130c0icw3cj209p219siaq0n8avmm0fpmph0iyjgx67w62sffrli";
      })
    ];
  });

  # Cabal_1_22_1_1 requires filepath >=1 && <1.4
  cabal-install = dontCheck (super.cabal-install.override { Cabal = null; });

  HStringTemplate = self.HStringTemplate_0_8_3;

  # We have Cabal 1.22.x.
  jailbreak-cabal = super.jailbreak-cabal.override { Cabal = null; };

  # GHC 7.10.x's Haddock binary cannot generate hoogle files.
  # https://ghc.haskell.org/trac/ghc/ticket/9921
  mkDerivation = drv: super.mkDerivation (drv // { doHoogle = false; });

  # haddock: No input file(s).
  nats = dontHaddock super.nats;
  bytestring-builder = dontHaddock super.bytestring-builder;

  # These used to be core packages in GHC 7.8.x.
  old-locale = self.old-locale_1_0_0_7;
  old-time = self.old-time_1_1_0_3;

  # We have transformers 4.x
  mtl = self.mtl_2_2_1;
  transformers-compat = disableCabalFlag super.transformers-compat "three";

  # We have time 1.5
  aeson = disableCabalFlag super.aeson "old-locale";

  # requires filepath >=1.1 && <1.4
  Glob = doJailbreak super.Glob;

  # Setup: At least the following dependencies are missing: base <4.8
  hspec-expectations = overrideCabal super.hspec-expectations (drv: {
    patchPhase = "sed -i -e 's|base < 4.8|base|' hspec-expectations.cabal";
  });
  utf8-string = overrideCabal super.utf8-string (drv: {
    patchPhase = "sed -i -e 's|base >= 3 && < 4.8|base|' utf8-string.cabal";
  });
  esqueleto = doJailbreak super.esqueleto;
  pointfree = doJailbreak super.pointfree;

  # bos/attoparsec#92
  attoparsec = dontCheck super.attoparsec;

  # Test suite fails with some (seemingly harmless) error.
  # https://code.google.com/p/scrapyourboilerplate/issues/detail?id=24
  syb = dontCheck super.syb;

  # Test suite has stricter version bounds
  retry = dontCheck super.retry;

  # Test suite fails with time >= 1.5
  http-date = dontCheck super.http-date;

  # Version 1.19.5 fails its test suite.
  happy = dontCheck super.happy;

  # Test suite fails in "/tokens_bytestring_unicode.g.bin".
  alex = dontCheck super.alex;

  # encoding fails to build on GHC 7.10 because of the Applicative-Monad Proposal
  encoding = overrideCabal super.encoding (drv: {
    sha256 = null;
    src = pkgs.fetchdarcs {
      url = http://static.ryantrinkle.com/encoding;
      rev = "0.7.0.3";
      sha256 = "1ssg9galkpbig05q5vqhqzljk29dg9z9hs02aqjs2ljqqxx1xnjf";
    };
    version = "0.7.0.3";
  });

  bzlib = overrideCabal super.bzlib (drv: {
    sha256 = null;
    src = pkgs.fetchdarcs {
      url = http://static.ryantrinkle.com/bzlib;
      rev = "0.5.0.5";
      sha256 = "1s5igawbak3971zx9hh7msw08wsk97zs3a7b31ryjfrbrb0959wh";
    };
    editedCabalFile = null;
    version = "0.5.0.5";
  });

/*
  haddock-library = overrideCabal super.haddock-library (drv: {
    sha256 = null;
    src = "${haddockSrc}/haddock-library";
    version = "1.2.0";
    doCheck = false;
    jailbreak = true;
  });

  haddock-api = overrideCabal super.haddock-api (drv: {
    sha256 = null;
    src = "${haddockSrc}/haddock-api";
    version = "2.16.0";
    doCheck = false;
    jailbreak = true;
  });

  haddock = overrideCabal super.haddock (drv: {
    sha256 = null;
    src = haddockSrc;
    version = "2.16.0";
    doCheck = false;
    jailbreak = true;
  });
*/

  stringsearch = overrideCabal super.stringsearch (drv: {
    sha256 = null;
    src = pkgs.fetchhg {
      url = https://bitbucket.org/ryantrinkle/stringsearch;
      rev = "9709b7d1b244";
      sha256 = "12xcmyh4rzi7wnfflq8br3xl37aphdb61q7wj1cpzvi1zyngff64";
    };
    version = "0.3.6.6";
  });

  # intervals fails to build on GHC 7.10 due to 'null' being added to Foldable
  intervals = overrideCabal super.intervals (drv: {
    sha256 = null;
    src = pkgs.fetchgit {
      url = git://github.com/pacak/intervals;
      rev = "9f0eb8d0278745e0a46580d379dab57de8c9d7a0";
      sha256 = "3da3c33ef57afc488f03c8b8a52925c8c6bf4cf8aac854da48dd565c7b61384d";
    };
    version = "0.7.0.2";
  });

  ghcjs-prim = self.callPackage ({ mkDerivation, fetchgit, primitive }: mkDerivation {
    pname = "ghcjs-prim";
    version = "0.1.0.0";
    src = fetchgit {
      url = git://github.com/ryantrinkle/ghcjs-prim.git;
      rev = "1d622ffecace0f56a73b7d32b71865d83fa2d496";
      sha256 = "609feced378a33dd62158b693876528da5293b86c38be7759002e4e09024cbdd";
    };
    buildDepends = [ primitive ];
    license = pkgs.stdenv.lib.licenses.bsd3;
  }) {};

  base64-bytestring = dontCheck super.base64-bytestring; # Hangs
  vector-algorithms = dontCheck super.vector-algorithms; # Hangs
  snap = overrideCabal super.snap (drv: {
    jailbreak = true;
    preConfigure = ''
      sed -i 's/template-haskell.*,/template-haskell -any,/' snap.cabal
    '';
  });
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

  # TODO: should eventually update the versions in hackage-packages.nix
  haddock-library = overrideCabal super.haddock-library (drv: {
    version = "1.2.0";
    sha256 = "0kf8qihkxv86phaznb3liq6qhjs53g3iq0zkvz5wkvliqas4ha56";
  });
  haddock-api = overrideCabal super.haddock-api (drv: {
    version = "2.16.0";
    sha256 = "0hk42w6fbr6xp8xcpjv00bhi9r75iig5kp34vxbxdd7k5fqxr1hj";
  });
  haddock = overrideCabal super.haddock (drv: {
    version = "2.16.0";
    sha256 = "1afb96w1vv3gmvha2f1h3p8zywpdk8dfk6bgnsa307ydzsmsc3qa";
  });

  # Upstream was notified about the over-specified constraint on 'base'
  # but refused to do anything about it because he "doesn't want to
  # support a moving target". Go figure.
  barecheck = doJailbreak super.barecheck;

  # Tests fail on Mac OS 10.9.4
  system-fileio = dontCheck super.system-fileio;

  # Fails on Mac OS 10.9.4
  comonad = dontCheck (super.comonad.override {
    doctest = null;
  });
  lens = dontCheck (super.lens.override {
    doctest = null;
  });
  distributive = dontCheck (super.distributive.override {
    doctest = null;
  });

  dependent-map = overrideCabal super.dependent-map (drv: {
    preConfigure = ''
      sed -i 's/^.*trust base.*$//' *.cabal
    '';
  });

  # Tests fail on Mac OS 10.10
  QuickCheck = dontCheck super.QuickCheck;
  async = dontCheck super.async;
  dlist = dontCheck super.dlist;
  free = dontCheck super.free;
  vector = dontCheck super.vector;

  # Tests fail due to new time library
  twitter-types = dontCheck super.twitter-types;

  # Tests take way too long
  RSA = dontCheck super.RSA;

  syb-with-class = appendPatch super.syb-with-class (pkgs.fetchpatch {
    url = "https://github.com/seereason/syb-with-class/compare/adc86a9...719e567.patch";
    sha256 = "1lwwvxyhxcmppdapbgpfhwi7xc2z78qir03xjrpzab79p2qyq7br";
  });

  wl-pprint = overrideCabal super.wl-pprint (drv: {
    postPatch = "sed -i '113iimport Prelude hiding ((<$>))' Text/PrettyPrint/Leijen.hs";
    jailbreak = true;
  });

  # https://github.com/kazu-yamamoto/unix-time/issues/30
  unix-time = dontCheck super.unix-time;

  # Until the changes have been pushed to Hackage
  mono-traversable = appendPatch super.mono-traversable (pkgs.fetchpatch {
    url = "https://github.com/snoyberg/mono-traversable/pull/68.patch";
    sha256 = "11hqf6hi3sc34wl0fn4rpigdf7wfklcjv6jwp8c3129yphg8687h";
  });
  conduit-combinators = appendPatch super.conduit-combinators (pkgs.fetchpatch {
    url = "https://github.com/fpco/conduit-combinators/pull/16.patch";
    sha256 = "0jpwpi3shdn5rms3lcr4srajbhhfp5dbwy7pl23c9kmlil3d9mk3";
  });
  annotated-wl-pprint = appendPatch super.annotated-wl-pprint (pkgs.fetchpatch {
    url = "https://patch-diff.githubusercontent.com/raw/david-christiansen/annotated-wl-pprint/pull/2.patch";
    sha256 = "0n0fbq3vd7b9kfmhg089q0dy40vawq4q88il3zc9ybivhi62nwv4";
  });
  ghc-events = appendPatch super.ghc-events (pkgs.fetchpatch {
    url = "https://patch-diff.githubusercontent.com/raw/haskell/ghc-events/pull/8.patch";
    sha256 = "1k881jrvzfvs761jgfhf5nsbmbc33c9333l4s0f5088p46ff2n1l";
  });
}
