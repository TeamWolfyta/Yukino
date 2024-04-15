{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.yukino;
let
  _config = config.yukino.locale;
in
{
  options.yukino.locale = {
    enable = mkBoolOpt false "yukino.locale.enable";
  };

  config = mkIf _config.enable { i18n.defaultLocale = "en_GB.UTF-8"; };
}
