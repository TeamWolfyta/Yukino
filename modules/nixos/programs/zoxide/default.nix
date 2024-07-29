{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  _config = config.${namespace}.programs.zoxide;
in
{
  options.${namespace}.programs.zoxide = {
    enable = mkBoolOpt false "programs.zoxide.enable";
  };

  config = mkIf _config.enable {
    yukino.home.extraOptions = {
      programs.zoxide = {
        enable = true;
        options = [ "--cmd cd" ];
      };
    };
  };
}
