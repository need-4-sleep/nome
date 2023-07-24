{ pkgs, ... }:

{
  services.playerctld.enable = true; # sends my keybinds to mpv

  programs.mpv = {
    enable = true;

    config = {

      # -- Behaviour --
      pause = true;
      border = "no";
      input-ipc-server="~~/socket"; # for kb cmds that playerctl cant handle
      save-position-on-quit = true;
      resume-playback = false;
      no-keepaspect-window = ""; # breaks paperwm otherwise

      # -- Hardware --
      hwdec = "auto-safe";
      vo = "gpu";
      #profile = "gpu-hq";
      hdr-compute-peak = false;

      # -- yt-dlp --
      ytdl-raw-options = "sub-lang='en',write-subs=,write-auto-sub=,write-subs=";
      ytdl-format = "bestvideo[height<=1440]+bestaudio/best[height<=1440]";

      # -- Subtitles --
      slang = "en";
      alang = "en";
      blend-subtitles = true;
      sub-color = "#eeeeee";
      sub-shadow-color = "#2B181818";
      sub-shadow-offset = 2;
      sub-font = "TeX Gyre Schola";
      sub-bold = "no";
      sub-font-size = 40;
      sub-border-size = 1.4;
      sub-border-color = "#F2181818";
      sub-spacing = 0.5;
      sub-justify = "left";
      sub-pos = 100; # sub pos 0% above bottom of screen
      sub-auto = "all";
      sub-ass = "";
      sub-scale-by-window = "no";

      # -- On-screen display --
      osc = "no";
      osd-bar = "no";
      cursor-autohide = 1500;
      osd-on-seek = "msg";
      osd-duration = 800;
      osd-status-msg = "\${playback-time} | \${percent-pos}%";
      osd-font-size = 28;
      osd-border-size = 1.5;
    };

    scripts = with pkgs.mpvScripts; [
      autoload
      mpris # use w/ playerctl
      thumbfast
    ];

    scriptOpts = {
      osc = {
        vidscale = true;
        timetotal = false;
        hidetimeout = 500;
        boxalpha = 25;
      };
      ytdl_hook = {
        ytdl_path = "yt-dlp";
      };
    };
  };

  # Additional scripts that aren't in nixpkgs.
  xdg.configFile = {
    "mpv/scripts/oscc.lua".source = ../sources/mpv/scripts/oscc;
    "mpv/scripts/seek-show.js".source = ../sources/mpv/scripts/seek-show-position;
    "mpv/fonts/".source =  ../sources/mpv/fonts;
  };
}
