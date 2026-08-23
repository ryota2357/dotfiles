{ pkgs, ... }:
let
  llm-agents = pkgs.llm-agents;
in
{
  home.packages = [
    llm-agents.claude-code
    llm-agents.antigravity-cli
    (pkgs.writeShellApplication {
      name = "copilot";
      runtimeInputs = [
        pkgs.bashInteractive # https://github.com/github/copilot-cli/issues/731
        llm-agents.copilot-cli
      ];
      text = ''
        BASH_PATH="$(which bash)"
        export SHELL="$BASH_PATH"
        exec copilot "$@"
      '';
    })
  ];

  home.file = {
    ".claude/settings.json".source = ../../../coding-agent/claude-code/settings.json;
    ".claude/CLAUDE.md".source = ../../../coding-agent/AGENTS.md;
    ".claude/skills".source = ../../../coding-agent/skills;

    ".gemini/antigravity-cli/settings.json" = {
      source = ../../../coding-agent/antigravity-cli/settings.json;
      force = true; # 元を削除してまでして trustedWorkspaces を書き込んでくるので
    };
    ".gemini/GEMINI.md".source = ../../../coding-agent/AGENTS.md;
    ".gemini/antigravity-cli/skills".source = ../../../coding-agent/skills;

    ".copilot/copilot-instructions.md".source = ../../../coding-agent/AGENTS.md;
    ".agents/skills".source = ../../../coding-agent/skills;
  };
}
