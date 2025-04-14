# flake.nix
{
  description = "Nix flake for GTK and related dependencies";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShell = pkgs.mkShell {
        buildInputs = [
          pkgs.pkg-config
          pkgs.gtk3
          pkgs.gdk-pixbuf
          pkgs.pango
          pkgs.cairo
          pkgs.glib
          pkgs.openssl
          pkgs.webkitgtk_4_1
          pkgs.webkitgtk
          pkgs.xdotool
        ];

        shellHook = ''
          export PKG_CONFIG_PATH=${
            pkgs.gtk3.dev}/lib/pkgconfig:${
            pkgs.gdk-pixbuf.dev}/lib/pkgconfig:${
            pkgs.pango.dev}/lib/pkgconfig:${
            pkgs.cairo.dev}/lib/pkgconfig:${
            pkgs.glib.dev}/lib/pkgconfig:${
            pkgs.openssl.dev}/lib/pkgconfig:${
            pkgs.webkitgtk.dev}/lib/pkgconfig:${
            pkgs.xdotool}/lib/pkgconfig:${
            pkgs.webkitgtk_4_1.dev}/lib/pkgconfig:$PKG_CONFIG_PATH
        '';
      };
    });
}