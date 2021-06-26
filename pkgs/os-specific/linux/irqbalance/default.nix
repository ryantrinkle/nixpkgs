{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, glib, ncurses, libcap_ng }:

stdenv.mkDerivation rec {
  pname = "irqbalance";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "irqbalance";
    repo = "irqbalance";
    rev = "v${version}";
    sha256 = "1677ap6z4hvwga0vb8hrvpc0qggyarg9mlg11pxywz7mq94vdx19";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config ];
  buildInputs = [ glib ncurses libcap_ng ];

  LDFLAGS = "-lncurses";

  postInstall =
    ''
      # Systemd service
      mkdir -p $out/lib/systemd/system
      grep -vi "EnvironmentFile" misc/irqbalance.service >$out/lib/systemd/system/irqbalance.service
      substituteInPlace $out/lib/systemd/system/irqbalance.service \
        --replace /usr/sbin/irqbalance $out/bin/irqbalance \
        --replace ' $IRQBALANCE_ARGS' ""
    '';

  meta = {
    homepage = "https://github.com/Irqbalance/irqbalance";
    description = "A daemon to help balance the cpu load generated by interrupts across all of a systems cpus";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
  };
}
