{ ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      format = ''
          $fill
        $character'';
      right_format = "$directory$git_branch$git_status";

      fill = {
        symbol = "─";
        style = "bold #3b4261";
      };

      directory = {
        style = "bold #7aa2f7";
        truncation_symbol = "…/";
        truncate_to_repo = true;
        read_only = " [RO]";
        read_only_style = "bold #f7768e";
      };

      character = {
        success_symbol = "[❯](bold #9ece6a)";
        error_symbol = "[❯](bold #f7768e)";
        vimcmd_symbol = "[❮](bold #7aa2f7)";
      };

      git_branch = {
        symbol = " ";
        format = " [$symbol$branch]($style) ";
        style = "bold #bb9af7";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
        style = "bold #f7768e";
      };

      hostname.disabled = true;
      username.disabled = true;
    };
  };
}
