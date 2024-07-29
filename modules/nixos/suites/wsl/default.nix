{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  _config = config.${namespace}.suites.wsl;
in
{
  options.${namespace}.suites.wsl = {
    enable = mkBoolOpt false "suites.wsl.enable";
  };

  config = mkIf _config.enable {
    environment = {
      sessionVariables."BROWSER" = "wslview";
      systemPackages = with pkgs; [ wslu ];
    };
  };
}
