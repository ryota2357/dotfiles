{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # aider-chat-full
    gemini-cli
    github-copilot-cli
  ];
  home.file.".aider.conf.yml".text = ''
    auto-commits: false
    dark-mode: true
  '';
  # home.file.".gemini/settings.json".text = ''
  # {
  #   "general": {
  #     "disableAutoUpdate": true,
  #     "preferredEditor": "vim"
  #   },
  #   "ide": {
  #     "hasSeenNudge": true
  #   },
  #   "tools": {
  #     "sandbox": true
  #   },
  #   "security": {
  #     "auth": {
  #       "selectedType": "oauth-personal"
  #     }
  #   },
  #   "ui": {
  #     "theme": "GitHub"
  #   }
  # }
  # '';
}
