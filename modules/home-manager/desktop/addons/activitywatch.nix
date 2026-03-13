{ pkgs, ... }:
{
  services.activitywatch = {
    enable = true;
    watchers = {
      aw-watcher-window = {
        package = pkgs.aw-watcher-window-wayland;
      };
    };
  };
}
