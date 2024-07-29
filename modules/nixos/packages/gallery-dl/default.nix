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
  _config = config.${namespace}.packages.gallery-dl;
in
{
  options.${namespace}.packages.gallery-dl = {
    enable = mkBoolOpt false "packages.gallery-dl.enable";
  };

  config = mkIf _config.enable { environment.systemPackages = with pkgs; [ gallery-dl ]; };
}
