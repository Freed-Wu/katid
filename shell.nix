{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkShell {
  name = "katid";
  buildInputs = [
    xmake
    pkg-config

    cmake
    ninja
    curl
    gnutar
    gzip
  ];
}
