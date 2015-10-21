module Main ( main ) where
import Test.DocTest
main :: IO ()
main = do
  doctest $ ["-isrc", "-optP-include", "-optPdist/build/autogen/cabal_macros.h"] ++ ["src/Cabal2Nix/CorePackages.hs","src/Cabal2Nix/Flags.hs","src/Cabal2Nix/Generate.hs","src/Cabal2Nix/Hackage.hs","src/Cabal2Nix/License.hs","src/Cabal2Nix/Name.hs","src/Cabal2Nix/Normalize.hs","src/Cabal2Nix/Package.hs","src/Cabal2Nix/PostProcess.hs","src/Cabal2Nix/Version.hs","src/Distribution/Nixpkgs/Fetch.hs","src/Distribution/Nixpkgs/Haskell.hs","src/Distribution/Nixpkgs/License.hs","src/Distribution/Nixpkgs/Meta.hs","src/Distribution/Nixpkgs/PackageMap.hs","src/Distribution/Nixpkgs/Util/PrettyPrinting.hs","src/Distribution/Nixpkgs/Util/Regex.hs","src/Language/Nix/Identifier.hs","src/Language/Nix/Path.hs"]
  doctest ["-isrc", "-optP-include", "-optPdist/build/autogen/cabal_macros.h", "src/cabal2nix.hs"]
  doctest ["-isrc", "-optP-include", "-optPdist/build/autogen/cabal_macros.h", "src/hackage2nix.hs"]
