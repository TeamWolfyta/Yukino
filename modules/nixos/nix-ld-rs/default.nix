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
  _config = config.yukino.nix-ld-rs;
in
{
  options.yukino.nix-ld-rs = { };

  config = {
    programs.nix-ld = {
      enable = true;
      package = inputs.nix-ld-rs.packages."${pkgs.system}".nix-ld-rs;
    };
  };
}
