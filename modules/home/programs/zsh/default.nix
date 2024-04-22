{ config, lib, pkgs, ... }:
with lib;
with lib.yukino;
let _config = config.yukino.programs.zsh;
in {
  options.yukino.programs.zsh = {
    enable = mkBoolOpt false "yukino.programs.zsh.enable";
  };

  config = mkIf _config.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = enabled;
      historySubstringSearch = enabled;
      oh-my-zsh = {
        enable = true;
        plugins = [ "docker" "eza" "git" "sudo" ];
      };
      plugins = [
        {
          name = "fast-syntax-highlighting";
          src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
        }
        {
          name = "you-should-use";
          src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
        }
      ];
    };
  };
}
