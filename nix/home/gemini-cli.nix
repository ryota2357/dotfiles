{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  versionCheckHook,
  typescript,
}:

buildNpmPackage (finalAttrs: {
  pname = "gemini-cli";
  version = "0.1.7";

  src = fetchFromGitHub {
    owner = "google-gemini";
    repo = "gemini-cli";
    tag = "v${finalAttrs.version}";
    hash = "sha256-DAenod/w9BydYdYsOnuLj7kCQRcTnZ81tf4MhLUug6c=";
  };

  npmDepsHash = "sha256-otogkSsKJ5j1BY00y4SRhL9pm7CK9nmzVisvGCDIMlU=";

  nativeBuildInputs = [ typescript ];

  preConfigure = ''
    mkdir -p packages/generated
    echo "export const GIT_COMMIT_INFO = { commitHash: '${finalAttrs.src.rev}' };" > packages/generated/git-commit.ts
  '';

  fixupPhase = ''
    runHook preFixup
    find $out -type l -exec test ! -e {} \; -delete
    runHook postFixup
  '';

  # nativeInstallCheckInputs = [
  #   versionCheckHook
  # ];
  # doInstallCheck = true;
  # versionCheckProgram = "${placeholder "out"}/bin/gemini";
  # versionCheckProgramArg = "--version";

  meta = {
    description = "Open-source AI agent that brings the power of Gemini directly into your terminal";
    homepage = "https://github.com/google-gemini/gemini-cli";
    changelog = "https://github.com/google-gemini/gemini-cli/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [
      ryota2357
    ];
    mainProgram = "gemini";
  };
})
