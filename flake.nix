{
  description = "Dioxus Desktop App with GTK Dev Env";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    devShells.default = let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in pkgs.mkShell {
      buildInputs = [
        pkgs.pkg-config
        pkgs.gtk3
        pkgs.glib
        pkgs.gdk-pixbuf
        pkgs.cairo
        pkgs.pango
        pkgs.at-spi2-core
        pkgs.openssl
        pkgs.libxkbcommon
      ];

      # Make sure pkg-config finds .pc files
      PKG_CONFIG_PATH = pkgs.lib.makeLibraryPath buildInputs + "/lib/pkgconfig";
    };
  };
}

