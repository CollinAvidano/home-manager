{ config, pkgs, inputs , ... }:
{
  home.packages = with pkgs; [
    spotify # for personal machines
    spotify-tui
  ]
}

