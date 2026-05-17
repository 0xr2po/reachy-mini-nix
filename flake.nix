{
  description = "Reachy Mini Tauri Dev Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShells.${system}.default = pkgs.mkShell {

        nativeBuildInputs = with pkgs; [
          pkg-config
          wrapGAppsHook4

          # Rust
          rustc
          cargo
          rustfmt
          clippy
          cargo-tauri

          # Node
          nodejs_24
          yarn

          # Misc
          git
        ];

        buildInputs = with pkgs; [
          webkitgtk_4_1
          gtk4
          glib
          cairo
          pango
          gdk-pixbuf
          librsvg
          openssl
          at-spi2-atk
          atkmm
          systemd.dev
          xdg-utils
        ];

        shellHook = ''
          export XDG_DATA_DIRS="$XDG_DATA_DIRS:$GSETTINGS_SCHEMAS_PATH"
          export PATH="${pkgs.xdg-utils}/bin:$PATH"

          echo ""
          echo "Reachy Mini Dev Shell loaded"
          echo "Node: $(node --version)"
          echo "Yarn: $(yarn --version)"
          echo "Rust: $(rustc --version)"
          echo ""
        '';
      };
    };
}
