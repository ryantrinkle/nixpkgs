{ stdenv
, fetchurl
, buildPythonPackage

, flask

# , pytestcache
# , pytestcov
# , pytestpep8
# , pytest
# , coverage
}:

buildPythonPackage rec {
  name = "Flask-Gravatar-${version}";
  version = "0.4.2";

  src = fetchurl {
    url = "https://pypi.python.org/packages/b3/7c/162f5b98b88d2088a1a451ae4a354c725c700246ae69cb8cc26175508e65/Flask-Gravatar-0.4.2.tar.gz";
    sha256 = "1lxci96axpcszv99k6fgizh94d5dva9n2917f3isqi8jl8kx939i";
  };

  buildInputs = [ flask ];

  doCheck = false;
  # doCheck = true;
  # checkInputs = [
  #   pytestcache
  #   pytestcov
  #   pytestpep8
  #   pytest
  #   coverage
  # ];

  propagatedBuildInputs = [  ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/zzzsochi/Flask-Gravatar";
    description = "Small and simple gravatar usage in Flask";
    license = licenses.bsd3;
    platforms = platforms.all;
    maintainers = [];
  };
}
