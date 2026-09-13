-- fuel system panel
-- FIX (XP12):
--   1. reset_switchers() does not zero fuel_flow_mode on a cold start - that
--      blocked the pump automatics. It DOES still close the fire valves, which
--      is correct; opening them is a checklist step (see reset_switchers below).
--   2. frame_time is used directly; a 0 means the sim is paused and is honoured

-- gauges
defineProperty("fuel_meter_summ",        globalPropertyf("tu-154/gauges/fuel/fuel_meter_summ"))
defineProperty("fuel_meter_tank1",       globalPropertyf("tu-154/gauges/fuel/fuel_meter_tank1"))
defineProperty("fuel_meter_tank2_left",  globalPropertyf("tu-154/gauges/fuel/fuel_meter_tank2_left"))
defineProperty("fuel_meter_tank2_right", globalPropertyf("tu-154/gauges/fuel/fuel_meter_tank2_right"))
defineProperty("fuel_meter_tank3_left",  globalPropertyf("tu-154/gauges/fuel/fuel_meter_tank3_left"))
defineProperty("fuel_meter_tank3_right", globalPropertyf("tu-154/gauges/fuel/fuel_meter_tank3_right"))
defineProperty("fuel_meter_tank4",       globalPropertyf("tu-154/gauges/fuel/fuel_meter_tank4"))
defineProperty("fuel_meter_mech",        globalPropertyf("tu-154/gauges/fuel/fuel_meter_mech"))
defineProperty("fuel_front_ind",         globalPropertyf("tu-154/gauges/misc/fuel_front_ind"))

-- controls on gauges
defineProperty("fuel_meter_summ_zero",  globalPropertyf("tu-154/buttons/fuel/fuel_meter_summ_zero"))
defineProperty("fuel_meter_summ_max",   globalPropertyf("tu-154/buttons/fuel/fuel_meter_summ_max"))
defineProperty("fuel_meter_tank2_zero", globalPropertyf("tu-154/buttons/fuel/fuel_meter_tank2_zero"))
defineProperty("fuel_meter_tank2_max",  globalPropertyf("tu-154/buttons/fuel/fuel_meter_tank2_max"))
defineProperty("fuel_meter_tank3_zero", globalPropertyf("tu-154/buttons/fuel/fuel_meter_tank3_zero"))
defineProperty("fuel_meter_tank3_max",  globalPropertyf("tu-154/buttons/fuel/fuel_meter_tank3_max"))
defineProperty("fuel_meter_tank4_zero", globalPropertyf("tu-154/buttons/fuel/fuel_meter_tank4_zero"))
defineProperty("fuel_meter_tank4_max",  globalPropertyf("tu-154/buttons/fuel/fuel_meter_tank4_max"))
defineProperty("fuel_front_zero",       globalPropertyf("tu-154/buttons/misc/fuel_front_zero"))
defineProperty("fuel_front_max",        globalPropertyf("tu-154/buttons/misc/fuel_front_max"))

-- controls
defineProperty("pump_tank2_left",  globalPropertyi("tu-154/switchers/fuel/pump_tank2_left"))
defineProperty("pump_tank2_right", globalPropertyi("tu-154/switchers/fuel/pump_tank2_right"))
defineProperty("pump_tank3_left",  globalPropertyi("tu-154/switchers/fuel/pump_tank3_left"))
defineProperty("pump_tank3_right", globalPropertyi("tu-154/switchers/fuel/pump_tank3_right"))
defineProperty("pump_tank4",       globalPropertyi("tu-154/switchers/fuel/pump_tank4"))
defineProperty("pump_tank1_1",     globalPropertyi("tu-154/switchers/fuel/pump_tank1_1"))
defineProperty("pump_tank1_2",     globalPropertyi("tu-154/switchers/fuel/pump_tank1_2"))
defineProperty("pump_tank1_3",     globalPropertyi("tu-154/switchers/fuel/pump_tank1_3"))
defineProperty("pump_tank1_4",     globalPropertyi("tu-154/switchers/fuel/pump_tank1_4"))

defineProperty("fuel_trans",         globalPropertyi("tu-154/switchers/fuel/fuel_trans"))
defineProperty("fuel_trans_cap",     globalPropertyi("tu-154/switchers/fuel/fuel_trans_cap"))
defineProperty("fuel_porc",          globalPropertyi("tu-154/switchers/fuel/fuel_porc"))
defineProperty("fuel_porc_cap",      globalPropertyi("tu-154/switchers/fuel/fuel_porc_cap"))
defineProperty("fuel_level",         globalPropertyi("tu-154/switchers/fuel/fuel_level"))
defineProperty("fuel_flow_mode",     globalPropertyi("tu-154/switchers/fuel/fuel_flow_mode"))
defineProperty("fuel_flow_on",       globalPropertyi("tu-154/switchers/fuel/fuel_flow_on"))
defineProperty("fuel_flow_on_cap",   globalPropertyi("tu-154/switchers/fuel/fuel_flow_on_cap"))

