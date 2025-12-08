{ pkgs, ... }:

{
  imports = [
    ./gui.nix
    ./core/default.nix
  ];
}
