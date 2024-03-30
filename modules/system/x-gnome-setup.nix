{ config, pkgs, lib, ... }:

with lib;
with builtins;

# Could group in key remapping basically anything in an x desktop setup I would want
# unsure what to call this but grouping my supporting gnome elements I use for services for i3 a lot of times and their configuration
let
  cfg = config.gnome;
in {
  options.gnome.enable = mkEnableOption "gnome";

  config = mkIf cfg.enable {
    gtk.iconTheme = {
      # package
      # name
    };
    # xdirs not tied to this



  };

}