---
name: pixelfixer
description: Use when the user asks to fix, repair, convert, grid-align, or recover native-resolution pixel art from blurry, AI-generated, upscaled, or fake pixel art. Runs the locally installed `pixelfixer` CLI.
---

# Pixel Art Fixer

Use the locally installed Pixel Art Fixer CLI to recover crisp, native-grid
pixel art from an image whose apparent pixels are enlarged, blurred, or
misaligned.

## Availability

The executable is installed at `~/.local/bin/pixelfixer` and is on `PATH` for
new zsh sessions. Verify it before use:

```sh
command -v pixelfixer
```

## Commands

Detect a source image's inferred native grid without modifying it:

```sh
pixelfixer full input.png
```

Use the quick, lower-confidence detector when turnaround matters:

```sh
pixelfixer fast input.png
```

Reconstruct a true-pixel image with the full detector:

```sh
pixelfixer process input.png output.png
```

Use the quicker reconstruction mode only when requested or appropriate:

```sh
pixelfixer process input.png output.png fast
```

`process` prints JSON containing the recovered `cols`, `rows`, grid-cell
steps, confidence path, and timings. Preserve it when it is useful for the
user's workflow.

## Output Handling

- Never overwrite the input unless the user explicitly requests it.
- PNG and JPEG inputs are supported. The input must be at least 16 px per side
  and no greater than four megapixels.
- Output is deliberately at native pixel resolution and can be very small.
  Preview or scale it only with nearest-neighbor interpolation.
- If grid inference reports a questionable consensus or the reconstruction
  looks wrong, inspect `pixelfixer full` output before trying alternatives.
- Use `recon` only when the user provides confirmed cell sizes and output
  dimensions:

```sh
pixelfixer recon input.png step_x step_y cols rows output.png
```

## Boundaries

This is a classical image-processing tool. It does not invent missing detail
or modify source calendars, application code, or unrelated image assets.
