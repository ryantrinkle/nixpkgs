{ stdenv, fetchurl, autoconf, automake, libtool
, llvm, libcxx, clang, openssl, libuuid
}:

let
  baseParams = rec {
    name = "cctools-port-${version}";
    version = "855";

    src = let
      # Should be fetchFromGitHub but it was whining so this will do for now
      owner  = "tpoechtrager";
      repo   = "cctools-port";
      rev    = "88fd4d1514b4e23cddb3409f74d09349d6ff2f3c";
    in fetchurl {
      url    = "http://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      sha256 = "0qka91xp7h16g3m20q3iraf5nnps8kq56qs5478j5zdx9ajjl5zq";
    };

    buildInputs = [ autoconf automake libtool openssl libuuid ] ++
      # Only need llvm and clang if the stdenv isn't already clang-based (TODO: just make a stdenv.cc.isClang)
      stdenv.lib.optionals (!stdenv.isDarwin) [ llvm clang ];

    patches = [ ./ld-rpath-nonfinal.patch ./ld-ignore-rpath-link.patch ];

    enableParallelBuilding = true;

    configureFlags = stdenv.lib.optionals (!stdenv.isDarwin) [ "CXXFLAGS=-I${libcxx}/include/c++/v1" ];

    postPatch = ''
      # FIXME: there are far more absolute path references that I don't want to fix right now
      substituteInPlace cctools/configure.ac \
        --replace "-isystem /usr/local/include -isystem /usr/pkg/include" "" \
        --replace "-L/usr/local/lib" "" \

      substituteInPlace cctools/include/Makefile \
        --replace "/bin/" ""

      patchShebangs tools
      sed -i -e 's/which/type -P/' tools/*.sh

      # Workaround for https://www.sourceware.org/bugzilla/show_bug.cgi?id=11157
      cat > cctools/include/unistd.h <<EOF
      #ifdef __block
      #  undef __block
      #  include_next "unistd.h"
      #  define __block __attribute__((__blocks__(byref)))
      #else
      #  include_next "unistd.h"
      #endif
      EOF
    '' + stdenv.lib.optionalString stdenv.isDarwin ''
      substituteInPlace cctools/otool/Makefile.am \
        --replace " -lobjc" ""

      substituteInPlace cctools/otool/print_objc.c \
        --replace "objc_getClass(objc_class.name)" "0" \
        --replace "objc_getMetaClass(objc_class.name)" "0"
    '' + stdenv.lib.optionalString (!stdenv.isDarwin) ''
      sed -i -e 's|clang++|& -I${libcxx}/include/c++/v1|' cctools/autogen.sh
    '';

    preConfigure = ''
      cd cctools
      sh autogen.sh
    '';

    preInstall = ''
      pushd include
      make DSTROOT=$out/include RC_OS=common install
      popd
    '';

    meta = {
      homepage = "http://www.opensource.apple.com/source/cctools/";
      description = "Mac OS X Compiler Tools (cross-platform port)";
      license = stdenv.lib.licenses.apsl20;
    };
  };
in {
  native = stdenv.mkDerivation (baseParams // {
    # A hack for now...
    postInstall = ''
      cat >$out/bin/dsymutil << EOF
      #!${stdenv.shell}
      EOF
      chmod +x $out/bin/dsymutil
    '';
  });

  cross =
    { cross, maloader, makeWrapper, xctoolchain}: stdenv.mkDerivation (baseParams // {
      configureFlags = baseParams.configureFlags ++ [ "--target=${cross.config}" ];

      postInstall = ''
        for tool in dyldinfo dwarfdump dsymutil; do
          ${makeWrapper}/bin/makeWrapper "${maloader}/bin/ld-mac" "$out/bin/${cross.config}-$tool" \
            --add-flags "${xctoolchain}/bin/$tool"
          ln -s "$out/bin/${cross.config}-$tool" "$out/bin/$tool"
        done
      '';
    });
}
