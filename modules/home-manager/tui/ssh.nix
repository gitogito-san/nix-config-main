{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:

let
  sshSettings = {
    "*" = {
      controlMaster = "auto";
      controlPath = "~/.ssh/%C";
      controlPersist = "10m";
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
in

{
  home.packages = [
    pkgs.autossh
    pkgs.mosh
  ];
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  }
  // (
    if (osConfig.networking.hostName == "trigkey") then
      { matchBlocks = sshSettings; }
    else
      { settings = sshSettings; }
  );
}
