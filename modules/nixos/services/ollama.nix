{ pkgs, ... }:
{
  services.ollama = {
    enable = false;
    # package = pkgs.ollama-cpu;
  };
}
