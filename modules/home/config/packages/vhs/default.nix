{ config, lib, pkgs, ... }:
with lib;
with lib.yukino;
let _config = config.yukino.config.packages.vhs;
in {
  options.yukino.config.packages.vhs = {
    enable = mkBoolOpt false "yukino.config.packages.vhs.enable";
  };

  config = mkIf _config.enable { home.packages = with pkgs; [ vhs ttyd ffmpeg ]; };
}
