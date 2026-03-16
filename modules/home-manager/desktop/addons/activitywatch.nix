{ pkgs, lib, ... }:

{
  services.activitywatch = {
    enable = true;
    watchers = lib.mkForce {
      awatcher = {
        package = pkgs.awatcher;
      };
    };
  };

  systemd.user.services.activitywatch-watcher-awatcher = {
    Unit = {
      After = [ "graphical-session.target" ];
    };
    Service = {
      Restart = "always";
      RestartSec = 3;
    };
  };
}
