{ pkgs, ... }:

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
            --sessions ${pkgs.hyprland}/share/wayland-sessions:${pkgs.niri}/share/wayland-sessions
        '';
        user = "greeter";
      };
    };
  };

  services.displayManager.sessionPackages = [
    pkgs.niri
    pkgs.hyprland
  ];

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
