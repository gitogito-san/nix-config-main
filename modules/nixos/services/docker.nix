{ pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    # defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.oci-containers.backend = "podman";

  # docker の代替である podman に乗り換え
  # virtualisation.docker.enable = true;
  # virtualisation.oci-containers.backend = "docker";

  # users.users.ya.extraGroups = [ "docker" ];
}
