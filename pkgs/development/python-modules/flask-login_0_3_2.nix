{ stdenv, buildPythonPackage, fetchurl, pythonAtLeast
, flask, nose, mock, blinker}:

buildPythonPackage rec {
  name = "Flask-Login-${version}";
  version = "0.3.2";

  src = fetchurl {
    url = "https://pypi.python.org/packages/06/e6/61ed90ed8ce6752b745ed13fac3ba407dc9db95dfa2906edc8dd55dde454/Flask-Login-0.3.2.tar.gz";
    sha256 = "e72eff5c35e5a31db1aeca1db5d2501be702674ea88e8f223b5d2b11644beee6";
  };

  buildInputs = [ nose mock ];
  propagatedBuildInputs = [ flask blinker ];

  checkPhase = "nosetests -d";

  doCheck = pythonAtLeast "3.3";

  meta = with stdenv.lib; {
    homepage = "https://github.com/maxcountryman/flask-login";
    description = "User session management for Flask";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ abbradar ];
  };
}
