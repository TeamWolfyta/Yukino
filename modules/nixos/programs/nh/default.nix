{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.programs.nh;
  user = config.yukino.config.user;
in
{
  options.yukino.programs.nh = {
    enable = mkBoolOpt false "yukino.programs.zsh.enable";
  };

  config = mkIf _config.enable {
    programs.nh = {
      enable = true;
      flake = "$HOME/projects/teamwolfyta/yukino";
    };
  };
}
