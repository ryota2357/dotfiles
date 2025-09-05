import * as opt from "jsr:@denops/std@^7.5.0/option";
import { defineSource, type Source } from "jsr:@vim-fall/std@^0.12.0/source";
import { expandGlob } from "jsr:@std/fs@^1.0.9/expand-glob";
import { join } from "jsr:@std/path@^1.1.2/join";

type Detail = {
  /**
   * The helptag identifier.
   */
  helptag: string;

  /**
   * The file where the helptag is located.
   */
  helpfile: string;

  /**
   * Optional language code for localized helptags.
   */
  lang?: string;
};

export function helptag(): Source<Detail> {
  return defineSource(async function* (denops, _params, { signal }) {
    const runtimepaths = (await opt.runtimepath.get(denops)).split(",");
    signal?.throwIfAborted();
    const seen = new Set<string>();
    let id = 0;
    let seenCount = 0;

    for (const runtimepath of runtimepaths) {
      for await (const helptag of discoverHelptags(runtimepath)) {
        signal?.throwIfAborted();
        const key = `${helptag.helptag}:${helptag.lang ?? ""}`;
        if (helptag.helptag == ":help") {
          console.log({ helptag, seenHas: seen.has(key) });
        }
        if (seen.has(key)) {
          seenCount++;
          continue;
        }
        yield {
          id: id++,
          value: key,
          detail: helptag,
        };
        seen.add(key);
      }
    }
  });
}

/**
 * Discovers helptags in the 'doc/tags' files within a given runtime path.
 *
 * This function reads helptag information from files in the `doc` directory
 * and handles both standard and localized tags files.
 *
 * @param runtimepath - The base path to search for helptag files.
 * @returns An async generator yielding helptag objects.
 */
async function* discoverHelptags(
  runtimepath: string,
): AsyncGenerator<Detail> {
  try {
    for await (
      const { path, name } of expandGlob(join(runtimepath, "doc", "tags*"), {
        includeDirs: false,
      })
    ) {
      const match = name.match(/^tags(-\w{2})?$/);
      if (!match) {
        continue;
      }
      console.log(path);
      const lang = match[1]?.slice(1); // slice(1) trims '-' of '-ja'
      const content = await Deno.readTextFile(path);
      for (const line of content.split("\n")) {
        if (line.startsWith("!_TAG_")) {
          continue;
        }
        const segments = line.split("\t", 3);
        if (segments.length < 3) {
          continue;
        }
        const [helptag, helpfile, _pattern] = segments;
        yield {
          helptag,
          helpfile,
          lang,
        };
      }
    }
  } catch (err) {
    if (isSilence(err)) return;
    throw err;
  }
}

/**
 * Determines if an error is a non-fatal, ignorable error.
 *
 * This includes errors like file not found, permission denied,
 * and filesystem loop errors, which are expected in some environments.
 *
 * @param err - The error to check.
 * @returns True if the error is ignorable, false otherwise.
 */
function isSilence(err: unknown): boolean {
  if (err instanceof Deno.errors.NotFound) {
    return true;
  }
  if (err instanceof Deno.errors.PermissionDenied) {
    return true;
  }
  if (err instanceof Deno.errors.FilesystemLoop) {
    return true;
  }
  if (err instanceof Error) {
    if (err.message.startsWith("File name too long (os error 63)")) {
      return true;
    }
  }
  return false;
}
