{ config, pkgs, inputs , ... }:
{
  imports = [
    ./editors/vim.nix
    # ./editors/vscode.nix
    ./system/touchegg.nix
    ./system/i3.nix
    ./terminal/shell.nix
    ./terminal/zellij.nix
    # TODO redshift, compton, and arandr
    ./terminal/tmux.nix
    # ./tools/docker.nix
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

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.11"; # Please read the comment before changing.

    # keyboard config
    home.keyboard = [ "caps:swapescape" "altwin:swap_alt_win" ];




    git = {
      enable = true;
      userName = "CollinAvidano";
      userEmail = "collin.avidano@gmail.com";
    };

    i3.enable = true;
    xsession.windowManager.i3.config.terminal = "gnome-terminal";

    # TODO move this
    programs.gnome-terminal = {
      enable = true;
    };


    # packages that were small enough I just enabled them here
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    shell.enable = true;
    bash.enable = true;
    zsh.enable = true;
    zellij.enable = true;
    tmux.enable = true;

    vim.enable = true;
    # vscode.enable = true;

    # Packages I need installed on every system
    home.packages = with pkgs; [
      coreutils
      file

      # nvtop
      nvtop-amd
      glances
      htop

      stress-ng
      # gpu-burn
      linuxPackages_latest.perf
      fio # flexible io tester

      curl
      wget
      wireshark
      tcpdump
      netperf # preferable to iperf3
      iproute2 # large set of common commands
      inetutils # ping and other network ones actuall not included in the ip route 2
      nmap
      openssl
      avahi # mdns and daemon
      dropwatch # packet drop monitoring and filtering debugging

      findutils # locate and other utils

      gcc
      cmake
      git-lfs
      github-cli
      gnumake

      # codeql #unfree package
      gitleaks

      gnupg
      jq
      kind

      k9s
      kubectl
      kubernetes-helm
      docker-compose
      libarchive
      libvirt

      pandoc

      ethtool
      pciutils
      lshw
      lm_sensors

      python3
      screen
      # tmux enabled by module
      tor
      torsocks

      tree
      ranger
      deer # ranger alternative

      unzip
      zip

      picocom

      nixos-rebuild
      nixos-shell
      nix-melt

      # spotify # for personal machines
      # spotify-tui

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
      # TODO define this as an order var of enabled options
      EDITOR = "vim";
      ALTERNATE_EDITOR = "";
    };

  };
}
