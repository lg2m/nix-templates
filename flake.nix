{
  description = "Flake templates for common projects";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: {
    templates = {
      python-uv = {
        path = ./templates/python-uv;
        description = "Python template using uv, just, pre-commit";
      };
    };
  };
}
