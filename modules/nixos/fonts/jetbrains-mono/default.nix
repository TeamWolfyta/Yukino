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
  _config = config.${namespace}.fonts.jetbrains-mono;
in
{
  options.${namespace}.fonts.jetbrains-mono = {
    enable = mkBoolOpt false "fonts.jetbrains-mono.enable";
  };

  config = mkIf _config.enable { fonts.packages = with pkgs; [ jetbrains-mono ]; };
}
