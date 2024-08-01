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
  _config = config.${namespace}.suites.development.python;
in
{
  options.${namespace}.suites.development.python = {
    enable = mkBoolOpt false "suites.development.python.enable";
  };

  config = mkIf _config.enable { environment.systemPackages = with pkgs; [ pixi ]; };
}
