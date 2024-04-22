{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.config.packages.nodejs;
in
{
  options.yukino.config.packages.nodejs = {
    enable = mkBoolOpt false "yukino.config.packages.nodejs.enable";
  };

  config = mkIf _config.enable {
    home.packages = with pkgs.nodePackages; [
      nodejs
      pnpm
      yarn
    ];
  };
}
