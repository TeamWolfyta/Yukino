{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.zsh;
in
{
  options.yukino.zsh = {
    enable = mkBoolOpt false "yukino.zsh.enable";
  };

  config = mkIf _config.enable {
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion = enabled;
        historySubstringSearch = enabled;

        oh-my-zsh = {
          enable = true;
          plugins = [
            "docker"
            "sudo"
          ];
        };

        plugins =
          let
            plugin = name: {
              inherit name;
              src = "${pkgs."zsh-${name}"}/share/zsh/site-functions";
            };
          in
          builtins.map plugin [
            "fast-syntax-highlighting"
            "you-should-use"
          ];
      };

      starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          hostname = {
            ssh_only = false;
          };
          sudo = {
            disabled = false;
          };
          os = {
            disabled = false;
          };
          username = {
            show_always = true;
          };
        };
      };
    };
  };
}
