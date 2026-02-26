{ pkgs, ... }:
{
  home.packages = with pkgs; [
    edge.claude-code-bin
    gemini-cli
    github-copilot-cli
  ];

  home.file = {
    ".claude/settings.json".source = ../../../coding-agent/claude-code/settings.json;
    ".claude/CLAUDE.md".source = ../../../coding-agent/AGENTS.md;

    ".gemini/settings.json".source = ../../../coding-agent/gemini-cli/settings.json;
    ".gemini/policies".source = ../../../coding-agent/gemini-cli/policies;
    ".gemini/GEMINI.md".source = ../../../coding-agent/AGENTS.md;

    ".copilot/copilot-instructions.md".source = ../../../coding-agent/AGENTS.md;
  };
}
