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
  _config = config.${namespace}.packages.ani-cli;
in
{
  options.${namespace}.packages.ani-cli = {
    enable = mkBoolOpt false "packages.ani-cli.enable";
  };

  config = mkIf _config.enable { environment.systemPackages = with pkgs; [ ani-cli ]; };
}
