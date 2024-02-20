{ config, pkgs, lib, ... }:
{
  config = {

    home.file = {
      ".config/touchegg/touchegg.conf".source = ../dotfiles/touchegg.conf;
    };
    home.packages = with pkgs; [
      pantheon.touchegg
    ];

  };
}
