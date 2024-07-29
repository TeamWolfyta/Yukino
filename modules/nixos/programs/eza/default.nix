{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  _config = config.${namespace}.programs.eza;
in
{
  options.${namespace}.programs.eza = {
    enable = mkBoolOpt false "programs.eza.enable";
  };

  config = mkIf _config.enable {
    yukino = {
      programs.zsh.oh-my-zsh.plugins = [ "eza" ];
      home.extraOptions = {
        programs.eza = {
          enable = true;
          git = true;
          icons = true;
        };
      };
    };
  };
}
