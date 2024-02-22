{ config, pkgs, lib, ... }:

with lib;
with builtins;

let
  cfg = config.zellij;
in {
  options.zellij.enable = mkEnableOption "zellij";

  config.programs.zellij = mkIf cfg.enable {
    enable = true;
    # definetly debating if having my own layer of enables vs the program.name.enable was worth it...
    enableZshIntegration = config.zsh.enable;
    enableBashIntegration = config.bash.enable;
  };
}