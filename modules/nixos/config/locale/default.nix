{ config, lib, ... }:
with lib;
with lib.yukino;
let _config = config.yukino.config.locale;
in {
  options.yukino.config.locale = {
    enable = mkBoolOpt false "yukino.config.locale.enable";
  };

  config = mkIf _config.enable {
    i18n.defaultLocale = "en_GB.UTF-8";
    time.timeZone = "Europe/London";
  };
}
