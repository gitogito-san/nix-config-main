{ pkgs, ... }:
let
  sessionDir = pkgs.linkFarm "wayland-sessions" [
    {
      name = "niri.desktop";
      path = "${pkgs.niri}/share/wayland-sessions/niri.desktop";
    }
    {
      name = "hyprland.desktop";
      path = "${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop";
    }
    {
      name = "fish.desktop";
      path = pkgs.writeText "fish.desktop" ''
        [Desktop Entry]
        Name=Shell (Fish)
        Exec=${pkgs.fish}/bin/fish
        Type=Application
      '';
    }
  ];
in

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --remember \
            --remember-session \
            --sessions ${sessionDir}
        '';
        user = "greeter";
      };
    };
  };

  services.displayManager.sessionPackages = [
    pkgs.niri
    pkgs.hyprland
  ];

  services.xserver.displayManager.startx.enable = false;

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

}
