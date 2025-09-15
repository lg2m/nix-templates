{
  description = "Python (uv) dev shell with ruff/ty/jedi/pylsp/pytest, just, pre-commit";

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
              ruff
              ty
              python313Packages.python-lsp-server
              python313Packages.jedi-language-server
              pytest
              pre-commit
              just
              git
            ]
            ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [
              coreutils
            ]);

          shellHook = ''
            echo "\n[python-uv] Tools available: uv, ruff, ty, pylsp, jedi, pytest, just, pre-commit"
            echo "Run 'just setup' to create .venv via uv and install pre-commit hooks.\n"
          '';
        };
      }
    );
}
