{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.user;
in
{
  options.yukino.user = with types; {
    name = mkOpt str "kieran" "yukino.user.name";
  };

  config = {
    programs.zsh = enabled;

    users = {
      mutableUsers = mkForce false;
      users = {
        ${_config.name} = {
          uid = 1000;
          shell = pkgs.zsh;
          isNormalUser = true;
          initialPassword = "1234";
        };
      };
    };
  };
}
