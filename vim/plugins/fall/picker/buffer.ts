import type { Entrypoint } from "jsr:@vim-fall/custom@^0.1.0";
import * as builtin from "jsr:@vim-fall/std@^0.12.0/builtin";

export const defineBufferPicker: Entrypoint = ({
  definePickerFromSource,
}) => {
  // TODO: 名無しbufferが表示されないので、カスタムsourceとrefinerつくる
  definePickerFromSource("buffer", builtin.source.buffer, {
    matchers: [builtin.matcher.fzf],
    previewers: [builtin.previewer.buffer],
    actions: {
      ...builtin.action.defaultOpenActions,
      ...builtin.action.defaultBufferActions,
    },
    defaultAction: "open",
    coordinator: builtin.coordinator.modern({
      widthRatio: 0.8,
      heightRatio: 0.8,
      previewRatio: 0.7,
    }),
  });
};
