{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.media.ncmpcpp;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.media.ncmpcpp = {
    enable = mkEnableOption "Enable ncmpcpp (Music Player Daemon Client)";
  };

  config = mkIf cfg.enable {
    custom.hjem.cfg.rum.programs.ncmpcpp = {
      enable = true;
      settings = {
        ncmpcpp_directory = "~/.config/ncmpcpp";
        external_editor = "hx";
        message_delay_time = 1;
        playlist_display_mode = "columns";
        browser_display_mode = "columns";
        search_engine_display_mode = "columns";
        playlist_editor_display_mode = "columns";
        autocenter_mode = "yes";
        centered_cursor = "yes";
        user_interface = "alternative";
        follow_now_playing_iterates = "yes";
        cyclic_scrolling = "yes";
        mouse_support = "yes";
        mouse_list_scroll_whole_page = "yes";
        lines_scrolled = "1";
        header_visibility = "yes";
        statusbar_visibility = "yes";
        titles_visibility = "yes";
        enable_window_title = "yes";
        progressbar_look = "=>-";
        now_playing_prefix = "$b";
        now_playing_suffix = "$/b";
        browser_playlist_prefix = "$2playlist$9 ";
        selected_item_prefix = "$6";
        selected_item_suffix = "$9";
        modified_item_prefix = "$3> ";
        song_status_format = "$7%t";
        song_list_format = "$1%n$9 $1%a$9 - $5%t$9 $R$1%l$9";
        song_columns_list_format = "(20) [red]{a} (30) [green]{f} (30) [white]{t|f} (5) [blue]{l}";
        visualizer_data_source = "/tmp/mpd.fifo";
        visualizer_output_name = "my_fifo";
        visualizer_in_stereo = "yes";
        visualizer_type = "spectrum";
        visualizer_look = "+|";
      };
    };
  };
}
