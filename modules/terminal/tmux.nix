#https://github.com/CollinAvidano/dotfiles/blob/master/tmux/.tmux.conf
{ config, pkgs, lib, ... }:
let
  cfg = config.tmux;
in {
  options.tmux.enable = lib.mkEnableOption "tmux";
  config = {
    shell.aliases = lib.mkIf cfg.enable {
      ns = "tmux new -s ";
      as = "tmux attach-session -t ";
    };
    # TODO need a make if here to include zsh if this is active

    programs.tmux = lib.mkIf cfg.enable {
      enable = true;
      keyMode = "vi";
      mouse = true;
      prefix = "C-a";
      # TODO make this a precedence thing
      shell = "${pkgs.zsh}/bin/zsh";
      baseIndex = 1;
      escapeTime = 0;
      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
        tmuxPlugins.yank
        tmuxPlugins.resurrect
        tmuxPlugins.continuum
        tmuxPlugins.nord
      ];
      extraConfig = ''
        set -g default-terminal "screen-256color"
        set-option -g default-terminal screen-256color

        # still need this for mouse mode
        # Mouse works as expected
        # set-option -g mouse on

        bind-key : command-prompt
        bind-key r refresh-client
        bind-key L clear-history

        bind-key space next-window
        bind-key bspace previous-window
        bind-key enter next-layout

        # When we add/remove windows, renumber them in sequential order.
        set -g renumber-windows on

        # MY CUSTOM WINDOW SPLITTING TO EMULATE I3
        bind-key -n M-g split-window -h
        bind-key -n M-v split-window -v

        bind-key -n M-h select-pane -L
        bind-key -n M-j select-pane -D
        bind-key -n M-k select-pane -U
        bind-key -n M-l select-pane -R

        bind-key -r -T prefix M-h resize-pane -L
        bind-key -r -T prefix M-j resize-pane -D
        bind-key -r -T prefix M-k resize-pane -U
        bind-key -r -T prefix M-l resize-pane -R

        bind-key a last-pane
        bind-key q display-panes
        bind-key c new-window
        bind-key t next-window
        bind-key T previous-window

        bind-key [ copy-mode
        bind-key ] paste-buffer

        # Setup 'v' to begin selection as in Vim
        bind-key -T copy-mode-vi v send -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
        bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R

        set-window-option -g other-pane-height 25
        set-window-option -g other-pane-width 80
        set-window-option -g display-panes-time 1500
        set-window-option -g window-status-current-style fg=magenta

        # Status Bar
        set-option -g status-interval 1
        set-option -g status-style bg=black
        set-option -g status-style fg=white
        set -g status-left '#[fg=green]#H #[default]'
        set -g status-right '%a%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d'

        set-option -g pane-active-border-style fg=yellow
        set-option -g pane-border-style fg=cyan

        # Set window notifications
        setw -g monitor-activity on
        set -g visual-activity on

        # Allow the arrow key to be used immediately after changing windows
        set-option -g repeat-time 0

        # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
        run '~/.tmux/plugins/tpm/tpm'
      '';
    };
  };
}
