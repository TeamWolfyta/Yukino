{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.config.packages.common;
in
{
  options.yukino.config.packages.common = {
    enable = mkBoolOpt false "yukino.config.packages.common.enable";
  };

  config = mkIf _config.enable {
    environment.systemPackages = with pkgs; [
      btop
      clac
      fastfetch
      fd
      file
      htop
      jq
      lsof
      onefetch
      tldr
      tree
      unzip
      wget
      zip
    ];
  };
}
