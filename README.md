# Tupolev Tu-154M for X-Plane 12

An implementation of the Tupolev Tu-154M for **X-Plane 12**.

Aircraft systems, avionics, and 2D popup panels are implemented as a **SASL3 (Lua)** plugin located in `plugins/tu-154/data/` and distributed with the aircraft.

## Overview

The project is organized by aircraft system. Each major system (electrical, fuel, powerplant, hydraulics, flight controls, anti-ice, navigation, autopilot, and others) is implemented as an independent Lua module. Modules do not call each other — they communicate through `tu-154/...` datarefs, which are also what the 3D cockpit animations, manipulators and SmartCopilot bind to.

The KLN 90B / MD41 GPS ships alongside it as a second, self-contained SASL3 plugin in `plugins/kln90b/`. It builds its own navigation database from X-Plane's nav data on first run; no extra download is needed.

## Requirements

* X-Plane 12

No additional dependencies are required. SASL3 is included with the aircraft.

## Installation

Copy the `TU-154M-CE` directory into your `X-Plane 12/Aircraft/` folder.

Or clone the repository directly:

```sh
cd "X-Plane 12/Aircraft/Tupolev"
git clone https://github.com/LincolnCFCruz/TU-154M-CE.git TU-154M-CE
```

Launch X-Plane 12 and select the Tupolev Tu-154M from the aircraft menu.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the development workflow and coding conventions.

For information about the project structure, datarefs, common modules, and instrument implementation, see [CLAUDE.md](CLAUDE.md).

## Credits

This aircraft is the work of many hands over many years.

**Felis** is the original author of the Tu-154M and laid the foundation for the project.

**Ivan** was one of the project's main contributors, making significant contributions to its development over the years.

**Evgeny** restored the aircraft for X-Plane 12.

**Ilya** and **Niko** continued development and evolution of the project.

This project also includes scripts from TU-154B2 project made by Silver.
[Unicode4all/Tu-154B2-CE](https://github.com/Unicode4all/Tu-154B2-CE).

This project also includes an adapted version of the KLN 90B GPS based on
[todirbg/kln90b](https://github.com/todirbg/kln90b).

## License

Licensed under the GNU General Public License v3.0. See [LICENSE](LICENSE) for details.
