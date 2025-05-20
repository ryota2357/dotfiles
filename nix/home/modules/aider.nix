{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aider-chat-full
  ];
  home.file.".aider.conf.yml".text = ''
    auto-commits: false
    dark-mode: true
  '';
}
