{ pkgs, ... }:
{
  services.activitywatch = {
    enable = true;
    watchers = pkgs.lib.mkForce {
      awatcher = {
        package = pkgs.awatcher;
        executable = "awatcher";
      };
    };
  };
}
