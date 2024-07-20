{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = {
		self,
		nixpkgs,
		flake-utils,
	}: flake-utils.lib.eachDefaultSystem (system: let

		pkgs = import nixpkgs { inherit system; };

		nested-static-libs = import ./default.nix { inherit pkgs; };

	in {
		packages = {
			default = nested-static-libs;
			inherit nested-static-libs;
		};

		devShells.default = pkgs.callPackage nested-static-libs.mkDevShell { };

		checks = {
			package = self.packages.${system}.git-point;
			devShell = self.devShells.${system}.default;
		};
	}); # outputs
}
