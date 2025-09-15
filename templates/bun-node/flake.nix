{
  description = "Bun + Node with Biome, just, and pre-commit";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages =
            with pkgs;
            [
              bun
              nodejs_24
              biome
              just
              git
              pre-commit
            ]
            ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [ coreutils ]);

          shellHook = ''
            echo "bun: $(bun --version)"
            echo "node: $(node --version)"
            echo "biome: $(biome --version)"
            echo "just: $(just --version)"
            echo "pre-commit: $(pre-commit --version)"
          '';
        };
      }
    );
}
