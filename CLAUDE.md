# Tu-154M SASL3 Architecture Guide

## 1. Purpose

This is the development guide for the **Tupolev Tu-154M Community Edition for X-Plane 12**.

All flight systems, avionics and 2D popups are implemented as a **SASL3 (Lua) plugin** in `plugins/tu-154/data/`.

This guide documents the plugin. The rest of the aircraft (`tu154.acf`,
`tu154_cockpit.obj`, `objects/`, `cockpit/`, `sounds/`, `liveries/`) is coupled
to the plugin **only** through datarefs — see **Hard Rule 1** and
*§10 Dataref & Command Contract*.

For onboarding see [`README.md`](README.md) and [`CONTRIBUTING.md`](CONTRIBUTING.md).

**If you change the architecture, conventions or test story documented here, update those files accordingly.**

## 2. Design Principles

- **Loose coupling through datarefs only.**
  Modules never call each other directly; they communicate **exclusively**
  through `tu-154/...` datarefs. This is why renaming a dataref silently breaks
  3D animations, manipulators and SmartCopilot sync (see **Hard Rule 1**).

- **Single owner per computed value.**
  Logic modules produce state; cockpit gauges and popup panels only display it.

- **Behaviour-preserving by default.**
  Any change to a *computed value* is a behaviour change (see **Hard Rule 2**).

- **Domain authenticity.**
  Russian instrument designations are kept verbatim in file and variable names
  (ПКП/pkp, АБСУ/absu, НВУ/nvu, ТКС/tks, ДИСС/diss, КСКВ/kskv, МСРП/msrp, …).

## 3. Hard Rules (non-negotiable)

1. **Datarefs are a frozen public contract.**
   Every dataref this aircraft owns lives under **`tu-154/`** — its own
   namespace, not Laminar's `sim/`, exactly as the sibling An-24RV-CE uses
   `an-24/`. `main.lua` defines the prefix as `pfx` (the creator files spell the
   names out in full).
   The bindings *outside* the plugin are what make a rename unrecoverable:
   `tu154_cockpit.obj` binds **586** distinct names, `objects/*.obj` **1357**,
   `tu154.acf` **239**, `tu154_clist.txt` **167**, and `smartcopilot.cfg`
   references **1127** distinct names across its entries. **Never rename a dataref.**

2. **Behaviour-preserving changes only** unless explicitly asked.

3. **Sources are UTF-8 without BOM, with LF line endings.**
   Enforced by [`.editorconfig`](.editorconfig), which is the authority.
   Comments and identifiers are English/ASCII; the only Cyrillic left is the
   **22 drawn string literals** in `systems/warnings/` (СРПБЗ callouts, screen
   captions, radar range labels), which must stay Cyrillic because they are what
   the panel displays. An editor that re-encodes on save double-encodes every one
   of them.

4. **Core helpers must not bind `tu-154/...` datarefs at include time.**
   `main.lua` includes `core/glbl_func.lua` and `core/glbl_draw.lua` *before* the
   components table runs `dataref_creator_1/2/3 {}`, which is what creates all
   2300 `tu-154/...` datarefs. Resolve such handles lazily on first use.

5. **Component order = draw / z-order.** When generating components in a loop,
   preserve the original order.

6. **Russian instrument names** (file and variable names) are **domain-authentic** — keep them.

7. **`components` in `main.lua` is also the creation order and the per-frame update order.**
   `dataref_creator_1/2/3` must stay first (everything else binds what they
   create); `time_logic {}` must stay first *after* them (it writes the frame
   clock everything else integrates); `sound_pause {}` must stay last inside the
   table (it observes what the frame played). `panel_windows {}` is instantiated
   immediately after the table — exactly where `panels_2d {}` sat historically.
   It binds `tu-154/xap/KLN90/visible`, which the separate `plugins/kln90b`
   creates; `core/glbl_func.lua`'s late-binding wrapper covers either plugin load
   order. `debug_inspector {}` follows it and is the only line in `main.lua` that
   can be commented out without consequence.

