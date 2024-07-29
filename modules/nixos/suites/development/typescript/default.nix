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
  _config = config.${namespace}.suites.development.typescript;
in
{
  options.${namespace}.suites.development.typescript = {
    enable = mkBoolOpt false "suites.development.typescript.enable";
  };

  config = mkIf _config.enable {
    environment.systemPackages = with pkgs.nodePackages; [
      nodejs
      yarn
      pnpm
    ];

    yukino.home.extraOptions = {
      programs.bun = {
        enable = true;
        settings = {
          telemetry = false;
        };
      };
    };
  };
}
