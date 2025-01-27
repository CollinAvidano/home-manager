{ config, pkgs, inputs , ... }:
{
  imports = [
    # TODO redshift, compton, and arandr
    ./editors/vim.nix
    # ./editors/vscode.nix
    ./system/touchegg.nix
    ./system/i3.nix
    ./terminal/shell.nix
    ./terminal/zellij.nix
    ./terminal/tmux.nix
    # ./tools/docker.nix
    ./tools/gdb.nix
    ./tools/git.nix
  ];

  config = {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;

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

    networking.networkmanager.enable = true;


    # TODO move this
    # out of bounds zero error it seems like there is a required option im not setting here
    # programs.gnome-terminal = {
    #   enable = true;
    #   themeVariant = "dark";
    # };

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
      curl
      wget
      gawk
      jq
      kind

      # nvtop
      nvtop-amd
      glances
      htop

      stress-ng
      # gpu-burn
      linuxPackages_latest.perf
      fio # flexible io tester

      # network utils
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

      codeql #unfree package
      gitleaks

      gnupg

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

      # nixos-rebuild
      # nixos-shell
      # nix-melt

      (pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    home.file = {
      ".config/user-dirs.dirs".source = "modules/dotfiles/user-dirs.dirs";
      ".config/mimeapps.list".source = "modules/dotfiles/mimeapps.list";
      ".clang-format".source = "modules/dotfiles/style-configs/.clang-format";
      ".editorconfig".source = "modules/dotfiles/style-configs/.editorconfig";
      ".style.yapf".source = "modules/dotfiles/style-configs/.style.yapf";

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
      TERM="screen-256color";
      # TODO MOVE TO RANGER
      RANGER_LOAD_DEFAULT_RC="FALSE";
      MOZ_USE_XINPUT2="1";
      QT_QPA_PLATFORMTHEME="gtk3";
    };

  };
}
