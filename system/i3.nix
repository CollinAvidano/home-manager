# https://github.com/CollinAvidano/dotfiles/blob/master/i3/.config/i3/config
{ config, pkgs, lib, ... }:
let
  mod = "Mod4";
in {
  # TODO FIX THIS
  # services.xserver.windowManager.i3.package = pkgs.i3;
  # i3 includes gaps past 4.22
  xsession.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
      i3blocks
    ];

    config = {
      modifier = mod;

      fonts = ["font pango:Sauce Code Pro Medium Nerd Font Complete, FontAwesome, 9"];

      keybindings = lib.mkOptionDefault {
        # TODO FIX THIS DMENU ALIAS HACK
        "${mod}+d" = "exec dmenu_run_aliases";

        "${mod}+c" = "workspace prev";
        "${mod}+m" = "workspace next";

        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" =  "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";

        "XF86MonBrightnessUp" = "exec --no-startup-id xbacklight -inc 5";
        "XF86MonBrightnessDown" = "exec --no-startup-id xbacklight -dec 5";
        "XF86WLANoff" = "exec --no-startup-id ifconfig wlp2s0 down toggle";
        "XF86WLANon" = "exec --no-startup-id ifconfig wlp2s0 up toggle";

        # "XF86Display" = "exec $scripts/toggleredshift.sh";
        "XF86Display" = "exec $scripts/monitor-switch.sh";

        "XF86Tools" = "exec --no-startup-id $scripts/toggletouchpad.sh";

        "XF86Bluetooth" = "exec $scripts/togglebluetooth.sh";

        # change focus
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+h" = "focus left";

        # alternatively, you can use the cursor keys:
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # move focused window
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+h" = "move left";

        # alternatively, you can use the cursor keys:
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # split in horizontal orientation
        "${mod}+g" = "split h";

        # split in vertical orientation
        "${mod}+v" = "split v";

        # enter fullscreen mode for the focused container
        "${mod}+f" = "fullscreen toggle";

        # change container layout (stacked, tabbed, toggle split)
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        # toggle tiling / floating
        "${mod}+Shift+space" = "floating toggle";

        # change focus between tiling / floating windows
        "${mod}+space" = "focus mode_toggle";

        # focus the parent container
        "${mod}+a" = "focus parent";

        # workspace ones should always be default

        # reload the configuration file
        "${mod}+Shift+c" = "reload";
        # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
        "${mod}+Shift+r" = "restart";
        # exit i3 (logs you out of your X session)
        "${mod}+Shift+e" = ''exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"'';

        "${mod}+r" = "mode resize";
        "Print" = "exec gnome-screenshot -ia &";
        "Control+Print" = "exec gnome-screenshot -id &";
      }; # END  KEYBINDS

      modes.resize = {
        "Left" = "resize shrink width 10 px or 10 ppt";
        "Down" = "resize grow height 10 px or 10 ppt";
        "Up" = "resize shrink height 10 px or 10 ppt";
        "Right" = "resize grow width 10 px or 10 ppt";
        "j" = "resize shrink width 10 px or 10 ppt";
        "k" = "resize grow height 10 px or 10 ppt";
        "h" = "resize shrink height 10 px or 10 ppt";
        "l" = "resize grow width 10 px or 10 ppt";
      };

      # Start i3bar to display a workspace bar (plus the system information i3status
      # finds out, if available)
      bars = [
        {
          "status_command" = "i3status";

          #TODO IMPLEMENT THIS FILE
          # https://github.com/CollinAvidano/dotfiles/blob/master/i3/.config/i3status/config

          #TODO THESE
          # tray_output primary

          # height 31

          # colors {
          #   background $nord0
          #   statusline $nord8

          #   focused_workspace  $nord3  $nord8
          #   active_workspace   $nord3  $nord8
          #   inactive_workspace $nord8  $nord3
          #   urgent_workspace   $nord3 $nord15
        }
      ];


      # bars = [
      #   {
      #     position = "bottom";
      #     statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
      #   }
      # ];




# # TODO STARTUP IN EXTRA CONFIG
# # start locking script
# exec --no-startup-id xss-lock -- $scripts/lock.sh

# # start compton compositor
# exec compton --config ~/.config/compton.conf -b -c

# # Wallpaper
# exec --no-startup-id /usr/bin/feh --bg-scale /home/collin/pictures/wallpaper.png &

# # Screenshots
# bindsym Print exec gnome-screenshot -ia &
# bindsym Control+Print exec gnome-screenshot -id &

# # Network manager applet
# exec --no-startup-id nm-applet &

# # Battery alert script
# exec --no-startup-id $scripts/i3-battery-popup.sh &

# # Disk automount wrapper for Udisks2
# exec --no-startup-id udiskie --tray --use-udisks2 &

# # Bluetooth applet
# # exec --no-startup-id blueman-applet

    };
  };
}