{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      vo = "gpu";
      hwdec = "auto-safe";

      osc = "no";
      border = "no";
      keep-open = "yes";

      screenshot-format = "png";
      screenshot-template = "%F-%P-shot";
      screenshot-directory = "~/Pictures/Screenshots";
    };

    scripts = [
      pkgs.mpvScripts.mpris
    ];
  };
}
