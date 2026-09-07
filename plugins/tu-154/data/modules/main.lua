--[[

  File: main.lua
  -----
  Main project script -- SASL3 entry point for the Tupolev Tu-154M.

  This is the SASL3 port of the former "Custom Avionics/avionics.lua". The
  component assembly below is the SASL2 list, in the SAME ORDER: the order is
  also the dataref-creation order and the per-frame update order, and several
  modules bind datarefs that an earlier module creates.

  Changes vs. avionics.lua (all required by SASL3, nothing else):
    * SASL2's implicit panel setup replaced by the explicit render/search-path
      calls below (SASL2's C side hard-coded <aircraft>/Custom Avionics).
    * `fixedPanelWidth/Height` -> `panelWidth3d/panelHeight3d`.
    * The shared helper functions moved to core/glbl_func.lua and are published
      on _G (see the note in that file -- contextWindow children no longer
      inherit this component's environment).
    * `panels_2d {}` (a component that owned all subpanel{} popups) became
      panels/panel_windows.lua (contextWindows) + core/panel_logic.lua
      (updatePanels). It stays LAST, exactly where panels_2d {} was.
      It binds tu-154/xap/KLN90/visible, which the separate plugins/kln90b
      plugin creates; core/glbl_func.lua's late-binding wrapper covers the case
      where X-Plane loads that plugin after this one.
    * `panelDir` is now derived here instead of being injected by the SASL2
      plugin; the value is identical (the aircraft folder).

--]]

-- Project settings
size          = { 2048, 2048 }
panelWidth3d  = 2048
panelHeight3d = 2048
panel2d       = false
project       = "tu-154"
-- Dataref namespace. Every dataref this aircraft owns lives under this prefix,
-- the same way the sibling An-24RV-CE uses "an-24/" (see CLAUDE.md Hard Rule 1).
pfx           = project .. "/"

print("this is Tu154M v1.1.6 by Felis")
print("Lua version is", _VERSION)

-- ============================================================
-- Runtime paths
-- ============================================================
-- Aircraft root directory (strip plugins/tu-154/... suffix from moduleDirectory)
aircraftDirectory = (moduleDirectory:match("^(.+)[/\\]plugins[/\\]tu%-154") or moduleDirectory):gsub("[/\\]$", "")

-- SASL2 injected `panelDir` (= the aircraft folder) as a global. Several modules
-- build absolute file paths from it. Only KLNconfig.txt and airfoils/*.afl still
-- live at the aircraft root; the RSBN database, the saved state and the MSRP
-- recordings moved under pluginDataDir (rsbn_logic / save_state / msrp_logic).
panelDir = aircraftDirectory

-- Plugin data directory -- SASL writes its log and state under here
pluginDataDir = (moduleDirectory:match("^(.+)[/\\]modules") or moduleDirectory):gsub("[/\\]$", "")

-- ============================================================
-- SASL3 render settings
-- ============================================================
setAircraftPanelRendering(true)
setInteractivity(true)
set3DRendering(true)
setRenderingMode2D(SASL_RENDER_2D_MULTIPASS)
setPanelRenderingMode(SASL_RENDER_PANEL_DEFAULT)

math.randomseed(os.time()) -- randomise random :)

-- ============================================================
-- Search paths
--
-- SASL2's C side put <aircraft>/Custom Avionics on the search path and every
-- nested folder was reached through the component "subdir" mechanism. SASL3
-- keeps that same subdir mechanism (initFilesystemHelpers.openFile), but the
-- by-system folders are now siblings, so each one is registered explicitly.
--
-- Note: addSearchPath() adds to BOTH the component and the resource search
-- lists (as it did in SASL2), so images/fonts next to a module are still found.
-- ============================================================
addSearchResourcesPath(moduleDirectory)            -- resolves sounds/*.wav
addSearchResourcesPath(moduleDirectory .. "/../components") -- vendored cursors.png

addSearchPath(moduleDirectory .. "/core")
addSearchPath(moduleDirectory .. "/components")
addSearchPath(moduleDirectory .. "/fonts")
addSearchPath(moduleDirectory .. "/images")
addSearchPath(moduleDirectory .. "/panels")

-- Avionics -- by-system folders.
addSearchPath(moduleDirectory .. "/systems/aero")
addSearchPath(moduleDirectory .. "/systems/airframe")
addSearchPath(moduleDirectory .. "/systems/anti_ice")
addSearchPath(moduleDirectory .. "/systems/apu")
addSearchPath(moduleDirectory .. "/systems/audio")
addSearchPath(moduleDirectory .. "/systems/autopilot")
addSearchPath(moduleDirectory .. "/systems/brakes")
addSearchPath(moduleDirectory .. "/systems/cockpit")
addSearchPath(moduleDirectory .. "/systems/debug")
addSearchPath(moduleDirectory .. "/systems/electrical")
addSearchPath(moduleDirectory .. "/systems/fire")
addSearchPath(moduleDirectory .. "/systems/flight_ctrls")
addSearchPath(moduleDirectory .. "/systems/flight_instr")
addSearchPath(moduleDirectory .. "/systems/fuel")
addSearchPath(moduleDirectory .. "/systems/hydraulics")
addSearchPath(moduleDirectory .. "/systems/lights")
addSearchPath(moduleDirectory .. "/systems/navigation")
addSearchPath(moduleDirectory .. "/systems/pneumatics")
addSearchPath(moduleDirectory .. "/systems/powerplant")
addSearchPath(moduleDirectory .. "/systems/recorders")
addSearchPath(moduleDirectory .. "/systems/warnings")

-- ============================================================
-- Include foundational scripts
-- ============================================================
include "glbl_func.lua"
include "glbl_draw.lua"
include "panel_logic.lua"

print("Tupolev Tu-154M")
print("---------")

-- ============================================================
-- Component table
--
-- Identical to the SASL2 avionics.lua assembly, in the same order.
-- ============================================================
components = {

    -- internal logic
    --creator_script {}, -- script for converting custom DataRef file to creator code
    dataref_creator_1 {}, -- main datarefs. controls and indicatios
    dataref_creator_2 {}, -- internal datarefs
    dataref_creator_3 {}, -- failures datarefs

    -- time_logic FIRST after the dataref creators: it writes
    -- tu-154/time/frame_time, and the components table is also the per-frame
    -- update order, so anything above it integrates the PREVIOUS frame's
    -- delta. save_state used to sit here and did exactly that.
    time_logic {},

    save_state {}, -- safe current state

    flap_aero {},

    -- The KLN90B/MD41 GPS itself is a separate SASL3 plugin (plugins/kln90b);
    -- this is only the aircraft side of it. It replaced the in-tree KLN90
    -- module that used to be registered here with
    -- position = { 1018, 506, 1029, 329 } -- the plugin now draws the unit at
    -- that same panel rect. See CLAUDE.md section 10a.
    kln90b_logic {},

    -- gauges and systems
    main_panel { -- panel for simulated 2D gauges
        position = { 0, 0, 2048, 2048 },
    },
    overhead {},
    animation {},
    electric_system {},
    lights_system {},
    apu_system {},
    engines_system {},
    fuel_system {},
    hydro_system {},
    kskv {},
    start_system {},
    controls {},
    fire_system {},
    antiice {},
    msrp {},
    brake_system {},
    sounds {},

    -- LAST in the table: holds the looping samples while frame_time is 0.
    -- SASL3 does not stop its own audio when X-Plane pauses, so without this
    -- the engine and cabin loops are the only part of the aircraft still
    -- running on the pause screen. It observes what the frame produced, so it
    -- has to come after every module that plays a sound. The mechanism lives
    -- in core/glbl_func.lua; this is only the driver.
    sound_pause {},

}

-- Floating popups. Instantiated AFTER the components table -- panels_2d {} was
-- the last entry in avionics.lua. It binds tu-154/xap/KLN90/visible, which the
-- separate plugins/kln90b creates (the in-tree KLN90 {} that used to sit in the
-- table above is gone); glbl_func.lua's late-binding wrapper covers either
-- plugin load order.
panel_windows {}

-- Developer tool. Not part of the aircraft: it registers its own floating
-- window plus the bindable command Tu-154/Debug/inspector, reads state by
-- dataref name only and writes nothing. Comment out the line to drop it.
debug_inspector {}

print("---------")

-- ============================================================
-- Main update -- runs every frame
-- ============================================================
function update()
    updateAll(components)
    -- runs last, exactly where panels_2d {}'s update() sat in the SASL2 table
    updatePanels()
end
