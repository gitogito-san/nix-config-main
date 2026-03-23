{ ... }:

{
  networking.firewall.allowedTCPPorts = [
    50000
    8083
  ];

  virtualisation.oci-containers.containers = {

    stirling-pdf = {
      image = "stirlingtools/stirling-pdf@sha256:6e01e599115e6269ee49f4421fa7a91c9f7c27186b8480899df3091f75d96d8e";
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
      image = "jvmilazz0/kavita@sha256:1f2acae7466d022f037ea09f7989eb7c487f916b881174c7a6de33dbfa8acb39";
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
