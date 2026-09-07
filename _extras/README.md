# `_extras/`

Everything here is **inert**. X-Plane never loads any of it, and no Lua on the
search path resolves into it. It is source art, reference documentation and
optional third-party add-on configs.

| Folder | What it holds |
|---|---|
| [`art/`](art/) | Photoshop sources for the drawn panel art — TAWS/TCAS/radar scales, digit strips, overhead and NVU textures, the palette and load panels. The exported `.png` that the plugin actually reads live in `plugins/tu-154/data/modules/images/`. |
| [`docs/`](docs/) | Documentation. `manuals/` — the shipped ENG/RUS tech manuals and limitations, plus `real_docs/` (the actual Tu-154M RLE and flight manual) and the Бехтир aerodynamics text. **Read [`manuals/real_docs/README.md`](docs/manuals/real_docs/README.md) before citing anything from `real_docs/`** — it maps the РЛЭ tables the powerplant code quotes to the files that hold them, and flags two engine PDFs whose filenames are wrong. `tutorials/` — navigation and quick-start walkthroughs, palette spreadsheet. Loose at the top: `tu154 rle_test absu.pdf`. |
| [`third_party/`](third_party/) | Optional integration configs for add-ons this aircraft supports but does not ship: RealityXP GNS, TDS GTN, X-Camera, X-RAAS, the Better-Pushback variant of `smartcopilot.cfg`, and the Tu-154 Crew installer. Copy the one you want to the aircraft root. Also holds `BBoxDecoder.zip` — the standalone decoder for `plugins/tu-154/data/output/black_box/*.bbox`; unzip it to use it. |
