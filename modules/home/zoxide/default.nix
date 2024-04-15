{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.zoxide;
in
{
  options.yukino.zoxide = with types; {
    enable = mkBoolOpt false "yukino.zoxide.enable";
  };

  config = mkIf _config.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
