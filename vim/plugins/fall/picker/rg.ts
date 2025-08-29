import type { Entrypoint } from "jsr:@vim-fall/custom@^0.1.0";
import { refineCurator } from "jsr:@vim-fall/std@^0.12.0";
import * as builtin from "jsr:@vim-fall/std@^0.12.0/builtin";

export const defineRgPicker: Entrypoint = ({
  definePickerFromCurator,
}) => {
  definePickerFromCurator(
    "rg",
    refineCurator(
      builtin.curator.grep,
      builtin.refiner.relativePath,
    ),
    {
      sorters: [],
      renderers: [],
      previewers: [builtin.previewer.file],
      actions: {
        ...builtin.action.defaultOpenActions,
        ...builtin.action.defaultQuickfixActions,
      },
      defaultAction: "open",
      coordinator: builtin.coordinator.modern({
        widthRatio: 0.9,
        heightRatio: 0.9,
      }),
    },
  );
};
