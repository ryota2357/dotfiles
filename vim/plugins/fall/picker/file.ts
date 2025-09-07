import type { Entrypoint } from "jsr:@vim-fall/custom@^0.1.0";
import { refineSource } from "jsr:@vim-fall/std@^0.12.0";
import * as builtin from "jsr:@vim-fall/std@^0.12.0/builtin";

const excludeDirectories = [
  ".cache",
  ".git",
  ".direnv",
  ".idea",
  "__pycache__",
  "node_modules",
  "target",
  "build",
  "cmake-build-debug",
  "cmake-build-release",
].map((p) => `/${p}`);

const excludeFile = [
  ".DS_Store",
  ".o",
  ".so",
];

export const defineFilePicker: Entrypoint = ({
  definePickerFromSource,
}) => {
  definePickerFromSource(
    "file",
    refineSource(
      builtin.source.file({
        filterDirectory(path) {
          for (const exclude of excludeDirectories) {
            if (path.endsWith(exclude)) {
              return false;
            }
          }
          return true;
        },
        filterFile(path) {
          for (const exclude of excludeFile) {
            if (path.endsWith(exclude)) {
              return false;
            }
          }
          return true;
        },
      }),
      builtin.refiner.relativePath,
    ),
    {
      matchers: [builtin.matcher.fzf],
      sorters: [],
      renderers: [builtin.renderer.nerdfont],
      actions: builtin.action.defaultOpenActions,
      defaultAction: "open",
      coordinator: builtin.coordinator.compact({
        widthRatio: 0.7,
        heightRatio: 0.85,
        hidePreview: true,
      }),
    },
  );
};