defineProperty("fuel_meter_on",      globalPropertyi("tu-154/switchers/fuel/fuel_meter_on"))
defineProperty("fuel_meter_mech_on", globalPropertyi("tu-154/switchers/fuel/fuel_meter_mech_on"))
defineProperty("fire_valve_1",       globalPropertyi("tu-154/switchers/fuel/fire_valve_1"))
defineProperty("fire_valve_2",       globalPropertyi("tu-154/switchers/fuel/fire_valve_2"))
defineProperty("fire_valve_3",       globalPropertyi("tu-154/switchers/fuel/fire_valve_3"))
defineProperty("fire_valve_1_cap",   globalPropertyi("tu-154/switchers/fuel/fire_valve_1_cap"))
defineProperty("fire_valve_2_cap",   globalPropertyi("tu-154/switchers/fuel/fire_valve_2_cap"))
defineProperty("fire_valve_3_cap",   globalPropertyi("tu-154/switchers/fuel/fire_valve_3_cap"))

defineProperty("reserv_pump_test", globalPropertyi("tu-154/buttons/eng/reserv_pump_test"))

-- lamps
defineProperty("fuel_2500",              globalPropertyf("tu-154/lights/small/fuel_2500"))
defineProperty("fuel_tank1_used",        globalPropertyf("tu-154/lights/small/fuel_tank1_used"))
defineProperty("fuel_tank3_left_fail",   globalPropertyf("tu-154/lights/small/fuel_tank3_left_fail"))
defineProperty("fuel_tank2_left_fail",   globalPropertyf("tu-154/lights/small/fuel_tank2_left_fail"))
defineProperty("fuel_tank2_right_fail",  globalPropertyf("tu-154/lights/small/fuel_tank2_right_fail"))
defineProperty("fuel_tank3_right_fail",  globalPropertyf("tu-154/lights/small/fuel_tank3_right_fail"))

defineProperty("fuel_pump_left_5",  globalPropertyf("tu-154/lights/small/fuel_pump_left_5"))
defineProperty("fuel_pump_left_6",  globalPropertyf("tu-154/lights/small/fuel_pump_left_6"))
defineProperty("fuel_pump_left_7",  globalPropertyf("tu-154/lights/small/fuel_pump_left_7"))
defineProperty("fuel_pump_left_8",  globalPropertyf("tu-154/lights/small/fuel_pump_left_8"))
defineProperty("fuel_pump_left_9",  globalPropertyf("tu-154/lights/small/fuel_pump_left_9"))

defineProperty("fuel_pump_right_5", globalPropertyf("tu-154/lights/small/fuel_pump_right_5"))
defineProperty("fuel_pump_right_6", globalPropertyf("tu-154/lights/small/fuel_pump_right_6"))
defineProperty("fuel_pump_right_7", globalPropertyf("tu-154/lights/small/fuel_pump_right_7"))
defineProperty("fuel_pump_right_8", globalPropertyf("tu-154/lights/small/fuel_pump_right_8"))
defineProperty("fuel_pump_right_9", globalPropertyf("tu-154/lights/small/fuel_pump_right_9"))

defineProperty("fuel_pump_10", globalPropertyf("tu-154/lights/small/fuel_pump_10"))
defineProperty("fuel_pump_11", globalPropertyf("tu-154/lights/small/fuel_pump_11"))
defineProperty("fuel_pump_1",  globalPropertyf("tu-154/lights/small/fuel_pump_1"))
defineProperty("fuel_pump_2",  globalPropertyf("tu-154/lights/small/fuel_pump_2"))
defineProperty("fuel_pump_3",  globalPropertyf("tu-154/lights/small/fuel_pump_3"))
defineProperty("fuel_pump_4",  globalPropertyf("tu-154/lights/small/fuel_pump_4"))

defineProperty("fuel_cut_off_1",         globalPropertyf("tu-154/lights/small/fuel_cut_off_1"))
defineProperty("fuel_cut_off_2",         globalPropertyf("tu-154/lights/small/fuel_cut_off_2"))
defineProperty("fuel_cut_off_3",         globalPropertyf("tu-154/lights/small/fuel_cut_off_3"))
defineProperty("fuel_flow_from_2",       globalPropertyf("tu-154/lights/small/fuel_flow_from_2"))
defineProperty("fuel_flow_from_3",       globalPropertyf("tu-154/lights/small/fuel_flow_from_3"))
defineProperty("fuel_flow_from_4",       globalPropertyf("tu-154/lights/small/fuel_flow_from_4"))

defineProperty("fuel_flow_auto_fail",    globalPropertyf("tu-154/lights/small/fuel_flow_auto_fail"))
defineProperty("fuel_reserv_trans_left", globalPropertyf("tu-154/lights/small/fuel_reserv_trans_left"))
defineProperty("fuel_reserv_trans_right",globalPropertyf("tu-154/lights/small/fuel_reserv_trans_right"))
defineProperty("fuel_porc_reserv",       globalPropertyf("tu-154/lights/small/fuel_porc_reserv"))
defineProperty("fuel_level_automat",     globalPropertyf("tu-154/lights/small/fuel_level_automat"))

