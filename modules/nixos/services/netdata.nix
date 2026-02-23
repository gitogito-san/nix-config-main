{ pkgs, ... }:

{
  services.netdata = {
    enable = true;
    package = pkgs.netdataCloud;

    config = {
      global = {
        "bind to" = "*";
      };
      web = {
        "allow connections from" = "localhost 100.*";
        "allow dashboard from" = "localhost 100.*";
      };
    };
  };

  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 19999 ];
}
