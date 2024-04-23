{ config, lib, pkgs, ... }:
with lib;
with lib.yukino;
let _config = config.yukino.config.fonts;
in {
  options.yukino.config.fonts = {
    enable = mkBoolOpt false "yukino.config.fonts.enable";
  };

  config = mkIf _config.enable { fonts.enableDefaultPackages = true; };
}
