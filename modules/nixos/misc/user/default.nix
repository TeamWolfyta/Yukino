{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  _config = config.${namespace}.user;
in
{
  options.${namespace}.user = with types; {
    extraGroups = mkOpt (listOf str) [ ] "user.extraGroups";
    password = mkOpt str "password" "user.password"; # DON'T HACK ME!
    username = mkOpt str "kieran" "user.username";
  };

  config = {
    users = {
      mutableUsers = false;
      users.${_config.username} = {
        extraGroups = [ "@wheel" ] ++ _config.extraGroups;
        isNormalUser = true;
        inherit (_config) password;
        shell = pkgs.zsh;
      };
    };
  };
}
