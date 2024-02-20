#https://github.com/CollinAvidano/dotfiles/blob/master/zsh/.zshrc
#https://github.com/CollinAvidano/dotfiles/tree/master/zsh
#https://github.com/CollinAvidano/dotfiles/tree/master/shell
{ config, pkgs, lib, ... }:

with lib;
with builtins;

{
  options = {
    shell = {
      # unsure if enable is needed really just using this attrs set as a way to set common config all shells source from to get program specific aliases
      enable = mkEnable "shell";

      aliases = mkOption {
        type = types.attrsOf types.str;
        default = { };
      };

      functions = mkOption {
        type = types.lines;
        default = "";
      };
    };

    bash.enable = mkEnable "bash";
    zsh.enable = mkEnable "zsh";
  };

  config = {
    # common config. Also done so if something needs to merge config that applies to both later
    # eg ros and its aliases then it can do so
    shell = mkIf config.shell.enable {
      aliases = import ../dotfiles/aliases.nix;
      functions = builtins.readFile ../dotfiles/functions;

      # preInit = ''
      #   ## A function to see if a command exists. Basically cross platform which
      #   exists() {
      #       command -v $1 >/dev/null
      #       return $?
      #   }
      # '';
    };


    programs.bash = mkIf config.bash.enable {
      enable = true;
      enableCompletion = !pkgs.stdenv.isDarwin;
      shellAliases = config.shell.aliases;

      shellOptions = [
        # Append to history file rather than replacing it.
        "histappend"

        # check the window size after each command and, if
        # necessary, update the values of LINES and COLUMNS.
        "checkwinsize"

        # Extended globbing.
        "extglob"

      ]
    };

    programs.zsh = mkIf config.zsh.enable  {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableVteIntegration = true;
      dotDir = ".config/zsh";
      autocd = true;
      defaultKeymap = "vicmd";
      shellAliases = config.shell.aliases;
      oh-my-zsh = {
        enable = true;
        #TODO ZOXIDE
        # TODO have the respective packages merge these into plugins if they are enabled
        plugins = [
          "git"
          "thefuck"
          "docker"
          "pip"
          "vi-mode"
          "zsh-autosuggestions"
          "zsh-nvm"
          "wd"
        ];
        theme = "powerlevel10k/powerlevel10k";
      };
      initExtra = ''
        ${builtins.readFile ../dotfiles/zshrc}
        ${builtins.readFile ../dotfiles/p10k}
      '';

      envExtra = ''
        # .zshenv is launched as part of zsh loading process
        # loads .env and .path if they exist both of which are intended to be shell independent
        ${builtins.readFile ../dotfiles/env}
      '';
    };

    home.packages = mkIf config.zsh.enable [
      pkgs.zsh-powerlevel10k
    ]


    programs.thefuck.enable = true;

    programs.thefuck.enableBashIntegration = true;

    # TODO merge these in on a make if? how do I deal with the enable then....
    programs.nix-index.enableZshIntegration = true;
    programs.thefuck.enableZshIntegration = true;
    programs.zellij.enableZshIntegration
    programs.zoxide.enableZshIntegration

  };
}