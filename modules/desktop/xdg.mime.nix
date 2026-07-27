{ ... }:
{
  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "text/html" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";

    # Video
    "video/mp4" = "mpv.desktop";
    "video/x-matroska" = "mpv.desktop";
    "video/webm" = "mpv.desktop";
    "video/x-msvideo" = "mpv.desktop";
    "video/quicktime" = "mpv.desktop";
    "video/mpeg" = "mpv.desktop";
    "video/x-flv" = "mpv.desktop";
    "video/3gpp" = "mpv.desktop";
    "video/3gpp2" = "mpv.desktop";
    "video/ogg" = "mpv.desktop";
    "video/x-ms-wmv" = "mpv.desktop";

    # Audio
    "audio/mpeg" = "mpv.desktop";
    "audio/mp4" = "mpv.desktop";
    "audio/ogg" = "mpv.desktop";
    "audio/flac" = "mpv.desktop";
    "audio/wav" = "mpv.desktop";
    "audio/x-wav" = "mpv.desktop";
    "audio/webm" = "mpv.desktop";
    "audio/x-matroska" = "mpv.desktop";
    "audio/opus" = "mpv.desktop";

    # GIF (see note below)
    "image/gif" = "mpv.desktop";
  };
}
