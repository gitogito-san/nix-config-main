{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [
      pkgs.libva-utils
      pkgs.vulkan-loader
      pkgs.vulkan-tools
    ];
  };

  programs.gamemode.enable = true;

  programs.gamescope.enable = true;

  zramSwap.enable = true;

  environment.systemPackages = [
    pkgs.mangohud
  ];
}
