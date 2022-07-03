{ pkgs, ... }:

{
  config = {
    # Overlay neovim by neovim nightly
    nixpkgs.overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
      }))
    ];

    # Enable neovim
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      vimAlias = true;
      vimdiffAlias = true;

      withNodeJs = true;
      withPython3 = true;
      withRuby = false;

      extraConfig = "lua require('init_lua')";
    };

    # Copy my config files
    xdg.configFile = {
      "nvim/lua/rc" = { source = ./lua/rc; recursive = true; };
      "nvim/lua/init_lua.lua".source = ./init.lua;
      "nvim/ftplugin".source = ./ftplugin;
      "nvim/winresize.vim".source = ./winresize.vim;
    };

    # Enable programs required to run nvim with my config
    programs.lazygit.enable = true;
    programs.fzf.enable = true;
    home.packages = [
      pkgs.gcc
      pkgs.rustup
      pkgs.stylua
      pkgs.actionlint
      pkgs.shellcheck
      pkgs.ripgrep
      pkgs.fd
      pkgs.unzip
      pkgs.pkg-config
      pkgs.openssl
      pkgs.sqlite
      pkgs.ranger
    ];

    home.sessionVariables.LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.so";
  };
}
