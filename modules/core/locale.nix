{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.core.locale;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.core.locale.enable = mkEnableOption "Enable Standard Locale/Timezone Settings";

  config = mkIf cfg.enable {
    time.timeZone = lib.mkDefault "UTC+2"; # Host file can override this
    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  };
}
