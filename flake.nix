{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url     = "github:nixos/nixpkgs/nixpkgs-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }:
		flake-utils.lib.eachDefaultSystem(system:
			let
				pkgs = nixpkgs.legacyPackages.${system};
				lib = nixpkgs.lib;

				rust-env = with pkgs; [
					cargo
					rustc
					rustfmt
					clippy
					rust-analyzer
					gdb
				];

			in rec {
				packages.default = pkgs.rustPlatform.buildRustPackage {
					pname = "upwards";
					version = "0.0.1";

					src = ./.;
					cargoLock.lockFile = ./Cargo.lock;
				};
				devShells.default = pkgs.mkShell rec {
					nativeBuildInputs = rust-env;
				};
			}
		);
}
