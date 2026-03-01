{ ... }:
{
  services.gvfs.enable = true;
  services.tumbler.enable = true;
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
}
