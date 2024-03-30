# AstroNvim config. Right now I'm just cloning the default config and making zero changes.
{ config, pkgs, lib, inputs, ... }:

with lib;
with builtins;

  config.programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

let
  files = (pipe astronvim [
    (lib.filesystem.listFilesRecursive)
    (map (x: {
      name = ".config/nvim${
          unsafeDiscardStringContext (removePrefix "${astronvim}" x)
        }";
      value = x;
    }))
    (listToAttrs)
  ]) // {
    # override default astrovim config here
  };
in {
  options.astronvim.enable = mkEnableOption "astronvim";

  config.home = mkIf config.astronvim.enable {
    packages = with pkgs; [
      neovim
      ripgrep
      lazygit
      gdu
      bottom
      nodejs
      python311
    ];

    file = listToAttrs (map (file: {
      name = "astronvim_${file.name}";
      value = {
        executable = false;
        source = file.value;
        target = file.name;
      };
    }) (map (name: {
      inherit name;
      value = getAttr name files;
    }) (attrNames files)));
  };
}