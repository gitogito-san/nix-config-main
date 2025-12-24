{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        serverAliveInterval = 60;
        serverAliveCountMax = 5;
      };

      ya = {
        hostname = "100.90.113.106";
        user = "ya";
        identityFile = "~/.ssh/id_main_minipc";
      };

      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github_ssh";
      };

      sol = {
        hostname = "sol.cc.uec.ac.jp";
        user = "y2511246";
        identityFile = "~/.ssh/uec_key";
      };

      ced = {
        hostname = "orange17.ced.cei.uec.ac.jp";
        user = "y2511246";
        proxyJump = "sol";
        identityFile = "~/.ssh/uec_key";
      };
    };

  };
}
