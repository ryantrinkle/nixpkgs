{ stdenv, fetchFromGitHub, autoconf, automake, pkgconfig, libtool, fuse }:

stdenv.mkDerivation rec {
  version = "3.2p1";
  pname = "libow";

  src = fetchFromGitHub {
    owner = "owfs";
    repo = "owfs";
    rev = "v${version}";
    sha256 = "17jhhvlqzndf7q3xnb8bjf4j0j905c420cbxabwpz8xac3z62vb8";
  };

  nativeBuildInputs = [ autoconf automake pkgconfig ];

  meta = with stdenv.lib; {
    description = "1-Wire File System full library";
    homepage = https://owfs.org/;
    license = licenses.gpl2;
    maintainers = with maintainers; [ disserman ];
    platforms = platforms.unix;
  };

  buildInputs = [ libtool fuse ];

  preConfigure = "./bootstrap";

  configureFlags = [
      "--disable-owtcl"
      "--disable-owphp"
      "--disable-owpython"
      "--disable-zero"
      "--enable-owshell"
      "--enable-owhttpd"
      "--disable-owftpd"
      "--enable-owserver"
      "--disable-owperl"
      "--disable-owtcl"
      "--disable-owtap"
      "--disable-owmon"
      "--disable-owexternal"
      "--enable-owfs"
    ];
}
