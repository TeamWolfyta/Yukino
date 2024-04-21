{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.config.packages;
in
{
  options.yukino.config.packages = {
    enable = mkBoolOpt false "yukino.config.packages.enable";
    enableFiles = mkBoolOpt true "yukino.config.packages.enableFiles";
    enableMonitoring = mkBoolOpt true "yukino.config.packages.enableMonitoring";
    enableNetworking = mkBoolOpt true "yukino.config.packages.enableNetworking";
    enableDataManipulation = mkBoolOpt true "yukino.config.packages.enableDataManipulation";
    enableSystemInformation = mkBoolOpt true "yukino.config.packages.enableSystemInformation";
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
