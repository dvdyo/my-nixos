{
  lib,
  config,
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
        };
        processes = {
          regex = true;
          default_tree = true;
          default_grouped = true;
          default_memory_value = true;
          current_usage = true;
          hide_k_threads = true;
          process_command = false;
        };
        colors = {
          table_header_color = "#a9b665"; # green
          all_cpu_color = "#7daea3"; # blue
          avg_cpu_color = "#ea6962"; # red
          cpu_core_colors = [
            "#d3869b" # magenta
            "#d8a657" # yellow
            "#89b482" # aqua
            "#a9b665" # green
            "#7daea3" # blue
            "#e78a4e" # orange
            "#ea6962" # red
            "#bdae93" # fg2 (filler since palette only has 7 accents)
          ];
          ram_color = "#d3869b"; # magenta
          swap_color = "#d8a657"; # yellow
          rx_color = "#89b482"; # aqua
          tx_color = "#a9b665"; # green
          widget_title_color = "#bdae93"; # fg2
          border_color = "#504945"; # bg2
          highlighted_border_color = "#7daea3"; # blue
          text_color = "#d4be98"; # fg1
          graph_color = "#bdae93"; # fg2
          cursor_color = "#89b482"; # aqua
          selected_text_color = "#282828"; # bg0
          selected_bg_color = "#7daea3"; # blue
          high_battery_color = "#a9b665"; # green
          medium_battery_color = "#d8a657"; # yellow
          low_battery_color = "#ea6962"; # red
        };
      };
    };
  };
}
