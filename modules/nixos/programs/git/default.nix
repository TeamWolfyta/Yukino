{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  _config = config.${namespace}.programs.git;
in
{
  options.${namespace}.programs.git = with types; {
    enable = mkBoolOpt false "programs.git.enable";
    username = mkOpt str "TeamWolfyta" "programs.git.username";
    useremail = mkOpt str "kieran@wolfyta.dev" "programs.git.useremail";
    signingKey =
      mkOpt str "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHK0wpkhtQEPJq1H3b8Agnp9JHNMRiUoLcW30WRwPKMH"
        "programs.git.signingKey";
  };

  config = mkIf _config.enable {
    yukino = {
      programs.zsh.oh-my-zsh.plugins = [ "git" ];
      home.extraOptions = {
        programs.git = {
          enable = true;
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
    };
  };
}
