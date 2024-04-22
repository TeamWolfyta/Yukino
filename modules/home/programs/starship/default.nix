{ config, lib, ... }:
with lib;
with lib.yukino;
let _config = config.yukino.programs.starship;
in {
  options.yukino.programs.starship = {
    enable = mkBoolOpt false "yukino.programs.starship.enable";
  };

  config = mkIf _config.enable {
    programs.starship = {
      enable = true;
      settings = {
        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[𝝬](bold red)";
        };
        hostname.ssh_only = false;
        username.disabled = false;
      };
    };
  };
}
