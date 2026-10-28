# T12 soldering station

A DIY T12 soldering station built around an STM32F103 Blue Pill and off-the-shelf modules, with one perfboard for the heater switch and thermocouple amplifier.

**Status:** work in progress. The design has not been validated as safe to build; review the schematic and perform staged hardware verification before use.

## Maintenance and licensing

This project is currently maintained solely by [@latudimas](https://github.com/latudimas). No additional maintainers are being appointed at this time. Please open an issue to discuss substantial changes before submitting a pull request.

The project is intended to be open source, but a license has not yet been selected. Public availability alone does not grant permission to reuse, modify, or redistribute the design; explicit licensing terms will be added separately.

## Layout

- `hardware/T12_Station/` — KiCad project, edited schematic, and custom symbol library. Open `T12_Station.kicad_pro` in KiCad.
- `hardware/T12_Station/.history/` — preserved KiCad local history; not the active design.
- `docs/schematic.pdf` — current schematic PDF, exported from the active `.kicad_sch` file.
- `docs/archive/T12_Station_schematic.previous.pdf` — original PDF retained for reference.
- `scripts/export-schematic.sh` — regenerate the current PDF with KiCad CLI.

Keep `T12.kicad_sym` and `sym-lib-table` beside the project: the library table uses a project-relative path.

## Export the schematic

Save your schematic edits in KiCad, then run:

```sh
./scripts/export-schematic.sh
```

The script finds `kicad-cli` on `PATH` or at the standard macOS KiCad application path. To use a different executable:

```sh
KICAD_CLI=/path/to/kicad-cli ./scripts/export-schematic.sh
```

The current PDF was generated using KiCad CLI 10.0.6. Exporting the PDF does not perform an electrical rules check.
