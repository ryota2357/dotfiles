import type { Entrypoint } from "jsr:@vim-fall/custom@^0.1.0";
import * as builtin from "jsr:@vim-fall/std@^0.12.0/builtin";
import * as extra from "jsr:@vim-fall/extra@^0.2.0";

import { horizontalModern } from "../coordinator/horizontal_modern.ts";

export const defineLinePicker: Entrypoint = ({
  definePickerFromSource,
}) => {
  definePickerFromSource("line", builtin.source.line, {
    matchers: [
      extra.matcher.kensaku,
      builtin.matcher.fzf,
    ],
    previewers: [builtin.previewer.buffer],
    actions: {
      ...builtin.action.defaultOpenActions,
      ...builtin.action.defaultQuickfixActions,
    },
    defaultAction: "open",
    coordinator: horizontalModern({
      widthRatio: 0.9,
      heightRatio: 0.9,
      previewRatio: 0.4,
    }),
  });
};
