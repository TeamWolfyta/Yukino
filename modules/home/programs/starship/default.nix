{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.programs.starship;
in
{
  options.yukino.programs.starship = {
    enable = mkBoolOpt false "yukino.programs.starship.enable";
  };

  config = mkIf _config.enable {
    programs.starship = {
      enable = true;
      settings = {
        hostname.ssh_only = false;
        sudo.disabled = false;
        username.show_always = true;
      };
    };
  };
}
