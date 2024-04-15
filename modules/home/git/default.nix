{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.git;
  user = config.yukino.user;
in
{
  options.yukino.git = with types; {
    enable = mkBoolOpt false "yukino.git.enable";
    userName = mkOpt str user.name "yukino.git.userName";
    userEmail = mkOpt str user.email "yukino.git.userEmail";
    signingKey = mkOpt str null "yukino.git.signingKey";
  };

  config = mkIf _config.enable {
    programs.git = {
      inherit (_config) userName userEmail;
      enable = true;
      lfs = enabled;
      signing.key = _config.signingKey;
      extraConfig = {
        pull = {
          rebase = true;
        };
        init = {
          defaultBranch = "main";
        };
        rebase = {
          autoStash = true;
        };
        commit = {
          gpgsign = true;
        };
        tag = {
          gpgsign = true;
        };
        gpg = {
          format = "ssh";
          ssh = {
            program = "/mnt/c/Program Files/1Password/app/8/op-ssh-sign-wsl";
          };
        };
      };
    };
  };
}
