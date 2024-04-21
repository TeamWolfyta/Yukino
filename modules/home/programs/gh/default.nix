{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.programs.gh;
in
{
  options.yukino.programs.gh = {
    enable = mkBoolOpt false "yukino.programs.gh.enable";
  };

  config = mkIf _config.enable {
    programs.gh = {
      enable = true;
      extensions = with pkgs; [
        gh-poi
        gh-markdown-preview
      ];
      gitCredentialHelper.enable = true;
    };
  };
}
