{ pkgs , ... } :

{
  programs.neovim =
  {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure.customRC = ( builtins.readFile ./nvim/vimrc );
    configure.packages.main = with pkgs.vimPlugins;
    {
      start = [ vim-nix ctrlp-vim ];
    };
  };
}
