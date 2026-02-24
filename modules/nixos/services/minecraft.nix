{ ... }:

{
  virtualisation.oci-containers.containers."minecraft-server" = {
    image = "itzg/minecraft-server:java17"; # Modパックのバージョンに合わせてJava17を指定
    autoStart = true;
    ports = [
      "25565:25565"
    ];
    environment = {
      EULA = "TRUE";

      TYPE = "CURSEFORGE";
      CF_SERVER_MOD = "/data/SkyFactory5-5.0.8.zip"; # 配置したZIPをここで読み込ませる
      MEMORY = "8G"; # メモリは8GBを確保

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
