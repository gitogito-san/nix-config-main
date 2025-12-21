{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.age ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/home/ya/.ssh/id_agenix"
  ];

  age.secrets = {
    copilotApiKey = {
      file = ../../../secrets/copilot-api-key.age;
      owner = "ya";
      group = "users";
      mode = "400";
    };
    geminiApiKey = {
      file = ../../../secrets/gemini-api-key.age;
      owner = "ya";
      group = "users";
      mode = "400";
    };
  };
}
