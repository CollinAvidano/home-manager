#https://github.com/CollinAvidano/dotfiles/blob/master/git/.gitconfig
{ pkgs, config, flake, ... }:
{
  home.packages = [ pkgs.git-lfs ];

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = flake.config.people.users.${config.home.username}.name;
    userEmail = flake.config.people.users.${config.home.username}.email;
    aliases = {
      mainlog = "log --all --decorate --oneline --graph";
      subup = "submodule update --init --recursive";
      # for adding tracking of things that cant be moved here which is really only done in the rare case of things that look for symlinking
      addext = "--work-tree=/ add";
    };
    ignores = [ "*~" "*.swp" ];
    extraConfig = {
      core.editor = "vim";
      core.autocrlf = "input";
      http = {
        sslCAinfo = "/etc/ssl/certs/ca-certificates.crt";
        sslVerify = true;
      };
      help.autocorrect = 1;
      credential.helper = "cache --timeout 7200";
    };
  };
}