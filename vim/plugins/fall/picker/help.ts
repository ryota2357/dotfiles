import type { Entrypoint } from "jsr:@vim-fall/custom@^0.1.0";
import * as builtin from "jsr:@vim-fall/std@^0.12.0/builtin";
import { helptag } from "../source/helptag.ts";

export const defineHelpPicker: Entrypoint = ({
  definePickerFromSource,
}) => {
  definePickerFromSource("help", helptag, {
    matchers: [builtin.matcher.fzf],
    renderers: [builtin.renderer.helptag],
    previewers: [builtin.previewer.helptag],
    actions: builtin.action.defaultHelpActions,
    defaultAction: "help",
    coordinator: builtin.coordinator.modern({
      widthRatio: 0.8,
      heightRatio: 0.8,
      previewRatio: 0.7,
    }),
  });
};