-- sources
defineProperty("eng1_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[0]"))
defineProperty("eng2_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[1]"))
defineProperty("eng3_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[2]"))

defineProperty("ENGN_FF_1", globalProperty("sim/cockpit2/engine/indicators/fuel_flow_kg_sec[0]"))
defineProperty("ENGN_FF_2", globalProperty("sim/cockpit2/engine/indicators/fuel_flow_kg_sec[1]"))
defineProperty("ENGN_FF_3", globalProperty("sim/cockpit2/engine/indicators/fuel_flow_kg_sec[2]"))

defineProperty("total_w",  globalPropertyf("sim/flightmodel/weight/m_fuel_total"))
defineProperty("tank1_w",  globalProperty("sim/flightmodel/weight/m_fuel[0]"))
defineProperty("tank4_w",  globalProperty("sim/flightmodel/weight/m_fuel[1]"))
defineProperty("tank2R_w", globalProperty("sim/flightmodel/weight/m_fuel[2]"))
defineProperty("tank2L_w", globalProperty("sim/flightmodel/weight/m_fuel[3]"))
defineProperty("tank3R_w", globalProperty("sim/flightmodel/weight/m_fuel[4]"))
defineProperty("tank3L_w", globalProperty("sim/flightmodel/weight/m_fuel[5]"))

defineProperty("reserv_trans", globalPropertyi("tu-154/fuel/reserv_trans"))
defineProperty("total_ft",     globalPropertyf("sim/time/total_flight_time_sec"))

defineProperty("bus27_volt_left",  globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))
defineProperty("bus115_1_volt",    globalPropertyf("tu-154/elec/bus115_1_volt"))
defineProperty("bus115_2_volt",    globalPropertyf("tu-154/elec/bus115_2_volt"))
defineProperty("bus115_3_volt",    globalPropertyf("tu-154/elec/bus115_3_volt"))

defineProperty("test_lamps", globalPropertyi("tu-154/buttons/lamp_test_hydro"))

defineProperty("pump_tank2_left1_work",  globalPropertyi("tu-154/fuel/pump_tank2_left_work1"))
defineProperty("pump_tank2_left2_work",  globalPropertyi("tu-154/fuel/pump_tank2_left_work2"))
defineProperty("pump_tank2_right1_work", globalPropertyi("tu-154/fuel/pump_tank2_right_work1"))
defineProperty("pump_tank2_right2_work", globalPropertyi("tu-154/fuel/pump_tank2_right_work2"))
defineProperty("pump_tank3_left1_work",  globalPropertyi("tu-154/fuel/pump_tank3_left_work1"))
defineProperty("pump_tank3_left2_work",  globalPropertyi("tu-154/fuel/pump_tank3_left_work2"))
defineProperty("pump_tank3_left3_work",  globalPropertyi("tu-154/fuel/pump_tank3_left_work3"))
defineProperty("pump_tank3_right1_work", globalPropertyi("tu-154/fuel/pump_tank3_right_work1"))
defineProperty("pump_tank3_right2_work", globalPropertyi("tu-154/fuel/pump_tank3_right_work2"))
defineProperty("pump_tank3_right3_work", globalPropertyi("tu-154/fuel/pump_tank3_right_work3"))
defineProperty("pump_tank41_work",       globalPropertyi("tu-154/fuel/pump_tank4_work1"))
defineProperty("pump_tank42_work",       globalPropertyi("tu-154/fuel/pump_tank4_work2"))
defineProperty("pump_tank1_1_work",      globalPropertyi("tu-154/fuel/pump_tank1_1_work"))
defineProperty("pump_tank1_2_work",      globalPropertyi("tu-154/fuel/pump_tank1_2_work"))
defineProperty("pump_tank1_3_work",      globalPropertyi("tu-154/fuel/pump_tank1_3_work"))
defineProperty("pump_tank1_4_work",      globalPropertyi("tu-154/fuel/pump_tank1_4_work"))

defineProperty("auto_tanks_turn",  globalPropertyi("tu-154/fuel/auto_tanks_turn"))
defineProperty("auto_tank_level_2",globalPropertyi("tu-154/fuel/auto_tank_level_2"))
defineProperty("auto_tank_level_3",globalPropertyi("tu-154/fuel/auto_tank_level_3"))

defineProperty("fire_vlv_open_1", globalPropertyf("tu-154/fuel/fire_vlv_open_1"))
defineProperty("fire_vlv_open_2", globalPropertyf("tu-154/fuel/fire_vlv_open_2"))
defineProperty("fire_vlv_open_3", globalPropertyf("tu-154/fuel/fire_vlv_open_3"))

defineProperty("frame_time",        globalPropertyf("tu-154/time/frame_time"))
defineProperty("frame_rate_period", globalPropertyf("sim/operation/misc/frame_rate_period"))

