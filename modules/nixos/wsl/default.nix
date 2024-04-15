{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.wsl;
in
{
  options.yukino.wsl = {
    enable = mkBoolOpt false "yukino.wsl.enable";
  };

  config = mkIf _config.enable {
    environment = {
      noXlibs = mkForce false;

      sessionVariables = {
        BROWSER = "wslview";
      };

      systemPackages = with pkgs; [ wslu ];
    };
  };
}
