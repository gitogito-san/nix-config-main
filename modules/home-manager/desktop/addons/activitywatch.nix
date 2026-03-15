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
}
