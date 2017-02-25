{ stdenv
, fetchurl
, buildPythonPackage

, flask
, blinker
}:

buildPythonPackage rec {
  version = "0.9.1";
  name = "Flask-Mail-${version}";

  src = fetchurl {
    url = "https://pypi.python.org/packages/05/2f/6a545452040c2556559779db87148d2a85e78a26f90326647b51dc5e81e9/${name}.tar.gz";
    sha256 = "22e5eb9a940bf407bcf30410ecc3708f3c56cc44b29c34e1726fe85006935f41";
  };

  propagatedBuildInputs = [
    flask
    blinker
  ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/rduplain/flask-mail";
    license = licenses.bsdOriginal;
    description = "Flask extension for sending email";
  };
}
