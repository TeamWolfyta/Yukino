{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.time;
in
{
  options.yukino.time = {
    enable = mkBoolOpt false "yukino.time.enable";
  };

  config = mkIf _config.enable { time.timeZone = "Europe/London"; };
}
