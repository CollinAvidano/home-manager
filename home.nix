{ config, pkgs, inputs , ... }:
{
  imports = [
    ./editors/vim.nix
    ./editors/vscode.nix
    ./system/i3.nix
    ./system/touchegg.nix
    ./terminal/shell.nix
    ./terminal/tmux.nix
    ./tools/docker.nix
    ./tools/gdb.nix
    ./tools/git.nix
  ];

  config = {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "collin";
    home.homeDirectory = "/home/collin";

    git = {
      enable = true;
      userName = "CollinAvidano";
      userEmail = "collin.avidano@gmail.com";
    };
    bash.enable = true;
    zsh.enable = true;
    tmux.enable = true;

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.11"; # Please read the comment before changing.

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Packages I need installed on every system
    home.packages = with pkgs; [
      coreutils
      file
      aerc
      # nvtop
      nvtop-amd
      glances
      htop
      bind
      bitwarden-cli
      stress-ng
      # gpu-burn
      linuxPackages_latest.perf
      fio # flexible io tester
      curl
      wget
      wireshark
      tcpdump
      netperf
      iproute2 # large set of common commands
      inetutils # ping and other network ones actuall not included in the ip route 2
      nmap
      openssl
      avahi # mdns and daemon
      deploy-rs
      dos2unix
      findutils
      fluxcd
      fzf
      gcc
      git-lfs
      github-cli
      gitleaks
      gnupg
      gnumake
      jq
      kind
      k9s
      kubectl
      kubernetes-helm
      docker-compose
      libarchive
      libvirt
      pandoc
      pciutils
      python3
      screen
      tmux
      tor
      torsocks
      tree
      unzip
      zip
      ranger
      nixos-rebuild
      nixos-shell
      nix-melt
      deer

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      (pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';

      # Webcord Nord theme
      ".config/WebCord/Themes/nordic.theme.css" = {
        source = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/orblazer/discord-nordic/bfd1da7e7a9a4291cd8f8c3dffc6a93dfc3d39d7/nordic.theme.css";
          sha256 = "sha256:13q4ijdpzxc4r9423s51hhcc8wzw3901cafqpnyqxn69vr2xnzrc";
        };
      };
    };

    # You can also manage environment variables but you will have to manually source
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    # or
    #  /etc/profiles/per-user/collin/etc/profile.d/hm-session-vars.sh
    # if you don't want to manage your shell through Home Manager.
    home.sessionVariables = {
      # TODO SET THIS FROM YOUR .env file
      # EDITOR = "emacs";
    };

  };
}
