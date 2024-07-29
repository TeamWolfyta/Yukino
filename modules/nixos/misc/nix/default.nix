{ lib, namespace, ... }:
with lib.${namespace};
{
  config = {
    nix = {
      # I prefer flakes.
      channel = disabled;
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
      };
      settings = {
        allowed-users = [ "@wheel" ];
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = [ "https://nix-community.cachix.org" ];
        trusted-substituters = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
        trusted-users = [
          "root"
          "@wheel"
        ];
        nix-path = [ "nixpkgs=flake:nixpkgs" ];
        use-xdg-base-directories = true;
        warn-dirty = false;
      };
    };
  };
}