## 4. Repository Layout

```
TU-154M-CE/
├── tu154.acf, tu154_cockpit.obj, cockpit/, objects/, liveries/, sounds/
├── airfoils/, black_box/
├── smartcopilot.cfg, tu154_clist.txt
├── _extras/                    <- art sources, reference docs, third-party add-on
│                                  configs (never loaded by the sim; see
│                                  _extras/README.md). X-Camera_tu154.csv,
│                                  X-RAAS.cfg, RealityXP.GNS.ini and TDSGTN.ini
│                                  live in _extras/third_party/, not at the root
└── plugins/
    ├── kln90b/                 <- the KLN90B/MD41 GPS: a SEPARATE SASL3 project
    │                              (see §10a)
    └── tu-154/                 <- the SASL3 plugin
        ├── 64/{win,lin,mac}.xpl, liblinux/, License, version.txt, changelog.txt
        └── data/
            ├── api/  init/  components/     <- VENDORED SASL3 framework. Do not modify.
            ├── output/                      <- SASLLog.txt and runtime .ini (gitignored)
            └── modules/                     <- ALL custom aircraft code
                ├── main.lua                 <- plugin entry point
                ├── core/                    <- shared infrastructure on _G (9 .lua)
                ├── components/              <- project-owned widget library (29 .lua)
                ├── panels/panel_windows.lua <- all floating contextWindows
                ├── systems/<system>/        <- by-system modules
                ├── images/  fonts/  sounds/ <- assets
                ├── databases/               <- RSBN beacon data
```

Note the collision: `data/components/` (framework, do not touch) versus
`data/modules/components/` (ours, editable).

**System folders** and their module counts:

| Folder | .lua | Folder | .lua |
|---|---|---|---|
| `aero` | 1 | `fuel` | 7 |
| `airframe` | 4 | `hydraulics` | 4 |
| `anti_ice` | 4 | `lights` | 6 |
| `apu` | 5 | `navigation` | 30 |
| `audio` | 17 | `pneumatics` | 6 |
| `autopilot` | 12 | `powerplant` | 9 |
| `brakes` | 1 | `recorders` | 3 |
| `cockpit` | 22 | `warnings` | 28 |
| `debug` | 4 | `fire` | 3 |
| `electrical` | 10 | `flight_ctrls` | 8 |
| `flight_instr` | 17 | | |

Every one of those folders is on the search path (`main.lua`). There are no
nested component folders left in the tree.

## 5. Runtime Architecture

`modules/main.lua` is the entry point. It:

- Sets the project size (2048×2048 panel, `panel2d = false`), the SASL3 render
  options, and every `addSearchPath` directory.
- Derives `aircraftDirectory`, `panelDir` (kept for source compatibility — the
  SASL2 host injected it) and `pluginDataDir`.
- Includes `core/glbl_func.lua`, `core/glbl_draw.lua`, `core/panel_logic.lua`.
- Declares the `components = { … }` assembly table (**Hard Rule 7**).
- Instantiates `panel_windows {}` and then `debug_inspector {}` after that table.
- Runs `update()` each frame: `updateAll(components)` then `updatePanels()`.

### Search-path mechanics

SASL3 resolves a registration name to the **first `<name>.lua`** found across the
`addSearchPath` dirs, and additionally probes `<dir>/<name>/<name>.lua` — pushing
that subdirectory onto the search path while the component loads. The whole
nested layout relies on that subdir mechanism.

- **Moving** a file only needs a new `addSearchPath` entry — the registration
  name is unchanged.
- **Renaming** a file needs its registration updated everywhere it is instantiated.
- **Filenames must stay globally unique** across all search paths.

## 6. Module Roles

The Tu-154M tree predates any naming convention, so roles are read from the code,
not the filename:

