import {
  BorderIndex as BI,
  DividerIndex as DI,
  type Theme,
} from "jsr:@vim-fall/std@^0.12.0/theme";
import type {
  Coordinator,
  Layout,
  Size,
  Style,
} from "jsr:@vim-fall/std@^0.12.0/coordinator";

const WIDTH_RATIO = 0.6;
const WIDTH_MIN = 10;
const WIDTH_MAX = 340;
const HEIGHT_RATIO = 0.8;
const HEIGHT_MIN = 5;
const HEIGHT_MAX = 70;
const PREVIEW_RATIO = 0.5;

export type HorizontalModernOptions = {
  /**
   * Ratio of the screen width to use for the coordinator.
   */
  widthRatio?: number;
  /**
   * Minimum width for the coordinator.
   */
  widthMin?: number;
  /**
   * Maximum width for the coordinator.
   */
  widthMax?: number;
  /**
   * Ratio of the screen height to use for the coordinator.
   */
  heightRatio?: number;
  /**
   * Minimum height for the coordinator.
   */
  heightMin?: number;
  /**
   * Maximum height for the coordinator.
   */
  heightMax?: number;
  /**
   * Ratio of width allocated for the preview component.
   */
  previewRatio?: number;
};

/**
 * Modern Coordinator.
 *
 * This coordinator is designed according to the author's preferences.
 * There is no space between the input and list components, but
 * the preview component is separated by a space.
 *
 * It looks like this (with MODERN_THEME):
 *
 * ```
 *                                Width
 *                 ╭──────────────────────────────────╮
 *              ╭─ ╭──────────────────────────────────╮ ─╮
 *              │  │                                  │  │
 *              │  │                                  │  │
 * previewHeight│  │                                  │  │
 *              │  │                                  │  │
 *              │  │                                  │  │
 *              ╰─ ╰──────────────────────────────────╯  │
 *              ╭─ ╭──────────────────────────────────╮  │Height
 * inputHeight  │  │                                  │  │
 *              ├─ ├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┤  │
 *              │  │                                  │  │
 *              │  │                                  │  │
 * listHeight   │  │                                  │  │
 *              │  │                                  │  │
 *              │  │                                  │  │
 *              ╰─ ╰──────────────────────────────────╯ ─╯
 * ```
 */
export function horizontalModern(
  options: HorizontalModernOptions = {},
): Coordinator {
  const {
    widthRatio = WIDTH_RATIO,
    widthMin = WIDTH_MIN,
    widthMax = WIDTH_MAX,
    heightRatio = HEIGHT_RATIO,
    heightMin = HEIGHT_MIN,
    heightMax = HEIGHT_MAX,
    previewRatio = PREVIEW_RATIO,
  } = options;

  /**
   * Computes the dimensions for the coordinator based on screen size.
   *
   * @param screen - The screen size to base the dimensions on.
   * @returns The calculated position and size for the coordinator.
   */
  const dimension = ({ width: screenWidth, height: screenHeight }: Size) => {
    const width = Math.min(
      widthMax,
      Math.max(widthMin, Math.floor(screenWidth * widthRatio)),
    );
    const height = Math.min(
      heightMax,
      Math.max(heightMin, Math.floor(screenHeight * heightRatio)),
    );
    const col = 1 + Math.floor((screenWidth - width) / 2);
    const row = 1 + Math.floor((screenHeight - height) / 2);
    return { col, row, width, height };
  };

  return {
    /**
     * Defines the border and divider styles for the components when preview is enabled.
     *
     * @param theme - The theme defining border and divider characters.
     * @returns The style configuration for input, list, and preview components.
     */
    style({ border, divider }: Theme): Style {
      return {
        input: [
          border[BI.TopLeft],
          border[BI.Top],
          border[BI.TopRight],
          border[BI.Right],
          "",
          "",
          "",
          border[BI.Left],
        ],
        list: [
          divider[DI.Left],
          divider[DI.Horizontal],
          divider[DI.Right],
          border[BI.Right],
          border[BI.BottomRight],
          border[BI.Bottom],
          border[BI.BottomLeft],
          border[BI.Left],
        ],
        preview: [
          border[BI.TopLeft],
          border[BI.Top],
          border[BI.TopRight],
          border[BI.Right],
          border[BI.BottomRight],
          border[BI.Bottom],
          border[BI.BottomLeft],
          border[BI.Left],
        ],
      } as const;
    },

    /**
     * Calculates the layout for the components including input, list, and preview.
     *
     * @param screen - The screen size for reference.
     * @returns The layout configuration for input, list, and preview components.
     */
    layout(screen: Size): Layout {
      const { col, row, width, height } = dimension(screen);
      const previewHeight = Math.max(0, Math.floor(height * previewRatio));
      const previewInnerHeight = previewHeight - 2;
      const inputHeight = 2;
      const inputInnerHeight = inputHeight - 1;
      const listHeight = height - inputHeight - previewHeight;
      const listInnerHeight = listHeight - 2;
      console.log({
        input: {
          col,
          row: row + previewHeight,
          width,
          height: inputInnerHeight,
        },
        list: {
          col,
          row: row + previewHeight + inputHeight,
          width,
          height: listInnerHeight,
        },
        preview: {
          col,
          row,
          width,
          height: previewInnerHeight,
        },
      });
      return {
        input: {
          col,
          row: row + previewHeight,
          width,
          height: inputInnerHeight,
        },
        list: {
          col,
          row: row + previewHeight + inputHeight,
          width,
          height: listInnerHeight,
        },
        preview: {
          col,
          row,
          width,
          height: previewInnerHeight,
        },
      } as const;
    },
  };
}
