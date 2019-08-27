{ mkDerivation, lib, extra-cmake-modules, qtbase,
akonadi-search, kbookmarks, kcalutils, kcmutils, kcompletion, kconfig,
kconfigwidgets, kcoreaddons, kdelibs4support, kdepim-apps-libs, kguiaddons, ki18n,
kiconthemes, kinit, kio, kldap, kmail-account-wizard, kmailtransport, libkdepim,
knotifications, knotifyconfig, kontactinterface, kparts, kpty, kservice,
ktextwidgets, ktnef, kwidgetsaddons, kwindowsystem, kxmlgui, libgravatar,
libksieve, mailcommon, messagelib, pim-sieve-editor, qtscript, qtwebengine
}:

mkDerivation {
  name = "libkmahjongg";
  meta = {
    license = with lib.licenses; [ gpl2 lgpl21 bsd3 ];
    maintainers = [ lib.maintainers.ryantrinkle ];
  };
  nativeBuildInputs = [ extra-cmake-modules ];
  buildInputs = [
    qtbase
    akonadi-search kbookmarks kcalutils kcmutils kcompletion kconfig
    kconfigwidgets kcoreaddons kdelibs4support kdepim-apps-libs kguiaddons ki18n
    kiconthemes kinit kio kldap kmail-account-wizard kmailtransport libkdepim
    knotifications knotifyconfig kontactinterface kparts kpty kservice
    ktextwidgets ktnef kwidgetsaddons kwindowsystem kxmlgui libgravatar
    libksieve mailcommon messagelib pim-sieve-editor qtscript qtwebengine
  ];
  propagatedBuildInputs = [ ];
  outputs = [ "out" "dev" ];
}
