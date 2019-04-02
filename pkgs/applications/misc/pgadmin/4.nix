{ stdenv
, buildPythonPackage
, fetchurl

, Babel
, beautifulsoup4
, blinker
, click
, extras
, fixtures
, flask
, flaskbabel
, flask_gravatar
, flask_htmlmin
, flask_login
, flask_mail
, flask_principal
, flask_security_fork
, flask_sqlalchemy
, flask_wtf
, html5lib
#, importlib
, itsdangerous
, jinja2
, linecache2
, markupsafe
, passlib
, pbr
, psycopg2
, pycrypto
, pyrsistent
, dateutil
, python_mimeparse
, pytz
, simplejson
, six
, speaklater
, sqlalchemy
, testscenarios
, testtools
, traceback2
, unittest2
, werkzeug
, wtforms
, sqlparse
, qt56
, which
, ncurses
}:

let
  name = "pgadmin4-${version}";
  version = "1.4";

#  src = stdenv.mkDerivation {
#    name = name + "-" + version + "-src";
    src = fetchurl {
      url = "http://ftp.postgresql.org/pub/pgadmin/pgadmin4/v${version}/source/pgadmin4-${version}.tar.gz";
      sha256 = "03mhcfp91han2kqwg165024hdvbsb0hd73kk332jw6bdm101x786";
    };
#    buildCommand = ''
#      unpackPhase
#      cp -r pgadmin4-*/web $out
#    '';
#  };
in

/*
buildPythonPackage {
  inherit name version src;

  preBuild = ''
    HOME=$PWD
  '';
*/
stdenv.mkDerivation {
  inherit name version src;
  preConfigure = ''
    cd runtime
    qmake
  '';
  buildInputs = [
    qt56.full
    qt56.qtwebengine
    which
    ncurses

    Babel
    beautifulsoup4
    blinker
    click
    extras
    fixtures
    flask
    flaskbabel
    flask_gravatar
    flask_htmlmin
    flask_login
    flask_mail
    flask_principal
    flask_security_fork
    flask_sqlalchemy
    flask_wtf
    html5lib
    # importlib
    itsdangerous
    jinja2
    linecache2
    markupsafe
    passlib
    pbr
    psycopg2
    pycrypto
    pyrsistent
    dateutil
    python_mimeparse
    pytz
    simplejson
    six
    speaklater
    sqlalchemy
    testscenarios
    testtools
    traceback2
    unittest2
    werkzeug
    wtforms
    sqlparse
  ];
}