-- Smart Copilot
defineProperty("ismaster",    globalPropertyf("scp/api/ismaster"))
-- hascontrol_1 removed - not used

-- failures
defineProperty("fuel_auto_fail",  globalPropertyi("tu-154/failures/fuel_auto_fail"))
defineProperty("fuel_level_fail", globalPropertyi("tu-154/failures/fuel_level_fail"))
defineProperty("fuel_porc_fail",  globalPropertyi("tu-154/failures/fuel_porc_fail"))

defineProperty("fuel_meter_2l_fail",   globalPropertyi("tu-154/failures/fuel_meter_2l_fail"))
defineProperty("fuel_meter_2r_fail",   globalPropertyi("tu-154/failures/fuel_meter_2r_fail"))
defineProperty("fuel_meter_3l_fail",   globalPropertyi("tu-154/failures/fuel_meter_3l_fail"))
defineProperty("fuel_meter_3r_fail",   globalPropertyi("tu-154/failures/fuel_meter_3r_fail"))
defineProperty("fuel_meter_1_fail",    globalPropertyi("tu-154/failures/fuel_meter_1_fail"))
defineProperty("fuel_meter_4_fail",    globalPropertyi("tu-154/failures/fuel_meter_4_fail"))
defineProperty("fuel_meter_summ_fail", globalPropertyi("tu-154/failures/fuel_meter_summ"))

defineProperty("fuel_flowmeter_1_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_1_fail"))
defineProperty("fuel_flowmeter_2_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_2_fail"))
defineProperty("fuel_flowmeter_3_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_3_fail"))

-- sounds
local rotary_sound   = loadSample('sounds/plastic_switch.wav')
local switcher_sound = loadSample('sounds/metal_switch.wav')
local cap_sound      = loadSample('sounds/cap.wav')

-- frame_time is 0 while the sim is paused - that is how systems/cockpit/time_logic.lua
-- signals it - so a legitimate 0 must be passed through rather than replaced.
-- See the same note in fuel_tanks.lua.
local function get_passed()
	local ft = get(frame_time)
	if ft == nil then ft = get(frame_rate_period) end
	if ft == nil or ft < 0 then ft = 0 end
	return ft
end

local passed = get_passed()

