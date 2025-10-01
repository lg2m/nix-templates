{
  description = "Tauri/GTK dev shell (Rust + GTK/WebKit + Node)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        linuxGtkPackages = with pkgs; [
          at-spi2-atk
          atkmm
          cairo
          gdk-pixbuf
          glib
          gtk3
          harfbuzz
          librsvg
          libsoup_3
          pango
          webkitgtk_4_1
          openssl
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          packages =
            (with pkgs; [
              pkg-config
              global-introspection
              cargo
              nodejs
              cargo-tauri
            ])
            # Only add the GTK/WebKit stack on Linux
            ++ pkgs.lib.optionals pkgs.stdenv.isLinux linuxGtkPackages
            # MacOS
            ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.coreutils ];

          OPENSSL_NO_VENDOR=1;

          shellHook = ''
            echo "cargo: $(cargo --version 2>/dev/null || echo not found)"
            echo "node:  $(node --version  2>/dev/null || echo not found)"
            echo "tauri: $(cargo tauri --version 2>/dev/null || echo not found)"
          '';
        };
      }
    );
}
