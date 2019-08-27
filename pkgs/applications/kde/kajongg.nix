{
  mkDerivation, lib,
  extra-cmake-modules, kdoctools,
  kinit, kguiaddons, kwindowsystem,
  libkmahjongg, python37, python37Packages
}:

mkDerivation {
  name = "kajongg";

  meta = {
    license = with lib.licenses; [ gpl2 fdl12 ];
    maintainers = with lib.maintainers; [ ryantrinkle ];
  };

  nativeBuildInputs = [ extra-cmake-modules kdoctools python37 ];

  propagatedBuildInputs = [ kinit kguiaddons kwindowsystem libkmahjongg python37 python37Packages.twisted ];
}
