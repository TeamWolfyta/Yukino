{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.config.packges;
in
{
  options.yukino.config.packges = {
    enable = mkBoolOpt false "yukino.config.packges.enable";
    enableFiles = mkBoolOpt true "yukino.config.packges.enableFiles";
    enableMonitoring = mkBoolOpt true "yukino.config.packges.enableMonitoring";
    enableNetworking = mkBoolOpt true "yukino.config.packges.enableNetworking";
    enableDataManipulation = mkBoolOpt true "yukino.config.packges.enableDataManipulation";
    enableSystemInformation = mkBoolOpt true "yukino.config.packges.enableSystemInformation";
  };

  config = mkIf _config.enable {
    environment.systemPackages =
      with pkgs;
      [ ]
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
      # Networkingdasdadas
      ++ optionals _config.enableNetworking [ wget ]
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