local function lamps()

	local test_btn  = get(test_lamps) * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0)

	local pump_2L1 = get(pump_tank2_left1_work)
	local pump_2L2 = get(pump_tank2_left2_work)
	local pump_2R1 = get(pump_tank2_right1_work)
	local pump_2R2 = get(pump_tank2_right2_work)
	local pump_3L1 = get(pump_tank3_left1_work)
	local pump_3L2 = get(pump_tank3_left2_work)
	local pump_3L3 = get(pump_tank3_left3_work)
	local pump_3R1 = get(pump_tank3_right1_work)
	local pump_3R2 = get(pump_tank3_right2_work)
	local pump_3R3 = get(pump_tank3_right3_work)
	local pump41   = get(pump_tank41_work)
	local pump42   = get(pump_tank42_work)
	local pump_1_1 = get(pump_tank1_1_work)
	local pump_1_2 = get(pump_tank1_2_work)
	local pump_1_3 = get(pump_tank1_3_work)
	local pump_1_4 = get(pump_tank1_4_work)

	local tank_level_2 = get(auto_tank_level_2)
	local tank_level_3 = get(auto_tank_level_3)

	local fuel_tank3_left_brt = 0
	if tank_level_3 == -1 then fuel_tank3_left_brt = 1 end
	set(fuel_tank3_left_fail, math.max(fuel_tank3_left_brt * lamps_brt, test_btn))

	local fuel_tank2_left_brt = 0
	if tank_level_2 == -1 then fuel_tank2_left_brt = 1 end
	set(fuel_tank2_left_fail, math.max(fuel_tank2_left_brt * lamps_brt, test_btn))

	local fuel_tank3_right_brt = 0
	if tank_level_3 == 1 then fuel_tank3_right_brt = 1 end
	set(fuel_tank3_right_fail, math.max(fuel_tank3_right_brt * lamps_brt, test_btn))

	local fuel_tank2_right_brt = 0
	if tank_level_2 == 1 then fuel_tank2_right_brt = 1 end
	set(fuel_tank2_right_fail, math.max(fuel_tank2_right_brt * lamps_brt, test_btn))

	set(fuel_pump_left_5,  math.max(bool2int(pump_2L1 > 0) * lamps_brt, test_btn))
	set(fuel_pump_left_6,  math.max(bool2int(pump_2L2 > 0) * lamps_brt, test_btn))
	set(fuel_pump_left_7,  math.max(bool2int(pump_3L1 > 0) * lamps_brt, test_btn))
	set(fuel_pump_left_8,  math.max(bool2int(pump_3L2 > 0) * lamps_brt, test_btn))
	set(fuel_pump_left_9,  math.max(bool2int(pump_3L3 > 0) * lamps_brt, test_btn))

	set(fuel_pump_right_5, math.max(bool2int(pump_2R1 > 0) * lamps_brt, test_btn))
	set(fuel_pump_right_6, math.max(bool2int(pump_2R2 > 0) * lamps_brt, test_btn))
	set(fuel_pump_right_7, math.max(bool2int(pump_3R1 > 0) * lamps_brt, test_btn))
	set(fuel_pump_right_8, math.max(bool2int(pump_3R2 > 0) * lamps_brt, test_btn))
	set(fuel_pump_right_9, math.max(bool2int(pump_3R3 > 0) * lamps_brt, test_btn))

	set(fuel_pump_10, math.max(bool2int(pump41 > 0) * lamps_brt, test_btn))
	set(fuel_pump_11, math.max(bool2int(pump42 > 0) * lamps_brt, test_btn))
	set(fuel_pump_1,  math.max(pump_1_1 * lamps_brt, test_btn))
	set(fuel_pump_2,  math.max(pump_1_2 * lamps_brt, test_btn))
	set(fuel_pump_3,  math.max(pump_1_3 * lamps_brt, test_btn))
	set(fuel_pump_4,  math.max(pump_1_4 * lamps_brt, test_btn))

	local fuel_cut_off_1_brt = 0
	if get(fire_vlv_open_1) > 0.7 then fuel_cut_off_1_brt = 1 end
	set(fuel_cut_off_1, math.max(fuel_cut_off_1_brt * lamps_brt, test_btn))

	local fuel_cut_off_2_brt = 0
	if get(fire_vlv_open_2) > 0.7 then fuel_cut_off_2_brt = 1 end
	set(fuel_cut_off_2, math.max(fuel_cut_off_2_brt * lamps_brt, test_btn))

	local fuel_cut_off_3_brt = 0
	if get(fire_vlv_open_3) > 0.7 then fuel_cut_off_3_brt = 1 end
	set(fuel_cut_off_3, math.max(fuel_cut_off_3_brt * lamps_brt, test_btn))

	local tank_turn = get(auto_tanks_turn)

	local fuel_flow_from_2_brt = 0
	if tank_turn == 1 or tank_turn == 2 then fuel_flow_from_2_brt = 1 end
	set(fuel_flow_from_2, math.max(fuel_flow_from_2_brt * lamps_brt, test_btn))

	local fuel_flow_from_3_brt = 0
	if tank_turn == 2 or tank_turn == 3 then fuel_flow_from_3_brt = 1 end
	set(fuel_flow_from_3, math.max(fuel_flow_from_3_brt * lamps_brt, test_btn))

	local fuel_flow_from_4_brt = 0
	if tank_turn == 4 then fuel_flow_from_4_brt = 1 end
	set(fuel_flow_from_4, math.max(fuel_flow_from_4_brt * lamps_brt, test_btn))

	local fuel_flow_auto_fail_brt = 0
	if tank_turn == 0 then fuel_flow_auto_fail_brt = 1 end
	set(fuel_flow_auto_fail, math.max(fuel_flow_auto_fail_brt * lamps_brt, test_btn))

	set(fuel_reserv_trans_left,  math.max(get(reserv_trans) * lamps_brt, test_btn))
	set(fuel_reserv_trans_right, math.max(get(reserv_trans) * lamps_brt, test_btn))
	set(fuel_porc_reserv,        math.max(get(reserv_pump_test) * lamps_brt, test_btn))

	local fuel_level_automat_brt = math.max(get(fuel_level) * (1 - get(fuel_level_fail)) * lamps_brt, test_btn)
	set(fuel_level_automat, fuel_level_automat_brt)

end


-- reset switchers for cold & dark
local notLoaded = true

local function reset_switchers()
	if get(eng1_N1) < 5 and get(eng2_N1) < 5 and get(eng3_N1) < 5 then
		-- FIX: the pumps are reset (this is correct for a cold start)
		set(pump_tank2_left,  0)
		set(pump_tank2_right, 0)
		set(pump_tank3_left,  0)
		set(pump_tank3_right, 0)
		set(pump_tank4,       0)
		set(pump_tank1_1,     0)
		set(pump_tank1_2,     0)
		set(pump_tank1_3,     0)
		set(pump_tank1_4,     0)
		set(fuel_level,       0)
		-- FIX: fuel_flow_mode is NOT reset - the dataref is empty in XP12,
		-- resetting to 0 blocked the pump automatics
		-- set(fuel_flow_mode, 0)
		set(fuel_flow_on,         0)
		set(fuel_meter_on,        0)
		set(fuel_meter_mech_on,   0)
		-- The fire valves ARE closed on a cold start. That is correct: opening
		-- them is a crew action, and tu154_clist.txt carries it as an explicit
		-- checklist step ("Engine Firewall Valves | ON"). fuel_engines.lua then
		-- cuts the fuel while the valve position is below 0.5, so the engines
		-- will not start until the crew has opened them.
		-- (An earlier XP12 note here claimed these were no longer reset. They are.)
		set(fire_valve_1, 0)
		set(fire_valve_2, 0)
		set(fire_valve_3, 0)
	end
	notLoaded = false
