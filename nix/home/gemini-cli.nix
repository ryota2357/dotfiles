{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  versionCheckHook,
  typescript,
}:

buildNpmPackage (finalAttrs: {
  pname = "gemini-cli";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "google-gemini";
    repo = "gemini-cli";
    rev = "01ff27709d7b62491bc2438fb8939da034c1c003";
    hash = "sha256-JgiK+8CtMrH5i4ohe+ipyYKogQCmUv5HTZgoKRNdnak=";
  };

  npmDepsHash = "sha256-yoUAOo8OwUWG0gyI5AdwfRFzSZvSCd3HYzzpJRvdbiM=";

  nativeBuildInputs = [ typescript ];

  fixupPhase = ''
    runHook preFixup
    find $out -type l -exec test ! -e {} \; -delete
    runHook postFixup
  '';

  nativeInstallCheckInputs = [
    versionCheckHook
  ];
  doInstallCheck = true;
  versionCheckProgram = "${placeholder "out"}/bin/gemini";
  versionCheckProgramArg = "--version";

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
