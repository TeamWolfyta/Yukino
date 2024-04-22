{ config, lib, ... }:
with lib;
with lib.yukino;
let _config = config.yukino.programs.bun;
in {
  options.yukino.programs.bun = {
    enable = mkBoolOpt false "yukino.programs.bun.enable";
  };

  config = mkIf _config.enable {
    programs.bun = {
      enable = true;
      settings = { telemetry = false; };
    };
  };
}
