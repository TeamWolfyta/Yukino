{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.programs.thefuck;
in
{
  options.yukino.programs.thefuck = {
    enable = mkBoolOpt false "yukino.programs.thefuck.enable";
  };

  config = mkIf _config.enable {
    programs.thefuck = {
      enable = true;
      enableInstantMode = true;
    };
  };
}
