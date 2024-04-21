{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.programs.common;
in
{
  options.yukino.programs.common = {
    enable = mkBoolOpt false "yukino.programs.common.enable";
    enableFiles = mkBoolOpt true "yukino.programs.common.enableFiles";
    enableMonitoring = mkBoolOpt true "yukino.programs.common.enableMonitoring";
    enableNetworking = mkBoolOpt true "yukino.programs.common.enableNetworking";
    enableDataManipulation = mkBoolOpt true "yukino.programs.common.enableDataManipulation";
    enableSystemInformation = mkBoolOpt true "yukino.programs.common.enableSystemInformation";
  };

  config = mkIf _config.enable {
    environment.systemPackages =
      with pkgs;
      [
        coreutils
        findutils
        util-linux
      ]
      # Files
      ++ optionals _config.enableFiles [
        fd
        file
        lsof
        tree
        unzip
        zip
      ]
      # Monitoring
      ++ optionals _config.enableMonitoring [
        btop
        htop
      ]
      # Networking
      ++ optionals _config.enableNetworking [
        curl
        wget
      ]
      # Data Manipulation
      ++ optionals _config.enableDataManipulation [
        clac
        jq
        tldr
      ]
      # System Information
      ++ optionals _config.enableSystemInformation [
        fastfetch
        neofetch
        onefetch
      ];
  };
}
