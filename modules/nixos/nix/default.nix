{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.nix;
in
{
  options.yukino.nix = { };

  config = {
    environment.systemPackages = with pkgs; [
      nix-index
      nix-output-monitor
      nix-prefetch-git
      nixfmt
    ];

    nix =
      let
        users = [
          "root"
          config.yukino.user.name
        ];
      in
      {
        settings = {
          trusted-users = users;
          sandbox = "relaxed";
          auto-optimise-store = true;
          allowed-users = users;
          experimental-features = "nix-command flakes";

          # Can't find documentation for these but they seem and sound important
          http-connections = 50;
          warn-dirty = false;
          log-lines = 50;
        };

        gc = {
          options = "--delete-older-than 30d";
          dates = "daily";
          automatic = true;
        };

        # flake-utils-plus
        generateRegistryFromInputs = true;
        generateNixPathFromInputs = true;
        linkInputs = true;
      };
  };
}
