{ pkgs, ... }:

{
  home.packages = [ pkgs.imv ];

  xdg.configFile."imv/config".text = ''
    [options]
    background = 1e1e2e
    overlay = true
    upscaling = next-neighbor
  '';
}
