{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.config.home;
in
{
  options.yukino.config.home = with types; {
    username = mkOpt str (config.snowfallorg.user.name or "kieran") "yukino.config.home.username";
    useremail = mkOpt str "kieran@wolfyta.dev" "yukino.config.home.useremail";
  };

  config = {
    home = {
      username = mkDefault _config.username;
      homeDirectory = mkDefault "/home/${_config.username}";
    };
  };
}
