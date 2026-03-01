{ ... }:

{
  virtualisation.oci-containers.containers."minecraft-server" = {
    image = "itzg/minecraft-server:java17"; # Modパックのバージョンに合わせてJava17を指定
    autoStart = false;
    ports = [
      "25565:25565"
    ];
    environment = {
      EULA = "TRUE";

      TYPE = "FORGE";
      VERSION = "1.20.1";
      GENERIC_PACK = "/data/SkyFactory_5_Server_5.0.8.zip";
      MEMORY = "8G";

      TZ = "Asia/Tokyo";
      CREATE_CONSOLE_IN_PIPE = "true";

      MAX_PLAYERS = "1";
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
