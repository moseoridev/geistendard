#!/usr/bin/env bash
set -euo pipefail

NERD_FONTS_VERSION="${NERD_FONTS_VERSION:-3.4.0}"
FONTFORGE_BIN="${FONTFORGE_BIN:-fontforge}"
SOURCE_DIR="${SOURCE_DIR:-fonts/ttf}"
OUTPUT_DIR="${OUTPUT_DIR:-fonts/nerd-font}"

for command in "$FONTFORGE_BIN" curl unzip; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "Required command not found: $command" >&2
    exit 1
  fi
done

shopt -s nullglob
source_fonts=("$SOURCE_DIR"/*.ttf)
if (( ${#source_fonts[@]} == 0 )); then
  echo "No source TTF fonts found in $SOURCE_DIR" >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

patcher_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONTS_VERSION}/FontPatcher.zip"
echo "Downloading Nerd Fonts patcher v${NERD_FONTS_VERSION}..."
curl --fail --location --retry 3 "$patcher_url" --output "$tmp_dir/FontPatcher.zip"
unzip -q "$tmp_dir/FontPatcher.zip" -d "$tmp_dir/patcher"

mkdir -p "$OUTPUT_DIR"

for source_font in "${source_fonts[@]}"; do
  echo "Patching $source_font..."
  "$FONTFORGE_BIN" -script "$tmp_dir/patcher/font-patcher" \
    --complete \
    --single-width-glyphs \
    --careful \
    --quiet \
    --no-progressbars \
    --outputdir "$OUTPUT_DIR" \
    "$source_font"
done

echo "Nerd Font builds written to $OUTPUT_DIR"
