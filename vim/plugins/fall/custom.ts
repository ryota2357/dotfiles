import type { Entrypoint } from "jsr:@vim-fall/custom@^0.1.0";
import * as builtin from "jsr:@vim-fall/std@^0.12.0/builtin";

import { defineBufferPicker } from "./picker/buffer.ts";
import { defineFilePicker } from "./picker/file.ts";
import { defineHelpPicker } from "./picker/help.ts";
import { defineLinePicker } from "./picker/line.ts";
import { defineRgPicker } from "./picker/rg.ts";

export const main: Entrypoint = (param) => {
  param.refineSetting({
    coordinator: builtin.coordinator.modern,
    theme: builtin.theme.MODERN_THEME,
  });

  defineFilePicker(param);
  defineLinePicker(param);
  defineRgPicker(param);
  defineHelpPicker(param);
  defineBufferPicker(param);
};
