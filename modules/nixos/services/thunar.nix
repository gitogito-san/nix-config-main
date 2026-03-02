{ pkgs, lib, ... }:
{
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  environment.systemPackages = [
    pkgs.sshfs
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
  programs.xfconf.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = lib.mkForce "*";
  };
}
