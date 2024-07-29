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
  _config = config.${namespace}.packages.rembg;
in
{
  options.${namespace}.packages.rembg = {
    enable = mkBoolOpt false "packages.rembg.enable";
  };

  config = mkIf _config.enable { environment.systemPackages = with pkgs.${namespace}; [ rembg ]; };
}
