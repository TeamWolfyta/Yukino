{ config, lib, pkgs, ... }:
with lib;
with lib.yukino;
let _config = config.yukino.config.packages.rembg;
in {
  options.yukino.config.packages.rembg = {
    enable = mkBoolOpt false "yukino.config.packages.rembg.enable";
  };

  config = mkIf _config.enable {
#    home.packages = with pkgs.nur.repos.nagy.python3Packages; [ rembg ];
  };
}
