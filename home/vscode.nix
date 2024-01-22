{ config, lib, pkgs, ... }:
{

  # TODO MAYBE JUST MAKE THE MUTABLE DIR THING AND CONFIGURE THIS WITH SETTINGS SYNC IT WOULD BE EASIER
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      1nVitr0.blocksort
      alefragnani.Bookmarks
      arcticicestudio.nord-visual-studio-code
      bbenoist.Nix
      bee.git-temporal-vscode
      betwo.b2-catkin-tools
      bierner.markdown-mermaid
      burkeholland.simple-react-snippets
      cheshirekow.cmake-format
      cschlosser.doxdocgen
      dbaeumer.vscode-eslint
      dsznajder.es7-react-js-snippets
      dtoplak.vscode-glsllint
      eamodio.gitlens
      felicio.vscode-fold
      github.vscode-github-actions
      Gruntfuggly.todo-tree
      hbenl.vscode-test-explorer
      jeff-hykin.better-cpp-syntax
      jnoortheen.nix-ide
      lauren.react-pack
      mhutchie.git-graph
      mkhl.direnv
      ms-azuretools.vscode-docker
      ms-dotnettools.csharp
      ms-dotnettools.vscode-dotnet-runtime
      ms-iot.vscode-ros
      ms-python.flake8
      ms-python.isort
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode-remote.remote-wsl
      ms-vscode-remote.vscode-remote-extensionpack
      ms-vscode.cmake-tools
      ms-vscode.cpptools
      ms-vscode.cpptools-extension-pack
      ms-vscode.cpptools-themes
      ms-vscode.hexeditor
      ms-vscode.makefile-tools
      ms-vscode.remote-explorer
      ms-vscode.remote-server
      ms-vscode.test-adapter-converter
      msjsdiag.vscode-react-native
      oderwat.indent-rainbow
      redhat.ansible
      redhat.java
      redhat.vscode-yaml
      reignofwebber.c-cpp-definition-generator
      rust-lang.rust-analyzer
      SimonSiefke.svg-preview
      slevesque.shader
      streetsidesoftware.code-spell-checker
      sumneko.lua
      tintinweb.vscode-decompiler
      twxs.cmake
      VisualStudioExptTeam.intellicode-api-usage-examples
      VisualStudioExptTeam.vscodeintellicode
      vscjava.vscode-java-debug
      vscjava.vscode-java-dependency
      vscjava.vscode-java-pack
      vscjava.vscode-java-test
      vscjava.vscode-maven
      vscodevim.vim
      Vue.volar
      waderyan.gitblame
      wmaurer.change-case
      zachflower.uncrustify
      zxh404.vscode-proto3
    ];

    # TODO just move these back to their own file
    userSettings = builtins.fromJSON ''
    {
      "nix.enableLanguageServer": true,
      "nix.serverPath": "rnix-lsp",
      "[*.nix]": {
          "editor.tabSize": 2
      },
      "indentRainbow.ignoreErrorLanguages": ["*.nix"],
      "fold.level": 2,
      "editor.bracketPairColorization.enabled": true,
      "editor.suggestSelection": "first",
      "editor.minimap.enabled": false,
      "editor.fontFamily": "SauceCodePro Nerd Font Mono, SauceCodePro NF",
      // "editor.fontFamily": "Consolas, 'Courier New', monospace",
      "editor.fontLigatures": false,
      "editor.insertSpaces": true,
      "editor.detectIndentation": false,
      "editor.fontSize": 14,
      "editor.tabSize": 4,
      "editor.codeLensFontFamily": "",
      "editor.codeLensFontSize": 0,
      "editor.largeFileOptimizations": false,
      "files.trimTrailingWhitespace": true,
      "files.exclude": {
          "**/.classpath": true,
          "**/.project": true,
          "**/.settings": true,
          "**/.factorypath": true
      },
      "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
      "cmake.configureOnOpen": false,
      "C_Cpp.updateChannel": "Insiders",
      "kite.showWelcomeNotificationOnStartup": false,
      "search.showLineNumbers": true,
      "jupyter.textOutputLimit": 200000,
      "python.languageServer": "Pylance",
      "workbench.editorAssociations": {
          "*.ipynb": "jupyter-notebook",
          "git-rebase-todo": "gitlens.rebase"
      },
      "notebook.cellToolbarLocation": {
          "default": "right",
          "jupyter-notebook": "left"
      },
      "keyboard.dispatch": "keyCode",
      "vim.useSystemClipboard": true,
      "vim.visualModeKeyBindings": [
          {
              "before": [
                  ">"
              ],
              "commands": [
                  "editor.action.indentLines"
              ]
          },
          {
              "before": [
                  "<"
              ],
              "commands": [
                  "editor.action.outdentLines"
              ]
          },

      ],
      "vim.visualModeKeyBindingsNonRecursive": [
          {
              "before": [
                  "p",
              ],
              "after": [
                  "p",
                  "g",
                  "v",
                  "y"
              ]
          }
      ],
      "vim.foldfix": true,
      "files.autoSave": "onWindowChange",
      "remote.SSH.remotePlatform": {
          "devbox": "linux",
          "simbox": "linux"
      },
      // "cmake.generator": "Ninja",
      // "cmake.preferredGenerators": [
      //     "Ninja",
      // ],
      "[cpp]": {
          "editor.defaultFormatter": "ms-vscode.cpptools"
      },
      "cmake.configureSettings": {

      },
      "gitlens.remotes": [{ "domain": "ghe.anduril.dev", "type": "GitHub" }],
      "terminal.integrated.fontSize": 14,
      "terminal.integrated.fontFamily": "SauceCodePro Nerd Font Mono, SauceCodePro NF",
      "terminal.external.linuxExec": "xterm",
      "git.mergeEditor": true,
      "javascript.inlayHints.parameterNames": "all",
      "terminal.integrated.automationProfile.linux": null,
      "C_Cpp.errorSquiggles": "enabled",
      "hexeditor.columnWidth": 16,
      "hexeditor.showDecodedText": false,
      "hexeditor.defaultEndianness": "little",
      "hexeditor.inspectorType": "aside",
      "[typescriptreact]": {
          "editor.defaultFormatter": "vscode.typescript-language-features"
      },
      "notebook.lineNumbers": "on",
      "editor.multiCursorLimit": 50000,
      "workbench.tree.indent": 20,
      "workbench.colorCustomizations": {
          "tree.indentGuidesStroke": "#ff0000"
      },
      "cmake.configureOnEdit": false,
      "git.autofetch": true,
      "[python]": {
          "editor.formatOnType": true
      },
      "ros.distro": "humble",
      "rust-analyzer.cargo.target": "thumbv7em-none-eabihf",
      "rust-analyzer.checkOnSave.allTargets": false,
      "rust-analyzer.server.path": "/nix/store/g4kgsiaizhv4naacl9zpv0caq2vx7zdl-rust-analyzer-2023-01-16//bin/rust-analyzer",
      "rust-analyzer.procMacro.server": null,
      "redhat.telemetry.enabled": false,
      "diffEditor.ignoreTrimWhitespace": false,
      "cSpell.enableFiletypes": [
          "ansible",
          "bat",
          "bibtex",
          "cmake",
          "cuda-cpp",
          "dockercompose",
          "dockerfile",
          "makefile",
          "nix",
          "pip-requirements",
          "powershell",
          "proto3",
          "shellscript",
          "tex",
          "toml",
          "vimrc",
          "xml"
      ],
      // "clangd.detectExtensionConflicts": false,
      // "C_Cpp.intelliSenseEngine": "disabled",
    } '';

    # TODO just move these back to their own file
    keybindings = builtins.fromJSON ''
    [
      {
        "key": "ctrl+shift+l c",
        "command": "gitlens.copyRemoteFileUrlToClipboard"
      },
      {
        "key": "ctrl+shift+l",
        "command": "-selectAllSearchEditorMatches",
        "when": "inSearchEditor"
      },
      {
        "key": "ctrl+shift+l",
        "command": "-editor.action.selectHighlights",
        "when": "editorFocus"
      },
      {
        "key": "ctrl+shift+l",
        "command": "-addCursorsAtSearchResults",
        "when": "fileMatchOrMatchFocus && searchViewletVisible"
      },
      {
        "key": "tab",
        "command": "selectNextQuickFix",
        "when": "editorFocus && quickFixWidgetVisible"
      },
      {
        "key": "shift+tab",
        "command": "selectPrevQuickFix",
        "when": "editorFocus && quickFixWidgetVisible"
      },
      {
        "key": "shift",
        "command": "selectNextSuggestion",
        "when": "editorTextFocus && suggestWidgetMultipleSuggestions && suggestWidgetVisible"
      },
      {
        "key": "shift+tab",
        "command": "selectPrevSuggestion",
        "when": "editorTextFocus && suggestWidgetMultipleSuggestions && suggestWidgetVisible"
      },
      {
        "key": "ctrl+p",
        "command": "-extension.vim_ctrl+p",
        "when": "editorTextFocus && vim.active && vim.use<C-p> && !inDebugRepl || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'CommandlineInProgress' || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'SearchInProgressMode'"
      },
      { "key": "ctrl+e", "command": "-workbench.action.quickOpen" }
    ] '';
  }; # end vscode
}