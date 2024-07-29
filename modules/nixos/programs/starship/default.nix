{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  _config = config.${namespace}.programs.starship;
in
{
  options.${namespace}.programs.starship = {
    enable = mkBoolOpt false "programs.starship.enable";
  };

  config = mkIf _config.enable {
    yukino.home.extraOptions = {
      programs.starship = {
        enable = true;
        settings = {
          character = {
            success_symbol = "[❯](bold green)";
            error_symbol = "[𝝬](bold red)";
          };
          hostname.ssh_only = false;
          username.disabled = false;
        };
      };
    };
  };
}
