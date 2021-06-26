{ stdenv, glibc, flex, bison, cmake
, version, src, meta }:
stdenv.mkDerivation {
  pname = "scyther-cli";
  inherit version;

  inherit src meta;

  nativeBuildInputs = [ cmake flex bison ];
  buildInputs = [ glibc.static ];

  patchPhase = ''
    # Since we're not in a git dir, the normal command this project uses to create this file wouldn't work
    printf "%s\n" "#define TAGVERSION \"${version}\"" > src/version.h
  '';

  configurePhase = ''
    (cd src && cmakeConfigurePhase)
  '';

  dontUseCmakeBuildDir = true;
  cmakeFlags = [ "-DCMAKE_C_FLAGS=-std=gnu89" ];

  installPhase = ''
    mkdir -p "$out/bin"
    mv src/scyther-linux "$out/bin/scyther-cli"
    ln -s "$out/bin/scyther-cli" "$out/bin/scyther-linux"
  '';
}
