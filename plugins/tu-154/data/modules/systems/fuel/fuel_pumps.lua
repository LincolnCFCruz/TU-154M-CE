-- MERGED VERSION (the old working logic + XP12 compatibility)
-- Key changes:
--   1. Pump logic from the old version - aggregate datarefs (pump_tank2_left_work = 0/1/2)
--      Works more reliably in XP12 - it does not depend on fuel_flow_mode
--   2. The automatics engage whenever 115 V power is present - not blocked by an empty dataref
--   3. frame_time is used directly; a 0 means the sim is paused and is honoured
--   4. The aggregate result datarefs are kept for compatibility with fuel_panel.lua
--      of the old version AND with the new work1/work2/work3 datarefs for fuel_tanks.lua

-- fuel amount
defineProperty("tank1_w",  globalProperty("sim/flightmodel/weight/m_fuel[0]"))
defineProperty("tank4_w",  globalProperty("sim/flightmodel/weight/m_fuel[1]"))
defineProperty("tank2R_w", globalProperty("sim/flightmodel/weight/m_fuel[2]"))
defineProperty("tank2L_w", globalProperty("sim/flightmodel/weight/m_fuel[3]"))
defineProperty("tank3R_w", globalProperty("sim/flightmodel/weight/m_fuel[4]"))
defineProperty("tank3L_w", globalProperty("sim/flightmodel/weight/m_fuel[5]"))

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

defineProperty("fuel_level",     globalPropertyi("tu-154/switchers/fuel/fuel_level"))
defineProperty("fuel_flow_mode", globalPropertyi("tu-154/switchers/fuel/fuel_flow_mode"))
defineProperty("fuel_flow_on",   globalPropertyi("tu-154/switchers/fuel/fuel_flow_on"))

-- power sources
defineProperty("bus27_volt_left",  globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))
defineProperty("bus115_1_volt",    globalPropertyf("tu-154/elec/bus115_1_volt"))
defineProperty("bus115_3_volt",    globalPropertyf("tu-154/elec/bus115_3_volt"))
-- NOTE: tu-154/elec/avto_L_volt / avto_R_volt / avto_L_amp / avto_R_amp and
-- tu-154/elec/fuel_pumps_115_aL_cc / _aR_cc exist (dataref_creator_2) but this
-- module never fed them -- the "avtoL/avtoR supply" half of the XP12 merge was
-- never finished. The dead bindings are gone; the datarefs stay at 0.

-- failures
defineProperty("fuel_auto_fail",    globalPropertyi("tu-154/failures/fuel_auto_fail"))
defineProperty("fuel_level_fail",   globalPropertyi("tu-154/failures/fuel_level_fail"))
defineProperty("fuel_pump_2l_fail", globalPropertyi("tu-154/failures/fuel_pump_2l_fail"))
defineProperty("fuel_pump_2r_fail", globalPropertyi("tu-154/failures/fuel_pump_2r_fail"))
defineProperty("fuel_pump_3l_fail", globalPropertyi("tu-154/failures/fuel_pump_3l_fail"))
defineProperty("fuel_pump_3r_fail", globalPropertyi("tu-154/failures/fuel_pump_3r_fail"))
defineProperty("fuel_pump_1_fail",  globalPropertyi("tu-154/failures/fuel_pump_1_fail"))
defineProperty("fuel_pump_4_fail",  globalPropertyi("tu-154/failures/fuel_pump_4_fail"))

-- results - AGGREGATE datarefs (the old logic, compatibility with the old fuel_panel)
defineProperty("pump_tank2_left_work",  globalPropertyi("tu-154/fuel/pump_tank2_left_work"))
defineProperty("pump_tank2_right_work", globalPropertyi("tu-154/fuel/pump_tank2_right_work"))
defineProperty("pump_tank3_left_work",  globalPropertyi("tu-154/fuel/pump_tank3_left_work"))
defineProperty("pump_tank3_right_work", globalPropertyi("tu-154/fuel/pump_tank3_right_work"))
defineProperty("pump_tank4_work",       globalPropertyi("tu-154/fuel/pump_tank4_work"))

