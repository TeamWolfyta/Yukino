{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  _config = config.${namespace}.programs.gh;
in
{
  options.${namespace}.programs.gh = {
    enable = mkBoolOpt false "programs.gh.enable";
  };

  config = mkIf _config.enable {
    yukino = {
      programs.zsh.oh-my-zsh.plugins = [ "gh" ];
      home.extraOptions = {
        programs.gh = {
          enable = true;
          gitCredentialHelper = enabled;
        };
      };
    };
  };
}