end


-- make switchers sound
local pump_tank2_left_last  = get(pump_tank2_left)
local pump_tank2_right_last = get(pump_tank2_right)
local pump_tank3_left_last  = get(pump_tank3_left)
local pump_tank3_right_last = get(pump_tank3_right)
local pump_tank4_last       = get(pump_tank4)
local pump_tank1_1_last     = get(pump_tank1_1)
local pump_tank1_2_last     = get(pump_tank1_2)
local pump_tank1_3_last     = get(pump_tank1_3)
local pump_tank1_4_last     = get(pump_tank1_4)

local fuel_trans_last       = get(fuel_trans)
local fuel_porc_last        = get(fuel_porc)
local fuel_level_last       = get(fuel_level)
local fuel_flow_mode_last   = get(fuel_flow_mode)
local fuel_flow_on_last     = get(fuel_flow_on)

local fuel_meter_on_last      = get(fuel_meter_on)
local fuel_meter_mech_on_last = get(fuel_meter_mech_on)
local fire_valve_1_last       = get(fire_valve_1)
local fire_valve_2_last       = get(fire_valve_2)
local fire_valve_3_last       = get(fire_valve_3)


local function check_switchers()

	local pump_tank2_left_sw  = get(pump_tank2_left)
	local pump_tank2_right_sw = get(pump_tank2_right)
	local pump_tank3_left_sw  = get(pump_tank3_left)
	local pump_tank3_right_sw = get(pump_tank3_right)
	local pump_tank4_sw       = get(pump_tank4)
	local pump_tank1_1_sw     = get(pump_tank1_1)
	local pump_tank1_2_sw     = get(pump_tank1_2)
	local pump_tank1_3_sw     = get(pump_tank1_3)
	local pump_tank1_4_sw     = get(pump_tank1_4)

	local fuel_trans_sw       = get(fuel_trans)
	local fuel_porc_sw        = get(fuel_porc)
	local fuel_level_sw       = get(fuel_level)
	local fuel_flow_mode_sw   = get(fuel_flow_mode)
	local fuel_flow_on_sw     = get(fuel_flow_on)

	local fuel_meter_on_sw      = get(fuel_meter_on)
	local fuel_meter_mech_on_sw = get(fuel_meter_mech_on)
	local fire_valve_1_sw       = get(fire_valve_1)
	local fire_valve_2_sw       = get(fire_valve_2)
	local fire_valve_3_sw       = get(fire_valve_3)

	local sw_change = pump_tank2_left_sw + pump_tank2_right_sw + pump_tank3_left_sw + pump_tank3_right_sw + pump_tank4_sw
	sw_change = sw_change + pump_tank1_1_sw + pump_tank1_2_sw + pump_tank1_3_sw + pump_tank1_4_sw
	sw_change = sw_change + fuel_trans_sw + fuel_porc_sw + fuel_level_sw + fuel_flow_mode_sw + fuel_flow_on_sw
	sw_change = sw_change + fuel_meter_on_sw + fuel_meter_mech_on_sw + fire_valve_1_sw + fire_valve_2_sw + fire_valve_3_sw

	sw_change = sw_change - pump_tank2_left_last - pump_tank2_right_last - pump_tank3_left_last - pump_tank3_right_last - pump_tank4_last
	sw_change = sw_change - pump_tank1_1_last - pump_tank1_2_last - pump_tank1_3_last - pump_tank1_4_last
	sw_change = sw_change - fuel_trans_last - fuel_porc_last - fuel_level_last - fuel_flow_mode_last - fuel_flow_on_last
	sw_change = sw_change - fuel_meter_on_last - fuel_meter_mech_on_last - fire_valve_1_last - fire_valve_2_last - fire_valve_3_last

	if sw_change ~= 0 then playSample(switcher_sound, false) end

	pump_tank2_left_last  = pump_tank2_left_sw
	pump_tank2_right_last = pump_tank2_right_sw
	pump_tank3_left_last  = pump_tank3_left_sw
	pump_tank3_right_last = pump_tank3_right_sw
	pump_tank4_last       = pump_tank4_sw
	pump_tank1_1_last     = pump_tank1_1_sw
	pump_tank1_2_last     = pump_tank1_2_sw
	pump_tank1_3_last     = pump_tank1_3_sw
	pump_tank1_4_last     = pump_tank1_4_sw

	fuel_trans_last       = fuel_trans_sw
	fuel_porc_last        = fuel_porc_sw
	fuel_level_last       = fuel_level_sw
	fuel_flow_mode_last   = fuel_flow_mode_sw
	fuel_flow_on_last     = fuel_flow_on_sw

	fuel_meter_on_last      = fuel_meter_on_sw
	fuel_meter_mech_on_last = fuel_meter_mech_on_sw
	fire_valve_1_last       = fire_valve_1_sw
	fire_valve_2_last       = fire_valve_2_sw
	fire_valve_3_last       = fire_valve_3_sw

