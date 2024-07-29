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
  _config = config.${namespace}.programs.zsh;
in
{
  options.${namespace}.programs.zsh = with types; {
    enable = mkBoolOpt false "programs.zsh.enable";
    oh-my-zsh.plugins = mkOpt (listOf str) [ ] "programs.zsh.oh-my-zsh.plugins";
  };

  config = mkIf _config.enable {
    programs.zsh = enabled;
    yukino.home.extraOptions = {
      programs.zsh = {
        enable = true;
        autosuggestion = enabled;
        enableCompletion = true;
        historySubstringSearch = enabled;
        oh-my-zsh = {
          enable = true;
          inherit (_config.oh-my-zsh) plugins;
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
  };
}
