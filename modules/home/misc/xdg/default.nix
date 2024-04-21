{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.misc.xdg;
in
{
  options.yukino.misc.xdg = {
    enable = mkBoolOpt false "yukino.misc.xdg.enable";
  };

  config = mkIf _config.enable { xdg = enabled; };
}
