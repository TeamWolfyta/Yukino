{
  config,
  lib,
  osConfig,
  ...
}:
with lib;
with lib.yukino;
{
  environment.variables.FLAKE = "/home/kieran/projects/teamwolfyta/yukino";

  yukino = {
    config = {
      home = {
        username = "kieran";
        useremail = "kieran@wolfyta.dev";
      };
    };
    programs = {
      eza = enabled;
      gh = enabled;
      git = {
        enable = true;
        username = "TeamWolfyta";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHK0wpkhtQEPJq1H3b8Agnp9JHNMRiUoLcW30WRwPKMH";
      };
      starship = enabled;
      thefuck = enabled;
      zoxide = enabled;
      zsh = enabled;
    };
    misc = {
      xdg = enabled;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "23.11");
}
