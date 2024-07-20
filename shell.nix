# Unlocked version. For locked inputs, use the flake.
{
	pkgs ? import <nixpkgs> { },
	nested-static-libs ? pkgs.callPackage ./package.nix { },
}:

pkgs.callPackage nested-static-libs.mkDevShell { }
