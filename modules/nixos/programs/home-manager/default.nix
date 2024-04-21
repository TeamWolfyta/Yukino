{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.programs.home-manager;
in
{
  options.yukino.programs.home-manager = { };

  config = {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
