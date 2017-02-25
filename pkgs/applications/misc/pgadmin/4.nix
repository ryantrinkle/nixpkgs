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
, flask_security
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
}:

let
  name = "pgadmin4-${version}";
  version = "1.2";

  src = stdenv.mkDerivation {
    name = name + "-" + version + "-src";
    src = fetchurl {
      url = "https://ftp.postgresql.org/pub/pgadmin3/pgadmin4/v${version}/source/${name}.tar.gz";
      sha256 = "01wiscicmy0y75ajidzgy8danhs07kyp1mhb27r84250qjgjbbq7";
    };
    buildCommand = ''
      unpackPhase
      cp -r pgadmin4-1.2/web $out
    '';
  };
in

buildPythonPackage {
  inherit name version src;

  buildInputs = [
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
    flask_security
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
