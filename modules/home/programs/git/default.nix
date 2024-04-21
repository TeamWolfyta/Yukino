{ config, lib, ... }:
with lib;
with lib.yukino;
let
  _config = config.yukino.programs.git;
  home = config.yukino.config.home;
in
{
  options.yukino.programs.git = with types; {
    enable = mkBoolOpt false "yukino.programs.git.enable";
    username = mkOpt str home.username "yukino.programs.git.username";
    useremail = mkOpt str home.useremail "yukino.programs.git.useremail";
    signingKey = mkOpt str null "yukino.programs.git.signingKey";
  };

  config = mkIf _config.enable {
    programs.git = {
      enable = true;
      delta = enabled;
      git-credential-oauth = enabled;
      extraConfig = {
        pull.rebase = true;
        init.defaultBranch = "main";
        rebase.autoStash = true;
        gpg = {
          format = "ssh";
          ssh.program = "/mnt/c/Program Files/1Password/app/8/op-ssh-sign-wsl";
        };
      };
      lfs = enabled;
      signing = {
        key = _config.signingKey;
        signByDefault = true;
      };
      userEmail = _config.useremail;
      userName = _config.username;
    };
  };
}
