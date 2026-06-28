# ocr-screenshot.nix
{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.screencap.ocrScreenshot;
  inherit (lib) mkEnableOption mkIf;

  ocrScreenshot = pkgs.writeShellApplication {
    name = "ocr-screenshot";
    runtimeInputs = with pkgs; [
      grim
      slurp
      tesseract
      wl-clipboard
      libnotify
      gnused
    ];
    text = ''
      content="$(grim -g "$(slurp)" - | \
        tesseract - stdout \
        --oem 1 \
        --psm 6 \
        -c load_system_dawg=1 \
        -c load_freq_dawg=1 \
        -c tessedit_char_blacklist="¦"
      )"

      # Exit silently if capture was cancelled or OCR returned nothing
      test -z "$content" && exit 0

      printf "%s" "$content" | wl-copy

      escape() {
        sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'
      }

      preview="$(printf "%s" "$content" | cut -c1-200 | escape)"

      notify-send \
        -h string:x-canonical-private-synchronous:ocr \
        -h string:markup-body:1 \
        "OCR copied" \
        "<tt>$preview</tt>"
    '';
  };
in
{
  options.custom.desktop.screencap.ocrScreenshot = {
    enable = mkEnableOption "OCR screenshot-to-clipboard script (grim + slurp + tesseract)";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ ocrScreenshot ];
  };
}
