{ config, lib, pkgs, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.config.wsl;
  user = config.yukino.config.user;
in {
  options.yukino.config.wsl = {
    enable = mkBoolOpt false "yukino.config.wsl.enable";
  };

  config = mkIf _config.enable {
    environment = {
      noXlibs = mkForce false;
      sessionVariables.BROWSER = "wslview";
      systemPackages = with pkgs; [ wslu ];
    };
    wsl = {
      enable = true;
      defaultUser = user.name;
      wslConf = {
        automount.root = "/mnt";
        user.default = user.name;
      };
    };
  };
}
