{ config, lib, ... }:
with lib;
with lib.yukino;
let _config = config.yukino.programs.eza;
in {
  options.yukino.programs.eza = {
    enable = mkBoolOpt false "yukino.programs.eza.enable";
  };

  config = mkIf _config.enable {
    programs.eza = {
      enable = true;
      icons = true;
    };
  };
}
