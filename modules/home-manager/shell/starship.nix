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
        style = "bold";
      };

      directory = {
        style = "bold";
        truncation_symbol = "…/";
        truncate_to_repo = true;
        read_only = " [RO]";
      };

      character = {
        success_symbol = "❯";
        error_symbol = "❯";
        vimcmd_symbol = "❮";
      };

      git_branch = {
        symbol = " ";
        format = " $symbol$branch ";
      };

      git_status = {
        format = "($all_status$ahead_behind )";
      };

      hostname.disabled = true;
      username.disabled = true;
    };
  };
}
