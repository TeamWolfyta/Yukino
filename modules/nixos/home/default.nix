{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.home;
in
{
  options.yukino.home = { };

  config = {
    snowfallorg.user.${config.yukino.user.name}.home.config = {
      xdg.enable = true;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