-- results - INDIVIDUAL tank 1 datarefs
defineProperty("pump_tank1_1_work", globalPropertyi("tu-154/fuel/pump_tank1_1_work"))
defineProperty("pump_tank1_2_work", globalPropertyi("tu-154/fuel/pump_tank1_2_work"))
defineProperty("pump_tank1_3_work", globalPropertyi("tu-154/fuel/pump_tank1_3_work"))
defineProperty("pump_tank1_4_work", globalPropertyi("tu-154/fuel/pump_tank1_4_work"))

-- results - INDIVIDUAL datarefs for tanks 2/3/4 (compatibility with the new fuel_tanks.lua)
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

defineProperty("auto_tanks_turn",   globalPropertyi("tu-154/fuel/auto_tanks_turn"))
defineProperty("auto_tank_level_2", globalPropertyi("tu-154/fuel/auto_tank_level_2"))
defineProperty("auto_tank_level_3", globalPropertyi("tu-154/fuel/auto_tank_level_3"))

defineProperty("fuel_pumps_115_1_cc",    globalPropertyf("tu-154/elec/fuel_pumps_115_1_cc"))
defineProperty("fuel_pumps_115_3_cc",    globalPropertyf("tu-154/elec/fuel_pumps_115_3_cc"))

-- time
defineProperty("frame_time",         globalPropertyf("tu-154/time/frame_time"))
defineProperty("frame_rate_period",  globalPropertyf("sim/operation/misc/frame_rate_period"))


-- fuel press after pumps
local pump_1_1_P = 1
local pump_1_2_P = 1
local pump_1_3_P = 1
local pump_1_4_P = 1

local pump_2L_P = 1
local pump_2R_P = 1
local pump_3L_P = 1
local pump_3R_P = 1
local pump_4_P  = 1


