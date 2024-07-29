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
  _config = config.${namespace}.packages.common;
in
{
  options.${namespace}.packages.common = {
    enable = mkBoolOpt false "packages.common.enable";
  };

  config = mkIf _config.enable {
    environment.systemPackages = with pkgs; [
      wget
      curl
    ];
  };
}
