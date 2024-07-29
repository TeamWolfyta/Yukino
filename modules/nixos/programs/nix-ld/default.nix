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
  _config = config.${namespace}.programs.nix-ld;
in
{
  options.${namespace}.programs.nix-ld = with types; {
    enable = mkBoolOpt false "programs.nix-ld.enable";
    libraries =
      mkOpt (listOf package) config.hardware.graphics.extraPackages
        "programs.nix-ld.libraries";
  };

  config = mkIf _config.enable {
    programs.nix-ld = {
      enable = true;
      inherit (_config) libraries;
      package = pkgs.nix-ld-rs;
    };
  };
}
