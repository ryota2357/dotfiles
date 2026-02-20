{ pkgs, ... }:
{
  home.packages = with pkgs; [
    claude-code-bin
    gemini-cli
    github-copilot-cli
  ];

  home.file = {
    ".claude/settings.json".source = ../../../coding-agent/claude-code/settings.json;
    ".claude/CLAUDE.md".source = ../../../coding-agent/AGENTS.md;

    ".gemini/settings.json".source = ../../../coding-agent/gemini-cli/settings.json;
    ".gemini/AGENTS.md".source = ../../../coding-agent/AGENTS.md;

    ".copilot/copilot-instructions.md".source = ../../../coding-agent/AGENTS.md;
  };
}
