# Project instructions

## Goal and scope

Build a DIY T12 soldering station using an STM32F103 Blue Pill, off-the-shelf modules, and **one perfboard for the heater switch and thermocouple amplifier**.

- Favor practical, inexpensive, readily available parts and wiring that can be assembled and debugged by hand.
- Keep the modular architecture. Do not turn this into a custom-PCB project or replace the controller without explicit approval.
- Treat the schematic as a design in progress, not a verified or safe-to-build reference.
- Distinguish confirmed design facts from proposed changes and assumptions. Ask before making major architectural, power-stage, or pin-assignment changes.

## Repository map and source of truth

- `hardware/T12_Station/T12_Station.kicad_pro` — active KiCad project.
- `hardware/T12_Station/T12_Station.kicad_sch` — authoritative schematic source.
- `hardware/T12_Station/T12.kicad_sym` — project-specific symbols.
- `hardware/T12_Station/sym-lib-table` — project-relative symbol library registration.
- `hardware/T12_Station/.history/` — KiCad automatic snapshots, not active design files. Preserve them; do not edit them or use them as the current design.
- `docs/schematic.pdf` — generated view of the active schematic, not an editable source.
- `docs/archive/` — historical reference exports; do not overwrite them as part of normal regeneration.
- `scripts/export-schematic.sh` — PDF export entry point.

Keep custom symbol paths portable using `${KIPRJMOD}`. Do not introduce machine-specific absolute library paths. Keep local preferences, lock files, and automatic backups out of version control.

## Working on the hardware design

1. Inspect the active schematic and relevant custom symbols before proposing or making changes.
2. Preserve unrelated work, reference designators, net names, and component identifiers wherever possible. Avoid broad reformatting of KiCad files.
3. Check connections electrically, not just visually: crossing wires, junctions, labels, pin numbers, and symbol pin types matter.
4. Verify component and module pinouts against documentation for the actual parts. Generic module names and seller diagrams are not sufficient proof of compatibility.
5. Record important assumptions, component substitutions, calculations, and unresolved questions in project documentation. Do not silently select safety-critical values.
6. Keep the schematic, wiring guidance, BOM, and firmware pin assignments consistent when those artifacts exist. Do not invent missing firmware or build procedures.

## Electrical and thermal safety

This project switches heater power and measures a small thermocouple signal. Errors can damage the electronics or cause uncontrolled heating.

- Keep mains wiring outside the DIY control/perfboard design. Prefer an appropriately rated, isolated, enclosed DC supply; do not add mains circuitry without explicit discussion.
- Verify heater supply voltage, current, power, connector ratings, wire gauge, fusing, and switch dissipation against the actual cartridge and supply.
- Check MOSFET polarity, gate-drive voltage, gate-source limits, default-off biasing, and behavior during MCU reset, boot, disconnection, or loss of logic power.
- Respect STM32 ADC input limits and the actual Blue Pill board's logic and power constraints. Do not assume all pins are 5 V tolerant or all boards have identical regulators and pinouts.
- Verify the T12 cartridge's shared heater/sensing arrangement and the timing needed to measure the thermocouple with heater drive off. Account for switching transients and analog settling rather than assuming continuous readings are valid.
- Check amplifier supply range, input common-mode range, offset, gain, output swing, filtering, input protection, and ADC scaling.
- Plan perfboard placement and return paths so high-current heater switching does not corrupt the low-level thermocouple signal. Document grounding, decoupling, and routing requirements that the schematic alone cannot express.
- For firmware work, require heater-off startup and fault states, bounded output, sensor-fault detection, and overtemperature handling. Do not describe software protections as a substitute for independent hardware protection.
- Recommend staged, current-limited bring-up and measurement before connecting or energizing the heater. Never claim the design is safe or tested without supporting checks and hardware results.

## Validation and generated files

After schematic edits:

1. Check that KiCad can load the active schematic and resolve project symbols.
2. Run KiCad electrical rules checking when available. Review and report warnings; do not silence checks merely to obtain a clean report.
3. Regenerate the PDF from the saved schematic:

   ```sh
   ./scripts/export-schematic.sh
   ```

   The script supports `kicad-cli` on `PATH`, the standard macOS installation, or an explicit override:

   ```sh
   KICAD_CLI=/path/to/kicad-cli ./scripts/export-schematic.sh
   ```

4. Inspect the exported PDF for missing symbols, clipped content, and unreadable labels when a PDF viewer or rendering tool is available.
5. Report what was checked, tool failures or warnings, and anything that still requires bench verification.

Successful PDF export is not an electrical rules check, simulation, or hardware validation. If KiCad or another required tool is unavailable, say so rather than claiming validation occurred.

## Communication

Keep changes focused and explain their electrical purpose. Summarize modified files, validation performed, and unresolved risks. For design recommendations, include relevant calculations or source references and distinguish measured results from estimates.
