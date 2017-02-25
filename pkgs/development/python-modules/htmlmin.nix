{ stdenv
, fetchurl
, buildPythonPackage
}:

buildPythonPackage rec {
  name = "htmlmin-${version}";
  version = "0.1.10";

  src = fetchurl {
    url = "https://pypi.python.org/packages/60/de/f42baab5b8cd8834311dfccf90bd7275bd8bab0f82780e244a5b05a165c1/${name}.tar.gz";
    sha256 = "ca5c5dfbb0fa58562e5cbc8dc026047f6cb431d4333504b11853853be448aa63";
  };

  doCheck = false;

  buildInputs = [ ];
  propagatedBuildInputs = [ ];

  meta = with stdenv.lib; {
    homepage = "https://htmlmin.readthedocs.io/en/latest/";
    license = licenses.bsdOriginal;
    description = "A configurable HTML Minifier with safety features.";
  };
}
