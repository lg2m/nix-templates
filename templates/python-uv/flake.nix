{
  description = "Python (uv) dev shell with just and pre-commit";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
              python313
              uv
              pre-commit
              just
              git
            ]
            ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [
              coreutils
            ]);

          shellHook = ''
            echo "uv: $(uv self version)"
            echo "pre-commit: $(pre-commit --version)"
            echo "just: $(just --version)"
          '';
        };
      }
    );
}
