{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.programs.zsh;
in
{
  options.yukino.programs.zsh = {
    enable = mkBoolOpt false "yukino.programs.zsh.enable";
  };

  config = mkIf _config.enable {
    home.shellAliases = {
      yukino-switch = "sudo nixos-rebuild switch --flake github:TeamWolfyta/Yukino --option tarball-ttl 0";
    };
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = enabled;
      historySubstringSearch = enabled;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "docker"
          "eza"
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
  };
}