- `*_logic.lua` — compute only (`defineProperty` + `update()`, no `components`).
- `*_panel.lua` — a system's clickable/indicator panel.
- `*_fails.lua` — that system's failure handling.
- `*_2d.lua` / `*_panel_2d.lua` — floating popup content, wired in `panels/panel_windows.lua`.
- Bare instrument names (`pkp`, `pnp`, `rmi`, `achs1`, `svs`, `tks`, …) —
  3D-panel gauges, aggregated by `systems/cockpit/main_panel.lua`.
- System aggregators (`electric_system`, `fuel_system`, `engines_system`, …) —
  thin files whose `components` table instantiates that system's parts. These are
  what `main.lua` registers.

## 7. Core Libraries (`modules/core/`)

Included by `main.lua` in this order (**Hard Rule 4**):

- **`glbl_func.lua`** — value helpers published on `_G`: `interpolate`, `sign`,
  `bool2int`, `line`, `isILS`; `lagCoef(dt, rate)` (a clamped first-order-lag
  coefficient — see *§7a Time base*); `holdToRepeat()` (click-repeat cadence for
  `onMouseHold`, driven by a real-time `sasl.createTimer()` so repeat still works
  while the sim is paused); the `playSample`/`stopSample` wrappers that track
  looping samples (`setSoundPaused`, `isSoundPaused`, `loopingSampleCount`); and
  the **late-binding `globalPropertyf/i/d/s` wrappers** that make a missing
  dataref read 0 instead of erroring — SmartCopilot, RealityXP, BetterPushback
  and a handful of inherited An-24 names depend on that.
- **`glbl_draw.lua`** — `texSize`, `drawTextureFill`, `drawScrollTape`,
  `drawRotatedScrollTape`, `drawNeedleTex`, `drawDigitStrip`. **This is where both
  SASL3 coordinate conventions are concentrated** — the component extent
  (`size[1]`/`size[2]`, never an implicit 100×100) and the texture-part source
  rect (pixels, bottom-left origin).
- **`panel_logic.lua`** — `drf_panels`, `cw_panels`, `updatePanels()`; the
  bidirectional sync between the `tu-154/panels/*` datarefs and the contextWindows.

Also in `core/` but not global infrastructure:

- `dataref_creator_1/2/3.lua` — the dataref registry: **2300** `createGlobalProperty*`
  calls (1460 controls/indications, 653 internal state, 187 failures). Registered
  as components, first in the table.
