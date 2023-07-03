// 参考: matsui54/ddu-vim-ui-select (https://github.com/matsui54/ddu-vim-ui-select/blob/main/denops/%40ddu-kinds/ui_select.ts)

import {
  ActionFlags,
  Actions,
  BaseKind,
  DduItem,
} from "https://deno.land/x/ddu_vim@v3.3.2/types.ts";
import { Denops } from "https://deno.land/x/ddu_vim@v3.3.2/deps.ts";
import { ActionData } from "../@ddu-sources/ui_select.ts";

type Params = Record<never, never>;

export class Kind extends BaseKind<Params> {
  actions: Actions<Params> = {
    select: async (args: { denops: Denops; items: DduItem[] }) => {
      const action = args.items[0]?.action as ActionData;
      await args.denops.call(
        "luaeval",
        "require('rc.ui.select').on_choice(_A.item, _A.index)",
        { item: action.item.raw, index: action.item.index },
      );
      return ActionFlags.None;
    },
  };

  params(): Params {
    return {};
  }
}
