{ pkgs, ... }:

{
  imports = [
#    ./boot.nix
#    ./networking.nix
#    ./i18n.nix
#    ./user.nix
#    ./system.nix
    ./power-management.nix
  ];
}
