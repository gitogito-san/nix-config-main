{ ... }:

{
  networking.firewall.allowedTCPPorts = [
    50000
    8083
  ];

  virtualisation.oci-containers.containers = {

    stirling-pdf = {
      image = "stirlingtools/stirling-pdf:latest-fat";
      ports = [ "8083:8080" ];
      volumes = [
        "/srv/stirling-pdf/tessdata:/usr/share/tessdata"
        "/srv/stirling-pdf/configs:/configs"
      ];
      environment = {
        SECURITY_ENABLE_LOGIN = "false";
        DOCKER_ENABLE_SECURITY = "false";
        SYSTEM_DEFAULTLOCALE = "ja-JP";
      };
    };

    kavita = {
      image = "jvmilazz0/kavita:latest";
      ports = [ "50000:5000" ];
      volumes = [
        "/srv/nas/books:/manga"
        "/srv/kavita/config:/kavita/config"
      ];
      environment = {
        TZ = "Asia/Tokyo";
      };
    };

  };
}
