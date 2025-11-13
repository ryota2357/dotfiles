{ pkgs, ... }:
let
  jsonFormat = pkgs.formats.json { };
in
{
  home.packages = with pkgs; [
    gemini-cli
    github-copilot-cli
  ];
  home.file.".gemini/settings.json".source = jsonFormat.generate "gemini-settings" {
    general = {
      disableAutoUpdate = true;
      preferredEditor = "vim";
    };
    ide.hasSeenNudge = true;
    tools.sandbox = true;
    security.auth.selectedType = "oauth-personal";
    ui.theme = "GitHub";
  };
}
