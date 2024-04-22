{ config, lib, pkgs, ... }:
with lib;
with lib.yukino;
let _config = config.yukino.config.user;
in {
  options.yukino.config.user = with types; {
    name = mkOpt str "kieran" "yukino.config.user.name";
  };

  config = {
    programs.zsh = enabled;
    users = {
      mutableUsers = mkForce false;
      users.${_config.name} = {
        uid = 1000;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" ];
        isNormalUser = true;
        initialPassword = "1234";
      };
    };
  };
}
