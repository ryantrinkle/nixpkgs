{ stdenv, fetchurl, fetchpatch, perl, python, ruby, bison, gperf, cmake
, pkgconfig, gettext, gobjectIntrospection, libnotify
, gtk2, gtk3, libwebp, enchant
, libxml2, libsoup, libxslt, harfbuzz, libpthreadstubs
, enableGeoLocation ? false, geoclue2, sqlite
, gst-plugins-base, readline, libedit
}:

assert enableGeoLocation -> geoclue2 != null;

with stdenv.lib;
stdenv.mkDerivation rec {
  name = "webkitgtk-${version}";
  version = "2.10.4";

  meta = {
    description = "Web content rendering engine, GTK+ port";
    homepage = "http://webkitgtk.org/";
    license = licenses.bsd2;
    platforms = platforms.linux;
    hydraPlatforms = [];
    maintainers = with maintainers; [ koral ];
  };

  preConfigure = "patchShebangs Tools";

  src = fetchurl {
    url = "http://webkitgtk.org/releases/${name}.tar.xz";
    sha256 = "0mghsbfnmmf6nsf7cb3ah76s77aigkzf3k6kw96wgh6all6jdy6v";
  };

  patches = [
    ./finding-harfbuzz-icu.patch
    (fetchpatch {
      name = "glibc-isnan.patch";
      url = "http://trac.webkit.org/changeset/194518/trunk/Source/JavaScriptCore"
        + "/runtime/Options.cpp?format=diff&new=194518";
      sha256 = "0pzdv1zmlym751n9d310cx3yp752yzsc49cysbvgnrib4dh68nbm";
    })
  ] ++ optional stdenv.isDarwin ./adding-libintl.patch;

  cmakeFlags = [
    "-DPORT=GTK"
    "-DENABLE_WEBKIT=ON"
    "-DENABLE_X11_TARGET=OFF"
    "-DENABLE_QUARTZ_TARGET=ON"
    "-DENABLE_TOOLS=ON"
    "-DENABLE_MINIBROWSER=ON"
    "-DENABLE_PLUGIN_PROCESS_GTK2=OFF"
    "-DENABLE_VIDEO=OFF"
    "-DENABLE_WEB_AUDIO=OFF"
    "-DENABLE_CREDENTIAL_STORAGE=OFF"
    "-DENABLE_GEOLOCATION=OFF"
    "-DENABLE_OPENGL=OFF"
    "-DENABLE_INTROSPECTION=OFF"
    "-DUSE_LIBNOTIFY=OFF"
    "-DUSE_LIBHYPHEN=OFF"
    "-DCMAKE_SHARED_LINKER_FLAGS=-L/path/to/nonexistent/folder"
  ];

  # XXX: WebKit2 missing include path for gst-plugins-base.
  # Filled: https://bugs.webkit.org/show_bug.cgi?id=148894
  NIX_CFLAGS_COMPILE = "-I${gst-plugins-base}/include/gstreamer-1.0";

  nativeBuildInputs = [
    cmake perl python ruby bison gperf sqlite
    pkgconfig gobjectIntrospection
  ];

  buildInputs = [
    gtk2 libwebp enchant libnotify
    libxml2 libxslt harfbuzz libpthreadstubs
    gst-plugins-base readline libedit gettext
  ] ++ optional enableGeoLocation geoclue2;

  propagatedBuildInputs = [
    libsoup gtk3
  ];

  enableParallelBuilding = true;
}