- `save_state.lua` — persists `saved_state.ini`.
- `functions.lua`, `nav_funcs.lua` — `include`-style helper files (they define into
  the *including* component's environment, not `_G`).

## 7a. Time base (`tu-154/time/frame_time`)

**One clock drives the whole aircraft.** `systems/cockpit/time_logic.lua` is the
only writer of `tu-154/time/frame_time`; **128** modules under `systems/` and
`core/` read it. It is created in `core/dataref_creator_1.lua` and is *internal* —
nothing in `objects/*.obj`, `tu154_cockpit.obj`, `tu154.acf`, `smartcopilot.cfg`
or `plugins/kln90b` binds it (each machine in a SmartCopilot session computes its
own; state is synced, deltas are not).

The contract, in both directions:

| | |
|---|---|
| **Units** | seconds of **sim** time since the previous frame |
| **Zero** | means *the simulation is not advancing*. Freeze: do not integrate, do not step a state machine, do not divide by it |
| **Ceiling** | clamped to `CLAMP` = 0.1 s. Below ~10 FPS the systems deliberately run slower than real time rather than take one huge step |
| **Source** | the delta of `sim/time/total_flight_time_sec`, which is the clock that tracks sim time — so **time acceleration is followed automatically**. `sim/operation/misc/frame_rate_period` covers the two frames where that delta is unusable (a flight reset, or float32 quantisation of an accumulating seconds counter very late in a long flight at a very high frame rate) |
| **Pause** | gated on `sim/time/paused`, authoritatively |

**Rules for consumers:**

1. **Never advance anything per frame.** Always multiply by `frame_time`.
   A bare per-frame coefficient makes the system four times faster at 120 FPS
   than at 30, and keeps it moving while the sim is paused.
2. **Guard every division** by `frame_time` (`if passed > 0 then …`). Most
   derivative terms in the tree already do; the РА-56 servos rely on a
   comparison that is false at zero, made explicit with `dt>0 and …`.
3. **First-order lags:** `x = x + (target - x) * lagCoef(dt, rate)`. With the
   0.1 s clamp, a bare `* dt * rate` reaches a coefficient of 1.0 at `rate` = 10,
   rings above that and **diverges** above 20. `lagCoef` is in
   `core/glbl_func.lua`; use it whenever `rate` > 10. Roughly twenty sites sit
   exactly at `rate` = 10 and are safe as written.
4. **Read it at the top of `update()`,** before any helper that integrates it.
5. **Do not time anything off `sim/time/total_running_time_sec`.** It does not
   stop for a pause. Accumulate `frame_time` into a module-local counter instead —
   `systems/powerplant/start_logic.lua` (`start_clock`),
   `systems/flight_instr/achs1.lua` and `systems/cockpit/UHUD.lua` (`run_clock`)
   are the worked examples. That dataref appears nowhere in the tree any more
   outside three explanatory comments, so a `grep` is enough to police this.
6. **Randomness is integration too.** A `math.random()` drawn every frame runs
   faster at a higher frame rate and keeps moving when `frame_time` is 0. Hold the
   sample on a fixed timebase (`noise()` in `systems/powerplant/engine_gauges.lua`),
   and express a per-frame probability as a per-second hazard
   (`math.random() < rate * frame_time`). An edge-triggered roll — one that fires
   on a state change — is fine as it is.
7. **Never substitute a fallback for a zero `frame_time`.** A `get_passed()`
   helper that swaps in `sim/operation/misc/frame_rate_period` when the value is 0
   opts the whole module out of the pause system — `frame_rate_period` keeps
   ticking on the pause screen. Guard on `nil` only, exactly as
   `systems/fuel/fuel_tanks.lua` documents, or return early as
   `systems/apu/apu_logic.lua` does.

**Do not raise `CLAMP`** without re-checking every `* frame_time * K` site: the
clamp is what keeps those filters stable.

**Load-time gates depend on this clock.** `core/save_state.lua` restores
`saved_state.ini` only after `start_counter > 2`, and 25 modules run a one-shot
reset of their switches behind a `notLoaded` flag that is cleared *inside* the
reset (ten of them gated on `sim_start_timer > 0.3`). If the clock ever stalls,
the saved state is never restored and those resets are merely deferred — they will
overwrite whatever the user has clicked in the meantime.

**Audio follows the same rule.** SASL3 does not stop its own samples when X-Plane
pauses, so `core/glbl_func.lua` wraps `playSample`/`stopSample` to track which
samples are **looping**, and `systems/audio/sound_pause.lua` — last in the
`main.lua` table — holds them whenever `frame_time` is 0. Only loops are held (the
engines, cabin ambience, inverters, air conditioning, sirens, speaker, taxi and
light noise, vents, GPU); the one-shots still play, so a switch clicked on the
pause screen still clicks. The wrappers are in `glbl_func.lua` rather than in a
module because they must be installed before any component body runs — several
call `playSample` at load time.

The debug inspector's **Fail** tab shows `frame_time` next to `sim/time/paused`,
`sim/time/sim_speed`, `sim/time/sim_speed_actual` and
`sim/operation/misc/frame_rate_period`, so a disagreement is visible in-sim.

## 8. Component Library (`modules/components/`)

The project owns its widget vocabulary. **This is not the vendored framework directory.**

`texture` / `textureLit` / `texture_ctr`, `free_texture` / `free_texture_lit` /
`freeTexture`, `switch` / `switch_lit`, `button`, `clickable`, `lamp`, `lever` /
`lever_hor`, `rotary`, `needle` / `needleLit`, `tape` / `tape_lit`,
`rotated_tape` / `rotated_tapeLit` / `rotatedTape`, `digitstape` /
`digitstapeLit` / `digitstapeSmoothLit`, `rectangle` / `rectangle_ctr`, `text` /
`text_draw`, `frame`.

Two structural facts:

- **Every drawing widget delegates to a `glbl_draw` helper.** Change a helper and
  every widget using it changes. This is deliberate: it keeps the two SASL3
  coordinate conversions in one reviewed place.
- **Widgets that draw the component's own extent use `size[1]`/`size[2]`.**
  Widgets whose *caller* supplies coordinates (`free_texture*`, `rectangle_ctr`)
  draw in the parent's pixel space and take those numbers verbatim.

## 9. Panel System

Floating popups are `contextWindow`s. There are twelve:

- Ten content panels declared by the table in
  [`panels/panel_windows.lua`](plugins/tu-154/data/modules/panels/panel_windows.lua):
  palette, payload, absu, ovhd, nvu, checklist, ground, uphone, camera, fails.
  Each is keyed into `cw_panels` and paired with its `tu-154/panels/show_*`
  dataref in `drf_panels`.
- One merged **menu strip** window (`tu154_menu`), 160×160 and undecorated,
  holding all six former menu subpanels at their original screen offsets.
  SASL3/XP12 floating windows have a 100×100 minimum and the strips are
  31×30…121×31, so they could not stay separate windows.
- One **debug inspector** window (`debug_inspector`, `systems/debug/`), a
  developer tool that is deliberately *not* in `cw_panels`/`drf_panels` and owns
  no `tu-154/panels/show_*` dataref: it is toggled by the bindable command its
  `contextWindow` declares, and remembers its geometry through `saveState`. See §12.

The KLN90B's own windows are **not** in this list — they belong to the separate
`plugins/kln90b` project, which runs the same bidirectional sync against
`tu-154/xap/KLN90/visible`, `.../KLN90pop/visible` and `.../MD41/visible` in its
own `main.lua`.

`updatePanels()` is a **bidirectional** sync with a `last_state` tiebreak: a
dataref change (menu button, 3D hotspot) moves the window; a window change
(X-Plane's own close button) writes the dataref. On the first frame the window
state wins.

## 10. Dataref & Command Contract

**Datarefs** — **2300** created, all under `tu-154/`, all in
`core/dataref_creator_1/2/3.lua`. No other module in the tree calls
`createGlobalProperty*`. Largest namespaces:

| Namespace | n | Namespace | n | Namespace | n |
|---|---|---|---|---|---|
| `lights` | 445 | `anim` | 85 | `radio` | 24 |
| `switchers` | 350 | `absu` | 46 | `fire` | 24 |
| `gauges` | 277 | `controlls` | 37 | `checklist` | 23 |
| `failures` | 239 | `fuel` | 31 | `xap` | 19 |
| `buttons` | 127 | `rotary` | 28 | `tks` | 18 |
| `nvu` | 111 | `payload` | 28 | `eng` | 16 |
| `elec` | 104 | `SC` | 27 | `antiice` | 16 |

**Third-party namespaces are left alone:** `scp/api/*` (SmartCopilot), `RXP/*`
(RealityXP GNS), `bp/*` (BetterPushback), and `custom/KLN90/*` + `custom/MD41/*`,
which belong to the vendored KLN90B and carry the same names there as in the An-24.

**Every `tu-154/` name a module binds is created.** A block at the end of
`dataref_creator_1.lua` holds the handles that modules bind but nothing writes yet
(`tu-154/t154/ppn13_*`, `tu-154/fuel/pump_*_work`, `tu-154/other/pedal_*`,
`tu-154/engine/hotstart_*`, `tu-154/engines/knd_*`, `tu-154/eng/apu_*`,
`tu-154/b2/elev_trimm_*_pk`, `tu-154/xap/An24_gauges/mrp_cc`). They sit at 0, but
they are real handles rather than wrapper reads, so they show up in DataRefTool and
can be wired later.

**What still reads 0 through the late-binding wrapper is third-party only** — the
three namespaces above, plus the optional-GNS reads. All **674** distinct `sim/`
names the plugin binds exist in XP12; the four that did not
(`sim/aircraft/overflow/acf_has_APU_switch`, `sim/aircraft/view/acf_has_press_controls`,
`sim/multiplayer/position/plane20_*`, and the `sim/GPS/g430n1_power_up`/`_dn`
commands) were removed or repointed and now survive only as comments explaining why.

**Commands** — the plugin creates exactly one, `Tu-154/Debug/inspector`, and only
indirectly: `systems/debug/debug_inspector.lua` passes `command = ...` to its
`contextWindow`, and `init/initContextWindows.lua` auto-creates a command whose
handler toggles that window. Nothing in the aircraft systems creates a command
(`systems/lights/light_commands.lua` has a `findCommand(name) or createCommand(name, 0)`
fallback, but every name it passes is a stock one that exists).

Otherwise the plugin uses `findCommand` + `registerCommandHandler` to intercept
**77** distinct stock X-Plane commands: `sim/flight_controls/*` (22),
`sim/autopilot/*` (22), `sim/GPS/*` (21), `sim/engines/*` (4), `sim/starters/*` (3),
`sim/lights/*` (3), `sim/transponder/*` (2), plus one each under `sim/view/` and
`sim/operation/`. A joystick binding to a stock command therefore runs Tu-154
logic, not X-Plane's.

The 27 `custom/KLN90/*` commands (unit buttons, knobs, window toggles) belong to
`plugins/kln90b`.

## 10a. KLN90B integration

The KLN90B/MD41 GPS is **not** part of this plugin. It is its own SASL3 project in
`plugins/kln90b/` — the build the sibling An-24RV-CE ships (v0.99.2b), with a
Tu-154 integration layer (`systems/navigation/kln90b_logic.lua`). Everything
crosses that boundary as datarefs; the two projects never see each other's Lua.

| Dataref | Direction | Owner |
|---|---|---|
| `tu-154/kln90/power_available` | aircraft → GPS | created by kln90b, written by `systems/navigation/kln90b_logic.lua` |
| `tu-154/kln90/primary` | aircraft → GPS | as above; 1 while `tu-154/anim/show_gns` == 0 |
| `tu-154/kln90/initialized` | GPS → aircraft | handshake, "the plugin is running" |
| `tu-154/kln90/kln_course` / `kln_dev` / `kln_flag` | GPS → aircraft | created here (`dataref_creator_2`), written by kln90b; read by `pnp` and `absu_controls` |
| `tu-154/xap/KLN90/MSG` / `WPT` | GPS → aircraft | created by kln90b; read by `systems/warnings/misc_lamps.lua` |
| `tu-154/switchers/kln_power_knob` / `kln_knob_out` | GPS → aircraft | created here; written by kln90b; bound by `objects/*.obj` |
| `tu-154/xap/KLN90/visible` / `KLN90pop/visible` / `MD41/visible` | both | created by kln90b; the menu strip in `panels/panel_windows.lua` toggles the first |

**Load order does not matter.** Whichever plugin X-Plane starts first, the other
side resolves late: the aircraft through `core/glbl_func.lua`'s late-binding
wrapper, the GPS through the retry in its own `tu154_bind()`. If `plugins/kln90b`
is removed or disabled, the aircraft simply reads zeros and the ПНП shows its KLN
flag.

The GPS draws itself onto **this** aircraft's panel texture at
`{1018, 506, 1029, 329}` — the rect the retired in-tree module used — via the
`KLN90_bezel` and `KLN90_screen` components in its `Custom Module/`.

## 11. Runtime Paths & Persisted State

`main.lua` exports:

- `aircraftDirectory` — the aircraft root (the repo root).
- `panelDir` — same value; kept because the SASL2 host injected this name and
  ~20 call sites build absolute paths from it.
- `pluginDataDir` — `plugins/tu-154/data`.

| File | Written by |
|---|---|
| `plugins/tu-154/data/output/saved_state.ini` | `core/save_state.lua` |
| `KLNconfig.txt` (aircraft root) | `plugins/kln90b/.../Custom Module/KLN90_panel.lua` |
| `plugins/tu-154/data/output/black_box/*.bbox` | `systems/recorders/msrp_logic.lua` |
| `plugins/tu-154/data/modules/state.txt` | SASL3 (window geometry) |
| `plugins/tu-154/data/output/SASLLog.txt` | SASL3 |
| `<X-Plane 12>/Custom Data/KLN90B_Navdata/*.txt` | `plugins/kln90b` (see below) |
| `<X-Plane 12>/Output/FMS plans/KLN 90B/*.fms` | `plugins/kln90b` |

Read-only data: the RSBN beacon databases at `modules/databases/rsbn.dat`
(`cis.dat` beside it is the same beacons under post-Soviet names, and is
unreferenced — the An-24RV-CE switches between the pair, this aircraft never had
that control); `airfoils/*.afl` at the aircraft root.

**The KLN90B builds its own navigation database — it is not a download.** On
first run `plugins/kln90b/.../Custom Module/KLN90_panel.lua` checks
`Custom Data/KLN90B_Navdata/` for `airports.txt`, `navaids.txt` and
`waypoints.txt`; if any is missing it parses X-Plane's own nav data
(`Global Scenery/Global Airports/Earth nav data/apt.dat`, every add-on scenery
`apt.dat`/`earth_nav.dat` it finds, and `earth_nav.dat` / `earth_fix.dat` from
`Custom Data/` when present, otherwise `Resources/default data/`) and writes the
three files itself. It also creates `Output/FMS plans/KLN 90B/` for its flight
plans. **Both paths are relative to the X-Plane root, not the aircraft**, and
neither is part of this repository — regenerating the database is how the GPS
picks up a new AIRAC cycle.

## 12. Testing & Debugging

There is no automated test suite that runs inside the sim. Verification is in-sim:

1. **Load the aircraft in X-Plane 12** and watch
   `plugins/tu-154/data/output/SASLLog.txt` for new `WARN` / `STACK` / `nil value`
   entries. A clean load is the baseline — compare against it, do not read the log
   cold.
2. **Exercise the system you touched**, both from the 3D cockpit and from its
   popup panel, and confirm the 3D animation follows (that is the dataref contract
   working end to end).
3. **The debug inspector** (`systems/debug/debug_inspector.lua` +
   `debug_inspector_view.lua`) is a tabbed live read-out of ~900 datarefs across
   **18** system tabs, drawn as gauges / bars / lamps / mode chips. Bind a key to
   `Tu-154/Debug/inspector` to toggle it. It reads state by dataref *name* only
   through a memoised `globalProperty()` cache, never `include()`s a systems
   module and never `set()`s anything, so it can be commented out of `main.lua`
   without touching the aircraft. Adding a reading means adding one row to the
   `schema` table in the view.
4. **After touching anything that integrates `frame_time`, pause the sim and
   watch.** With `sim/time/paused` set, nothing may drift: no needle creep, no
   state machine stepping, no timer counting, and the looping samples must go
   quiet. The inspector's **Fail** tab puts `frame_time` next to `sim/time/paused`
   and the sim-speed datarefs, which is the fastest way to spot a module that has
   opted itself out of the pause system (see *§7a Time base*, rules 1 and 7).
5. **Check time acceleration too.** At 2×/4× the systems must speed up with the
   sim, because `frame_time` is derived from sim time, not wall-clock time.

## 13. Instrument Glossary

| Module | Instrument |
|---|---|
| `pkp` | ПКП — attitude director indicator |
| `pnp` | ПНП — horizontal situation indicator |
| `agr` / `mgv` | АГР / МГВ — standby horizon, vertical gyro |
| `bkk` | БКК — bank/attitude monitoring unit |
| `rmi` | RMI bearing pointer |
| `achs1` / `clock24` | АЧС-1 / 24 h clock |
| `eup53` | ЭУП-53 — turn and slip |
| `uap14` | УАП-14 — AoA / g (АУАСП) |
| `usvp` | УСВП |
| `svs` | СВС — air data computer |
| `mach_meters` / `mech_aneroid` | Machmeters / mechanical aneroid instruments |
| `uvid_15fk` | УВИД-15ФК — feet altimeter |
| `vbe_altimeter` | electronic altimeter |
| `rv5` | РВ-5 — radio altimeter |
| `termo` | thermometers |
| `absu*` / `ra56_*` | АБСУ-154 autopilot + РА-56 servos |
| `nvu*` | НВУ — navigation computer |
| `rsbn*` | РСБН — short-range radio navigation |
| `tks` / `bgmk` / `km5` / `ush3` | ТКС-П2 heading system |
| `diss*` | ДИСС — doppler |
| `ark15` | АРК-15 — ADF |
| `course_mp` | Курс-МП — VOR/ILS |
| `dme` / `mrp` / `spu` / `vhf` | DME / marker / intercom / VHF |
| `radar` | weather radar |
| `taws*` / `tcas*` | TAWS / TCAS |
| `msrp*` | МСРП — flight data recorder |
| `kskv*` | КСКВ — air conditioning / pressurisation |
| `so72_panel` | СО-72 transponder |

## 14. Common Development Tasks

### Adding an instrument
1. Put the file in its `systems/<system>/` folder (add an `addSearchPath` line in
   `main.lua` if the folder is new).
2. Instantiate it from that system's aggregator, or from
   `systems/cockpit/main_panel.lua` for a 3D-panel gauge.
3. Draw with `size[1]`/`size[2]`, never a literal 100 — see *§8 Component Library*.

### Adding a dataref
1. Name it under `tu-154/`, in an existing namespace where one fits. Never under
   `sim/` — that is Laminar's.
2. Declare it in `core/dataref_creator_1.lua` (controls/indications), `_2`
   (internal) or `_3` (failures).
3. Bind it with `globalPropertyf/i/...` in the modules that use it.
4. **Never rename** an existing dataref (**Hard Rule 1**).

### Adding a floating panel
1. Write the content module as `*_2d.lua` in its system folder.
2. Add a `tu-154/panels/show_*` dataref in `dataref_creator_2.lua`.
3. Add an entry to the `panels` table and a `content` constructor in
   `panels/panel_windows.lua`.
4. Remember the 100×100 minimum window size.

### Adding a clickable control
Use `clickable` / `switch_lit` / `button` with `onMouseDown`. If the control should
repeat while held, add `onMouseHold = holdToRepeat()` (or `holdToRepeat(stepFn)`) —
see *§7 Core Libraries*.

### SASL3 API traps

Each of these fails silently or at load time, and each has bitten this project:

- **Array datarefs:** use the **untyped** `globalProperty("name[0]")`. The typed
  `globalPropertyf/i/d/s` pass the string to `sasl.findDataRef` verbatim and
  `name[0]` is not a dataref — you get nil and the value silently reads 0. A
  scalar accessor on an array dataref fails the same way.
- **`playSample(id, isLooping)`** takes a **boolean**, not 0/1.
- **`set(prop, value)`** needs the value; `set(prop)` is a runtime error.
- **Never `createGlobalProperty*` under `sim/`** — SASL3 refuses it. Use `tu-154/`.
- A function that reads a module-level `local` must be defined **after** it, or the
  name resolves as a global and SASL tries to load it as a component.