end


-- make caps sound
local fuel_trans_cap_last     = get(fuel_trans_cap)
local fuel_porc_cap_last      = get(fuel_porc_cap)
local fuel_flow_on_cap_last   = get(fuel_flow_on_cap)
local fire_valve_1_cap_last   = get(fire_valve_1_cap)
local fire_valve_2_cap_last   = get(fire_valve_2_cap)
local fire_valve_3_cap_last   = get(fire_valve_3_cap)

local function caps_check()
	local fuel_trans_cap_sw   = get(fuel_trans_cap)
	local fuel_porc_cap_sw    = get(fuel_porc_cap)
	local fuel_flow_on_cap_sw = get(fuel_flow_on_cap)
	local fire_valve_1_cap_sw = get(fire_valve_1_cap)
	local fire_valve_2_cap_sw = get(fire_valve_2_cap)
	local fire_valve_3_cap_sw = get(fire_valve_3_cap)

	local cap_change = fuel_trans_cap_sw + fuel_porc_cap_sw + fuel_flow_on_cap_sw + fire_valve_1_cap_sw + fire_valve_2_cap_sw + fire_valve_3_cap_sw
	cap_change = cap_change - fuel_trans_cap_last - fuel_porc_cap_last - fuel_flow_on_cap_last - fire_valve_1_cap_last - fire_valve_2_cap_last - fire_valve_3_cap_last

	if cap_change ~= 0 then playSample(cap_sound, false) end

	fuel_trans_cap_last   = fuel_trans_cap_sw
	fuel_porc_cap_last    = fuel_porc_cap_sw
	fuel_flow_on_cap_last = fuel_flow_on_cap_sw
	fire_valve_1_cap_last = fire_valve_1_cap_sw
	fire_valve_2_cap_last = fire_valve_2_cap_sw
	fire_valve_3_cap_last = fire_valve_3_cap_sw

	if fuel_porc_cap_sw == 0 then set(fuel_porc, 0) end

end


-- mechanic fuel meters
local mech_counter = 0

local function mech_fuel_meter()

	local power = get(fuel_meter_mech_on) == 1 and (get(bus27_volt_left) > 13 or get(bus27_volt_right) > 13)

	local fuel_summ_calc = get(fuel_meter_mech)

	-- The counter batches the subtraction into 10 s chunks, so it may only run
	-- while the meter is actually counting. It used to accumulate unconditionally
	-- and reset only inside the branch below, so switching the meter on with the
	-- engines already running subtracted fuel flow x (time since load) in one step.
	if fuel_summ_calc > 0 and power then
		mech_counter = mech_counter + passed

		if mech_counter > 10 then
			fuel_summ_calc = fuel_summ_calc - (get(ENGN_FF_1) * (1 - get(fuel_flowmeter_1_fail)) + get(ENGN_FF_2) * (1 - get(fuel_flowmeter_2_fail)) + get(ENGN_FF_3) * (1 - get(fuel_flowmeter_3_fail))) * mech_counter
			mech_counter = 0
		end
	else
		mech_counter = 0
	end

	set(fuel_meter_mech, fuel_summ_calc)

end


-- fuel meters
local summ_act       = 0
local tank1_act      = 0
local tank2L_act     = 0
local tank2R_act     = 0
local tank3L_act     = 0
local tank3R_act     = 0
local tank4_act      = 0
local summ_front_act = 0

