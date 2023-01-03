import { BaseSource, Item } from "https://deno.land/x/ddu_vim@v2.0.0/types.ts";
import { Denops } from "https://deno.land/x/ddu_vim@v2.0.0/deps.ts";

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

  gather(args: {
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

  params(): Params {
    return {};
  }
}
