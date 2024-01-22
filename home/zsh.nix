#https://github.com/CollinAvidano/dotfiles/blob/master/zsh/.zshrc
#https://github.com/CollinAvidano/dotfiles/tree/master/zsh
{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableVteIntegration = true;
    autocd = true;
    defaultKeymap = "vicmd";
    oh-my-zsh = {
      enable = true;
      #TODO ZOXIDE
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
      HYPHEN_INSENSITIVE="true"
      # don't verify history expansion before execution
      unsetopt histverify

      # don't share history
      unsetopt sharehistory

      # User configuration
      setopt extended_glob
      # Compilation flags
      export ARCHFLAGS="-arch x86_64"

      eval "$(zoxide init zsh)"

      # Set personal aliases, overriding those provided by oh-my-zsh libs,
      # plugins, and themes. Aliases can be placed here, though oh-my-zsh
      # users are encouraged to define aliases within the ZSH_CUSTOM folder.
      # For a full list of active aliases, run `alias`.
      #
      # Most of these I try to keep shell independent

      if [ -f $HOME/.functions ]; then
          . $HOME/.functions
      fi

      if [ -f $HOME/.aliases ]; then
          . $HOME/.aliases
      fi

      if [ -f $HOME/.path ]; then
          . $HOME/.path
      fi

      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # Colorizer aliases using grc
      [[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

      if [ -f $HOME/.ros_setup ]; then
          . $HOME/.ros_setup
      fi

      # non shell independent stuff
      # run zsh hook
      precmd() { eval "$PROMPT_COMMAND" }

    '';
    #TODO CHECK YOU NEED TO RUN THE P10k STUFF
    #TODO ADD OTHER ENV STUFF SUCH AS CONDA
    #TODO NEED TO FIGURE OUT CLANG FORMAT STUFF
    #TODO MAYBE DONT DO STUFF FOR powerlevel 10k through official means as you have that if statement for fonts for basic terms

    envExtra = ''
      # .zshenv is launched as part of zsh loading process
      # loads .env and .path if they exist both of which are intended to be shell independent
      if [ -f $HOME/.env ]; then
        . $HOME/.env
      fi

      if [ -f $HOME/.path ]; then
        . $HOME/.path
      fi
    '';


  };
  programs.nix-index.enableZshIntegration = true;

  programs.thefuck.enable = true;
  programs.thefuck.enableBashIntegration = true;
  programs.thefuck.enableZshIntegration = true;
}