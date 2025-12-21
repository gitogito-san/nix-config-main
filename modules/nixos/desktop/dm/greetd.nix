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
            --sessions /run/current-system/sw/share/wayland-sessions \
            --cmd niri
        '';
        user = "greeter";
      };
    };
  };

}
