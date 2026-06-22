{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.sysmons.bottom;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.sysmons.bottom.enable = mkEnableOption "Enable bottom sysmon";

  config = mkIf cfg.enable {
    # Configure Bottom via Hjem Rum
    custom.hjem.cfg.rum.programs.bottom = {
      enable = true;
      settings = {
        flags = {
          table_gap = "none";
          battery = true;
          processes.regex = true;
          processes.default_tree = true;
          processes.default_grouped = true;
          processes.default_memory_value = true;
          processes.current_usage = true;
          processes.hide_k_threads = true;
          processes.process_command = false;
        };
        colors = {
          table_header_color = "LightBlue";
          all_cpu_color = "LightCyan";
          avg_cpu_color = "Red";
          cpu_core_colors = ["LightMagenta" "LightYellow" "LightCyan" "LightGreen" "LightBlue" "Red" "Cyan" "Magenta"];
          ram_color = "LightMagenta";
          swap_color = "LightYellow";
          rx_color = "LightCyan";
          tx_color = "LightGreen";
          widget_title_color = "Gray";
          border_color = "Gray";
          highlighted_border_color = "LightBlue";
          text_color = "Gray";
          graph_color = "Gray";
          cursor_color = "LightCyan";
          selected_text_color = "Black";
          selected_bg_color = "LightBlue";
          high_battery_color = "Green";
          medium_battery_color = "Yellow";
          low_battery_color = "Red";
        };
      };
    };
  };
}
