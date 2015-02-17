{ stdenv, binutils-raw, cctools }:

stdenv.mkDerivation {
  name = "cctools-binutils-darwin";
  buildCommand = ''
    mkdir -p $out/bin $out/include

    for i in ${binutils-raw}/bin/*; do
      ln -s "$i" "$out/bin/$(basename $i)"
    done

    # We specifically need:
    # - ld: binutils doesn't provide it on darwin
    # - as: as above
    # - ar: the binutils one prodices .a files that the cctools ld doesn't like
    # - ranlib: for compatibility with ar
    # - dsymutil: soon going away once it goes into LLVM (this one is fake anyway)
    # - otool: we use it for some of our name mangling
    # - install_name_tool: we use it to rewrite stuff in our bootstrap tools
    # - strip: the binutils one seems to break mach-o files
    # - lipo: gcc build assumes it exists
    for i in ar ranlib as dsymutil install_name_tool ld strip otool lipo; do
      ln -sf "${cctools}/bin/$i" "$out/bin/$i"
    done

    for i in ${binutils-raw}/include/*.h; do
      ln -s "$i" "$out/include/$(basename $i)"
    done

    for i in ${cctools}/include/*; do
      ln -s "$i" "$out/include/$(basename $i)"
    done

    # FIXME: this will give us incorrect man pages for bits of cctools
    ln -s ${binutils-raw}/share $out/share
    ln -s ${binutils-raw}/lib $out/lib

    ln -s ${cctools}/libexec $out/libexec
  '';
}
