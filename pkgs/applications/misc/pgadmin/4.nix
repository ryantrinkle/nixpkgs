{ buildPythonPackage
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
#, flask-Security  #!
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

buildPythonPackage rec {
  name = "pgadmin4-${version}";
  version = "1.2";

  src = fetchurl {
    url = "https://ftp.postgresql.org/pub/pgadmin3/pgadmin4/v${version}/source/pgadmin4-${version}.tar.gz";
    sha256 = "01wiscicmy0y75ajidzgy8danhs07kyp1mhb27r84250qjgjbbq7";
  };

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
    # flask-Security  #!
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
