--[[
  main.lua -- SASL3 entry point for the Tupolev Tu-154M.

  The components table below is also the dataref-creation order and the
  per-frame update order (CLAUDE.md Hard Rule 7): modules bind datarefs an
  earlier module creates, and integrate the frame_time an earlier one writes.
--]]

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

-- the aircraft folder, under the name the modules build their paths from
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

math.randomseed(os.time())

-- ============================================================
-- Search paths: every system folder is registered, so a module is found by
-- name alone. addSearchPath() covers components and resources, so an image or
-- font next to a module is found too.
-- ============================================================
addSearchResourcesPath(moduleDirectory)            -- resolves sounds/*.wav
addSearchResourcesPath(moduleDirectory .. "/../components") -- vendored cursors.png

addSearchPath(moduleDirectory .. "/core")
addSearchPath(moduleDirectory .. "/components")
addSearchPath(moduleDirectory .. "/fonts")
addSearchPath(moduleDirectory .. "/images")
addSearchPath(moduleDirectory .. "/panels")

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

-- ============================================================
-- Component table
-- ============================================================
components = {

    -- internal logic
    dataref_creator_1 {}, -- main datarefs: controls and indications
    dataref_creator_2 {}, -- internal datarefs
    dataref_creator_3 {}, -- failures datarefs

    -- time_logic FIRST after the dataref creators: it writes
    -- tu-154/time/frame_time, and the components table is also the per-frame
    -- update order, so anything above it integrates the PREVIOUS frame's
    -- delta. save_state used to sit here and did exactly that.
    time_logic {},

    save_state {}, -- persists current state

    flap_aero {},

    -- the aircraft side of the KLN90B/MD41 GPS; the unit itself is the
    -- separate plugins/kln90b (CLAUDE.md section 10a)
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

    -- LAST: holds the looping samples while frame_time is 0, so it must come
    -- after every module that plays one
    sound_pause {},

}

-- Floating popups, after the table. They bind tu-154/xap/KLN90/visible, which
-- plugins/kln90b creates; the late-binding wrapper covers either load order.
panel_windows {}

-- Developer tool, not part of the aircraft: reads datarefs by name, writes
-- nothing, and can be commented out.
debug_inspector {}

-- ============================================================
-- Main update -- runs every frame
-- ============================================================
function update()
    updateAll(components)
    updatePanels()     -- popup windows <-> tu-154/panels/show_* datarefs
    updateTopBarMenu() -- the Plugins-menu checkboxes follow
end
