{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.gh;
in
{
  options.yukino.gh = with types; {
    enable = mkBoolOpt false "yukino.gh.enable";
  };

  config = mkIf _config.enable {
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
