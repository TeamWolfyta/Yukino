{
  config,
  inputs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  _config = config.${namespace}.services.vscode-server;
in
{
  options.${namespace}.services.vscode-server = {
    enable = mkBoolOpt false "services.vscode-server.enable";
  };

  config = mkIf _config.enable {
    yukino.home.extraOptions = {
      imports = with inputs; [ vscode-server.homeModules.default ];
      home.sessionVariables."EDITOR" = "code --wait";
      services.vscode-server = enabled;
    };
  };
}
