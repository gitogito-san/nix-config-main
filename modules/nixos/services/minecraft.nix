{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers."minecraft-server" = {
    image = "itzg/minecraft-server";
    autoStart = true;
    ports = [
      "25565:25565"
    ];
    environment = {
      EULA = "TRUE";
      VERSION = "1.20.1";
      TYPE = "FABRIC";
      MEMORY = "4G";
      TZ = "Asia/Tokyo";
      CREATE_CONSOLE_IN_PIPE = "true";

      MAX_PLAYERS = "4";
      VIEW_DISTANCE = "10";

      OPS = "ak_chan";

      ENABLE_WHITELIST = "TRUE";
      ENFORCE_WHITELIST = "TRUE";
      WHITELIST = "ak_chan";
    };
    volumes = [
      "/home/ya/docker/minecraft:/data"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedUDPPorts = [ 25565 ];
}
