{ ... }:

{
  services.navidrome = {
    enable = true;
    settings = {
      Address = "0.0.0.0";
      Port = 4533;
      MusicFolder = "/srv/music";
      DefaultLanguage = "jp";
    };
  };

  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 4533 ];
}
