{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.programs.nix-ld;
in
{
  options.yukino.programs.nix-ld = {
    enable = mkBoolOpt false "yukino.programs.nix-ld.enable";
  };

  config = mkIf _config.enable {
    programs.nix-ld = {
      enable = true;
      package = inputs.nix-ld-rs.packages."${pkgs.system}".nix-ld-rs;
    };
  };
}
