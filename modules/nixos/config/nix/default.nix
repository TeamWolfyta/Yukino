{ config, lib, pkgs, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.config.nix;
  user = config.yukino.config.user;
in {
  options.yukino.config.nix = {
    enable = mkBoolOpt false "yukino.config.nix.enable";
  };

  config = mkIf _config.enable {
    environment.systemPackages = with pkgs; [
      nix-index
      nix-output-monitor
      nix-prefetch-git
      nixfmt
    ];
    nix = let users = [ "root" user.name ];
    in {
      package = pkgs.nixVersions.latest;
      gc = {
        options = "--delete-older-than 30d";
        dates = "daily";
        automatic = true;
      };
      settings = {
        trusted-users = users;
        sandbox = "relaxed";
        auto-optimise-store = true;
        allowed-users = users;
        experimental-features = "nix-command flakes";
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
      };
      # flake-utils-plus
      generateRegistryFromInputs = true;
      generateNixPathFromInputs = true;
      linkInputs = true;
    };
  };
}
