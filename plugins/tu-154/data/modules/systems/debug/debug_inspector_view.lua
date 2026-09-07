--[[

  File: debug_inspector_view.lua
  -----
  Tu-154M System Viewer / Debug Inspector -- the tabbed UI component.

  Developer/debug tool. Renders a graphical, tabbed overview of the major
  aircraft systems (gauges / bars / LEDs / chips) by reading datarefs LIVE.
  Modelled on the sibling An-24RV-CE tool of the same name.

  DECOUPLING CONTRACT (do not break):
    * This file reads aircraft state ONLY by dataref string name, through a
      memoised globalProperty() cache (see H()/readv() below). It never
      include()s or references any modules/systems/*.lua file, and it
      never set()s a system dataref. The schema table below is just strings.
    * "Commands" in X-Plane are momentary and have no readable state, and this
      plugin creates none of its own anyway (CLAUDE.md section 10), so the
      schema surfaces the *datarefs the commands act on* -- switch / lever /
      mode positions, status lamps -- that is the observable system state.
    * Every `dref` below is a name created in core/dataref_creator_1/2/3.lua.
      Nothing here creates a dataref, so Hard Rule 4 does not apply and the
      component may be instantiated at any point.

  Layout is a fixed 920x560 canvas; the context window scales it
  proportionally (see debug_inspector.lua). Long tabs scroll vertically
  (mouse wheel or the arrow buttons in the right gutter).

--]] size = { 920, 560 }

-- ---------------------------------------------------------------------------
-- Palette (SASL colours are {r,g,b,a} floats 0..1)
-- ---------------------------------------------------------------------------
local COL_BG     = { 0.10, 0.11, 0.13, 0.97 }
local COL_TAB    = { 0.14, 0.15, 0.18, 1 }
local COL_TABON  = { 0.20, 0.22, 0.27, 1 }
local COL_CARD   = { 0.13, 0.14, 0.17, 1 }
local COL_FRAME  = { 0.28, 0.30, 0.35, 1 }
local COL_TEXT   = { 0.88, 0.90, 0.94, 1 }
local COL_DIM    = { 0.55, 0.58, 0.64, 1 }
local COL_GREEN  = { 0.27, 0.82, 0.40, 1 }
local COL_AMBER  = { 0.98, 0.74, 0.20, 1 }
local COL_RED    = { 0.94, 0.30, 0.30, 1 }
local COL_ACCENT = { 0.32, 0.66, 0.96, 1 }
local COL_OFF    = { 0.30, 0.32, 0.37, 1 }

-- Roboto-Regular.ttf ships with the vendored framework in data/components,
-- which main.lua puts on the resource search path.
local font = sasl.gl.loadFont("Roboto-Regular.ttf")

-- ---------------------------------------------------------------------------
-- Schema: one entry per tab. `short` is the tab-bar label, `name` the header.
-- Field kinds: gauge | bar | value | lamp | fail | enum
--   gauge/bar : min, max, unit, [warn_lo], [warn_hi], [dp]
--   value     : unit, [dp]
--   lamp      : on at value > 0.5; [fault]=true => on is bad (red), off is OK
--   fail      : a tu-154/failures/... flag -- 0 OK, non-zero FAIL
--   enum      : map = { [n] = "LABEL", ... }
--
-- `value` is used wherever the real-world scale of a dataref is not certain,
-- so no card ever implies a limit the systems code does not actually use.
-- ---------------------------------------------------------------------------
local ENUM_BUS27_SRC  = { [0] = "NONE", [1] = "VU", [2] = "VU RES", [3] = "BAT 1+3", [4] = "BAT 1", [5] = "BAT 2" }
local ENUM_AXIS_MAIN  = { [0] = "OFF", [1] = "CWS", [2] = "STAB" }
local ENUM_PNP        = { [0] = "OFF", [1] = "NVU", [2] = "VOR 1", [3] = "VOR 2", [4] = "LANDING" }
local ENUM_RMI_SRC    = { [0] = "BLANK", [1] = "ARK 1", [2] = "ARK 2", [3] = "VOR 1", [4] = "VOR 2", [5] = "RSBN" }
local ENUM_TRIM_SW    = { [-1] = "LEFT", [0] = "OFF", [1] = "RIGHT" }
local ENUM_FIRE_STATE = { [0] = "NORMAL", [1] = "OVERHEAT", [2] = "FIRE" }
local ENUM_WIN_HEAT   = { [-1] = "LOW", [0] = "OFF", [1] = "HIGH" }

local schema = {

    -- =======================================================================
    { name = "Electrical -- buses and generators", short = "Elec", fields = {
        { label = "27 V bus left",       dref = "tu-154/elec/bus27_volt_left",     kind = "gauge", min = 0, max = 32,  unit = "V", warn_lo = 24 },
        { label = "27 V bus right",      dref = "tu-154/elec/bus27_volt_right",    kind = "gauge", min = 0, max = 32,  unit = "V", warn_lo = 24 },
        { label = "27 V load left",      dref = "tu-154/elec/bus27_amp_left",      kind = "bar",   min = 0, max = 600, unit = "A" },
        { label = "27 V load right",     dref = "tu-154/elec/bus27_amp_right",     kind = "bar",   min = 0, max = 600, unit = "A" },
        { label = "27 V source left",    dref = "tu-154/elec/bus27_source_left",   kind = "enum",  map = ENUM_BUS27_SRC },
        { label = "27 V source right",   dref = "tu-154/elec/bus27_source_right",  kind = "enum",  map = ENUM_BUS27_SRC },
        { label = "27 V buses tied",     dref = "tu-154/elec/bus_connected",       kind = "lamp" },
        { label = "Avto bus L volt",     dref = "tu-154/elec/avto_L_volt",         kind = "gauge", min = 0, max = 32,  unit = "V" },
        { label = "Avto bus R volt",     dref = "tu-154/elec/avto_R_volt",         kind = "gauge", min = 0, max = 32,  unit = "V" },
        { label = "Avto bus L amp",      dref = "tu-154/elec/avto_L_amp",          kind = "bar",   min = 0, max = 200, unit = "A" },
        { label = "Avto bus R amp",      dref = "tu-154/elec/avto_R_amp",          kind = "bar",   min = 0, max = 200, unit = "A" },

        { label = "115 V bus 1",         dref = "tu-154/elec/bus115_1_volt",       kind = "gauge", min = 0, max = 130, unit = "V", warn_lo = 104 },
        { label = "115 V bus 2",         dref = "tu-154/elec/bus115_2_volt",       kind = "gauge", min = 0, max = 130, unit = "V", warn_lo = 104 },
        { label = "115 V bus 3",         dref = "tu-154/elec/bus115_3_volt",       kind = "gauge", min = 0, max = 130, unit = "V", warn_lo = 104 },
        { label = "115 V emerg 1",       dref = "tu-154/elec/bus115_em_1_volt",    kind = "gauge", min = 0, max = 130, unit = "V", warn_lo = 104 },
        { label = "115 V emerg 2",       dref = "tu-154/elec/bus115_em_2_volt",    kind = "gauge", min = 0, max = 130, unit = "V", warn_lo = 104 },
        { label = "115 V frequency",     dref = "tu-154/elec/bus115_freq",         kind = "gauge", min = 0, max = 450, unit = "Hz", warn_lo = 380 },
        { label = "115 V load 1",        dref = "tu-154/elec/bus115_1_amp",        kind = "bar",   min = 0, max = 200, unit = "A" },
        { label = "115 V load 2",        dref = "tu-154/elec/bus115_2_amp",        kind = "bar",   min = 0, max = 200, unit = "A" },
        { label = "115 V load 3",        dref = "tu-154/elec/bus115_3_amp",        kind = "bar",   min = 0, max = 200, unit = "A" },
        { label = "115 V emerg 1 amp",   dref = "tu-154/elec/bus115_em_1_amp",     kind = "bar",   min = 0, max = 200, unit = "A" },
        { label = "115 V emerg 2 amp",   dref = "tu-154/elec/bus115_em_2_amp",     kind = "bar",   min = 0, max = 200, unit = "A" },

        { label = "36 V bus left",       dref = "tu-154/elec/bus36_volt_left",     kind = "gauge", min = 0, max = 45,  unit = "V", warn_lo = 33 },
        { label = "36 V bus right",      dref = "tu-154/elec/bus36_volt_right",    kind = "gauge", min = 0, max = 45,  unit = "V", warn_lo = 33 },
        { label = "36 V load left",      dref = "tu-154/elec/bus36_amp_left",      kind = "bar",   min = 0, max = 100, unit = "A" },
        { label = "36 V load right",     dref = "tu-154/elec/bus36_amp_right",     kind = "bar",   min = 0, max = 100, unit = "A" },
        { label = "TR 1 running",        dref = "tu-154/elec/bus36_tr1_work",      kind = "lamp" },
        { label = "TR 2 running",        dref = "tu-154/elec/bus36_tr2_work",      kind = "lamp" },
        { label = "36 V source left",    dref = "tu-154/elec/bus36_src_L",         kind = "enum",  map = { [0] = "TR 1", [1] = "TR 2" } },
        { label = "36 V source right",   dref = "tu-154/elec/bus36_src_R",         kind = "enum",  map = { [0] = "TR 2", [1] = "TR 1" } },
        { label = "PTS-250 1 running",   dref = "tu-154/elec/bus36_pts1_work",     kind = "lamp" },
        { label = "PTS-250 2 running",   dref = "tu-154/elec/bus36_pts2_work",     kind = "lamp" },
        { label = "PTS-250 1 volt",      dref = "tu-154/elec/bus36_volt_pts250_1", kind = "gauge", min = 0, max = 45,  unit = "V" },
        { label = "PTS-250 2 volt",      dref = "tu-154/elec/bus36_volt_pts250_2", kind = "gauge", min = 0, max = 45,  unit = "V" },
        { label = "PTS-250 1 amp",       dref = "tu-154/elec/bus36_amp_pts250_1",  kind = "bar",   min = 0, max = 100, unit = "A" },
        { label = "PTS-250 2 amp",       dref = "tu-154/elec/bus36_amp_pts250_2",  kind = "bar",   min = 0, max = 100, unit = "A" },

        { label = "GEN 1 running",       dref = "tu-154/elec/gen1_work",           kind = "lamp" },
        { label = "GEN 2 running",       dref = "tu-154/elec/gen2_work",           kind = "lamp" },
        { label = "GEN 3 running",       dref = "tu-154/elec/gen3_work",           kind = "lamp" },
        { label = "APU GEN running",     dref = "tu-154/elec/gen4_work",           kind = "lamp" },
        { label = "RAP (GPU) running",   dref = "tu-154/elec/gpu_work",            kind = "lamp" },
        { label = "GEN 1 overload",      dref = "tu-154/elec/gen1_overload",       kind = "lamp", fault = true },
        { label = "GEN 2 overload",      dref = "tu-154/elec/gen2_overload",       kind = "lamp", fault = true },
        { label = "GEN 3 overload",      dref = "tu-154/elec/gen3_overload",       kind = "lamp", fault = true },
        { label = "APU GEN overload",    dref = "tu-154/elec/gen4_overload",       kind = "lamp", fault = true },
        { label = "RAP overload",        dref = "tu-154/elec/gpu_overload",        kind = "lamp", fault = true },
        { label = "GEN 1 volt",          dref = "tu-154/elec/gen1_volt",           kind = "gauge", min = 0, max = 130, unit = "V" },
        { label = "GEN 2 volt",          dref = "tu-154/elec/gen2_volt",           kind = "gauge", min = 0, max = 130, unit = "V" },
        { label = "GEN 3 volt",          dref = "tu-154/elec/gen3_volt",           kind = "gauge", min = 0, max = 130, unit = "V" },
        { label = "APU GEN volt",        dref = "tu-154/elec/gen4_volt",           kind = "gauge", min = 0, max = 130, unit = "V" },
        { label = "RAP volt",            dref = "tu-154/elec/gpu_volt",            kind = "gauge", min = 0, max = 130, unit = "V" },
        { label = "GEN 1 load",          dref = "tu-154/elec/gen1_amp",            kind = "bar",   min = 0, max = 200, unit = "A" },
        { label = "GEN 2 load",          dref = "tu-154/elec/gen2_amp",            kind = "bar",   min = 0, max = 200, unit = "A" },
        { label = "GEN 3 load",          dref = "tu-154/elec/gen3_amp",            kind = "bar",   min = 0, max = 200, unit = "A" },
        { label = "APU GEN load",        dref = "tu-154/elec/gen4_amp",            kind = "bar",   min = 0, max = 200, unit = "A" },
        { label = "RAP load",            dref = "tu-154/elec/gpu_amp",             kind = "bar",   min = 0, max = 200, unit = "A" },
        { label = "GEN distrib fail",    dref = "tu-154/failures/gen_dist_fail",   kind = "fail" },
    } },

    -- =======================================================================
    { name = "Batteries and rectifiers", short = "Bat/VU", fields = {
        { label = "VU 1 volt",           dref = "tu-154/elec/vu1_volt",            kind = "gauge", min = 0, max = 32,  unit = "V", warn_lo = 24 },
        { label = "VU 2 volt",           dref = "tu-154/elec/vu2_volt",            kind = "gauge", min = 0, max = 32,  unit = "V", warn_lo = 24 },
        { label = "VU standby volt",     dref = "tu-154/elec/vu_res_volt",         kind = "gauge", min = 0, max = 32,  unit = "V", warn_lo = 24 },
        { label = "VU 1 amp",            dref = "tu-154/elec/vu1_amp",             kind = "bar",   min = 0, max = 300, unit = "A" },
        { label = "VU 2 amp",            dref = "tu-154/elec/vu2_amp",             kind = "bar",   min = 0, max = 300, unit = "A" },
        { label = "VU standby amp",      dref = "tu-154/elec/vu_res_amp",          kind = "bar",   min = 0, max = 300, unit = "A" },
        { label = "VU standby to left",  dref = "tu-154/elec/vu_res_to_L",         kind = "lamp" },
        { label = "VU standby to right", dref = "tu-154/elec/vu_res_to_R",         kind = "lamp" },

        { label = "BAT 1 volt",          dref = "tu-154/elec/bat_volt_1",          kind = "gauge", min = 0, max = 32,  unit = "V", warn_lo = 22 },
        { label = "BAT 2 volt",          dref = "tu-154/elec/bat_volt_2",          kind = "gauge", min = 0, max = 32,  unit = "V", warn_lo = 22 },
        { label = "BAT 3 volt",          dref = "tu-154/elec/bat_volt_3",          kind = "gauge", min = 0, max = 32,  unit = "V", warn_lo = 22 },
        { label = "BAT 4 volt",          dref = "tu-154/elec/bat_volt_4",          kind = "gauge", min = 0, max = 32,  unit = "V", warn_lo = 22 },
        { label = "BAT 1 amp",           dref = "tu-154/elec/bat_amp_1",           kind = "bar",   min = 0, max = 300, unit = "A" },
        { label = "BAT 2 amp",           dref = "tu-154/elec/bat_amp_2",           kind = "bar",   min = 0, max = 300, unit = "A" },
        { label = "BAT 3 amp",           dref = "tu-154/elec/bat_amp_3",           kind = "bar",   min = 0, max = 300, unit = "A" },
        { label = "BAT 4 amp",           dref = "tu-154/elec/bat_amp_4",           kind = "bar",   min = 0, max = 300, unit = "A" },
        { label = "BAT 1 charge",        dref = "tu-154/elec/bat_cc_1",            kind = "value", unit = "A", dp = 1 },
        { label = "BAT 2 charge",        dref = "tu-154/elec/bat_cc_2",            kind = "value", unit = "A", dp = 1 },
        { label = "BAT 3 charge",        dref = "tu-154/elec/bat_cc_3",            kind = "value", unit = "A", dp = 1 },
        { label = "BAT 4 charge",        dref = "tu-154/elec/bat_cc_4",            kind = "value", unit = "A", dp = 1 },
        { label = "BAT 1 temp",          dref = "tu-154/elec/bat_therm_1",         kind = "gauge", min = 0, max = 100, unit = "C", warn_hi = 55 },
        { label = "BAT 2 temp",          dref = "tu-154/elec/bat_therm_2",         kind = "gauge", min = 0, max = 100, unit = "C", warn_hi = 55 },
        { label = "BAT 3 temp",          dref = "tu-154/elec/bat_therm_3",         kind = "gauge", min = 0, max = 100, unit = "C", warn_hi = 55 },
        { label = "BAT 4 temp",          dref = "tu-154/elec/bat_therm_4",         kind = "gauge", min = 0, max = 100, unit = "C", warn_hi = 55 },
        { label = "BAT 1 is source",     dref = "tu-154/elec/bat_is_source_1",     kind = "lamp" },
        { label = "BAT 2 is source",     dref = "tu-154/elec/bat_is_source_2",     kind = "lamp" },
        { label = "BAT 3 is source",     dref = "tu-154/elec/bat_is_source_3",     kind = "lamp" },
        { label = "BAT 4 is source",     dref = "tu-154/elec/bat_is_source_4",     kind = "lamp" },

        { label = "BAT 1 failed",        dref = "tu-154/failures/bat_1_fail",      kind = "fail" },
        { label = "BAT 2 failed",        dref = "tu-154/failures/bat_2_fail",      kind = "fail" },
        { label = "BAT 3 failed",        dref = "tu-154/failures/bat_3_fail",      kind = "fail" },
        { label = "BAT 4 failed",        dref = "tu-154/failures/bat_4_fail",      kind = "fail" },
        { label = "BAT 1 short/runaway", dref = "tu-154/failures/bat_1_kz",        kind = "fail" },
        { label = "BAT 2 short/runaway", dref = "tu-154/failures/bat_2_kz",        kind = "fail" },
        { label = "BAT 3 short/runaway", dref = "tu-154/failures/bat_3_kz",        kind = "fail" },
        { label = "BAT 4 short/runaway", dref = "tu-154/failures/bat_4_kz",        kind = "fail" },
        { label = "VU 1 failed",         dref = "tu-154/failures/vu1_fail",        kind = "fail" },
        { label = "VU 2 failed",         dref = "tu-154/failures/vu2_fail",        kind = "fail" },
        { label = "VU standby failed",   dref = "tu-154/failures/vu3_fail",        kind = "fail" },
        { label = "TR 1 failed",         dref = "tu-154/failures/tr1_fail",        kind = "fail" },
        { label = "TR 2 failed",         dref = "tu-154/failures/tr2_fail",        kind = "fail" },
        { label = "PTS-250 1 failed",    dref = "tu-154/failures/pts250_1_fail",   kind = "fail" },
        { label = "PTS-250 2 failed",    dref = "tu-154/failures/pts250_2_fail",   kind = "fail" },
        { label = "115 V inverter fail", dref = "tu-154/failures/inv115_fail",     kind = "fail" },
    } },

    -- =======================================================================
    { name = "Fuel", short = "Fuel", fields = {
        { label = "Total fuel",          dref = "tu-154/gauges/fuel/fuel_meter_summ",        kind = "value", unit = "kg" },
        { label = "Front panel gauge",   dref = "tu-154/gauges/misc/fuel_front_ind",         kind = "value", unit = "kg" },
        { label = "Flowmeter",           dref = "tu-154/gauges/fuel/fuel_meter_mech",        kind = "value", unit = "kg" },
        { label = "Tank 1",              dref = "tu-154/gauges/fuel/fuel_meter_tank1",       kind = "bar", min = 0, max = 3300, unit = "kg" },
        { label = "Tank 2 left",         dref = "tu-154/gauges/fuel/fuel_meter_tank2_left",  kind = "bar", min = 0, max = 9500, unit = "kg" },
        { label = "Tank 2 right",        dref = "tu-154/gauges/fuel/fuel_meter_tank2_right", kind = "bar", min = 0, max = 9500, unit = "kg" },
        { label = "Tank 3 left",         dref = "tu-154/gauges/fuel/fuel_meter_tank3_left",  kind = "bar", min = 0, max = 5405, unit = "kg" },
        { label = "Tank 3 right",        dref = "tu-154/gauges/fuel/fuel_meter_tank3_right", kind = "bar", min = 0, max = 5405, unit = "kg" },
        { label = "Tank 4",              dref = "tu-154/gauges/fuel/fuel_meter_tank4",       kind = "bar", min = 0, max = 6598, unit = "kg" },

        { label = "Usage order",         dref = "tu-154/fuel/auto_tanks_turn",     kind = "enum", map = { [0] = "OFF", [1] = "OFF", [2] = "TANK 2", [3] = "TANK 3", [4] = "TANK 4" } },
        { label = "Balancing tanks 2",   dref = "tu-154/fuel/auto_tank_level_2",   kind = "enum", map = { [-1] = "LEFT", [0] = "NONE", [1] = "RIGHT" } },
        { label = "Balancing tanks 3",   dref = "tu-154/fuel/auto_tank_level_3",   kind = "enum", map = { [-1] = "LEFT", [0] = "NONE", [1] = "RIGHT" } },
        { label = "Standby transfer",    dref = "tu-154/fuel/reserv_trans",        kind = "lamp" },

        { label = "Pump tank 1-1",       dref = "tu-154/fuel/pump_tank1_1_work",      kind = "lamp" },
        { label = "Pump tank 1-2",       dref = "tu-154/fuel/pump_tank1_2_work",      kind = "lamp" },
        { label = "Pump tank 1-3",       dref = "tu-154/fuel/pump_tank1_3_work",      kind = "lamp" },
        { label = "Pump tank 1-4",       dref = "tu-154/fuel/pump_tank1_4_work",      kind = "lamp" },
        { label = "Pumps tank 2 left",   dref = "tu-154/fuel/pump_tank2_left_work",   kind = "lamp" },
        { label = "Pumps tank 2 right",  dref = "tu-154/fuel/pump_tank2_right_work",  kind = "lamp" },
        { label = "Pumps tank 3 left",   dref = "tu-154/fuel/pump_tank3_left_work",   kind = "lamp" },
        { label = "Pumps tank 3 right",  dref = "tu-154/fuel/pump_tank3_right_work",  kind = "lamp" },
        { label = "Pumps tank 4",        dref = "tu-154/fuel/pump_tank4_work",        kind = "lamp" },

        { label = "Fuel to engine 1",    dref = "tu-154/fuel/eng_fuel_press_1",    kind = "lamp" },
        { label = "Fuel to engine 2",    dref = "tu-154/fuel/eng_fuel_press_2",    kind = "lamp" },
        { label = "Fuel to engine 3",    dref = "tu-154/fuel/eng_fuel_press_3",    kind = "lamp" },
        { label = "Fire valve 1 open",   dref = "tu-154/fuel/fire_vlv_open_1",     kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Fire valve 2 open",   dref = "tu-154/fuel/fire_vlv_open_2",     kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Fire valve 3 open",   dref = "tu-154/fuel/fire_vlv_open_3",     kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Eng 1 fuel press",    dref = "tu-154/gauges/eng/fuel_press_1",  kind = "value", dp = 2 },
        { label = "Eng 2 fuel press",    dref = "tu-154/gauges/eng/fuel_press_2",  kind = "value", dp = 2 },
        { label = "Eng 3 fuel press",    dref = "tu-154/gauges/eng/fuel_press_3",  kind = "value", dp = 2 },
        { label = "Fuel temp 1",         dref = "tu-154/gauges/eng/fuel_temp_1",   kind = "value", unit = "C", dp = 1 },
        { label = "Fuel temp 2",         dref = "tu-154/gauges/eng/fuel_temp_2",   kind = "value", unit = "C", dp = 1 },

        { label = "Pump load 115-1",     dref = "tu-154/elec/fuel_pumps_115_1_cc", kind = "bar", min = 0, max = 100, unit = "A" },
        { label = "Pump load 115-3",     dref = "tu-154/elec/fuel_pumps_115_3_cc", kind = "bar", min = 0, max = 100, unit = "A" },
        { label = "Pump load 27 V",      dref = "tu-154/elec/fuel_pumps_27_cc",    kind = "bar", min = 0, max = 100, unit = "A" },

        { label = "2500 kg remaining",   dref = "tu-154/lights/fuel_less_2500",    kind = "lamp", fault = true },
        { label = "Fuel siren",          dref = "tu-154/alarm/speaker_fuel",       kind = "lamp", fault = true },
        { label = "Automatics failed",   dref = "tu-154/failures/fuel_auto_fail",  kind = "fail" },
        { label = "Balancing failed",    dref = "tu-154/failures/fuel_level_fail", kind = "fail" },
        { label = "Metering failed",     dref = "tu-154/failures/fuel_porc_fail",  kind = "fail" },
    } },

    -- =======================================================================
    { name = "Hydraulics", short = "Hydr", fields = {
        { label = "System 1 pressure",   dref = "tu-154/hydro/gs_press_1",                 kind = "gauge", min = 0, max = 250, unit = "kg/cm2", warn_lo = 150 },
        { label = "System 2 pressure",   dref = "tu-154/hydro/gs_press_2",                 kind = "gauge", min = 0, max = 250, unit = "kg/cm2", warn_lo = 150 },
        { label = "System 3 pressure",   dref = "tu-154/hydro/gs_press_3",                 kind = "gauge", min = 0, max = 250, unit = "kg/cm2", warn_lo = 150 },
        { label = "Emerg brake press",   dref = "tu-154/hydro/gs_press_4",                 kind = "gauge", min = 0, max = 250, unit = "kg/cm2" },
        { label = "Gauge 1",             dref = "tu-154/gauges/hydro/pressure_ind_1",      kind = "value", dp = 1 },
        { label = "Gauge 2",             dref = "tu-154/gauges/hydro/pressure_ind_2",      kind = "value", dp = 1 },
        { label = "Gauge 3",             dref = "tu-154/gauges/hydro/pressure_ind_3",      kind = "value", dp = 1 },
        { label = "Gauge emergency",     dref = "tu-154/gauges/hydro/pressure_ind_emerg",  kind = "value", dp = 1 },

        { label = "System 1 fluid",      dref = "tu-154/hydro/gs_qty_1",           kind = "value", unit = "l", dp = 1 },
        { label = "System 2 fluid",      dref = "tu-154/hydro/gs_qty_2",           kind = "value", unit = "l", dp = 1 },
        { label = "System 3 fluid",      dref = "tu-154/hydro/gs_qty_3",           kind = "value", unit = "l", dp = 1 },
        { label = "Tank 1 fluid",        dref = "tu-154/hydro/gs_bak_qty_1",       kind = "value", unit = "l", dp = 1 },
        { label = "Tank 2 fluid",        dref = "tu-154/hydro/gs_bak_qty_2",       kind = "value", unit = "l", dp = 1 },
        { label = "Tank 3 fluid",        dref = "tu-154/hydro/gs_bak_qty_3",       kind = "value", unit = "l", dp = 1 },
        { label = "Tank 1+2 shown",      dref = "tu-154/hydro/gs_qty_12_show",     kind = "value", unit = "l", dp = 1 },
        { label = "Tank 3 shown",        dref = "tu-154/hydro/gs_qty_3_show",      kind = "value", unit = "l", dp = 1 },
        { label = "Tank 1+2 gauge",      dref = "tu-154/gauges/hydro/qty_12",      kind = "value", dp = 1 },
        { label = "Tank 3 gauge",        dref = "tu-154/gauges/hydro/qty_3",       kind = "value", dp = 1 },

        { label = "Pump station 2 amp",  dref = "tu-154/hydro/gs_pump_2_cc",          kind = "bar", min = 0, max = 100, unit = "A" },
        { label = "Pump station 3 amp",  dref = "tu-154/hydro/gs_pump_3_cc",          kind = "bar", min = 0, max = 100, unit = "A" },
        { label = "Nosewheel turn pwr",  dref = "tu-154/hydro/nosewheel_turn_power",  kind = "lamp" },

        { label = "Sys 1 low press",     dref = "tu-154/lights/small/front_hydr_fail_1", kind = "lamp", fault = true },
        { label = "Sys 2 low press",     dref = "tu-154/lights/small/front_hydr_fail_2", kind = "lamp", fault = true },
        { label = "Sys 3 low press",     dref = "tu-154/lights/small/front_hydr_fail_3", kind = "lamp", fault = true },
        { label = "Emerg low press",     dref = "tu-154/lights/small/front_hydr_fail_4", kind = "lamp", fault = true },
        { label = "No standby G",        dref = "tu-154/lights/no_reserve_g",            kind = "lamp", fault = true },

        { label = "Leak system 1",       dref = "tu-154/failures/hydro_leak_1",       kind = "fail" },
        { label = "Leak system 2",       dref = "tu-154/failures/hydro_leak_2",       kind = "fail" },
        { label = "Leak system 3",       dref = "tu-154/failures/hydro_leak_3",       kind = "fail" },
        { label = "Leak emergency",      dref = "tu-154/failures/hydro_leak_4",       kind = "fail" },
        { label = "Pump 1-1 failed",     dref = "tu-154/failures/hydro_pump_fail_11", kind = "fail" },
        { label = "Pump 1-2 failed",     dref = "tu-154/failures/hydro_pump_fail_12", kind = "fail" },
        { label = "Pump 2 failed",       dref = "tu-154/failures/hydro_pump_fail_2",  kind = "fail" },
        { label = "Pump 3 failed",       dref = "tu-154/failures/hydro_pump_fail_3",  kind = "fail" },
        { label = "Elec pump 2 failed",  dref = "tu-154/failures/hydro_elec_fail_2",  kind = "fail" },
        { label = "Elec pump 3 failed",  dref = "tu-154/failures/hydro_elec_fail_3",  kind = "fail" },
    } },

    -- =======================================================================
    -- Tab label was "NK-8-2U", which is the Tu-154B's engine. The M flies the
    -- D-30KU-154 2nd series; the limits quoted below come from its own RLE 8.1.1.
    { name = "Engines -- D-30KU-154", short = "Eng", fields = {
        -- warn_hi are the RLE 8.1.1 redlines: N1 (LP/KND) 95 %, N2 (HP/KVD) 98.5 %
        { label = "N1 engine 1",         dref = "tu-154/gauges/engine/rpm_low_1",  kind = "gauge", min = 0, max = 110, unit = "%", warn_hi = 95 },
        { label = "N1 engine 2",         dref = "tu-154/gauges/engine/rpm_low_2",  kind = "gauge", min = 0, max = 110, unit = "%", warn_hi = 95 },
        { label = "N1 engine 3",         dref = "tu-154/gauges/engine/rpm_low_3",  kind = "gauge", min = 0, max = 110, unit = "%", warn_hi = 95 },
        { label = "N2 engine 1",         dref = "tu-154/gauges/engine/rpm_high_1", kind = "gauge", min = 0, max = 110, unit = "%", warn_hi = 98.5 },
        { label = "N2 engine 2",         dref = "tu-154/gauges/engine/rpm_high_2", kind = "gauge", min = 0, max = 110, unit = "%", warn_hi = 98.5 },
        { label = "N2 engine 3",         dref = "tu-154/gauges/engine/rpm_high_3", kind = "gauge", min = 0, max = 110, unit = "%", warn_hi = 98.5 },
        { label = "EGT engine 1",        dref = "tu-154/gauges/eng/egt_1",         kind = "gauge", min = 0, max = 800, unit = "C", warn_hi = 650 },
        { label = "EGT engine 2",        dref = "tu-154/gauges/eng/egt_2",         kind = "gauge", min = 0, max = 800, unit = "C", warn_hi = 650 },
        { label = "EGT engine 3",        dref = "tu-154/gauges/eng/egt_3",         kind = "gauge", min = 0, max = 800, unit = "C", warn_hi = 650 },

        -- Raw sim N2 next to the displayed N2 above. The n2_scale table in
        -- engine_gauges.lua maps one to the other, and the idle references in
        -- rud_logic.lua carry a value on each scale, so seeing both at once is
        -- what lets that mapping be checked instead of assumed.
        { label = "N2 raw sim 1",        dref = "sim/flightmodel/engine/ENGN_N2_[0]", kind = "value", unit = "%", dp = 1 },
        { label = "N2 raw sim 2",        dref = "sim/flightmodel/engine/ENGN_N2_[1]", kind = "value", unit = "%", dp = 1 },
        { label = "N2 raw sim 3",        dref = "sim/flightmodel/engine/ENGN_N2_[2]", kind = "value", unit = "%", dp = 1 },
        { label = "N1 raw sim 1",        dref = "sim/flightmodel/engine/ENGN_N1_[0]", kind = "value", unit = "%", dp = 1 },
        { label = "Throttle used 1",     dref = "sim/flightmodel/engine/ENGN_thro_use[0]", kind = "value", dp = 4 },

        -- Thrust readout, for calibrating the rating against the documented
        -- takeoff figure: 10 500 kgf +/-1 % = 102 970 N per engine, SL/ISA,
        -- static (engine RE Book I, 072.00.00 sect.5.9.1.1, p.17).
        -- Read these with brakes set at the takeoff stop before changing any
        -- constant -- several multipliers stack between acf_tmax and the nozzle.
        { label = "Thrust engine 1",     dref = "sim/cockpit2/engine/indicators/thrust_n[0]", kind = "gauge", min = 0, max = 120000, unit = "N", warn_hi = 105000 },
        { label = "Thrust engine 2",     dref = "sim/cockpit2/engine/indicators/thrust_n[1]", kind = "gauge", min = 0, max = 120000, unit = "N", warn_hi = 105000 },
        { label = "Thrust engine 3",     dref = "sim/cockpit2/engine/indicators/thrust_n[2]", kind = "gauge", min = 0, max = 120000, unit = "N", warn_hi = 105000 },
        { label = "acf_tmax commanded",  dref = "sim/aircraft/engine/acf_tmax",               kind = "value", unit = "N" },
        -- Reverser travel, engines 1 and 3 only (No.2 has no reverser).
        -- Documented reverse: min <=500 kgf (4905 N), max 3400 kgf (33 344 N).
        { label = "Reverser 1 deployed", dref = "sim/flightmodel2/engines/thrust_reverser_deploy_ratio[0]", kind = "bar", min = 0, max = 1 },
        { label = "Reverser 3 deployed", dref = "sim/flightmodel2/engines/thrust_reverser_deploy_ratio[2]", kind = "bar", min = 0, max = 1 },

        { label = "Oil press 1",         dref = "tu-154/gauges/eng/oil_press_1",   kind = "value", dp = 2 },
        { label = "Oil press 2",         dref = "tu-154/gauges/eng/oil_press_2",   kind = "value", dp = 2 },
        { label = "Oil press 3",         dref = "tu-154/gauges/eng/oil_press_3",   kind = "value", dp = 2 },
        { label = "Oil temp 1",          dref = "tu-154/gauges/eng/oil_temp_1",    kind = "gauge", min = 0, max = 150, unit = "C", warn_hi = 110 },
        { label = "Oil temp 2",          dref = "tu-154/gauges/eng/oil_temp_2",    kind = "gauge", min = 0, max = 150, unit = "C", warn_hi = 110 },
        { label = "Oil temp 3",          dref = "tu-154/gauges/eng/oil_temp_3",    kind = "gauge", min = 0, max = 150, unit = "C", warn_hi = 110 },
        { label = "Oil qty 1",           dref = "tu-154/gauges/eng/oil_qty_1",     kind = "value", unit = "l", dp = 1 },
        { label = "Oil qty 2",           dref = "tu-154/gauges/eng/oil_qty_2",     kind = "value", unit = "l", dp = 1 },
        { label = "Oil qty 3",           dref = "tu-154/gauges/eng/oil_qty_3",     kind = "value", unit = "l", dp = 1 },

        { label = "Fuel flow 1",         dref = "tu-154/gauges/eng/fuel_flow_1",   kind = "value", unit = "kg/h" },
        { label = "Fuel flow 2",         dref = "tu-154/gauges/eng/fuel_flow_2",   kind = "value", unit = "kg/h" },
        { label = "Fuel flow 3",         dref = "tu-154/gauges/eng/fuel_flow_3",   kind = "value", unit = "kg/h" },
        { label = "FF model 1",          dref = "tu-154/engines/FuelFlow_1",       kind = "value", dp = 3 },
        { label = "FF model 2",          dref = "tu-154/engines/FuelFlow_2",       kind = "value", dp = 3 },
        { label = "FF model 3",          dref = "tu-154/engines/FuelFlow_3",       kind = "value", dp = 3 },

        { label = "Vibration gauge 1",   dref = "tu-154/gauges/eng/vibra_1",       kind = "bar", min = 0, max = 100, unit = "%" },
        { label = "Vibration gauge 2",   dref = "tu-154/gauges/eng/vibra_2",       kind = "bar", min = 0, max = 100, unit = "%" },
        { label = "Vibration gauge 3",   dref = "tu-154/gauges/eng/vibra_3",       kind = "bar", min = 0, max = 100, unit = "%" },
        { label = "Vibration raw 1",     dref = "tu-154/eng/vibration_1",          kind = "value", dp = 2 },
        { label = "Vibration raw 2",     dref = "tu-154/eng/vibration_2",          kind = "value", dp = 2 },
        { label = "Vibration raw 3",     dref = "tu-154/eng/vibration_3",          kind = "value", dp = 2 },

        { label = "RNA 1",               dref = "tu-154/engines/rna_1",            kind = "lamp" },
        { label = "RNA 2",               dref = "tu-154/engines/rna_2",            kind = "lamp" },
        { label = "RNA 3",               dref = "tu-154/engines/rna_3",            kind = "lamp" },
        { label = "KND 1",               dref = "tu-154/engines/knd_1",            kind = "value", dp = 2 },
        { label = "KND 3",               dref = "tu-154/engines/knd_3",            kind = "value", dp = 2 },
        { label = "Flight idle",         dref = "tu-154/engines/flight_idle",      kind = "value", dp = 2 },
        { label = "Flight idle rpm",     dref = "tu-154/engines/flight_idle_rpm",  kind = "value", dp = 2 },
        { label = "Delta ISA temp",      dref = "tu-154/engines/d_isa_temp",       kind = "value", unit = "C", dp = 1 },
        { label = "Max KVD",             dref = "tu-154/engine/max_KVD",           kind = "value", dp = 2 },

        { label = "Throttle 1",          dref = "tu-154/controlls/throttle_1",     kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Throttle 2",          dref = "tu-154/controlls/throttle_2",     kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Throttle 3",          dref = "tu-154/controlls/throttle_3",     kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Stop cock 1",         dref = "tu-154/controlls/fuel_cutoff_1",  kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Stop cock 2",         dref = "tu-154/controlls/fuel_cutoff_2",  kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Stop cock 3",         dref = "tu-154/controlls/fuel_cutoff_3",  kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Reverser lever L",    dref = "tu-154/controlls/revers_L",       kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Reverser lever R",    dref = "tu-154/controlls/revers_R",       kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Eng 1 rev buckets",   dref = "tu-154/lights/engines/eng1_reverse_doors", kind = "lamp" },
        { label = "Eng 3 rev buckets",   dref = "tu-154/lights/engines/eng3_reverse_doors", kind = "lamp" },
        { label = "Eng 1 fuel P lamp",   dref = "tu-154/lights/engines/eng1_fuel_p",        kind = "lamp", fault = true },
        { label = "Eng 2 fuel P lamp",   dref = "tu-154/lights/engines/eng2_fuel_p",        kind = "lamp", fault = true },
        { label = "Eng 3 fuel P lamp",   dref = "tu-154/lights/engines/eng3_fuel_p",        kind = "lamp", fault = true },

        { label = "Eng 1 runtime",       dref = "tu-154/failures/engine_runtime_1",    kind = "value", unit = "h", dp = 1 },
        { label = "Eng 2 runtime",       dref = "tu-154/failures/engine_runtime_2",    kind = "value", unit = "h", dp = 1 },
        { label = "Eng 3 runtime",       dref = "tu-154/failures/engine_runtime_3",    kind = "value", unit = "h", dp = 1 },
        { label = "Eng 1 oil left",      dref = "tu-154/failures/engn_oil_qty_1",      kind = "value", unit = "l", dp = 1 },
        { label = "Eng 2 oil left",      dref = "tu-154/failures/engn_oil_qty_2",      kind = "value", unit = "l", dp = 1 },
        { label = "Eng 3 oil left",      dref = "tu-154/failures/engn_oil_qty_3",      kind = "value", unit = "l", dp = 1 },
        { label = "Eng 1 oil leak",      dref = "tu-154/failures/engn_oil_leak_1",     kind = "fail" },
        { label = "Eng 2 oil leak",      dref = "tu-154/failures/engn_oil_leak_2",     kind = "fail" },
        { label = "Eng 3 oil leak",      dref = "tu-154/failures/engn_oil_leak_3",     kind = "fail" },
        { label = "Eng 1 fuel pmp fail", dref = "tu-154/failures/eng_fuel_pmp_fail_1", kind = "fail" },
        { label = "Eng 2 fuel pmp fail", dref = "tu-154/failures/eng_fuel_pmp_fail_2", kind = "fail" },
        { label = "Eng 3 fuel pmp fail", dref = "tu-154/failures/eng_fuel_pmp_fail_3", kind = "fail" },
    } },

    -- =======================================================================
    { name = "APU and engine start", short = "APU", fields = {
        { label = "APU system on",       dref = "tu-154/eng/apu_system_on",        kind = "lamp" },
        { label = "APU ready",           dref = "tu-154/eng/apu_ready",            kind = "lamp" },
        { label = "APU start phase",     dref = "tu-154/eng/apu_start_phase",      kind = "enum", map = { [0] = "NONE", [1] = "COLD CRANK", [2] = "STARTER", [3] = "COMBUSTION", [4] = "OVERSHOOT", [5] = "WARM-UP", [6] = "RUNNING" } },
        { label = "APU rpm",             dref = "tu-154/eng/apu_n1",               kind = "gauge", min = 0, max = 110, unit = "%" },
        { label = "APU EGT",             dref = "tu-154/eng/apu_egt",              kind = "gauge", min = 0, max = 800, unit = "C", warn_hi = 700 },
        { label = "APU oil temp",        dref = "tu-154/eng/apu_oil_t",            kind = "gauge", min = 0, max = 150, unit = "C", warn_hi = 110 },
        { label = "APU oil press",       dref = "tu-154/eng/apu_oil_p",            kind = "value", dp = 2 },
        { label = "APU oil qty",         dref = "tu-154/eng/apu_oil_q",            kind = "value", unit = "l", dp = 1 },
        { label = "APU fuel press",      dref = "tu-154/eng/apu_fuel_p",           kind = "value", dp = 2 },
        { label = "APU air press",       dref = "tu-154/eng/apu_air_press",        kind = "value", dp = 2 },
        { label = "APU air doors",       dref = "tu-154/eng/apu_air_doors",        kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "APU doors anim",      dref = "tu-154/anim/apu_doors",           kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "APU chamber fuel",    dref = "tu-154/eng/apu_fuel_last",        kind = "value", unit = "", dp = 2 },
        { label = "APU cooldown",        dref = "tu-154/eng/apu_cooldown",         kind = "value", unit = "s" },
        { label = "APU runtime",         dref = "tu-154/failures/apu_runtime",     kind = "value", unit = "s", dp = 0 },
        { label = "APU oil remaining",   dref = "tu-154/failures/apu_oil_qty",     kind = "value", unit = "l", dp = 1 },

        { label = "APU rpm gauge",       dref = "tu-154/gauges/eng/apu_rpm",       kind = "value", dp = 1 },
        { label = "APU EGT gauge",       dref = "tu-154/gauges/eng/apu_egt",       kind = "value", dp = 1 },
        { label = "APU oil T gauge",     dref = "tu-154/gauges/eng/apu_oil_temp",  kind = "value", dp = 1 },
        { label = "APU doors lamp",      dref = "tu-154/lights/apu/doors_open",    kind = "lamp" },
        { label = "APU fuel P lamp",     dref = "tu-154/lights/apu/fuel_press",    kind = "lamp", fault = true },

        { label = "APU start bus",       dref = "tu-154/elec/apu_start_bus",       kind = "gauge", min = 0, max = 32, unit = "V" },
        { label = "APU starter amp",     dref = "tu-154/elec/apu_start_cc",        kind = "value", unit = "A" },
        { label = "APU start seq",       dref = "tu-154/elec/apu_start_seq",       kind = "lamp" },
        { label = "APU APD working",     dref = "tu-154/elec/apu_apd_working",     kind = "lamp" },
        { label = "APU burning fuel",    dref = "tu-154/elec/apu_burning_fuel",    kind = "value", dp = 3 },

        { label = "Start sys pressure",  dref = "tu-154/start/starter_pressure",   kind = "value", dp = 2 },
        { label = "Starter P gauge",     dref = "tu-154/gauges/eng/starter_press", kind = "value", dp = 2 },
        { label = "Start system on",     dref = "tu-154/start/start_sys_work",     kind = "lamp" },
        { label = "APD 1 running",       dref = "tu-154/start/apd_working_1",      kind = "lamp" },
        { label = "APD 2 running",       dref = "tu-154/start/apd_working_2",      kind = "lamp" },
        { label = "APD 3 running",       dref = "tu-154/start/apd_working_3",      kind = "lamp" },
        { label = "Start fuel eng 1",    dref = "tu-154/start/fuel_in_1",          kind = "lamp" },
        { label = "Start fuel eng 2",    dref = "tu-154/start/fuel_in_2",          kind = "lamp" },
        { label = "Start fuel eng 3",    dref = "tu-154/start/fuel_in_3",          kind = "lamp" },

        { label = "APU failed",          dref = "tu-154/failures/apu_fail",            kind = "fail" },
        { label = "APU starter fail",    dref = "tu-154/failures/apu_start_fail",      kind = "fail" },
        { label = "APU gen fail",        dref = "tu-154/failures/apu_gen_fail",        kind = "fail" },
        { label = "APU bleed fail",      dref = "tu-154/failures/apu_press_fail",      kind = "fail" },
        { label = "APU oil overheat",    dref = "tu-154/failures/apu_fail_oilt",       kind = "fail" },
        { label = "APU EGT exceed",      dref = "tu-154/failures/apu_fail_egt",        kind = "fail" },
        { label = "APU fuel in chamber", dref = "tu-154/failures/apu_fail_fuel_left",  kind = "fail" },
        { label = "APU oil cooler fail", dref = "tu-154/failures/apu_fail_oil_cooler", kind = "fail" },
    } },

    -- =======================================================================
    { name = "Fire protection", short = "Fire", fields = {
        { label = "Fire detected",       dref = "tu-154/fire/fire_detected",       kind = "lamp", fault = true },
        { label = "Fire siren",          dref = "tu-154/fire/fire_siren",          kind = "lamp", fault = true },
        { label = "FIRE lamp",           dref = "tu-154/lights/fire",              kind = "lamp", fault = true },
        { label = "Turn on SPZ",         dref = "tu-154/lights/fire/turn_on_spz",  kind = "lamp", fault = true },
        { label = "Engine 1 state",      dref = "tu-154/fire/engine_fire_state_1", kind = "enum", map = ENUM_FIRE_STATE },
        { label = "Engine 2 state",      dref = "tu-154/fire/engine_fire_state_2", kind = "enum", map = ENUM_FIRE_STATE },
        { label = "Engine 3 state",      dref = "tu-154/fire/engine_fire_state_3", kind = "enum", map = ENUM_FIRE_STATE },
        { label = "APU state",           dref = "tu-154/fire/engine_fire_state_4", kind = "enum", map = ENUM_FIRE_STATE },

        { label = "Fire eng 1 lamp",     dref = "tu-154/lights/fire/fire_eng_1",     kind = "lamp", fault = true },
        { label = "Fire eng 2 lamp",     dref = "tu-154/lights/fire/fire_eng_2",     kind = "lamp", fault = true },
        { label = "Fire eng 3 lamp",     dref = "tu-154/lights/fire/fire_eng_3",     kind = "lamp", fault = true },
        { label = "Fire APU lamp",       dref = "tu-154/lights/fire/fire_apu",       kind = "lamp", fault = true },
        { label = "Overheat eng 1",      dref = "tu-154/lights/fire/overheat_eng_1", kind = "lamp", fault = true },
        { label = "Overheat eng 2",      dref = "tu-154/lights/fire/overheat_eng_2", kind = "lamp", fault = true },
        { label = "Overheat eng 3",      dref = "tu-154/lights/fire/overheat_eng_3", kind = "lamp", fault = true },
        { label = "Check overheat",      dref = "tu-154/lights/fire/check_overheat", kind = "lamp", fault = true },

        { label = "Fuel cut eng 1",      dref = "tu-154/fire/engine_fuel_cut_1",     kind = "lamp" },
        { label = "Fuel cut eng 2",      dref = "tu-154/fire/engine_fuel_cut_2",     kind = "lamp" },
        { label = "Fuel cut eng 3",      dref = "tu-154/fire/engine_fuel_cut_3",     kind = "lamp" },
        { label = "Fuel off lamp 1",     dref = "tu-154/lights/fire/fuel_off_eng_1", kind = "lamp" },
        { label = "Fuel off lamp 2",     dref = "tu-154/lights/fire/fuel_off_eng_2", kind = "lamp" },
        { label = "Fuel off lamp 3",     dref = "tu-154/lights/fire/fuel_off_eng_3", kind = "lamp" },

        { label = "Ext bottle 1 used",   dref = "tu-154/fire/ext_used_1",          kind = "lamp", fault = true },
        { label = "Ext bottle 2 used",   dref = "tu-154/fire/ext_used_2",          kind = "lamp", fault = true },
        { label = "Ext bottle 3 used",   dref = "tu-154/fire/ext_used_3",          kind = "lamp", fault = true },
        { label = "Neutral gas used",    dref = "tu-154/fire/ng_used",             kind = "lamp", fault = true },
        { label = "Eng 1 ext used",      dref = "tu-154/fire/eng1_ext_used",       kind = "lamp", fault = true },
        { label = "Eng 2 ext used",      dref = "tu-154/fire/eng2_ext_used",       kind = "lamp", fault = true },
        { label = "Eng 3 ext used",      dref = "tu-154/fire/eng3_ext_used",       kind = "lamp", fault = true },
        { label = "APU ext used",        dref = "tu-154/fire/apu_ext_used",        kind = "lamp", fault = true },
        { label = "Valve open eng 1",    dref = "tu-154/fire/valve_open_1",        kind = "lamp" },
        { label = "Valve open eng 2",    dref = "tu-154/fire/valve_open_2",        kind = "lamp" },
        { label = "Valve open eng 3",    dref = "tu-154/fire/valve_open_3",        kind = "lamp" },
        { label = "Valve open APU",      dref = "tu-154/fire/valve_open_4",        kind = "lamp" },
        { label = "Bag 1",               dref = "tu-154/fire/fire_bag1",           kind = "lamp" },
        { label = "Bag 2",               dref = "tu-154/fire/fire_bag2",           kind = "lamp" },
        { label = "Fire sys load",       dref = "tu-154/fire/fire_sys_cc",         kind = "bar", min = 0, max = 50, unit = "A" },

        { label = "Smoke 1",             dref = "tu-154/lights/fire/smoke_1",           kind = "lamp", fault = true },
        { label = "Smoke 2",             dref = "tu-154/lights/fire/smoke_2",           kind = "lamp", fault = true },
        { label = "Smoke zone 2 left",   dref = "tu-154/lights/fire/smoke_zone2_left",  kind = "lamp", fault = true },
        { label = "Smoke zone 2 right",  dref = "tu-154/lights/fire/smoke_zone2_right", kind = "lamp", fault = true },
        { label = "Smoke zone 3",        dref = "tu-154/lights/fire/smoke_zone3",       kind = "lamp", fault = true },
        { label = "Smoke zone 4",        dref = "tu-154/lights/fire/smoke_zone4",       kind = "lamp", fault = true },
        { label = "Smoke zone 5 left",   dref = "tu-154/lights/fire/smoke_zone5_left",  kind = "lamp", fault = true },
        { label = "Smoke zone 5 right",  dref = "tu-154/lights/fire/smoke_zone5_right", kind = "lamp", fault = true },
        { label = "Smoke zone 6",        dref = "tu-154/lights/fire/smoke_zone6",       kind = "lamp", fault = true },
    } },

    -- =======================================================================
    { name = "Anti-ice", short = "Ice", fields = {
        { label = "Ice detected",        dref = "tu-154/antiice/ice_detected",     kind = "lamp", fault = true },
        { label = "SOI running",         dref = "tu-154/antiice/ice_detect_ok",    kind = "lamp" },
        { label = "Wing heating",        dref = "tu-154/antiice/wing_heating",     kind = "lamp" },
        { label = "Slat heating",        dref = "tu-154/antiice/slat_heating",     kind = "lamp" },
        { label = "Wing heat temp",      dref = "tu-154/antiice/wing_heat_t",      kind = "gauge", min = 0, max = 150, unit = "C" },
        { label = "Stab heat temp",      dref = "tu-154/antiice/stab_heat_t",      kind = "gauge", min = 0, max = 150, unit = "C" },
        { label = "Stab heat open",      dref = "tu-154/antiice/stab_heat_open",   kind = "lamp" },
        { label = "Eng 1 heat flap",     dref = "tu-154/antiice/eng_heat_open_1",  kind = "lamp" },
        { label = "Eng 2 heat flap",     dref = "tu-154/antiice/eng_heat_open_2",  kind = "lamp" },
        { label = "Eng 3 heat flap",     dref = "tu-154/antiice/eng_heat_open_3",  kind = "lamp" },
        { label = "Wing temp gauge",     dref = "tu-154/gauges/eng/wing_temp",     kind = "value", unit = "C", dp = 1 },
        { label = "Stab temp gauge",     dref = "tu-154/gauges/eng/stab_temp",     kind = "value", unit = "C", dp = 1 },

        { label = "AI load 27 L",        dref = "tu-154/antiice/ai_27_L_cc",       kind = "bar", min = 0, max = 200, unit = "A" },
        { label = "AI load 27 R",        dref = "tu-154/antiice/ai_27_R_cc",       kind = "bar", min = 0, max = 200, unit = "A" },
        { label = "AI load 115-1",       dref = "tu-154/antiice/ai_115_1_cc",      kind = "bar", min = 0, max = 200, unit = "A" },
        { label = "AI load 115-2",       dref = "tu-154/antiice/ai_115_2_cc",      kind = "bar", min = 0, max = 200, unit = "A" },
        { label = "AI load 115-3",       dref = "tu-154/antiice/ai_115_3_cc",      kind = "bar", min = 0, max = 200, unit = "A" },

        { label = "Pitot heat 1",        dref = "tu-154/switchers/ovhd/pitot_heat_1",  kind = "lamp" },
        { label = "Pitot heat 2",        dref = "tu-154/switchers/ovhd/pitot_heat_2",  kind = "lamp" },
        { label = "Pitot heat ABSU",     dref = "tu-154/switchers/ovhd/pitot_heat_3",  kind = "lamp" },
        { label = "Window heat 1",       dref = "tu-154/switchers/ovhd/window_heat_1", kind = "enum", map = ENUM_WIN_HEAT },
        { label = "Window heat 2",       dref = "tu-154/switchers/ovhd/window_heat_2", kind = "enum", map = ENUM_WIN_HEAT },
        { label = "Window heat 3",       dref = "tu-154/switchers/ovhd/window_heat_3", kind = "enum", map = ENUM_WIN_HEAT },
        { label = "Heat OK 1",           dref = "tu-154/lights/small/heat_ok_1",   kind = "lamp" },
        { label = "Heat OK 2",           dref = "tu-154/lights/small/heat_ok_2",   kind = "lamp" },
        { label = "Heat OK 3",           dref = "tu-154/lights/small/heat_ok_3",   kind = "lamp" },

        { label = "Window heat 1 fail",  dref = "tu-154/failures/window_heat_fail_1", kind = "fail" },
        { label = "Window heat 2 fail",  dref = "tu-154/failures/window_heat_fail_2", kind = "fail" },
        { label = "Window heat 3 fail",  dref = "tu-154/failures/window_heat_fail_3", kind = "fail" },
        { label = "PPD-3 heat fail",     dref = "tu-154/antiice/ppd_3_heat_fail",     kind = "fail" },
        { label = "Ice detector fail",   dref = "tu-154/failures/rio_fail",           kind = "fail" },
    } },

    -- =======================================================================
    { name = "Air conditioning and pressurisation (KSKV)", short = "Air", fields = {
        { label = "Cabin altitude",      dref = "tu-154/gauges/airbleed/cabin_alt",      kind = "value", unit = "m" },
        { label = "Cabin alt (new)",     dref = "tu-154/gauges/airbleed/cabin_alt_new",  kind = "value", unit = "m" },
        { label = "Cabin diff press",    dref = "tu-154/gauges/airbleed/cabin_diff",     kind = "value", dp = 2 },
        { label = "Cabin diff (new)",    dref = "tu-154/gauges/airbleed/cabin_diff_new", kind = "value", dp = 2 },
        { label = "Cabin VSI",           dref = "tu-154/gauges/airbleed/cabin_vvi",      kind = "value", dp = 2 },
        { label = "Depress/overpress",   dref = "tu-154/alarm/main_pressure",            kind = "lamp", fault = true },

        { label = "Cockpit temp gauge",  dref = "tu-154/gauges/airbleed/cockpit_temp",   kind = "value", unit = "C", dp = 1 },
        { label = "Cabin temp gauge",    dref = "tu-154/gauges/airbleed/cabin_temp",     kind = "value", unit = "C", dp = 1 },
        { label = "Duct temp gauge",     dref = "tu-154/gauges/airbleed/system_temp",    kind = "value", unit = "C", dp = 1 },
        { label = "Air flow 1",          dref = "tu-154/gauges/airbleed/air_flow_1",     kind = "value", dp = 2 },
        { label = "Air flow 2",          dref = "tu-154/gauges/airbleed/air_flow_2",     kind = "value", dp = 2 },
        { label = "Air usage left",      dref = "tu-154/bleed/air_usage_L",              kind = "value", dp = 2 },
        { label = "Air usage right",     dref = "tu-154/bleed/air_usage_R",              kind = "value", dp = 2 },
        { label = "Bleed valve eng 1",   dref = "tu-154/bleed/eng_airvalve_1",           kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Bleed valve eng 2",   dref = "tu-154/bleed/eng_airvalve_2",           kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Bleed valve eng 3",   dref = "tu-154/bleed/eng_airvalve_3",           kind = "bar", min = 0, max = 1, dp = 2 },

        { label = "Hot duct temp",       dref = "tu-154/bleed/hot_tube_t",         kind = "value", unit = "C", dp = 1 },
        { label = "Door heat duct",      dref = "tu-154/bleed/door_heat_tube_t",   kind = "value", unit = "C", dp = 1 },
        { label = "Cockpit duct",        dref = "tu-154/bleed/cockpit_tube_t",     kind = "value", unit = "C", dp = 1 },
        { label = "Cabin 1 duct",        dref = "tu-154/bleed/cabin1_tube_t",      kind = "value", unit = "C", dp = 1 },
        { label = "Cabin 2 duct",        dref = "tu-154/bleed/cabin2_tube_t",      kind = "value", unit = "C", dp = 1 },
        { label = "Cold duct 1",         dref = "tu-154/bleed/cold_tube1_t",       kind = "value", unit = "C", dp = 1 },
        { label = "Cold duct 2",         dref = "tu-154/bleed/cold_tube2_t",       kind = "value", unit = "C", dp = 1 },
        { label = "Cockpit temp",        dref = "tu-154/bleed/cockpit_temp",       kind = "value", unit = "C", dp = 1 },
        { label = "Cabin 1 temp",        dref = "tu-154/bleed/cabin_1_temp",       kind = "value", unit = "C", dp = 1 },
        { label = "Cabin 2 temp",        dref = "tu-154/bleed/cabin_2_temp",       kind = "value", unit = "C", dp = 1 },
        { label = "Thermo cockpit",      dref = "tu-154/thermo/cockpit_temp",      kind = "value", unit = "C", dp = 1 },
        { label = "Thermo cabin 1",      dref = "tu-154/thermo/cabin1_temp",       kind = "value", unit = "C", dp = 1 },
        { label = "Thermo cabin 2",      dref = "tu-154/thermo/cabin2_temp",       kind = "value", unit = "C", dp = 1 },
        { label = "ARD temp",            dref = "tu-154/kskv/ard_temp",            kind = "value", unit = "C", dp = 1 },
        { label = "Water level",         dref = "tu-154/misc/water_level",         kind = "value", dp = 2 },
        { label = "Water pressure",      dref = "tu-154/gauges/eng/water_pressure", kind = "value", dp = 2 },

        { label = "PSVP left on",        dref = "tu-154/switchers/airbleed/psvp_left_on",   kind = "lamp" },
        { label = "PSVP right on",       dref = "tu-154/switchers/airbleed/psvp_right_on",  kind = "lamp" },
        { label = "Ground cond on",      dref = "tu-154/switchers/airbleed/ground_cond_on", kind = "lamp" },
        { label = "Heating stopped",     dref = "tu-154/switchers/airbleed/heat_close",     kind = "lamp", fault = true },

        { label = "Turbo-cooler L fail", dref = "tu-154/failures/tth_left_fail",   kind = "fail" },
        { label = "Turbo-cooler R fail", dref = "tu-154/failures/tth_right_fail",  kind = "fail" },
        { label = "Outflow valve fail",  dref = "tu-154/failures/sard_valve_fail", kind = "fail" },
        { label = "PSVP left fail",      dref = "tu-154/failures/psvp_fail_left",  kind = "fail" },
        { label = "PSVP right fail",     dref = "tu-154/failures/psvp_fail_right", kind = "fail" },
        { label = "Bleed 1 fail",        dref = "tu-154/failures/airbleed_1",      kind = "fail" },
        { label = "Bleed 2 fail",        dref = "tu-154/failures/airbleed_2",      kind = "fail" },
        { label = "Bleed 3 fail",        dref = "tu-154/failures/airbleed_3",      kind = "fail" },
    } },

    -- =======================================================================
    { name = "Landing gear and brakes", short = "Gear", fields = {
        { label = "Gear lever",          dref = "tu-154/controll/gear_lever",      kind = "enum", map = { [-1] = "UP", [0] = "NEUTRAL", [1] = "DOWN" } },
        { label = "Parking brake",       dref = "tu-154/controll/parking_brake",   kind = "lamp" },
        { label = "Emerg gear ext",      dref = "tu-154/controll/emerg_gear_ext",  kind = "lamp", fault = true },
        { label = "Gears not extended",  dref = "tu-154/lights/gears_not_ext",     kind = "lamp", fault = true },
        { label = "Green front",         dref = "tu-154/lights/gears_green_front", kind = "lamp" },
        { label = "Green left",          dref = "tu-154/lights/gears_green_left",  kind = "lamp" },
        { label = "Green right",         dref = "tu-154/lights/gears_green_right", kind = "lamp" },
        { label = "Red front",           dref = "tu-154/lights/gears_red_front",   kind = "lamp", fault = true },
        { label = "Red left",            dref = "tu-154/lights/gears_red_left",    kind = "lamp", fault = true },
        { label = "Red right",           dref = "tu-154/lights/gears_red_right",   kind = "lamp", fault = true },

        { label = "Nose gear pos",       dref = "tu-154/anim/lg/front_pos",        kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Main gear pos L",     dref = "tu-154/anim/lg/main_pos_left",    kind = "value", dp = 2 },
        { label = "Main gear pos R",     dref = "tu-154/anim/lg/main_pos_right",   kind = "value", dp = 2 },
        { label = "Nose strut defl",     dref = "tu-154/anim/lg/front_defl",       kind = "value", dp = 2 },
        { label = "Nose steering",       dref = "tu-154/anim/lg/front_turn",       kind = "value", unit = "deg", dp = 1 },
        { label = "Bogie rot left",      dref = "tu-154/anim/lg/main_rot_left",    kind = "value", dp = 2 },
        { label = "Bogie rot right",     dref = "tu-154/anim/lg/main_rot_right",   kind = "value", dp = 2 },
        { label = "Nosewheel lever",     dref = "tu-154/controlls/nosewheel_lever", kind = "value", dp = 2 },
        { label = "Nacelle light",       dref = "tu-154/lights/gear_nacelle_light", kind = "bar", min = 0, max = 1, dp = 2 },

        { label = "Brake pedal L",       dref = "tu-154/controlls/brake_L",        kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Brake pedal R",       dref = "tu-154/controlls/brake_R",        kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Emerg brake",         dref = "tu-154/controlls/brake_emerg",    kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Emerg brake L",       dref = "tu-154/controlls/brake_emerg_L",  kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Emerg brake R",       dref = "tu-154/controlls/brake_emerg_R",  kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Brake applied L",     dref = "tu-154/brakes/int_brakes_L",      kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Brake applied R",     dref = "tu-154/brakes/int_brakes_R",      kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Brake press L",       dref = "tu-154/gauges/console/gear_brake_press_L", kind = "value", dp = 1 },
        { label = "Brake press R",       dref = "tu-154/gauges/console/gear_brake_press_R", kind = "value", dp = 1 },
        { label = "Brake temp left",     dref = "tu-154/failures/brake_heat_left",     kind = "gauge", min = 0, max = 600, unit = "C", warn_hi = 300 },
        { label = "Brake temp right",    dref = "tu-154/failures/brake_heat_right",    kind = "gauge", min = 0, max = 600, unit = "C", warn_hi = 300 },
        { label = "Brake wear left",     dref = "tu-154/failures/brake_runtime_left",  kind = "value", dp = 1 },
        { label = "Brake wear right",    dref = "tu-154/failures/brake_runtime_right", kind = "value", dp = 1 },
        { label = "Gear/flap warning",   dref = "tu-154/alarm/main_gear_flaps",        kind = "lamp", fault = true },
    } },

    -- =======================================================================
    { name = "Flight controls", short = "Ctrl", fields = {
        { label = "Flap lever",          dref = "tu-154/controll/flaps_lever",         kind = "value", unit = "deg", dp = 1 },
        { label = "Flap left",           dref = "tu-154/gauges/misc/flap_left_ind",    kind = "value", unit = "deg", dp = 1 },
        { label = "Flap right",          dref = "tu-154/gauges/misc/flap_right_ind",   kind = "value", unit = "deg", dp = 1 },
        { label = "Flap asymmetry",      dref = "tu-154/lights/flaps_unsync",          kind = "lamp", fault = true },
        { label = "Flap 1 PK",           dref = "tu-154/lights/flaps_1_valve",         kind = "lamp" },
        { label = "Flap 2 PK",           dref = "tu-154/lights/flaps_2_valve",         kind = "lamp" },
        { label = "Slats extended",      dref = "tu-154/lights/slats_extended",        kind = "lamp" },
        { label = "Slat asymmetry",      dref = "tu-154/lights/slats_unsync",          kind = "lamp", fault = true },
        { label = "Manual slat sw",      dref = "tu-154/switchers/slat_man",           kind = "enum", map = { [-1] = "RETRACT", [0] = "OFF", [1] = "EXTEND" } },

        { label = "Stabiliser",          dref = "tu-154/gauges/misc/stab_ind",         kind = "value", unit = "deg", dp = 2 },
        { label = "Elevator gauge",      dref = "tu-154/gauges/misc/elevator_ind",     kind = "value", dp = 2 },
        { label = "Stab CG setting",     dref = "tu-154/controll/stab_setting",        kind = "enum", map = { [0] = "AFT", [1] = "MID", [2] = "FWD" } },
        { label = "Stab manual",         dref = "tu-154/controll/stab_manual",         kind = "enum", map = { [-1] = "NOSE DN", [0] = "NEUTRAL", [1] = "NOSE UP" } },
        { label = "Elev trim switch",    dref = "tu-154/controll/elev_trimm_switcher", kind = "enum", map = { [-1] = "NOSE DN", [0] = "NEUTRAL", [1] = "NOSE UP" } },
        { label = "Aileron trim sw",     dref = "tu-154/controll/ail_trimm_sw",        kind = "enum", map = ENUM_TRIM_SW },
        { label = "Rudder trim sw",      dref = "tu-154/controll/rudd_trimm_sw",       kind = "enum", map = ENUM_TRIM_SW },
        { label = "Pitch trim",          dref = "tu-154/trimmers/int_pitch_trim",      kind = "value", dp = 3 },
        { label = "Roll trim",           dref = "tu-154/trimmers/int_roll_trim",       kind = "value", dp = 3 },
        { label = "Yaw trim",            dref = "tu-154/trimmers/int_yaw_trim",        kind = "value", dp = 3 },

        { label = "Yoke pitch",          dref = "tu-154/controlls/yoke_pitch",         kind = "value", dp = 3 },
        { label = "Yoke roll",           dref = "tu-154/controlls/yoke_roll",          kind = "value", dp = 3 },
        { label = "Pedals",              dref = "tu-154/controlls/pedals",             kind = "value", dp = 3 },
        { label = "Rudder gauge",        dref = "tu-154/gauges/misc/rudder_pos_ind",   kind = "value", dp = 2 },
        { label = "Aileron gauge",       dref = "tu-154/gauges/misc/aileron_pos_ind",  kind = "value", dp = 2 },
        { label = "Elevator pos gauge",  dref = "tu-154/gauges/misc/elevator_pos_ind", kind = "value", dp = 2 },
        { label = "Elevator L phys",     dref = "tu-154/controlls/elev_L_phys",        kind = "value", dp = 2 },
        { label = "Elevator R phys",     dref = "tu-154/controlls/elev_R_phys",        kind = "value", dp = 2 },
        { label = "Aileron L phys",      dref = "tu-154/controlls/ail_L_phys",         kind = "value", dp = 2 },
        { label = "Aileron R phys",      dref = "tu-154/controlls/ail_R_phys",         kind = "value", dp = 2 },
        { label = "Spoiler L phys",      dref = "tu-154/controlls/spoil_L_phys",       kind = "value", dp = 2 },
        { label = "Spoiler R phys",      dref = "tu-154/controlls/spoil_R_phys",       kind = "value", dp = 2 },
        { label = "Elev coefficient",    dref = "tu-154/controlls/elev_coeff",         kind = "value", dp = 3 },
        { label = "Rudder coefficient",  dref = "tu-154/controlls/rudder_coeff",       kind = "value", dp = 3 },

        { label = "Spoiler lever",       dref = "tu-154/controlls/spoilers_lever",      kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Spoilers inn left",   dref = "tu-154/lights/spoilers_inn_left",      kind = "lamp" },
        { label = "Spoilers inn right",  dref = "tu-154/lights/spoilers_inn_right",     kind = "lamp" },
        { label = "Spoilers mid left",   dref = "tu-154/lights/spoilers_mid_left",      kind = "lamp" },
        { label = "Spoilers mid right",  dref = "tu-154/lights/spoilers_mid_right",     kind = "lamp" },
        { label = "Booster 1",           dref = "tu-154/switchers/console/buster_on_1", kind = "lamp" },
        { label = "Booster 2",           dref = "tu-154/switchers/console/buster_on_2", kind = "lamp" },
        { label = "Booster 3",           dref = "tu-154/switchers/console/buster_on_3", kind = "lamp" },
        { label = "Feel unit selector",  dref = "tu-154/controll/contr_force_set",      kind = "enum", map = { [-1] = "FLIGHT", [0] = "AUTO", [1] = "T/O-LDG" } },
        { label = "Feel unit elev",      dref = "tu-154/controls/control_force_pos",     kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Feel unit rudder",    dref = "tu-154/controls/control_force_pos_rud", kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Control load 27 L",   dref = "tu-154/control/ctr_27_L_cc",           kind = "bar", min = 0, max = 100, unit = "A" },
        { label = "Control load 27 R",   dref = "tu-154/control/ctr_27_R_cc",           kind = "bar", min = 0, max = 100, unit = "A" },

        { label = "Aileron L failed",    dref = "tu-154/failures/ail_fail_left",         kind = "fail" },
        { label = "Aileron R failed",    dref = "tu-154/failures/ail_fail_right",        kind = "fail" },
        { label = "Flap L failed",       dref = "tu-154/failures/flap_fail_left",        kind = "fail" },
        { label = "Flap R failed",       dref = "tu-154/failures/flap_fail_right",       kind = "fail" },
        { label = "Slats failed",        dref = "tu-154/failures/slats_fail",            kind = "fail" },
        { label = "Rudder failed",       dref = "tu-154/failures/rudder_fail",           kind = "fail" },
        { label = "Elevator L failed",   dref = "tu-154/failures/elev_fail_left",        kind = "fail" },
        { label = "Elevator R failed",   dref = "tu-154/failures/elev_fail_right",       kind = "fail" },
        { label = "Stab drive failed",   dref = "tu-154/failures/stab_eng_fail",         kind = "fail" },
        { label = "Stab auto failed",    dref = "tu-154/failures/stab_automatic_fail",   kind = "fail" },
        { label = "Emerg trim failed",   dref = "tu-154/failures/trim_emerg_elv_fail",   kind = "fail" },
        { label = "Spoil inn L failed",  dref = "tu-154/failures/fail_spoil_inn_left",   kind = "fail" },
        { label = "Spoil inn R failed",  dref = "tu-154/failures/fail_spoil_inn_right",  kind = "fail" },
        { label = "Spoil mid L failed",  dref = "tu-154/failures/fail_spoil_mid_left",   kind = "fail" },
        { label = "Spoil mid R failed",  dref = "tu-154/failures/fail_spoil_mid_right",  kind = "fail" },
        { label = "Spoil out L failed",  dref = "tu-154/failures/fail_spoil_out_left",   kind = "fail" },
        { label = "Spoil out R failed",  dref = "tu-154/failures/fail_spoil_out_right",  kind = "fail" },
    } },

    -- =======================================================================
    { name = "Flight instruments", short = "Flt", fields = {
        { label = "SVS altitude",        dref = "tu-154/svs/altitude",                  kind = "value", unit = "m" },
        { label = "SVS mach",            dref = "tu-154/svs/machno",                    kind = "value", dp = 3 },
        { label = "SVS TAS",             dref = "tu-154/svs/true_airspeed",             kind = "value", unit = "km/h" },
        { label = "IAS captain",         dref = "tu-154/gauges/speed/ias_left",         kind = "value", unit = "km/h" },
        { label = "IAS copilot",         dref = "tu-154/gauges/speed/ias_right",        kind = "value", unit = "km/h" },
        { label = "Mach captain",        dref = "tu-154/gauges/speed/mach_left",        kind = "value", dp = 3 },
        { label = "Mach copilot",        dref = "tu-154/gauges/speed/mach_right",       kind = "value", dp = 3 },
        { label = "KUS IAS captain",     dref = "tu-154/gauges/speed/kus_ias_left",     kind = "value", unit = "km/h" },
        { label = "KUS TAS captain",     dref = "tu-154/gauges/speed/kus_tas_left",     kind = "value", unit = "km/h" },
        { label = "Yellow marker L",     dref = "tu-154/gauges/speed/ias_yellow_left",  kind = "value", unit = "km/h" },
        { label = "Yellow marker R",     dref = "tu-154/gauges/speed/ias_yellow_right", kind = "value", unit = "km/h" },

        { label = "VSI left",            dref = "tu-154/gauges/vvi_left",                  kind = "value", unit = "m/s", dp = 1 },
        { label = "VSI right",           dref = "tu-154/gauges/vvi_right",                 kind = "value", unit = "m/s", dp = 1 },
        { label = "VAR-75",              dref = "tu-154/gauges/alt/var75",                 kind = "value", dp = 2 },
        { label = "VAR-30",              dref = "tu-154/gauges/alt/var30",                 kind = "value", dp = 2 },
        { label = "VD-15 alt captain",   dref = "tu-154/gauges/alt/vd15_alt_left",         kind = "value", unit = "m" },
        { label = "VD-15 alt copilot",   dref = "tu-154/gauges/alt/vd15_alt_right",        kind = "value", unit = "m" },
        { label = "VD-15 press cap",     dref = "tu-154/gauges/alt/vd15_pressure_left",    kind = "value", dp = 1 },
        { label = "VD-15 press cop",     dref = "tu-154/gauges/alt/vd15_pressure_right",   kind = "value", dp = 1 },
        { label = "VBE alt left",        dref = "tu-154/gauges/alt/vbe_alt_left",          kind = "value", unit = "m" },
        { label = "VBE alt right",       dref = "tu-154/gauges/alt/vbe_alt_right",         kind = "value", unit = "m" },
        { label = "VBE press left",      dref = "tu-154/gauges/alt/vbe_press_left",        kind = "value" },
        { label = "VBE press right",     dref = "tu-154/gauges/alt/vbe_press_right",       kind = "value" },
        { label = "VBE FL left",         dref = "tu-154/gauges/alt/vbe_flightlevel_left",  kind = "value" },
        { label = "VBE FL right",        dref = "tu-154/gauges/alt/vbe_flightlevel_right", kind = "value" },
        { label = "VBE STD left",        dref = "tu-154/gauges/alt/vbe_std_left",          kind = "lamp" },
        { label = "VBE STD right",       dref = "tu-154/gauges/alt/vbe_std_right",         kind = "lamp" },
        { label = "UVID-15 needle",      dref = "tu-154/gauges/alt/uvid_needle_left",      kind = "value", dp = 1 },

        { label = "RV-5 alt left",       dref = "tu-154/misc/rv5_alt_left",                 kind = "value", unit = "m", dp = 1 },
        { label = "RV-5 alt right",      dref = "tu-154/misc/rv5_alt_right",                kind = "value", unit = "m", dp = 1 },
        { label = "RV-5 DH left",        dref = "tu-154/misc/rv5_dh_signal_left",           kind = "lamp" },
        { label = "RV-5 DH right",       dref = "tu-154/misc/rv5_dh_signal_right",          kind = "lamp" },
        { label = "RV-5 flag left",      dref = "tu-154/gauges/alt/radioalt_flag_left",     kind = "lamp", fault = true },
        { label = "RV-5 flag right",     dref = "tu-154/gauges/alt/radioalt_flag_right",    kind = "lamp", fault = true },

        { label = "Roll captain",        dref = "tu-154/gauges/ahz/roll_L",         kind = "value", unit = "deg", dp = 1 },
        { label = "Pitch captain",       dref = "tu-154/gauges/ahz/pitch_L",        kind = "value", unit = "deg", dp = 1 },
        { label = "Roll copilot",        dref = "tu-154/gauges/ahz/roll_R",         kind = "value", unit = "deg", dp = 1 },
        { label = "Pitch copilot",       dref = "tu-154/gauges/ahz/pitch_R",        kind = "value", unit = "deg", dp = 1 },
        { label = "Roll AGR",            dref = "tu-154/gauges/ahz/roll_C",         kind = "value", unit = "deg", dp = 1 },
        { label = "Pitch AGR",           dref = "tu-154/gauges/ahz/pitch_C",        kind = "value", unit = "deg", dp = 1 },
        { label = "AGD flag captain",    dref = "tu-154/gauges/ahz/ahz_flag_L",     kind = "lamp", fault = true },
        { label = "AGD flag copilot",    dref = "tu-154/gauges/ahz/ahz_flag_R",     kind = "lamp", fault = true },
        { label = "AGR flag",            dref = "tu-154/gauges/ahz/ahz_flag_C",     kind = "lamp", fault = true },
        { label = "MGV monitor roll",    dref = "tu-154/gyro/mgv_contr_roll",       kind = "value", unit = "deg", dp = 1 },
        { label = "MGV monitor pitch",   dref = "tu-154/gyro/mgv_contr_pitch",      kind = "value", unit = "deg", dp = 1 },
        { label = "MGV monitor flag",    dref = "tu-154/gyro/mgv_contr_flag",       kind = "lamp", fault = true },
        { label = "BKK pitch",           dref = "tu-154/bkk/bkk_pitch",             kind = "value", unit = "deg", dp = 1 },
        { label = "BKK roll",            dref = "tu-154/bkk/bkk_roll",              kind = "value", unit = "deg", dp = 1 },
        { label = "PKP roll left",       dref = "tu-154/bkk/pkp_roll_left",         kind = "value", unit = "deg", dp = 1 },
        { label = "PKP roll right",      dref = "tu-154/bkk/pkp_roll_right",        kind = "value", unit = "deg", dp = 1 },

        { label = "Angle of attack",     dref = "tu-154/gauges/misc/aoa_ind",       kind = "value", unit = "deg", dp = 1 },
        { label = "AoA sector",          dref = "tu-154/gauges/misc/aoa_sector",    kind = "value", dp = 1 },
        { label = "G load",              dref = "tu-154/gauges/misc/gforce_ind",    kind = "value", unit = "g", dp = 2 },
        { label = "G load max",          dref = "tu-154/gauges/misc/gforce_max",    kind = "value", unit = "g", dp = 2 },
        { label = "G load min",          dref = "tu-154/gauges/misc/gforce_min",    kind = "value", unit = "g", dp = 2 },
        { label = "Turn rate",           dref = "tu-154/gauges/misc/turn_rate_ind", kind = "value", dp = 2 },
        { label = "Slip",                dref = "tu-154/gauges/misc/slip_rate_ind", kind = "value", dp = 2 },
        { label = "Outside air temp",    dref = "tu-154/gauges/misc/thermo_outside", kind = "value", unit = "C", dp = 1 },

        { label = "Pitot 1 failed",      dref = "tu-154/failures/pitot1",           kind = "fail" },
        { label = "Pitot 2 failed",      dref = "tu-154/failures/pitot2",           kind = "fail" },
        { label = "Static 1 failed",     dref = "tu-154/failures/static1",          kind = "fail" },
        { label = "Static 2 failed",     dref = "tu-154/failures/static2",          kind = "fail" },
        { label = "AoA sensor failed",   dref = "tu-154/failures/AOA",              kind = "fail" },
        { label = "UVID-15 failed",      dref = "tu-154/failures/uvid15_fail",      kind = "fail" },
        { label = "RV-5 1 failed",       dref = "tu-154/failures/rv1_fail",         kind = "fail" },
        { label = "RV-5 2 failed",       dref = "tu-154/failures/rv2_fail",         kind = "fail" },
        { label = "AGR failed",          dref = "tu-154/failures/agr_fail",         kind = "fail" },
        { label = "MGV failed",          dref = "tu-154/failures/mgv_fail",         kind = "fail" },
        { label = "BKK failed",          dref = "tu-154/failures/bkk_fail",         kind = "fail" },
        { label = "KPP 1 failed",        dref = "tu-154/failures/kpp_1_fail",       kind = "fail" },
        { label = "KPP 2 failed",        dref = "tu-154/failures/kpp_2_fail",       kind = "fail" },
        { label = "KPP 3 failed",        dref = "tu-154/failures/kpp_3_fail",       kind = "fail" },
    } },

    -- =======================================================================
    { name = "ABSU-154 autopilot", short = "ABSU", fields = {
        { label = "Roll main mode",      dref = "tu-154/absu/roll_main_mode",               kind = "enum", map = ENUM_AXIS_MAIN },
        { label = "Pitch main mode",     dref = "tu-154/absu/pitch_main_mode",              kind = "enum", map = ENUM_AXIS_MAIN },
        { label = "Roll sub mode",       dref = "tu-154/absu/roll_sub_mode",                kind = "enum", map = { [0] = "OFF", [1] = "STAB", [2] = "ZK", [3] = "NVU", [4] = "AZ 1", [5] = "AZ 2", [6] = "APPROACH" } },
        { label = "Pitch sub mode",      dref = "tu-154/absu/pitch_sub_mode",               kind = "enum", map = { [0] = "OFF", [1] = "STAB", [2] = "V", [3] = "M", [4] = "H", [5] = "GLIDESLOPE", [6] = "GO-AROUND" } },
        { label = "Roll mode console",   dref = "tu-154/gauges/console/absu_roll_mode",     kind = "enum", map = ENUM_AXIS_MAIN },
        { label = "Pitch mode console",  dref = "tu-154/gauges/console/absu_pitch_mode",    kind = "enum", map = ENUM_AXIS_MAIN },
        { label = "Autothrottle mode",   dref = "tu-154/absu/stu_mode",                     kind = "enum", map = { [0] = "OFF", [1] = "ON", [2] = "ARMED", [3] = "STAB", [4] = "GO-AROUND" } },
        { label = "Go-around command",   dref = "tu-154/absu/toga_comm",                    kind = "lamp" },
        { label = "STU mode selector",   dref = "tu-154/switchers/console/absu_speed_mode", kind = "enum", map = { [0] = "OFF", [1] = "NVU", [2] = "AZ 1", [3] = "AZ 2", [4] = "LANDING" } },
        { label = "PNP mode 1",          dref = "tu-154/absu/absu_pnp_mode_1",              kind = "enum", map = ENUM_PNP },
        { label = "PNP mode 2",          dref = "tu-154/absu/absu_pnp_mode_2",              kind = "enum", map = ENUM_PNP },

        { label = "Roll director",       dref = "tu-154/absu/absu_roll_ind",       kind = "value", dp = 2 },
        { label = "Pitch director",      dref = "tu-154/absu/absu_pitch_ind",      kind = "value", dp = 2 },
        { label = "Roll director flag",  dref = "tu-154/absu/absu_roll_flag",      kind = "lamp", fault = true },
        { label = "Pitch dir flag",      dref = "tu-154/absu/absu_pitch_flag",     kind = "lamp", fault = true },
        { label = "RA-56 pitch rod",     dref = "tu-154/absu/contr_pitch",         kind = "value", dp = 3 },
        { label = "RA-56 roll rod",      dref = "tu-154/absu/contr_roll",          kind = "value", dp = 3 },
        { label = "RA-56 yaw rod",       dref = "tu-154/absu/contr_yaw",           kind = "value", dp = 3 },
        { label = "Command pitch",       dref = "tu-154/absu/cmd_pitch",           kind = "value", dp = 3 },
        { label = "Command roll",        dref = "tu-154/absu/cmd_roll",            kind = "value", dp = 3 },
        { label = "Command yaw",         dref = "tu-154/absu/cmd_yaw",             kind = "value", dp = 3 },
        { label = "Throttle 1 rate",     dref = "tu-154/absu/rud_1_spd",           kind = "value", dp = 3 },
        { label = "Throttle 2 rate",     dref = "tu-154/absu/rud_2_spd",           kind = "value", dp = 3 },
        { label = "Throttle 3 rate",     dref = "tu-154/absu/rud_3_spd",           kind = "value", dp = 3 },
        { label = "ABSU pitch trim",     dref = "tu-154/absu/absu_pitch_trimm",    kind = "enum", map = { [-1] = "NOSE DN", [0] = "OFF", [1] = "NOSE UP" } },
        { label = "H integral",          dref = "tu-154/absu/d_H_integral",        kind = "value", dp = 3 },
        { label = "V integral",          dref = "tu-154/absu/d_V_integral",        kind = "value", dp = 3 },
        { label = "M integral",          dref = "tu-154/absu/d_M_integral",        kind = "value", dp = 4 },

        { label = "ABSU healthy",        dref = "tu-154/lights/absu_work",         kind = "lamp" },
        { label = "Stabilisation on",    dref = "tu-154/lights/stab_work",         kind = "lamp" },
        { label = "STAB roll",           dref = "tu-154/lights/stab_roll",         kind = "lamp" },
        { label = "STAB pitch",          dref = "tu-154/lights/stab_pitch",        kind = "lamp" },
        { label = "STAB H",              dref = "tu-154/lights/stab_h",            kind = "lamp" },
        { label = "STAB V",              dref = "tu-154/lights/stab_v",            kind = "lamp" },
        { label = "STAB M",              dref = "tu-154/lights/stab_m",            kind = "lamp" },
        { label = "STU roll lamp",       dref = "tu-154/lights/small/stu_roll",    kind = "lamp" },
        { label = "STU pitch lamp",      dref = "tu-154/lights/small/stu_pitch",   kind = "lamp" },
        { label = "STU go-around lamp",  dref = "tu-154/lights/small/stu_toga",    kind = "lamp" },
        { label = "AT 2 lamp",           dref = "tu-154/lights/small/at_2",        kind = "lamp" },
        { label = "Roll damper fail",    dref = "tu-154/absu/damp_roll_lamp",      kind = "lamp", fault = true },
        { label = "Pitch damper fail",   dref = "tu-154/absu/damp_pitch_lamp",     kind = "lamp", fault = true },
        { label = "Yaw damper fail",     dref = "tu-154/absu/damp_yaw_lamp",       kind = "lamp", fault = true },
        { label = "Roll control fail",   dref = "tu-154/absu/roll_contr_lamp",     kind = "lamp", fault = true },
        { label = "Pitch control fail",  dref = "tu-154/absu/pitch_contr_lamp",    kind = "lamp", fault = true },
        { label = "Fly roll manually",   dref = "tu-154/absu/man_roll_lamp",       kind = "lamp" },
        { label = "Fly pitch manually",  dref = "tu-154/absu/man_pitch_lamp",      kind = "lamp" },
        { label = "Fly go-around",       dref = "tu-154/absu/man_toga_lamp",       kind = "lamp" },
        { label = "Triangle lamp",       dref = "tu-154/absu/triangle_lamp_signal", kind = "lamp", fault = true },
        { label = "ABSU fail siren",     dref = "tu-154/absu/absu_fail_signal",    kind = "lamp", fault = true },
        { label = "AT fail signal",      dref = "tu-154/absu/at_fail_signal",      kind = "lamp", fault = true },
        { label = "ABSU siren",          dref = "tu-154/alarm/speaker_absu",       kind = "lamp", fault = true },
        { label = "Outside course",      dref = "tu-154/absu_course_out",          kind = "lamp", fault = true },
        { label = "Outside glideslope",  dref = "tu-154/absu_gs_out",              kind = "lamp", fault = true },
        { label = "AT speed diff L",     dref = "tu-154/absu_at_dif_left",         kind = "value", dp = 1 },
        { label = "AT speed diff R",     dref = "tu-154/absu_at_dif_right",        kind = "value", dp = 1 },
        { label = "Second Kurs-MP",      dref = "tu-154/absu_use_second_nav",      kind = "lamp" },
        { label = "ABSU 27 V power",     dref = "tu-154/absu_power_27",            kind = "lamp" },
        { label = "ABSU load",           dref = "tu-154/absu_power_cc",            kind = "bar", min = 0, max = 50, unit = "A" },
        { label = "AT load",             dref = "tu-154/absu_at_power_cc",         kind = "bar", min = 0, max = 50, unit = "A" },

        { label = "Roll channel on",     dref = "tu-154/switchers/console/absu_roll_ch_on",  kind = "lamp" },
        { label = "Pitch channel on",    dref = "tu-154/switchers/console/absu_pitch_ch_on", kind = "lamp" },
        { label = "Turbulence mode",     dref = "tu-154/switchers/console/absu_smooth_on",   kind = "lamp" },
        { label = "Turn knob",           dref = "tu-154/switchers/console/absu_turn_handle", kind = "value" },
        { label = "Pitch thumbwheel",    dref = "tu-154/switchers/console/absu_pitch_wheel", kind = "value", dp = 2 },
        { label = "Nav needles on",      dref = "tu-154/switchers/console/absu_nav_on",      kind = "lamp" },
        { label = "Landing needles on",  dref = "tu-154/switchers/console/absu_landing_on",  kind = "lamp" },

        { label = "RA-56 roll failed",   dref = "tu-154/failures/absu_ra56_roll_fail",   kind = "fail" },
        { label = "RA-56 pitch failed",  dref = "tu-154/failures/absu_ra56_pitch_fail",  kind = "fail" },
        { label = "RA-56 yaw failed",    dref = "tu-154/failures/absu_ra56_yaw_fail",    kind = "fail" },
        { label = "AT 1 failed",         dref = "tu-154/failures/absu_at1_fail",         kind = "fail" },
        { label = "AT 2 failed",         dref = "tu-154/failures/absu_at2_fail",         kind = "fail" },
        { label = "Roll damper failed",  dref = "tu-154/failures/absu_damp_roll_fail",   kind = "fail" },
        { label = "Pitch damp failed",   dref = "tu-154/failures/absu_damp_pitch_fail",  kind = "fail" },
        { label = "Yaw damper failed",   dref = "tu-154/failures/absu_damp_yaw_fail",    kind = "fail" },
        { label = "Lateral ctrl failed", dref = "tu-154/failures/absu_contr_roll_fail",  kind = "fail" },
        { label = "Long ctrl failed",    dref = "tu-154/failures/absu_contr_pitch_fail", kind = "fail" },
        { label = "Go-around calc fail", dref = "tu-154/failures/absu_calc_toga_fail",   kind = "fail" },
        { label = "STU lateral failed",  dref = "tu-154/failures/absu_calc_roll_fail",   kind = "fail" },
        { label = "STU long failed",     dref = "tu-154/failures/absu_calc_pitch_fail",  kind = "fail" },
        { label = "BDLU failed",         dref = "tu-154/failures/absu_bdlu_fail",        kind = "fail" },
        { label = "AT blocked",          dref = "tu-154/failures/absu_at_blocked",       kind = "fail" },
    } },

    -- =======================================================================
    { name = "Navigation -- NVU / DISS / TKS / RSBN", short = "Nav", fields = {
        { label = "NVU mode",            dref = "tu-154/nvu/nvu_mode",                   kind = "enum", map = { [0] = "OFF", [1] = "READY", [2] = "DEAD RECK", [3] = "CORRECTION" } },
        { label = "Active NVU set",      dref = "tu-154/nvu/nvu_active",                 kind = "enum", map = { [0] = "NONE", [1] = "NVU 1", [2] = "NVU 2" } },
        { label = "NVU heading",         dref = "tu-154/nvu/nvu_res_course",             kind = "value", unit = "deg", dp = 1 },
        { label = "NVU track offset",    dref = "tu-154/nvu/nvu_res_z",                  kind = "value", unit = "km", dp = 2 },
        { label = "Changing orthodrome", dref = "tu-154/nvu/nvu_changing_ort",           kind = "lamp" },
        { label = "NVU not available",   dref = "tu-154/nvu/nvu_fail",                   kind = "lamp", fault = true },
        { label = "Current S1",          dref = "tu-154/nvu/current_S1",                 kind = "value", dp = 1 },
        { label = "Current Z1",          dref = "tu-154/nvu/current_Z1",                 kind = "value", dp = 1 },
        { label = "Next S1",             dref = "tu-154/nvu/next_S1",                    kind = "value", dp = 1 },
        { label = "Next Z1",             dref = "tu-154/nvu/next_Z1",                    kind = "value", dp = 1 },
        { label = "Current S2",          dref = "tu-154/nvu/current_S2",                 kind = "value", dp = 1 },
        { label = "Current Z2",          dref = "tu-154/nvu/current_Z2",                 kind = "value", dp = 1 },
        { label = "Next S2",             dref = "tu-154/nvu/next_S2",                    kind = "value", dp = 1 },
        { label = "Next Z2",             dref = "tu-154/nvu/next_Z2",                    kind = "value", dp = 1 },
        { label = "ZPU 1",               dref = "tu-154/nvu/zpu1",                       kind = "value", unit = "deg", dp = 1 },
        { label = "ZPU 2",               dref = "tu-154/nvu/zpu2",                       kind = "value", unit = "deg", dp = 1 },
        { label = "NVU power on",        dref = "tu-154/switchers/console/nvu_power_on", kind = "lamp" },
        { label = "NVU reckoning on",    dref = "tu-154/switchers/console/nvu_calc_on",  kind = "lamp" },
        { label = "NVU correction on",   dref = "tu-154/switchers/console/nvu_corr_on",  kind = "lamp" },
        { label = "Turn radius knob",    dref = "tu-154/switchers/console/nvu_turn_sel", kind = "enum", map = { [-1] = "FORCED", [0] = "OFF", [1] = "R 5", [2] = "R 10", [3] = "R 15", [4] = "R 20", [5] = "R 25" } },
        { label = "NVU / SNS select",    dref = "tu-154/switchers/nav_select",           kind = "enum", map = { [0] = "NVU", [1] = "SNS" } },
        { label = "ZK entry side",       dref = "tu-154/switchers/ZK_select",            kind = "enum", map = { [0] = "LEFT", [1] = "RIGHT" } },
        { label = "NVU load",            dref = "tu-154/nvu/nvu_cc",                     kind = "bar", min = 0, max = 50, unit = "A" },

        { label = "DISS mode",           dref = "tu-154/nvu/diss_mode",            kind = "enum", map = { [0] = "OFF", [1] = "OPERATE", [2] = "MEMORY" } },
        { label = "DISS ground speed",   dref = "tu-154/nvu/diss_groundspeed",     kind = "value", unit = "km/h" },
        { label = "DISS drift angle",    dref = "tu-154/nvu/diss_slip_angle",      kind = "value", unit = "deg", dp = 1 },
        { label = "DISS wind dir",       dref = "tu-154/nvu/diss_wind_course",     kind = "value", unit = "deg" },
        { label = "DISS wind speed",     dref = "tu-154/nvu/diss_wind_spd",        kind = "value", unit = "km/h" },
        { label = "DISS load",           dref = "tu-154/nvu/diss_cc",              kind = "bar", min = 0, max = 50, unit = "A" },

        { label = "TKS heading GPK",     dref = "tu-154/tks/course_gpk",             kind = "value", unit = "deg", dp = 1 },
        { label = "TKS heading GMK",     dref = "tu-154/tks/course_gmk",             kind = "value", unit = "deg", dp = 1 },
        { label = "MK-5 heading 1",      dref = "tu-154/tks/course_mk_1",            kind = "value", unit = "deg", dp = 1 },
        { label = "MK-5 heading 2",      dref = "tu-154/tks/course_mk_2",            kind = "value", unit = "deg", dp = 1 },
        { label = "GA-1 heading",        dref = "tu-154/tks/course_ga_1",            kind = "value", unit = "deg", dp = 1 },
        { label = "GA-2 heading",        dref = "tu-154/tks/course_ga_2",            kind = "value", unit = "deg", dp = 1 },
        { label = "BGMK 1 heading",      dref = "tu-154/tks/course_bgmk_1",          kind = "value", unit = "deg", dp = 1 },
        { label = "BGMK 2 heading",      dref = "tu-154/tks/course_bgmk_2",          kind = "value", unit = "deg", dp = 1 },
        { label = "TKS fail left",       dref = "tu-154/tks/fail_left",              kind = "lamp", fault = true },
        { label = "TKS fail right",      dref = "tu-154/tks/fail_right",             kind = "lamp", fault = true },
        { label = "TKS main GA fail",    dref = "tu-154/lights/small/tks_main_fail",  kind = "lamp", fault = true },
        { label = "TKS ctrl GA fail",    dref = "tu-154/lights/small/tks_contr_fail", kind = "lamp", fault = true },

        { label = "RSBN azimuth",        dref = "tu-154/rsbn/azimuth",                    kind = "value", unit = "deg", dp = 1 },
        { label = "RSBN distance",       dref = "tu-154/rsbn/distance",                   kind = "value", unit = "km", dp = 1 },
        { label = "RSBN azimuth gauge",  dref = "tu-154/gauges/misc/rsbn_azimuth_ind",    kind = "value", dp = 1 },
        { label = "RSBN dist gauge",     dref = "tu-154/gauges/misc/rsbn_distance_km",    kind = "value", unit = "km", dp = 1 },
        { label = "RSBN receiving",      dref = "tu-154/failures/rsbn_rec",               kind = "lamp" },
        { label = "RSBN power",          dref = "tu-154/switchers/ovhd/rsbn_on",          kind = "lamp" },
        { label = "RSBN load",           dref = "tu-154/radio/rsbn_cc",                   kind = "bar", min = 0, max = 30, unit = "A" },

        { label = "KLN desired track",   dref = "tu-154/kln90/kln_course",         kind = "value", unit = "deg", dp = 1 },
        { label = "KLN deviation",       dref = "tu-154/kln90/kln_dev",            kind = "value", unit = "nm", dp = 2 },
        { label = "KLN flag",            dref = "tu-154/kln90/kln_flag",           kind = "lamp", fault = true },
        { label = "KLN switch",          dref = "tu-154/switchers/ovhd/kln_on",    kind = "lamp" },

        { label = "NVU failed",          dref = "tu-154/failures/nvu_fail",             kind = "fail" },
        { label = "DISS failed",         dref = "tu-154/failures/diss_fail",            kind = "fail" },
        { label = "RSBN failed",         dref = "tu-154/failures/rsbn_fail",            kind = "fail" },
        { label = "NVU-VOR auto fail",   dref = "tu-154/failures/nvu_vor_avtomat_fail", kind = "fail" },
        { label = "TKS KM 1 failed",     dref = "tu-154/failures/tks_km1_fail",         kind = "fail" },
        { label = "TKS KM 2 failed",     dref = "tu-154/failures/tks_km2_fail",         kind = "fail" },
        { label = "TKS BGMK 1 failed",   dref = "tu-154/failures/tks_bgmk1_fail",       kind = "fail" },
        { label = "TKS BGMK 2 failed",   dref = "tu-154/failures/tks_bgmk2_fail",       kind = "fail" },
    } },

    -- =======================================================================
    { name = "Radio navigation and comms", short = "Radio", fields = {
        { label = "ARK 1 bearing",       dref = "tu-154/radio/adf_bear_1",             kind = "value", unit = "deg", dp = 1 },
        { label = "ARK 2 bearing",       dref = "tu-154/radio/adf_bear_2",             kind = "value", unit = "deg", dp = 1 },
        { label = "ARK 1 signal",        dref = "tu-154/radio/ark15_L_signal",         kind = "value", dp = 2 },
        { label = "ARK 2 signal",        dref = "tu-154/radio/ark15_R_signal",         kind = "value", dp = 2 },
        { label = "ARK 1 mode",          dref = "tu-154/switchers/ovhd/ark_1_mode",    kind = "enum", map = { [0] = "OFF", [1] = "COMPASS", [2] = "ANTENNA", [3] = "LOOP" } },
        { label = "ARK 2 mode",          dref = "tu-154/switchers/ovhd/ark_2_mode",    kind = "enum", map = { [0] = "OFF", [1] = "COMPASS", [2] = "ANTENNA", [3] = "LOOP" } },
        { label = "ARK 1 channel",       dref = "tu-154/switchers/ovhd/ark_1_channel", kind = "value" },
        { label = "ARK 2 channel",       dref = "tu-154/switchers/ovhd/ark_2_channel", kind = "value" },

        { label = "VOR 1 bearing",       dref = "tu-154/radio/vor_bear_1",         kind = "value", unit = "deg", dp = 1 },
        { label = "VOR 2 bearing",       dref = "tu-154/radio/vor_bear_2",         kind = "value", unit = "deg", dp = 1 },
        { label = "DME 1 distance",      dref = "tu-154/radio/vor_dme_1",          kind = "value", dp = 1 },
        { label = "DME 2 distance",      dref = "tu-154/radio/vor_dme_2",          kind = "value", dp = 1 },
        { label = "NAV 1 course bar",    dref = "tu-154/radio/nav1_cs",            kind = "value", dp = 3 },
        { label = "NAV 1 glideslope",    dref = "tu-154/radio/nav1_gs",            kind = "value", dp = 3 },
        { label = "NAV 2 course bar",    dref = "tu-154/radio/nav2_cs",            kind = "value", dp = 3 },
        { label = "NAV 2 glideslope",    dref = "tu-154/radio/nav2_gs",            kind = "value", dp = 3 },
        { label = "NAV 1 course flag",   dref = "tu-154/radio/nav1_cs_flag",       kind = "lamp", fault = true },
        { label = "NAV 1 GS flag",       dref = "tu-154/radio/nav1_gs_flag",       kind = "lamp", fault = true },
        { label = "NAV 2 course flag",   dref = "tu-154/radio/nav2_cs_flag",       kind = "lamp", fault = true },
        { label = "NAV 2 GS flag",       dref = "tu-154/radio/nav2_gs_flag",       kind = "lamp", fault = true },
        { label = "SP-50 course 1",      dref = "tu-154/lights/small/sp50_c1",     kind = "lamp" },
        { label = "SP-50 GS 1",          dref = "tu-154/lights/small/sp50_g1",     kind = "lamp" },
        { label = "SP-50 course 2",      dref = "tu-154/lights/small/sp50_c2",     kind = "lamp" },
        { label = "SP-50 GS 2",          dref = "tu-154/lights/small/sp50_g2",     kind = "lamp" },
        { label = "SP-50 mode",          dref = "tu-154/switchers/ovhd/sp50_mode",     kind = "enum", map = { [0] = "ILS", [1] = "KATET", [2] = "SP-50" } },
        { label = "SP-50 nav mode",      dref = "tu-154/switchers/ovhd/sp50_nav_mode", kind = "enum", map = { [0] = "LANDING", [1] = "EN ROUTE" } },
        { label = "SP-50 DME/RSBN",      dref = "tu-154/switchers/ovhd/sp50_dme_rsbn", kind = "enum", map = { [0] = "DME", [1] = "RSBN" } },

        { label = "RMI 1 src captain",   dref = "tu-154/gauges/compas/source_1_switch_left",  kind = "enum", map = ENUM_RMI_SRC },
        { label = "RMI 2 src captain",   dref = "tu-154/gauges/compas/source_2_switch_left",  kind = "enum", map = ENUM_RMI_SRC },
        { label = "RMI 1 src copilot",   dref = "tu-154/gauges/compas/source_1_switch_right", kind = "enum", map = ENUM_RMI_SRC },
        { label = "RMI 2 src copilot",   dref = "tu-154/gauges/compas/source_2_switch_right", kind = "enum", map = ENUM_RMI_SRC },
        { label = "Bearing 1 captain",   dref = "tu-154/gauges/compas/bearing_1_left",        kind = "value", unit = "deg", dp = 1 },
        { label = "Bearing 2 captain",   dref = "tu-154/gauges/compas/bearing_2_left",        kind = "value", unit = "deg", dp = 1 },
        { label = "Bearing 1 copilot",   dref = "tu-154/gauges/compas/bearing_1_right",       kind = "value", unit = "deg", dp = 1 },
        { label = "Bearing 2 copilot",   dref = "tu-154/gauges/compas/bearing_2_right",       kind = "value", unit = "deg", dp = 1 },

        { label = "Radar on",            dref = "tu-154/switchers/console/rls_on",       kind = "lamp" },
        { label = "Radar mode",          dref = "tu-154/switchers/console/rls_mode",     kind = "enum", map = { [0] = "READY", [1] = "WEATHER" } },
        { label = "Radar range",         dref = "tu-154/switchers/console/rls_distance", kind = "value" },
        { label = "Radar ready lamp",    dref = "tu-154/lights/small/rls_ready",         kind = "lamp" },
        { label = "Radar weather lamp",  dref = "tu-154/lights/small/rls_weather",       kind = "lamp" },

        { label = "Transponder red",     dref = "tu-154/lights/small/transponder_red",   kind = "lamp", fault = true },
        { label = "Transponder green",   dref = "tu-154/lights/small/transponder_green", kind = "lamp" },
        { label = "Transponder fail",    dref = "tu-154/lights/small/transponder1_fail", kind = "lamp", fault = true },

        { label = "VHF 1 load",          dref = "tu-154/radio/vhf1_cc",            kind = "bar", min = 0, max = 20, unit = "A" },
        { label = "VHF 2 load",          dref = "tu-154/radio/vhf2_cc",            kind = "bar", min = 0, max = 20, unit = "A" },
        { label = "ARK 1 load",          dref = "tu-154/radio/ark15_L_cc",         kind = "bar", min = 0, max = 20, unit = "A" },
        { label = "ARK 2 load",          dref = "tu-154/radio/ark15_R_cc",         kind = "bar", min = 0, max = 20, unit = "A" },
        { label = "Kurs-MP 1 load",      dref = "tu-154/radio/nav1_pow_cc",        kind = "bar", min = 0, max = 20, unit = "A" },
        { label = "Kurs-MP 2 load",      dref = "tu-154/radio/nav2_pow_cc",        kind = "bar", min = 0, max = 20, unit = "A" },
        { label = "Radar load",          dref = "tu-154/radio/radar_cc",           kind = "bar", min = 0, max = 20, unit = "A" },

        { label = "Kurs-MP 1 failed",    dref = "tu-154/failures/nav1_fail",       kind = "fail" },
        { label = "Kurs-MP 2 failed",    dref = "tu-154/failures/nav2_fail",       kind = "fail" },
        { label = "SD-72 1 failed",      dref = "tu-154/failures/dme1_fail",       kind = "fail" },
        { label = "SD-72 2 failed",      dref = "tu-154/failures/dme2_fail",       kind = "fail" },
        { label = "MRP failed",          dref = "tu-154/failures/mrp_fail",        kind = "fail" },
        { label = "Radar failed",        dref = "tu-154/failures/radar_fail",      kind = "fail" },
    } },

    -- =======================================================================
    { name = "Warnings -- SRPBZ / TCAS / BKK", short = "Warn", fields = {
        { label = "Gear/flap warning",   dref = "tu-154/alarm/main_gear_flaps",    kind = "lamp", fault = true },
        { label = "Cabin pressure",      dref = "tu-154/alarm/main_pressure",      kind = "lamp", fault = true },
        { label = "AoA / g siren",       dref = "tu-154/alarm/speaker_auasp",      kind = "lamp", fault = true },
        { label = "Fuel siren",          dref = "tu-154/alarm/speaker_fuel",       kind = "lamp", fault = true },
        { label = "Overspeed siren",     dref = "tu-154/alarm/speaker_speed",      kind = "lamp", fault = true },
        { label = "ABSU siren",          dref = "tu-154/alarm/speaker_absu",       kind = "lamp", fault = true },
        { label = "Triangle lamp",       dref = "tu-154/lights/triangle",          kind = "lamp", fault = true },
        { label = "Terrain warning",     dref = "tu-154/lights/warning_terrain",   kind = "lamp", fault = true },

        { label = "Critical AoA",        dref = "tu-154/auasp/alpha_critical",     kind = "lamp", fault = true },
        { label = "Critical g",          dref = "tu-154/auasp/gforce_critical",    kind = "lamp", fault = true },
        { label = "BKK left bank big",   dref = "tu-154/bkk/left_roll_big",        kind = "lamp", fault = true },
        { label = "BKK right bank big",  dref = "tu-154/bkk/right_roll_big",       kind = "lamp", fault = true },
        { label = "BKK MGV ctrl fail",   dref = "tu-154/bkk/mgv_contr_fail",       kind = "lamp", fault = true },
        { label = "BKK no AG monitor",   dref = "tu-154/bkk/no_contr_ag",          kind = "lamp", fault = true },
        { label = "BKK PKP left fail",   dref = "tu-154/bkk/pkp_fail_left",        kind = "lamp", fault = true },
        { label = "BKK PKP right fail",  dref = "tu-154/bkk/pkp_fail_right",       kind = "lamp", fault = true },
        { label = "BKK healthy lamp",    dref = "tu-154/lights/small/bkk_ok",      kind = "lamp" },

        { label = "SRPBZ mode",          dref = "tu-154/taws/mode_set",            kind = "enum", map = { [0] = "OFF", [1] = "TERRAIN", [2] = "PROFILE", [3] = "CLOCK", [4] = "POWER UP" } },
        { label = "SRPBZ range",         dref = "tu-154/taws/distance_set",        kind = "enum", map = { [0] = "10 km", [1] = "20 km", [2] = "40 km", [3] = "80 km", [4] = "160 km", [5] = "320 km", [6] = "640 km" } },
        { label = "SRPBZ message",       dref = "tu-154/taws/taws_message",        kind = "enum", map = { [0] = "NONE", [1] = "PULL UP", [2] = "ALT CALL", [3] = "PULL UP", [4] = "TERRAIN", [5] = "TERR AHEAD", [6] = "LOW TERRAIN", [7] = "ALT CALL", [8] = "LOW GEAR", [9] = "LOW FLAPS", [10] = "CHECK ALT", [11] = "SINK RATE", [12] = "DONT SINK", [13] = "GLIDESLOPE" } },
        { label = "SRPBZ language",      dref = "tu-154/taws/taws_english",        kind = "enum", map = { [0] = "RUSSIAN", [1] = "ENGLISH" } },
        { label = "SRPBZ alt left",      dref = "tu-154/taws/taws_alt_left",       kind = "lamp" },
        { label = "SRPBZ alt right",     dref = "tu-154/taws/taws_alt_right",      kind = "lamp" },
        { label = "SRPBZ load",          dref = "tu-154/taws/taws_cc",             kind = "bar", min = 0, max = 20, unit = "A" },
        { label = "GS alert interval",   dref = "tu-154/taws/gs_msg_int",          kind = "value", dp = 2 },
        { label = "GS alert volume",     dref = "tu-154/taws/gs_msg_vol",          kind = "value", dp = 2 },
        { label = "EGPWS sound inhibit", dref = "tu-154/egpws/dis_sound",          kind = "lamp", fault = true },
        { label = "EGPWS GS inhibit",    dref = "tu-154/egpws/dis_gs",             kind = "lamp", fault = true },
        { label = "EGPWS RPPZ inhibit",  dref = "tu-154/egpws/dis_rppz",           kind = "lamp", fault = true },
        { label = "EGPWS flap inhibit",  dref = "tu-154/egpws/dis_flaps",          kind = "lamp", fault = true },
        { label = "EGPWS gear inhibit",  dref = "tu-154/egpws/dis_gear",           kind = "lamp", fault = true },

        { label = "TCAS mode",           dref = "tu-154/tcas/mode_set",            kind = "enum", map = { [-1] = "TEST", [0] = "STBY", [1] = "ALT OFF", [2] = "ALT ON", [3] = "TA", [4] = "TA/RA" } },
        { label = "TCAS range",          dref = "tu-154/tcas/range_set",           kind = "enum", map = { [0] = "3 nm", [1] = "5 nm", [2] = "10 nm", [3] = "15 nm" } },
        { label = "TCAS level mode",     dref = "tu-154/tcas/level_mode",          kind = "enum", map = { [-1] = "BELOW", [0] = "NORMAL", [1] = "ABOVE" } },
        { label = "TCAS FL mode",        dref = "tu-154/tcas/fl_mode",             kind = "enum", map = { [0] = "ABSOLUTE", [1] = "RELATIVE" } },
        { label = "TCAS traffic",        dref = "tu-154/tcas/traffic_det",         kind = "lamp", fault = true },

        { label = "MSRP power",          dref = "tu-154/msrp/msrp_power",          kind = "lamp" },
        { label = "MSRP recording",      dref = "tu-154/msrp/msrp_recording",      kind = "lamp" },
        { label = "MSRP load 27 L",      dref = "tu-154/msrp/msrp_27_L_cc",        kind = "bar", min = 0, max = 20, unit = "A" },
        { label = "MSRP load 27 R",      dref = "tu-154/msrp/msrp_27_R_cc",        kind = "bar", min = 0, max = 20, unit = "A" },

        { label = "SRPBZ failed",        dref = "tu-154/failures/taws_fail",          kind = "fail" },
        { label = "Main siren failed",   dref = "tu-154/failures/main_alarm_fail",    kind = "fail" },
        { label = "Speaker siren fail",  dref = "tu-154/failures/speaker_alarm_fail", kind = "fail" },
    } },

    -- =======================================================================
    { name = "Doors, lights and payload", short = "Load", fields = {
        { label = "Front pax door L",    dref = "tu-154/lights/left_front_pax_door", kind = "lamp", fault = true },
        { label = "Mid pax door L",      dref = "tu-154/lights/left_mid_pax_door",   kind = "lamp", fault = true },
        { label = "Mid pax door R",      dref = "tu-154/lights/right_mid_pax_door",  kind = "lamp", fault = true },
        { label = "Front cargo hatch",   dref = "tu-154/lights/cargo_front_door",    kind = "lamp", fault = true },
        { label = "Rear cargo hatch",    dref = "tu-154/lights/cargo_back_door",     kind = "lamp", fault = true },
        { label = "Cargo door 1 anim",   dref = "tu-154/anim/cargo_1",               kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Cargo door 2 anim",   dref = "tu-154/anim/cargo_2",               kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Pax door 1 anim",     dref = "tu-154/anim/pax_door_1",            kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Pax door 2 anim",     dref = "tu-154/anim/pax_door_2",            kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Pax door 3 anim",     dref = "tu-154/anim/pax_door_3",            kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Cockpit door anim",   dref = "tu-154/anim/cockpit_door",          kind = "bar", min = 0, max = 1, dp = 2 },

        { label = "Landing light L",     dref = "tu-154/anim/light_open_left",        kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Landing light R",     dref = "tu-154/anim/light_open_right",       kind = "bar", min = 0, max = 1, dp = 2 },
        { label = "Land lamp fail FL",   dref = "tu-154/failures/lan_lamp_fail_FL",   kind = "fail" },
        { label = "Land lamp fail FR",   dref = "tu-154/failures/lan_lamp_fail_FR",   kind = "fail" },
        { label = "Land lamp fail WL",   dref = "tu-154/failures/lan_lamp_fail_WL",   kind = "fail" },
        { label = "Land lamp fail WR",   dref = "tu-154/failures/lan_lamp_fail_WR",   kind = "fail" },
        { label = "Cockpit light L amp", dref = "tu-154/elec/cockpit_light_cc_left",  kind = "bar", min = 0, max = 100, unit = "A" },
        { label = "Cockpit light R amp", dref = "tu-154/elec/cockpit_light_cc_right", kind = "bar", min = 0, max = 100, unit = "A" },
        { label = "Cockpit light 115",   dref = "tu-154/elec/cockpit_light_cc_115",   kind = "bar", min = 0, max = 100, unit = "A" },
        { label = "Ext light L amp",     dref = "tu-154/elec/ext_light_cc_left",      kind = "bar", min = 0, max = 100, unit = "A" },
        { label = "Ext light R amp",     dref = "tu-154/elec/ext_light_cc_right",     kind = "bar", min = 0, max = 100, unit = "A" },
        { label = "Ext light 115 amp",   dref = "tu-154/elec/ext_light_cc_115",       kind = "bar", min = 0, max = 100, unit = "A" },

        { label = "Actual weight",       dref = "tu-154/misc/weight_actual",       kind = "value", unit = "kg" },
        { label = "Actual CG",           dref = "tu-154/misc/cg_pos_actual",       kind = "value", unit = "%", dp = 2 },
        { label = "Crew in cockpit",     dref = "tu-154/payload/crew_num",         kind = "value" },
        { label = "Cabin crew",          dref = "tu-154/payload/cabin_num",        kind = "value" },
        { label = "Pax zone 1",          dref = "tu-154/payload/zone_1",           kind = "value" },
        { label = "Pax zone 2",          dref = "tu-154/payload/zone_2",           kind = "value" },
        { label = "Pax zone 4",          dref = "tu-154/payload/zone_4",           kind = "value" },
        { label = "Pax zone 5",          dref = "tu-154/payload/zone_5",           kind = "value" },
        { label = "Pax zone 6",          dref = "tu-154/payload/zone_6",           kind = "value" },
        { label = "Baggage 1",           dref = "tu-154/payload/cargo_1",          kind = "value", unit = "kg" },
        { label = "Baggage 2",           dref = "tu-154/payload/cargo_2",          kind = "value", unit = "kg" },
        { label = "Galley load",         dref = "tu-154/payload/kitchens",         kind = "value", unit = "kg" },
        { label = "Other load",          dref = "tu-154/payload/various",          kind = "value", unit = "kg" },
        { label = "Planned tank 1",      dref = "tu-154/payload/tank_1",           kind = "value", unit = "kg" },
        { label = "Planned tank 2L",     dref = "tu-154/payload/tank_2L",          kind = "value", unit = "kg" },
        { label = "Planned tank 2R",     dref = "tu-154/payload/tank_2R",          kind = "value", unit = "kg" },
        { label = "Planned tank 3L",     dref = "tu-154/payload/tank_3L",          kind = "value", unit = "kg" },
        { label = "Planned tank 3R",     dref = "tu-154/payload/tank_3R",          kind = "value", unit = "kg" },
        { label = "Planned tank 4",      dref = "tu-154/payload/tank_4",           kind = "value", unit = "kg" },
    } },

    -- =======================================================================
    { name = "Failure master and remaining flags", short = "Fail", fields = {
        { label = "Failures enabled",    dref = "tu-154/failures/failures_enabled", kind = "lamp" },
        { label = "Save state enabled",  dref = "tu-154/save_state_enabled",        kind = "lamp" },
        { label = "Hardware cockpit",    dref = "tu-154/hardware_cockpit",          kind = "lamp" },
        -- Time base. Frame time is the plugin's own delta; the three sim
        -- values beside it are what it is derived from, so a disagreement is
        -- visible at a glance. Under time acceleration, Frame time should
        -- track (sim speed actual / FPS), not 1/FPS -- see CLAUDE.md
        -- "Time base".
        { label = "Frame time",          dref = "tu-154/time/frame_time",           kind = "value", unit = "s", dp = 4 },
        { label = "Sim paused",          dref = "sim/time/paused",                  kind = "lamp" },
        { label = "Sim speed",           dref = "sim/time/sim_speed",               kind = "value", unit = "x", dp = 0 },
        { label = "Sim speed actual",    dref = "sim/time/sim_speed_actual",        kind = "value", unit = "x", dp = 2 },
        { label = "Sim frame period",    dref = "sim/operation/misc/frame_rate_period", kind = "value", unit = "s", dp = 4 },

        { label = "ACHS-1 captain fail",  dref = "tu-154/failures/acs1_fail",       kind = "fail" },
        { label = "ACHS-1 copilot fail",  dref = "tu-154/failures/acs2_fail",       kind = "fail" },
        { label = "ACHS-1 engineer fail", dref = "tu-154/failures/acs3_fail",       kind = "fail" },

        { label = "Fuel pump 1 fail",    dref = "tu-154/failures/fuel_pump_1_fail",      kind = "fail" },
        { label = "Fuel pump 2L fail",   dref = "tu-154/failures/fuel_pump_2l_fail",     kind = "fail" },
        { label = "Fuel pump 2R fail",   dref = "tu-154/failures/fuel_pump_2r_fail",     kind = "fail" },
        { label = "Fuel pump 3L fail",   dref = "tu-154/failures/fuel_pump_3l_fail",     kind = "fail" },
        { label = "Fuel pump 3R fail",   dref = "tu-154/failures/fuel_pump_3r_fail",     kind = "fail" },
        { label = "Fuel pump 4 fail",    dref = "tu-154/failures/fuel_pump_4_fail",      kind = "fail" },
        { label = "Fuel meter 1 fail",   dref = "tu-154/failures/fuel_meter_1_fail",     kind = "fail" },
        { label = "Fuel meter 2L fail",  dref = "tu-154/failures/fuel_meter_2l_fail",    kind = "fail" },
        { label = "Fuel meter 2R fail",  dref = "tu-154/failures/fuel_meter_2r_fail",    kind = "fail" },
        { label = "Fuel meter 3L fail",  dref = "tu-154/failures/fuel_meter_3l_fail",    kind = "fail" },
        { label = "Fuel meter 3R fail",  dref = "tu-154/failures/fuel_meter_3r_fail",    kind = "fail" },
        { label = "Fuel meter 4 fail",   dref = "tu-154/failures/fuel_meter_4_fail",     kind = "fail" },
        { label = "Fuel meter sum fail", dref = "tu-154/failures/fuel_meter_summ",       kind = "fail" },
        { label = "Flowmeter 1 fail",    dref = "tu-154/failures/fuel_flowmeter_1_fail", kind = "fail" },
        { label = "Flowmeter 2 fail",    dref = "tu-154/failures/fuel_flowmeter_2_fail", kind = "fail" },
        { label = "Flowmeter 3 fail",    dref = "tu-154/failures/fuel_flowmeter_3_fail", kind = "fail" },

        { label = "UTE 1 fail",          dref = "tu-154/failures/ute_1_fail",          kind = "fail" },
        { label = "UTE 2 fail",          dref = "tu-154/failures/ute_2_fail",          kind = "fail" },
        { label = "BShU pitch fail",     dref = "tu-154/failures/bshu_tet_fail",       kind = "fail" },
        { label = "BShU roll fail",      dref = "tu-154/failures/bshu_gam_fail",       kind = "fail" },
        { label = "BNS pitch fail",      dref = "tu-154/failures/bns_tet_fail",        kind = "fail" },
        { label = "BNS roll fail",       dref = "tu-154/failures/bns_gam_fail",        kind = "fail" },
        { label = "ABSU VU 1 fail",      dref = "tu-154/failures/absu_vu1_fail",       kind = "fail" },
        { label = "ABSU VU 2 fail",      dref = "tu-154/failures/absu_vu2_fail",       kind = "fail" },
        { label = "ABSU VU 3 fail",      dref = "tu-154/failures/absu_vu3_fail",       kind = "fail" },
        { label = "ABSU VKV fail",       dref = "tu-154/failures/absu_vkv_fail",       kind = "fail" },
        { label = "ABSU alt/spd fail",   dref = "tu-154/failures/absu_alt_speed_fail", kind = "fail" },
        { label = "ABSU AT fail",        dref = "tu-154/failures/absu_at_fail",        kind = "fail" },
        { label = "ABSU BAP pitch",      dref = "tu-154/failures/absu_bap_pitch_fail", kind = "fail" },
        { label = "ABSU BAP roll",       dref = "tu-154/failures/absu_bap_roll_fail",  kind = "fail" },
        { label = "MGV pitch 1 fail",    dref = "tu-154/failures/mgv_thet_1_fail",     kind = "fail" },
        { label = "MGV pitch 2 fail",    dref = "tu-154/failures/mgv_thet_2_fail",     kind = "fail" },
        { label = "MGV pitch 3 fail",    dref = "tu-154/failures/mgv_thet_3_fail",     kind = "fail" },
        { label = "MGV roll 1 fail",     dref = "tu-154/failures/mgv_gam_1_fail",      kind = "fail" },
        { label = "MGV roll 2 fail",     dref = "tu-154/failures/mgv_gam_2_fail",      kind = "fail" },
        { label = "MGV roll 3 fail",     dref = "tu-154/failures/mgv_gam_3_fail",      kind = "fail" },
        { label = "RA-56 1 roll fail",   dref = "tu-154/failures/absu_ra1_roll_fail",  kind = "fail" },
        { label = "RA-56 2 roll fail",   dref = "tu-154/failures/absu_ra2_roll_fail",  kind = "fail" },
        { label = "RA-56 3 roll fail",   dref = "tu-154/failures/absu_ra3_roll_fail",  kind = "fail" },
        { label = "RA-56 1 pitch fail",  dref = "tu-154/failures/absu_ra1_pitch_fail", kind = "fail" },
        { label = "RA-56 2 pitch fail",  dref = "tu-154/failures/absu_ra2_pitch_fail", kind = "fail" },
        { label = "RA-56 3 pitch fail",  dref = "tu-154/failures/absu_ra3_pitch_fail", kind = "fail" },
        { label = "RA-56 1 yaw fail",    dref = "tu-154/failures/absu_ra1_yaw_fail",   kind = "fail" },
        { label = "RA-56 2 yaw fail",    dref = "tu-154/failures/absu_ra2_yaw_fail",   kind = "fail" },
        { label = "RA-56 3 yaw fail",    dref = "tu-154/failures/absu_ra3_yaw_fail",   kind = "fail" },
    } },
}

-- ---------------------------------------------------------------------------
-- Decoupled dataref read cache (memoised handles, like texSize in glbl_draw)
-- ---------------------------------------------------------------------------
local handles = {}
local function H(name)
    local h = handles[name]
    if not h then
        h = globalProperty(name)
        handles[name] = h
    end
    return h
end

local function readv(name)
    local ok, v = pcall(get, H(name))
    if ok and type(v) == "number" then
        return v
    end
    return 0
end

local function clamp(lo, v, hi)
    if v < lo then
        return lo
    end
    if v > hi then
        return hi
    end
    return v
end

-- ---------------------------------------------------------------------------
-- Geometry (fixed canvas; window scales it proportionally)
-- ---------------------------------------------------------------------------
local W, Hh = size[1], size[2]
local TAB_H = 30
local HEADER_H = 28
local PAD = 10
local CARD_W = 219
local CARD_H = 74
local CARD_GAP = 8
local COL_STRIDE = CARD_W + CARD_GAP -- 227
local ROW_STRIDE = CARD_H + CARD_GAP -- 82
-- tab bar wraps to as many rows as needed to keep each tab >= MIN_TAB_W wide
local N_TABS = #schema
local MIN_TAB_W = 84
local TAB_ROWS = math.max(1, math.ceil(N_TABS / math.floor(W / MIN_TAB_W)))
local TAB_PER_ROW = math.ceil(N_TABS / TAB_ROWS)
local TAB_W = W / TAB_PER_ROW
local TAB_AREA_H = TAB_ROWS * TAB_H
local CONTENT_L = PAD
local CONTENT_T = Hh - TAB_AREA_H - HEADER_H -- top y, below the tab rows
local CONTENT_B = PAD
local CONTENT_W = W - 2 * PAD
local CONTENT_H = CONTENT_T - CONTENT_B
local COLS = 4
local VIS_ROWS = math.floor((CONTENT_H + CARD_GAP) / ROW_STRIDE)

-- shared UI state (upvalues; read/written by clickables, update(), draw())
local current_tab = 1
local scroll_row = 0
local max_scroll = 0

local function colorFor(v, warn_lo, warn_hi)
    if warn_lo and v < warn_lo then
        return COL_AMBER
    end
    if warn_hi and v > warn_hi then
        return COL_RED
    end
    return COL_GREEN
end

local function fmt(v, dp)
    return string.format("%." .. (dp or 0) .. "f", v)
end

-- ---------------------------------------------------------------------------
-- Widget renderers -- each draws inside the card rect (x = left, y = bottom)
-- ---------------------------------------------------------------------------
local function drawLabel(x, y, text)
    sasl.gl.drawText(font, x + 8, y + CARD_H - 17, text, 12, false, false, TEXT_ALIGN_LEFT, COL_DIM)
end

local function wLamp(x, y, f, v)
    local on = v > 0.5
    local col
    if f.fault then
        col = on and COL_RED or COL_GREEN
    else
        col = on and COL_GREEN or COL_OFF
    end
    local cx, cy = x + 20, y + 24
    sasl.gl.drawCircle(cx, cy, 9, true, col)
    sasl.gl.drawCircle(cx, cy, 9, false, COL_FRAME)
    local txt
    if f.fault then
        txt = on and "ALARM" or "OK"
    else
        txt = on and "ON" or "OFF"
    end
    sasl.gl.drawText(font, x + 38, y + 18, txt, 14, false, false, TEXT_ALIGN_LEFT, on and COL_TEXT or COL_DIM)
end

-- The Tu-154 tu-154/failures/... datarefs are plain 0/1 flags set by the
-- failure panel, not X-Plane failure codes -- anything non-zero is a failure.
local function wFail(x, y, f, v)
    local bad = math.abs(v) > 0.5
    local col = bad and COL_RED or COL_GREEN
    local cx, cy = x + 20, y + 24
    sasl.gl.drawCircle(cx, cy, 9, true, col)
    sasl.gl.drawCircle(cx, cy, 9, false, COL_FRAME)
    sasl.gl.drawText(font, x + 38, y + 18, bad and "FAIL" or "OK", 14, false, false, TEXT_ALIGN_LEFT, COL_TEXT)
end

local function wBar(x, y, f, v)
    local minv, maxv = f.min or 0, f.max or 1
    local frac = clamp(0, (v - minv) / (maxv - minv), 1)
    local col = colorFor(v, f.warn_lo, f.warn_hi)
    local bx, by, bw, bh = x + 8, y + 14, CARD_W - 16, 14
    sasl.gl.drawRectangle(bx, by, bw, bh, COL_OFF)
    sasl.gl.drawRectangle(bx, by, bw * frac, bh, col)
    sasl.gl.drawFrame(bx, by, bw, bh, COL_FRAME)
    local dp = f.dp or ((maxv - minv) >= 50 and 0 or 1)
    sasl.gl.drawText(font, x + CARD_W - 8, y + 36, fmt(v, dp) .. " " .. (f.unit or ""), 14, false, false,
        TEXT_ALIGN_RIGHT, COL_TEXT)
end

local function wGauge(x, y, f, v)
    local minv, maxv = f.min or 0, f.max or 1
    local frac = clamp(0, (v - minv) / (maxv - minv), 1)
    local col = colorFor(v, f.warn_lo, f.warn_hi)
    local cx, cy, r = x + 32, y + 30, 22
    local startA, sweep = 135, 270
    sasl.gl.drawArc(cx, cy, r - 6, r, startA, sweep, COL_OFF)
    if frac > 0 then
        sasl.gl.drawArc(cx, cy, r - 6, r, startA, sweep * frac, col)
    end
    local dp = f.dp or ((maxv - minv) >= 50 and 0 or 1)
    sasl.gl.drawText(font, x + 64, y + 32, fmt(v, dp), 17, false, false, TEXT_ALIGN_LEFT, COL_TEXT)
    sasl.gl.drawText(font, x + 64, y + 16, f.unit or "", 11, false, false, TEXT_ALIGN_LEFT, COL_DIM)
end

local function wValue(x, y, f, v)
    local s = fmt(v, f.dp or 0)
    if f.unit and f.unit ~= "" then
        s = s .. " " .. f.unit
    end
    sasl.gl.drawText(font, x + 8, y + 22, s, 20, false, false, TEXT_ALIGN_LEFT, COL_TEXT)
end

local function wEnum(x, y, f, v)
    local key = math.floor(v + 0.5)
    local txt = (f.map and f.map[key]) or fmt(v, 0)
    local active = key ~= 0
    local tw = sasl.gl.measureText(font, txt, 13, false, false)
    local cw = clamp(40, tw + 18, CARD_W - 16)
    local bx, by = x + 8, y + 14
    sasl.gl.drawRectangle(bx, by, cw, 22, active and COL_ACCENT or COL_OFF)
    sasl.gl.drawText(font, bx + cw / 2, by + 5, txt, 13, false, false, TEXT_ALIGN_CENTER, COL_TEXT)
end

local RENDER = {
    lamp = wLamp,
    fail = wFail,
    bar = wBar,
    gauge = wGauge,
    value = wValue,
    enum = wEnum
}

local function drawCard(x, y, f)
    sasl.gl.drawRectangle(x, y, CARD_W, CARD_H, COL_CARD)
    sasl.gl.drawFrame(x, y, CARD_W, CARD_H, COL_FRAME)
    drawLabel(x, y, f.label)
    local r = RENDER[f.kind] or wValue
    r(x, y, f, readv(f.dref))
end

-- ---------------------------------------------------------------------------
-- Frame
-- ---------------------------------------------------------------------------
function update()
    local n = #schema[current_tab].fields
    local total_rows = math.ceil(n / COLS)
    max_scroll = math.max(0, total_rows - VIS_ROWS)
    scroll_row = clamp(0, scroll_row, max_scroll)
end

local function drawTabBar()
    for i = 1, N_TABS do
        local j = i - 1
        local row = math.floor(j / TAB_PER_ROW)
        local x0 = (j % TAB_PER_ROW) * TAB_W
        local y0 = Hh - (row + 1) * TAB_H
        local on = (i == current_tab)
        sasl.gl.drawRectangle(x0, y0, TAB_W, TAB_H, on and COL_TABON or COL_TAB)
        sasl.gl.drawText(font, x0 + TAB_W / 2, y0 + 9, schema[i].short, 13, false, false, TEXT_ALIGN_CENTER,
            on and COL_TEXT or COL_DIM)
        if on then
            sasl.gl.drawRectangle(x0, y0, TAB_W, 3, COL_ACCENT)
        end
        sasl.gl.drawLine(x0, y0, x0, y0 + TAB_H, COL_BG)
    end
end

local function drawHeader()
    local y = CONTENT_T
    sasl.gl.drawText(font, PAD, y + 7, schema[current_tab].name, 17, false, false, TEXT_ALIGN_LEFT, COL_TEXT)
    -- always-on power readout (visible from any tab)
    local dcl = readv("tu-154/elec/bus27_volt_left")
    local dcr = readv("tu-154/elec/bus27_volt_right")
    local ac = readv("tu-154/elec/bus115_1_volt")
    sasl.gl.drawCircle(W - 290, y + 14, 6, true, dcl >= 24 and COL_GREEN or COL_RED)
    sasl.gl.drawText(font, W - 278, y + 7, "27L " .. fmt(dcl, 1) .. "V", 14, false, false, TEXT_ALIGN_LEFT, COL_DIM)
    sasl.gl.drawCircle(W - 185, y + 14, 6, true, dcr >= 24 and COL_GREEN or COL_RED)
    sasl.gl.drawText(font, W - 173, y + 7, "27R " .. fmt(dcr, 1) .. "V", 14, false, false, TEXT_ALIGN_LEFT, COL_DIM)
    sasl.gl.drawCircle(W - 80, y + 14, 6, true, ac >= 104 and COL_GREEN or COL_RED)
    sasl.gl.drawText(font, W - 68, y + 7, "115 " .. fmt(ac, 0) .. "V", 14, false, false, TEXT_ALIGN_LEFT, COL_DIM)
    sasl.gl.drawLine(PAD, y + 2, W - PAD, y + 2, COL_FRAME)
end

local function drawScrollbar()
    if max_scroll <= 0 then
        return
    end
    local total_rows = VIS_ROWS + max_scroll
    local trackX, trackW = W - 8, 5
    sasl.gl.drawRectangle(trackX, CONTENT_B, trackW, CONTENT_H, COL_OFF)
    local thumbH = CONTENT_H * (VIS_ROWS / total_rows)
    local thumbY = CONTENT_T - thumbH - (CONTENT_H - thumbH) * (scroll_row / max_scroll)
    sasl.gl.drawRectangle(trackX, thumbY, trackW, thumbH, COL_ACCENT)
    -- arrow glyphs (clickable areas are separate components)
    local ax = W - 18
    sasl.gl.drawTriangle(ax, CONTENT_T - 4, ax + 8, CONTENT_T - 4, ax + 4, CONTENT_T - 14, COL_DIM)  -- up
    sasl.gl.drawTriangle(ax, CONTENT_B + 14, ax + 8, CONTENT_B + 14, ax + 4, CONTENT_B + 4, COL_DIM) -- down
end

function draw()
    sasl.gl.drawRectangle(0, 0, W, Hh, COL_BG)
    drawTabBar()
    drawHeader()

    local fields = schema[current_tab].fields
    sasl.gl.setClipArea(CONTENT_L, CONTENT_B, CONTENT_W, CONTENT_H)
    for k = 0, #fields - 1 do
        local row = math.floor(k / COLS)
        local screenRow = row - scroll_row
        if screenRow >= 0 and screenRow < VIS_ROWS then
            local col = k % COLS
            local cx = CONTENT_L + col * COL_STRIDE
            local cy = CONTENT_T - (screenRow + 1) * CARD_H - screenRow * CARD_GAP
            drawCard(cx, cy, fields[k + 1])
        end
    end
    sasl.gl.resetClipArea()

    drawScrollbar()
end

-- ---------------------------------------------------------------------------
-- Interactivity -- child clickables (handlers are rawget-dispatched, so they
-- must be constructor props on real clickable components, not file globals)
-- ---------------------------------------------------------------------------
local function scrollBy(d)
    scroll_row = clamp(0, scroll_row + d, max_scroll)
end

local comps = {}

-- tab buttons across the top (multi-row grid; matches drawTabBar)
do
    for i = 1, N_TABS do
        local j = i - 1
        local row = math.floor(j / TAB_PER_ROW)
        local x0 = (j % TAB_PER_ROW) * TAB_W
        local y0 = Hh - (row + 1) * TAB_H
        comps[#comps + 1] = clickable {
            position = { x0, y0, TAB_W, TAB_H },
            onMouseDown = function()
                current_tab = i
                scroll_row = 0
                return true
            end
        }
    end
end

-- mouse-wheel scrolling over the content area
comps[#comps + 1] = clickable {
    position = { CONTENT_L, CONTENT_B, CONTENT_W, CONTENT_H },
    onMouseWheel = function(_, _, _, _, _, _, clicks)
        scrollBy(-(clicks or 0))
        return true
    end
}

-- scroll arrows (right gutter)
comps[#comps + 1] = clickable {
    position = { W - 20, CONTENT_T - 16, 16, 16 },
    onMouseDown = function()
        scrollBy(-1)
        return true
    end,
    onMouseHold = holdToRepeat(function()
        scrollBy(-1)
    end)
}
comps[#comps + 1] = clickable {
    position = { W - 20, CONTENT_B, 16, 16 },
    onMouseDown = function()
        scrollBy(1)
        return true
    end,
    onMouseHold = holdToRepeat(function()
        scrollBy(1)
    end)
}

components = comps
