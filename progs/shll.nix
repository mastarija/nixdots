{ pkgs , ... } :

{
  programs.zsh =
  {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.theme = "avit";
    syntaxHighlighting.enable = true;
  };
  users.defaultUserShell = pkgs.zsh;
}
