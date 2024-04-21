{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.programs.home-manager;
  user = config.yukino.config.user;
in
{
  options.yukino.programs.home-manager = with types; {
    extraOptions = mkOpt attrs { } "yukino.programs.home-manager.extraOptions";
  };

  config = {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users.${user.name} = mkAliasDefinitions _config.extraOptions;
    };
  };
}
