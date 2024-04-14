{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.basic;
in
{
  options.yukino.basic = { };

  config = {
    environment.systemPackages = with pkgs; [
      btop
      clac
      coreutils
      curl
      fastfetch
      fd
      file
      findutils
      htop
      jq
      lsof
      micro
      tldr
      tree
      unzip
      util-linux
      wget
      zip
    ];
  };
}
