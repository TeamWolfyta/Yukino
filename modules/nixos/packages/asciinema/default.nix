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
  _config = config.${namespace}.packages.asciinema;
in
{
  options.${namespace}.packages.asciinema = {
    enable = mkBoolOpt false "packages.asciinema.enable";
  };

  config = mkIf _config.enable {
    environment.systemPackages = with pkgs; [
      asciinema
      asciinema-agg
    ];
  };
}
