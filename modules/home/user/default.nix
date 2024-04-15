{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.user;
in
{
  options.yukino.user = with types; {
    name = mkOpt str (config.snowfallorg.user.name or "kieran") "yukino.user.name";
    email = mkOpt str (config.snowfallorg.user.email or "kieran@wolfyta.dev") "yukino.user.email";
  };

  config = {
    home = {
      username = mkDefault _config.name;
      homeDirectory = mkDefault "/home/${_config.name}";
    };
  };
}
