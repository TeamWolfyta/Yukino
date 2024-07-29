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
  _config = config.${namespace}.suites.development.nix;
  _git = config.${namespace}.programs.git;
in
{
  options.${namespace}.suites.development.nix = {
    enable = mkBoolOpt false "suites.development.nix.enable";
  };

  config = mkIf _config.enable {
    environment.systemPackages = with pkgs; [
      cachix
      deadnix
      nix-init
      nix-melt
      nix-prefetch-docker
      nix-prefetch-git
      nix-prefetch-github
      nix-update
      nixd
      nixfmt-rfc-style
      nurl
      statix
    ];

    yukino.home.extraOptions.xdg.configFile."nix-init/config.toml".text = ''
      maintainers = [ "${_git.username}" ]
    '';
  };
}
