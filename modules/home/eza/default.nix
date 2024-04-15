{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.eza;
in
{
  options.yukino.eza = with types; {
    enable = mkBoolOpt false "yukino.eza.enable";
  };

  config = mkIf _config.enable {
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      icons = true;
    };
  };
}
