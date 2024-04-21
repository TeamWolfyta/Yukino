{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.programs.zoxide;
in
{
  options.yukino.programs.zoxide = {
    enable = mkBoolOpt false "yukino.programs.zoxide.enable";
  };

  config = mkIf _config.enable {
    programs.zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
