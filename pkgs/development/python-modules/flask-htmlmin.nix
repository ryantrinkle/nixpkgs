{ stdenv
, fetchurl
, buildPythonPackage

, flask
, htmlmin
}:

buildPythonPackage rec {
  name = "Flask-HTMLmin-${version}";
  version = "1.2";

    src = fetchurl {
      url = "https://pypi.python.org/packages/dd/2e/9f2d797d2ac59549fb3f493ab4716f2dbe538802d2c172fcc6f39eb079bf/${name}.tar.gz";
      sha256 = "888c04505e8e0406f91d053c5297ef553b4a0eb4065f293ee073aa290ea6dfd8";
    };

  buildInputs = [ flask htmlmin ];

  doCheck = false;

  propagatedBuildInputs = [ flask htmlmin ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/hamidfzm/Flask-HTMLmin";
    description = "Minimize rendered templates html";
    license = licenses.bsdOriginal;
    platforms = platforms.all;
    maintainers = [];
  };
}
