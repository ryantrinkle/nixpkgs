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
, flask-Gravatar
, flask-HTMLmin
, flask-Login
, flask-Mail
, flask-Principal
, flask-Security
, flask-SQLAlchemy
, flask-WTF
, html5lib
, importlib
, itsdangerous
, Jinja2
, linecache2
, MarkupSafe
, passlib
, pbr
, psycopg2
, pycrypto
, pyrsistent
, python-dateutil
, python-mimeparse
, pytz
, simplejson
, six
, speaklater
, SQLAlchemy
, testscenarios
, testtools
, traceback2
, unittest2
, Werkzeug
, WTForms
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
    flask-Gravatar
    flask-HTMLmin
    flask-Login
    flask-Mail
    flask-Principal
    flask-Security
    flask-SQLAlchemy
    flask-WTF
    html5lib
    importlib
    itsdangerous
    Jinja2
    linecache2
    MarkupSafe
    passlib
    pbr
    psycopg2
    pycrypto
    pyrsistent
    python-dateutil
    python-mimeparse
    pytz
    simplejson
    six
    speaklater
    SQLAlchemy
    testscenarios
    testtools
    traceback2
    unittest2
    Werkzeug
    WTForms
    sqlparse
  ];
}
