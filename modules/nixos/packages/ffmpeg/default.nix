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
  _config = config.${namespace}.packages.ffmpeg;
in
{
  options.${namespace}.packages.ffmpeg = {
    enable = mkBoolOpt false "packages.ffmpeg.enable";
  };

  config = mkIf _config.enable { environment.systemPackages = with pkgs; [ ffmpeg ]; };
}
