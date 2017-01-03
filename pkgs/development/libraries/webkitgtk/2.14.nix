{ stdenv, fetchurl, perl, python2, ruby, bison, gperf, cmake
, pkgconfig, gettext, gobjectIntrospection, libnotify, gnutls
, gtk2, gtk3, wayland, libwebp, enchant, xlibs, libxkbcommon, epoxy, at_spi2_core
, libxml2, libsoup, libsecret, libxslt, harfbuzz, libpthreadstubs
, enableGeoLocation ? !stdenv.isDarwin, geoclue2, sqlite
, gst-plugins-base, readline, libedit, mesa, libintlOrEmpty, darwin
}:

assert enableGeoLocation -> geoclue2 != null;

with stdenv.lib;
stdenv.mkDerivation rec {
  name = "webkitgtk-${version}";
  version = "2.14.1";

  meta = {
    description = "Web content rendering engine, GTK+ port";
    homepage = "http://webkitgtk.org/";
    license = licenses.bsd2;
    platforms = platforms.linux;
    hydraPlatforms = [];
    maintainers = with maintainers; [ ];
  };

  preConfigure = "patchShebangs Tools";

  src = fetchurl {
    url = "http://webkitgtk.org/releases/${name}.tar.xz";
    sha256 = "1dffnz20psgc604azhbzn9a6cdhafar9dw74w3bbwrfy531pcb9f";
  };

  # see if we can clean this up....

  patches = [
    ./finding-harfbuzz-icu.patch
    ./initialize-threading.patch
  ];

  cmakeFlags = [
    "-DPORT=GTK"
    "-DUSE_LIBHYPHEN=0"
  ] ++ (if stdenv.isDarwin then [
    "-DENABLE_GEOLOCATION=OFF"
    "-DENABLE_OPENGL=OFF"
    "-DCMAKE_MACOSX_RPATH=1"
    "-DCMAKE_BUILD_WITH_INSTALL_RPATH=1"
  ] else [
    "-DENABLE_GLES2=ON"
  ]);

  configureFlags = optionals stdenv.isDarwin [
    "--disable-x11-target"
    "--enable-quartz-target"
    "--disable-web-audio"
  ];

  # XXX: WebKit2 missing include path for gst-plugins-base.
  # Filled: https://bugs.webkit.org/show_bug.cgi?id=148894
  NIX_CFLAGS_COMPILE = "-I${gst-plugins-base.dev}/include/gstreamer-1.0";

  NIX_LDFLAGS = if stdenv.isDarwin then "-lintl" else "";

  nativeBuildInputs = [
    cmake perl python2 ruby bison gperf sqlite
    pkgconfig gettext gobjectIntrospection
  ];

  buildInputs = [
    gtk2 libwebp enchant libnotify gnutls
    libxml2 libsecret libxslt harfbuzz libpthreadstubs
    gst-plugins-base libxkbcommon epoxy at_spi2_core
  ] ++ optional enableGeoLocation geoclue2
    ++ (with xlibs; [ libXdmcp libXt libXtst ])
    ++ (if stdenv.isDarwin then [
    readline libedit mesa libintlOrEmpty
  ] else [
    wayland
  ]);

  propagatedBuildInputs = [
    libsoup gtk3
  ];

  enableParallelBuilding = true;
}
