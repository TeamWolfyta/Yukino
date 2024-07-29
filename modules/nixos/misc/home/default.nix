{
  config,
  inputs,
  lib,
  namespace,
  options,
  ...
}:
with lib;
with lib.${namespace};
let
  _user = config.${namespace}.user;
in
{
  imports = with inputs; [ home-manager.nixosModules.home-manager ];

  options.${namespace}.home = with types; {
    extraOptions = mkOpt attrs { } "home.extraOptions";
  };

  config = {
    yukino.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users.${_user.username} = mkAliasDefinitions options.yukino.home.extraOptions;
    };
  };
}
