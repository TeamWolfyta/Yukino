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
    email = mkOpt str "kieran@wolfyta.dev" "yukino.user.email";
  };

  config = {
    programs.zsh = enabled;

    users = {
      mutableUsers = mkForce false;
      users = {
        ${_config.name} = {
          uid = 1000;
          shell = pkgs.zsh;
          extraGroups = [ "wheel" ];
          isNormalUser = true;
          initialPassword = "1234";
        };
      };
    };
  };
}