local function electric_meters()
	local power = get(total_ft) < 10 or (get(fuel_meter_on) == 1 and (get(bus27_volt_left) > 13 or get(bus27_volt_right) > 13) and (get(bus115_1_volt) > 110 or get(bus115_3_volt) > 110))

	local tank1_need      = get(fuel_meter_tank1)
	local tank2L_need     = get(fuel_meter_tank2_left)
	local tank2R_need     = get(fuel_meter_tank2_right)
	local tank3L_need     = get(fuel_meter_tank3_left)
	local tank3R_need     = get(fuel_meter_tank3_right)
	local tank4_need      = get(fuel_meter_tank4)
	local summ_front_need = get(fuel_front_ind)
	local summ_need       = get(fuel_meter_summ)

	if power then
		tank1_need  = get(tank1_w)
		tank2L_need = get(tank2L_w)
		tank2R_need = get(tank2R_w)
		tank3L_need = get(tank3L_w)
		tank3R_need = get(tank3R_w)
		tank4_need  = get(tank4_w)

		if get(fuel_meter_tank2_zero) == 1 then
			tank2L_need = 0
			tank2R_need = 0
		elseif get(fuel_meter_tank2_max) == 1 then
			tank2L_need = 11400
			tank2R_need = 11400
		end

		if get(fuel_meter_tank3_zero) == 1 then
			tank3L_need = 0
			tank3R_need = 0
		elseif get(fuel_meter_tank3_max) == 1 then
			tank3L_need = 6400
			tank3R_need = 6400
		end

		if get(fuel_meter_tank4_zero) == 1 then
			tank4_need = 0
		elseif get(fuel_meter_tank4_max) == 1 then
			tank4_need = 8000
		end

		summ_need       = tank2L_act + tank2R_act + tank3L_act + tank3R_act + tank4_act + tank1_act
		summ_front_need = summ_need

		if get(fuel_front_zero) == 1 then
			summ_front_need = 0
		elseif get(fuel_front_max) == 1 then
			summ_front_need = 47000
		end

		if get(fuel_meter_summ_zero) == 1 then
			summ_need  = 0
			tank1_need = 0
		elseif get(fuel_meter_summ_max) == 1 then
			summ_need  = 47000
			tank1_need = 4700
		end

	end

	-- set smooth movements
	if get(fuel_meter_summ_fail) == 0 then
		if summ_act < summ_need - 1000 then summ_act = summ_act + passed * 10000 * 1.5
		elseif summ_act > summ_need + 1000 then summ_act = summ_act - passed * 10000 * 1.5
		else summ_act = summ_act + (summ_need - summ_act) * passed * 10 end
	end

	if get(fuel_meter_1_fail) == 0 then
		if tank1_act < tank1_need - 100 then tank1_act = tank1_act + passed * 1000 * 1.5
		elseif tank1_act > tank1_need + 100 then tank1_act = tank1_act - passed * 1000 * 1.5
		else tank1_act = tank1_act + (tank1_need - tank1_act) * passed * 10 end
	end

	if get(fuel_meter_2l_fail) == 0 then
		if tank2L_act < tank2L_need - 100 then tank2L_act = tank2L_act + passed * 2000 * 1.8
		elseif tank2L_act > tank2L_need + 100 then tank2L_act = tank2L_act - passed * 2000 * 1.8
		else tank2L_act = tank2L_act + (tank2L_need - tank2L_act) * lagCoef(passed, 15) end
	end

	if get(fuel_meter_2r_fail) == 0 then
		if tank2R_act < tank2R_need - 100 then tank2R_act = tank2R_act + passed * 2000 * 1.8
		elseif tank2R_act > tank2R_need + 100 then tank2R_act = tank2R_act - passed * 2000 * 1.8
		else tank2R_act = tank2R_act + (tank2R_need - tank2R_act) * lagCoef(passed, 15) end
	end

	if get(fuel_meter_3l_fail) == 0 then
		if tank3L_act < tank3L_need - 100 then tank3L_act = tank3L_act + passed * 1000 * 2
		elseif tank3L_act > tank3L_need + 100 then tank3L_act = tank3L_act - passed * 1000 * 2
		else tank3L_act = tank3L_act + (tank3L_need - tank3L_act) * lagCoef(passed, 15) end
	end

	if get(fuel_meter_3r_fail) == 0 then
		if tank3R_act < tank3R_need - 100 then tank3R_act = tank3R_act + passed * 1000 * 2
		elseif tank3R_act > tank3R_need + 100 then tank3R_act = tank3R_act - passed * 1000 * 2
		else tank3R_act = tank3R_act + (tank3R_need - tank3R_act) * lagCoef(passed, 15) end
	end

	if get(fuel_meter_4_fail) == 0 then
		if tank4_act < tank4_need - 100 then tank4_act = tank4_act + passed * 1000 * 2.5
		elseif tank4_act > tank4_need + 100 then tank4_act = tank4_act - passed * 1000 * 2.5
		else tank4_act = tank4_act + (tank4_need - tank4_act) * passed * 10 end
	end

	if get(fuel_meter_summ_fail) == 0 then
		if summ_front_act < summ_front_need - 1000 then summ_front_act = summ_front_act + passed * 10000 * 1.5
		elseif summ_front_act > summ_front_need + 1000 then summ_front_act = summ_front_act - passed * 10000 * 1.5
		else summ_front_act = summ_front_act + (summ_front_need - summ_front_act) * passed * 10 end
	end

	set(fuel_meter_summ,        summ_act)
	set(fuel_meter_tank1,       tank1_act)
	set(fuel_meter_tank2_left,  tank2L_act)
	set(fuel_meter_tank2_right, tank2R_act)
	set(fuel_meter_tank3_left,  tank3L_act)
	set(fuel_meter_tank3_right, tank3R_act)
	set(fuel_meter_tank4,       tank4_act)
	set(fuel_front_ind,         summ_front_act)

end


local sim_start_timer = 0

function update()

	-- FIX: frame_time with a fallback
	passed = get_passed()

	-- reset switchers
	sim_start_timer = sim_start_timer + passed
	if sim_start_timer > 0.3 then
		if notLoaded then reset_switchers() end
		check_switchers()
		caps_check()
	end

	local MASTER = get(ismaster) ~= 1

	if MASTER then
		mech_fuel_meter()
	end

	electric_meters()
	lamps()

end
