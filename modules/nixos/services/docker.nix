{ pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  users.users.ya.extraGroups = [ "docker" ];
}
