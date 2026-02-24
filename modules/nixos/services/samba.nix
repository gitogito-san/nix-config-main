{ ... }:

{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "Trigkey NAS";
        "map to guest" = "bad user";
      };
      "music" = {
        path = "/var/lib/navidrome/music";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "force user" = "ya";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
