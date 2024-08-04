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
  _config = config.${namespace}.suites.development.csharp;
in
{
  options.${namespace}.suites.development.csharp = {
    enable = mkBoolOpt false "suites.development.csharp.enable";
  };

  config = mkIf _config.enable {
    environment.systemPackages = with pkgs; [
      dotnet-sdk_8
      msbuild
      omnisharp-roslyn
    ];
  };
}
