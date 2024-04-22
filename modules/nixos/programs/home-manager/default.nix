{ config, lib, ... }:
with lib;
with lib.yukino;
let _config = config.yukino.programs.home-manager;
in {
  options.yukino.programs.home-manager = with types; {
    extraOptions = mkOpt attrs { } "yukino.programs.home-manager.extraOptions";
  };

  config = {
    snowfallorg.user.${config.yukino.config.user.name}.home.config =
      config.yukino.programs.home-manager.extraOptions;
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