function update()

	-- frame_time is 0 while the sim is paused - that is how time_logic.lua signals
	-- it - so a legitimate 0 is passed through rather than replaced by the
	-- still-running frame_rate_period. See the note in fuel_tanks.lua.
	local passed = get(frame_time)
	if passed == nil then passed = get(frame_rate_period) end
	if passed == nil or passed < 0 then passed = 0 end

	-- check power
	local power_27L = get(bus27_volt_left) > 13
	local power_27R = get(bus27_volt_right) > 13
	local power115  = get(bus115_1_volt) > 110 or get(bus115_3_volt) > 110

	-- fuel quantity
	local tank_qty_2L = get(tank2L_w)
	local tank_qty_2R = get(tank2R_w)
	local tank_qty_3L = get(tank3L_w)
	local tank_qty_3R = get(tank3R_w)
	local tank_qty_4  = get(tank4_w)

	-- tanks has fuel
	local fuel_1  = get(tank1_w) > 150
	local fuel_2L = tank_qty_2L > 60
	local fuel_2R = tank_qty_2R > 60
	local fuel_3L = tank_qty_3L > 200
	local fuel_3R = tank_qty_3R > 200
	local fuel_4  = tank_qty_4 > 50

	-- main pumps logic
	local pump2L_work = 0
	local pump2R_work = 0
	local pump3L_work = 0
	local pump3R_work = 0
	local pump4_work  = 0

	local pump1_1_work = 0
	local pump1_2_work = 0
	local pump1_3_work = 0
	local pump1_4_work = 0

	local tank_level_2 = 0
	local tank_level_3 = 0

	-- calculate automatic cue mode
	local tanks_turn = 0
	if (power_27L or power_27R) and get(fuel_flow_on) == 1 and get(fuel_auto_fail) == 0 then
		if tank_qty_2L + tank_qty_2R > 7400 then tanks_turn = 1
		elseif tank_qty_2L + tank_qty_2R <= 7400 and (fuel_2L or fuel_2R) and (fuel_3L or fuel_3R) then tanks_turn = 2
		elseif fuel_3L or fuel_3R then tanks_turn = 3
		elseif fuel_2L or fuel_2R then tanks_turn = 1
		elseif fuel_4 then tanks_turn = 4
		end
	end

	-- FIX: fuel_flow_mode - if the dataref is empty/0 in XP12, work in manual mode
	-- the pumps will switch on anyway through manual mode as long as 115 V power is present
	local flow_mode = get(fuel_flow_mode)
	local is_auto = flow_mode ~= nil and flow_mode == 1

	if power115 then

		if tanks_turn > 0 and is_auto then
			-- automatic mode
			if tanks_turn == 1 then
				if tank_qty_2L > 500 then pump2L_work = math.max(0, 2 - get(fuel_pump_2l_fail))
				elseif fuel_2L then pump2L_work = math.max(0, get(pump_tank2_left) * 2 - get(fuel_pump_2l_fail)) end

				if tank_qty_2R > 500 then pump2R_work = math.max(0, 2 - get(fuel_pump_2r_fail))
				elseif fuel_2R then pump2R_work = math.max(0, get(pump_tank2_right) * 2 - get(fuel_pump_2r_fail)) end

			elseif tanks_turn == 2 then
				if tank_qty_2L > 500 then pump2L_work = math.max(0, 2 - get(fuel_pump_2l_fail))
				elseif fuel_2L then pump2L_work = math.max(0, get(pump_tank2_left) * 2 - get(fuel_pump_2l_fail)) end

				if tank_qty_2R > 500 then pump2R_work = math.max(0, 2 - get(fuel_pump_2r_fail))
				elseif fuel_2R then pump2R_work = math.max(0, get(pump_tank2_right) * 2 - get(fuel_pump_2r_fail)) end

				if tank_qty_3L > 2200 then pump3L_work = math.max(0, 3 - get(fuel_pump_3l_fail))
				elseif fuel_3L then pump3L_work = math.max(0, get(pump_tank3_left) * 3 - get(fuel_pump_3l_fail)) end

				if tank_qty_3R > 2200 then pump3R_work = math.max(0, 3 - get(fuel_pump_3r_fail))
				elseif fuel_3R then pump3R_work = math.max(0, get(pump_tank3_right) * 3 - get(fuel_pump_3r_fail)) end

			elseif tanks_turn == 3 then
				if tank_qty_3L > 2200 then pump3L_work = math.max(0, 3 - get(fuel_pump_3l_fail))
				elseif fuel_3L then pump3L_work = math.max(0, get(pump_tank3_left) * 3 - get(fuel_pump_3l_fail)) end

				if tank_qty_3R > 2200 then pump3R_work = math.max(0, 3 - get(fuel_pump_3r_fail))
				elseif fuel_3R then pump3R_work = math.max(0, get(pump_tank3_right) * 3 - get(fuel_pump_3r_fail)) end

			elseif tanks_turn == 4 then
				if tank_qty_4 > 600 then pump4_work = math.max(0, 2 - get(fuel_pump_4_fail))
				elseif fuel_4 then pump4_work = math.max(0, get(pump_tank4) * 2 - get(fuel_pump_4_fail)) end
			end

		else
			-- manual mode (including XP12, where fuel_flow_mode is empty)
			if fuel_2L then pump2L_work = math.max(0, get(pump_tank2_left) * 2 - get(fuel_pump_2l_fail)) end
			if fuel_2R then pump2R_work = math.max(0, get(pump_tank2_right) * 2 - get(fuel_pump_2r_fail)) end
			if fuel_3L then pump3L_work = math.max(0, get(pump_tank3_left) * 3 - get(fuel_pump_3l_fail)) end
			if fuel_3R then pump3R_work = math.max(0, get(pump_tank3_right) * 3 - get(fuel_pump_3r_fail)) end
			if fuel_4  then pump4_work  = math.max(0, get(pump_tank4) * 2 - get(fuel_pump_4_fail)) end
		end

		-- balancing logic
		if get(fuel_level) == 1 and get(fuel_level_fail) == 0 then
			if tank_qty_2R - tank_qty_2L > 350 then
				tank_level_2 = -1
				pump2L_work = 0
			elseif tank_qty_2L - tank_qty_2R > 350 then
				tank_level_2 = 1
				pump2R_work = 0
			else
				tank_level_2 = 0
			end

			if tank_qty_3R - tank_qty_3L > 300 then
				tank_level_3 = -1
				pump3L_work = 0
			elseif tank_qty_3L - tank_qty_3R > 300 then
				tank_level_3 = 1
				pump3R_work = 0
			else
				tank_level_3 = 0
			end
		end

		-- the tank 1 pumps run independently of the automatics
		if fuel_1 then
			-- fuel_pump_1_fail is a COUNT of failed pumps: fuel_fails.lua sets it to
			-- N when pumps 1..N have failed, so pump N is out when the count >= N.
			pump1_1_work = get(pump_tank1_1) * bool2int(get(fuel_pump_1_fail) < 1)
			pump1_2_work = get(pump_tank1_2) * bool2int(get(fuel_pump_1_fail) < 2)
			pump1_3_work = get(pump_tank1_3) * bool2int(get(fuel_pump_1_fail) < 3)
			pump1_4_work = get(pump_tank1_4) * bool2int(get(fuel_pump_1_fail) < 4)
		end

	end


	-- calculate pressures
	if pump2L_work > 0 and pump_2L_P < 1 then pump_2L_P = pump_2L_P + passed * 0.8
	elseif pump_2L_P > 0 then pump_2L_P = pump_2L_P - passed * 0.8 end

	if pump2R_work > 0 and pump_2R_P < 1 then pump_2R_P = pump_2R_P + passed * 0.8
	elseif pump_2R_P > 0 then pump_2R_P = pump_2R_P - passed * 0.8 end

	if pump3L_work > 0 and pump_3L_P < 1 then pump_3L_P = pump_3L_P + passed * 0.8
	elseif pump_3L_P > 0 then pump_3L_P = pump_3L_P - passed * 0.8 end

	if pump3R_work > 0 and pump_3R_P < 1 then pump_3R_P = pump_3R_P + passed * 0.8
	elseif pump_3R_P > 0 then pump_3R_P = pump_3R_P - passed * 0.8 end

	if pump4_work > 0 and pump_4_P < 1 then pump_4_P = pump_4_P + passed * 0.8
	elseif pump_4_P > 0 then pump_4_P = pump_4_P - passed * 0.8 end

	if pump1_1_work == 1 and pump_1_1_P < 1 then pump_1_1_P = pump_1_1_P + passed * 0.8
	elseif pump_1_1_P > 0 then pump_1_1_P = pump_1_1_P - passed * 0.8 end

	if pump1_2_work == 1 and pump_1_2_P < 1 then pump_1_2_P = pump_1_2_P + passed * 0.8
	elseif pump_1_2_P > 0 then pump_1_2_P = pump_1_2_P - passed * 0.8 end

	if pump1_3_work == 1 and pump_1_3_P < 1 then pump_1_3_P = pump_1_3_P + passed * 0.8
	elseif pump_1_3_P > 0 then pump_1_3_P = pump_1_3_P - passed * 0.8 end

	if pump1_4_work == 1 and pump_1_4_P < 1 then pump_1_4_P = pump_1_4_P + passed * 0.8
	elseif pump_1_4_P > 0 then pump_1_4_P = pump_1_4_P - passed * 0.8 end


	-- calculate electrics
	-- Tank 1's four pumps are split across the two buses (1+3 on bus 1, 2+4 on
	-- bus 3); the tank 2/3/4 pumps are a shared load and so weigh the same on
	-- both. The tank-3 term used to carry an extra "* 2" on bus 1 only.
	local shared_load = pump4_work + pump2L_work * 0.5 + pump2R_work * 0.5 + pump3L_work * 0.3 + pump3R_work * 0.3
	local bus_1_load = (pump1_1_work + pump1_3_work) * 8.3 + shared_load * 2.6
	local bus_3_load = (pump1_2_work + pump1_4_work) * 8.3 + shared_load * 2.6


	local p2L = bool2int(pump_2L_P > 0.9)
	local p2R = bool2int(pump_2R_P > 0.9)
	local p3L = bool2int(pump_3L_P > 0.9)
	local p3R = bool2int(pump_3R_P > 0.9)
	local p4  = bool2int(pump_4_P  > 0.9)

	-- aggregate datarefs (for the old version of fuel_panel)
	set(pump_tank2_left_work,  math.max(0, p2L * 2 - get(fuel_pump_2l_fail)))
	set(pump_tank2_right_work, math.max(0, p2R * 2 - get(fuel_pump_2r_fail)))
	set(pump_tank3_left_work,  math.max(0, p3L * 3 - get(fuel_pump_3l_fail)))
	set(pump_tank3_right_work, math.max(0, p3R * 3 - get(fuel_pump_3r_fail)))
	set(pump_tank4_work,       math.max(0, p4  * 2 - get(fuel_pump_4_fail)))

	-- individual tank 1 datarefs
	set(pump_tank1_1_work, bool2int(pump_1_1_P > 0.9))
	set(pump_tank1_2_work, bool2int(pump_1_2_P > 0.9))
	set(pump_tank1_3_work, bool2int(pump_1_3_P > 0.9))
	set(pump_tank1_4_work, bool2int(pump_1_4_P > 0.9))

	-- individual datarefs for tanks 2/3/4 (for compatibility with fuel_tanks.lua).
	-- These MUST account for the failure count the way the aggregates above do:
	-- fuel_tanks.lua sums them to get the number of running pumps, so writing the
	-- raw pressure flag meant a tank with 2 of its 3 pumps failed still transferred
	-- at the full 3-pump rate while the panel lamps correctly showed them out.
	-- fuel_pump_*_fail is a COUNT, so pump N is out when the count >= N - the same
	-- idiom as the tank 1 pumps above. Each set therefore sums to (n - failed).
	local f2l = get(fuel_pump_2l_fail)
	local f2r = get(fuel_pump_2r_fail)
	local f3l = get(fuel_pump_3l_fail)
	local f3r = get(fuel_pump_3r_fail)
	local f4  = get(fuel_pump_4_fail)

	set(pump_tank2_left1_work,  p2L * bool2int(f2l < 1))
	set(pump_tank2_left2_work,  p2L * bool2int(f2l < 2))
	set(pump_tank2_right1_work, p2R * bool2int(f2r < 1))
	set(pump_tank2_right2_work, p2R * bool2int(f2r < 2))
	set(pump_tank3_left1_work,  p3L * bool2int(f3l < 1))
	set(pump_tank3_left2_work,  p3L * bool2int(f3l < 2))
	set(pump_tank3_left3_work,  p3L * bool2int(f3l < 3))
	set(pump_tank3_right1_work, p3R * bool2int(f3r < 1))
	set(pump_tank3_right2_work, p3R * bool2int(f3r < 2))
	set(pump_tank3_right3_work, p3R * bool2int(f3r < 3))
	set(pump_tank41_work, p4 * bool2int(f4 < 1))
	set(pump_tank42_work, p4 * bool2int(f4 < 2))

	set(auto_tanks_turn,   tanks_turn)
	set(auto_tank_level_2, tank_level_2)
	set(auto_tank_level_3, tank_level_3)

	set(fuel_pumps_115_1_cc, bus_1_load)
	set(fuel_pumps_115_3_cc, bus_3_load)

end
