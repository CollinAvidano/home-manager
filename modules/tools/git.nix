#https://github.com/CollinAvidano/dotfiles/blob/master/git/.gitconfig
{ config, pkgs, lib, ... }:

with lib;
with builtins;

let
  cfg = config.git;
in {
  options.git = {
    enable = mkEnableOption "git";
    userName = mkOption {
      type = types.str;
      default = "";
    };

    userEmail = mkOption {
      type = types.str;
      default = "";
    };

    signingKey = mkOption {
      type = types.str;
      default = "";
    };

  };

  config = {
    home.packages = mkIf cfg.enable [ pkgs.git-lfs ];

    programs.git = mkIf cfg.enable {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      lfs.enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      signing = {
        key = cfg.signingKey;
        signByDefault = cfg.signingKey != "";
      };
      # userName = "CollinAvidano";
      # userEmail = "collin.avidano@gmail.com";
      aliases = {
        mainlog = "log --all --decorate --oneline --graph";
        subup = "submodule update --init --recursive";
        # for adding tracking of things that cant be moved here which is really only done in the rare case of things that look for symlinking
        addext = "--work-tree=/ add";
      };
      ignores = [ "*~" "*.swp" ];
      extraConfig = {
        # TODO make this env var EDITOR
        # see if nix has a better way to set that
        commit = { gpgSign = cfg.signingKey != ""; };
        core = {
          editor = "vim";
          autocrlf = "input";
        };
        http = {
          sslCAinfo = "/etc/ssl/certs/ca-certificates.crt";
          sslVerify = true;
        };
        help.autocorrect = 1;
        credential.helper = "cache --timeout 7200";
        color = { ui = "auto"; };
        push = { autoSetupRemote = true; };
      };
    };

    shell.aliases = mkIf cfg.enable {
      g="git";
      gs="git status";
      gr="cd $(git rev-parse --show-toplevel)";
    };

    shell.functions = mkIf cfg.enable ''
      # git remove and git move I think now properly do this anyways
      # git functions
      submoduleadd() {
        git submodule add $1
        git submodule update --init --recursive
        cd $CATKIN_WS && rosdep install --from-paths src --ignore-src -r -y
      }

      submoduleremove() {
        repopath=$(git rev-parse --show-toplevel)

        git submodule deinit -f $1
        rm -rf $repopath/.git/modules/$1
        git rm -f $1
        git commit -m "Removed submodule"
      }
    '';
  };
}