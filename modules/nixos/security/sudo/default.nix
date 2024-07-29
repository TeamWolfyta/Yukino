{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  _config = config.${namespace}.security.sudo;
in
{
  options.${namespace}.security.sudo = {
    enable = mkBoolOpt false "security.sudo.enable";
  };

  config = mkIf _config.enable {
    yukino.programs.zsh.oh-my-zsh.plugins = [ "sudo" ];
    security.sudo = {
      enable = true;
      execWheelOnly = true;
    };
  };
}
