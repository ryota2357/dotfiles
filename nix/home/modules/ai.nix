{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # aider-chat-full
    gemini-cli
  ];
  home.file.".aider.conf.yml".text = ''
    auto-commits: false
    dark-mode: true
  '';
  # home.file.".gemini/settings.json".text = ''
  #   {
  #     "theme": "GitHub",
  #     "selectedAuthType": "oauth-personal",
  #     "sandbox": true
  #   }
  # '';
}
