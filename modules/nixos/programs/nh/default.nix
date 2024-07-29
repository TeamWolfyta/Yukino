{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  _config = config.${namespace}.programs.nh;
  _user = config.${namespace}.user;
in
{
  options.${namespace}.programs.nh = {
    enable = mkBoolOpt false "programs.nh.enable";
  };

  config = mkIf _config.enable {
    programs.nh = {
      enable = true;
      flake = "/home/${_user.username}/projects/teamwolfyta/yukino";
    };
  };
}
