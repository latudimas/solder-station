#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
CLI="${KICAD_CLI:-kicad-cli}"

if ! command -v "$CLI" >/dev/null 2>&1; then
    if [[ -z "${KICAD_CLI:-}" && -x /Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli ]]; then
        CLI=/Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli
    else
        printf 'KiCad CLI not found. Install KiCad or set KICAD_CLI to its executable path.\n' >&2
        exit 1
    fi
fi

mkdir -p "$ROOT/docs"
"$CLI" sch export pdf \
    --output "$ROOT/docs/schematic.pdf" \
    "$ROOT/hardware/T12_Station/T12_Station.kicad_sch"
