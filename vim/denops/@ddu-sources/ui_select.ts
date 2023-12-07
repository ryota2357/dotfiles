// 参考: matsui54/ddu-vim-ui-select (https://github.com/matsui54/ddu-vim-ui-select/blob/main/denops/%40ddu-sources/ui_select.ts)

import {
  BaseSource,
  type DduEvent,
  Item,
} from "https://deno.land/x/ddu_vim@v3.8.1/types.ts";
import type { Denops } from "https://deno.land/x/ddu_vim@v3.8.1/deps.ts";

type SelectItem = {
  index: number;
  raw: unknown;
  text: string;
};

type Params = {
  items?: SelectItem[];
};

export type ActionData = {
  item: SelectItem;
};

export class Source extends BaseSource<Params> {
  kind = "ui_select";

  override gather(args: {
    denops: Denops;
    sourceParams: Params;
  }): ReadableStream<Item<ActionData>[]> {
    return new ReadableStream({
      start(controller) {
        controller.enqueue(
          args.sourceParams.items?.map((item) => ({
            word: item.text,
            action: { item: item },
          })) ?? [],
        );
        controller.close();
      },
    });
  }

  override async onEvent(args: {
    denops: Denops;
    event: DduEvent;
  }): Promise<void> {
    if (args.event === "cancel") {
      await args.denops.call(
        "luaeval",
        "require('rc.ui.select').on_choice(nil, nil)",
      );
    }
  }

  params(): Params {
    return {};
  }
}
