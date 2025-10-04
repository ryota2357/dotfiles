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
  #   {
  #     "disableAutoUpdate": true,
  #     "preferredEditor": "vim",
  #     "sandbox": true,
  #     "selectedAuthType": "oauth-personal",
  #     "theme": "GitHub",
  #     "hasSeenIdeIntegrationNudge": true
  #   }
  # '';
}
