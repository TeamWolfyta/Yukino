{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.python;
in
{
  options.yukino.python = with types; {
    enable = mkBoolOpt false "yukino.python.enable";
  };

  config = mkIf _config.enable {
    home.packages = [ (pkgs.python3.withPackages (ppkgs: with ppkgs; [ "rembg[cli]" ])) ];
  };
}
