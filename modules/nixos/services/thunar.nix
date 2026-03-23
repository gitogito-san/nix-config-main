{ pkgs, lib, ... }:
{
  programs.thunar = {
    enable = true;
    plugins = [
      pkgs.thunar-archive-plugin
      pkgs.thunar-volman
    ];
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  environment.systemPackages = [
    pkgs.file-roller
    pkgs.unzip
    pkgs.zip
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
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = lib.mkForce "*";
  };
}
