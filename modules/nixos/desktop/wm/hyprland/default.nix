{ ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # for thunar
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  misc = {
    vfr = true;
    vrr = 1;
  };
}
