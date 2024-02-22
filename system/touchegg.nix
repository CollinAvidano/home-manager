{ config, pkgs, lib, ... }:
{
  config = {

    # TODO unsure if this should be a home manager thing as usually I would have i3 boot this
    home.file = {
      ".config/touchegg/touchegg.conf".source = ../dotfiles/touchegg.conf;
    };
    home.packages = with pkgs; [
      pantheon.touchegg
    ];

  };
}
