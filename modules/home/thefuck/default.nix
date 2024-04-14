{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.thefuck;
in
{
  options.yukino.thefuck = {
    enable = mkBoolOpt false "yukino.thefuck.enable";
  };

  config = mkIf _config.enable {
    programs = {
      thefuck = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
