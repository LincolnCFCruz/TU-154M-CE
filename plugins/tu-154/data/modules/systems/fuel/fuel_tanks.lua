-- fuel quantity
defineProperty("tank1_w",  globalProperty("sim/flightmodel/weight/m_fuel[0]")) -- fuel weight
defineProperty("tank4_w",  globalProperty("sim/flightmodel/weight/m_fuel[1]")) -- fuel weight
defineProperty("tank2R_w", globalProperty("sim/flightmodel/weight/m_fuel[2]")) -- fuel weight
defineProperty("tank2L_w", globalProperty("sim/flightmodel/weight/m_fuel[3]")) -- fuel weight
defineProperty("tank3R_w", globalProperty("sim/flightmodel/weight/m_fuel[4]")) -- fuel weight
defineProperty("tank3L_w", globalProperty("sim/flightmodel/weight/m_fuel[5]")) -- fuel weight


-- fuel tanks pumps control
defineProperty("tank1_pump",  globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[0]"))
defineProperty("tank4_pump",  globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[1]"))
defineProperty("tank2R_pump", globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[2]"))
defineProperty("tank2L_pump", globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[3]"))
defineProperty("tank3R_pump", globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[4]"))
defineProperty("tank3L_pump", globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[5]"))

defineProperty("fuel_trans", globalPropertyi("tu-154/switchers/fuel/fuel_trans")) -- standby transfer valves
defineProperty("fuel_porc",  globalPropertyi("tu-154/switchers/fuel/fuel_porc"))  -- forced, metered

-- fuel pumps work
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
defineProperty("pump_tank41_work", globalPropertyi("tu-154/fuel/pump_tank4_work1"))
defineProperty("pump_tank42_work", globalPropertyi("tu-154/fuel/pump_tank4_work2"))
defineProperty("pump_tank1_1_work", globalPropertyi("tu-154/fuel/pump_tank1_1_work"))
defineProperty("pump_tank1_2_work", globalPropertyi("tu-154/fuel/pump_tank1_2_work"))
defineProperty("pump_tank1_3_work", globalPropertyi("tu-154/fuel/pump_tank1_3_work"))
defineProperty("pump_tank1_4_work", globalPropertyi("tu-154/fuel/pump_tank1_4_work"))

defineProperty("reserv_trans", globalPropertyi("tu-154/fuel/reserv_trans"))

-- porc_open decides whether fuel reaches tank 1 at all and was never published;
-- reserv_trans below is only the >0.9 end of trans_pos, so the valve's travel
-- was not visible either
defineProperty("porc_open_out", globalPropertyi("tu-154/fuel/porc_open")) -- metering unit passing fuel
defineProperty("trans_pos_out", globalPropertyf("tu-154/fuel/trans_pos")) -- standby transfer valve travel, 0..1

defineProperty("apu_burn_fuel", globalPropertyf("tu-154/elec/apu_burning_fuel")) -- the APU is running and burning fuel

-- altitude
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation")) -- physical altitude MSL. meters

defineProperty("gear_defl_L", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]")) -- landing gear strut compression
defineProperty("gear_defl_R", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]")) -- landing gear strut compression

-- failures
defineProperty("rel_fuelcap",    globalPropertyi("sim/operation/failures/rel_fuelcap")) -- Fuel Cap left off
defineProperty("fuel_porc_fail", globalPropertyi("tu-154/failures/fuel_porc_fail"))

-- time
defineProperty("frame_time",       globalPropertyf("tu-154/time/frame_time"))


defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 V bus voltage

defineProperty("fuel_temp_1", globalPropertyf("tu-154/gauges/eng/fuel_temp_1")) -- fuel temperature
defineProperty("fuel_temp_2", globalPropertyf("tu-154/gauges/eng/fuel_temp_2")) -- fuel temperature
defineProperty("tat", globalPropertyf("sim/weather/aircraft/temperature_leadingedge_deg_c"))  --XP12

-- the APU fuel consumption is 160-240 kg/h depending on the load.

-- X-Plane's own tank pumps stay on: fuel_pumps.lua decides what actually flows,
-- and switching any of them off here starves the engines.
set(tank1_pump,  1)
set(tank4_pump,  1)
set(tank2R_pump, 1)
set(tank2L_pump, 1)
set(tank3R_pump, 1)
set(tank3L_pump, 1)

function onModuleDone()
	set(tank1_pump,  1)
	set(tank4_pump,  1)
	set(tank2R_pump, 1)
	set(tank2L_pump, 1)
	set(tank3R_pump, 1)
	set(tank3L_pump, 1)
end


local passed = get(frame_time)

local porc_open = false
local transfer  = false -- fuel goes aside porc

local trans_pos = 0

-- fuel pumps random
local tank2L_rnd = math.random(95, 105) * 0.01
local tank2R_rnd = math.random(95, 105) * 0.01
local tank3L_rnd = math.random(95, 105) * 0.01
local tank3R_rnd = math.random(95, 105) * 0.01

local fuel_temp_act_1 = get(tat)
local fuel_temp_act_2 = get(tat)
local start_timer = 0

function update()

	passed = get(frame_time)

	if start_timer < 60 then
		start_timer = start_timer + passed
	end

	-- fuel tanks amount
	local tank1_qty  = get(tank1_w)
	local tank4_qty  = get(tank4_w)
	local tank2L_qty = get(tank2L_w)
	local tank2R_qty = get(tank2R_w)
	local tank3L_qty = get(tank3L_w)
	local tank3R_qty = get(tank3R_w)

	local power27 = get(bus27_volt_right) > 13

	-- check tank 1 quantity
	local tank1_full = tank1_qty >= 3300

	-- porcioner manipulations
	if (tank1_qty < 3150 and get(fuel_porc_fail) == 0) or (get(fuel_porc) == 1 and power27 and not tank1_full) then
		porc_open = true  -- open porc
	elseif tank1_full then
		porc_open = false -- close it
	end

	-- reserv fuel transfer
	if get(fuel_trans) == 1 and trans_pos < 1 and power27 then
		trans_pos = trans_pos + passed
	elseif trans_pos > 0 and power27 then
		trans_pos = trans_pos - passed
	end

	transfer = trans_pos > 0.9
	set(reserv_trans, bool2int(trans_pos > 0.9))

	-- calculate fuel pumps speed depending on altitude
	local spd = 1.55 - get(msl_alt) * 1.11 / 14000 -- kg/sec

	-- check pumps work
	local pump2L = (get(pump_tank2_left1_work)  + get(pump_tank2_left2_work))  * spd * tank2L_rnd
	local pump2R = (get(pump_tank2_right1_work) + get(pump_tank2_right2_work)) * spd * tank2R_rnd
	local pump3L = (get(pump_tank3_left1_work)  + get(pump_tank3_left2_work)  + get(pump_tank3_left3_work))  * spd * tank3L_rnd
	local pump3R = (get(pump_tank3_right1_work) + get(pump_tank3_right2_work) + get(pump_tank3_right3_work)) * spd * tank3R_rnd
	local pump4  = (get(pump_tank41_work) + get(pump_tank42_work)) * spd

	-- transfer fuel from other tanks
	if porc_open or (transfer and not tank1_full) then
		-- take fuel from tanks 2, 3, 4
		tank2L_qty = tank2L_qty - passed * pump2L
		tank2R_qty = tank2R_qty - passed * pump2R
		tank3L_qty = tank3L_qty - passed * pump3L
		tank3R_qty = tank3R_qty - passed * pump3R
		tank4_qty  = tank4_qty  - passed * pump4
		-- give it to tank 1
		tank1_qty = tank1_qty + (pump2L + pump2R + pump3L + pump3R + pump4) * passed

	-- top the tanks 2 back up on the ground, tank 1 already being full.
	-- The pumps circulate through the ring main, so tanks 2 are debited by their
	-- own pumps and then credited again; the net gain to tanks 2 is what comes
	-- out of tanks 3 and 4.
	elseif transfer and tank1_full and (tank2L_qty < 9500 or tank2R_qty < 9500) and get(gear_defl_L) + get(gear_defl_R) > 0.05 then
		local tank2L_take = bool2int(tank2L_qty < 9500)
		local tank2R_take = bool2int(tank2R_qty < 9500)
		-- take fuel from the pumping tanks
		tank2L_qty = tank2L_qty - passed * pump2L
		tank2R_qty = tank2R_qty - passed * pump2R
		tank3L_qty = tank3L_qty - passed * pump3L
		tank3R_qty = tank3R_qty - passed * pump3R
		tank4_qty  = tank4_qty  - passed * pump4
		-- move it to whichever of the tanks 2 is still accepting fuel.
		-- The take flags MUST gate the credits: without them a single tank below
		-- 9500 gave divide == 1 and both tanks were credited the full amount,
		-- creating fuel out of nothing at twice the rate it was drawn.
		local total_pump = (pump2L + pump2R + pump3L + pump3R + pump4) * passed
		local divide = tank2L_take + tank2R_take
		if divide > 0 then
			tank2L_qty = tank2L_qty + total_pump * tank2L_take / divide
			tank2R_qty = tank2R_qty + total_pump * tank2R_take / divide
		end
	end

	-- take fuel for APU
	if get(apu_burn_fuel) == 1 then
		tank1_qty = tank1_qty - passed * 0.0556
	end

	-- limit fuel amount in tanks
	if tank1_qty  > 3350  then tank1_qty  = 3350  end
	if tank2L_qty > 9550  then tank2L_qty = 9550  end
	if tank2R_qty > 9550  then tank2R_qty = 9550  end
	if tank3L_qty > 5425  then tank3L_qty = 5425  end
	if tank3R_qty > 5425  then tank3R_qty = 5425  end
	if tank4_qty  > 6600  then tank4_qty  = 6600  end

	-- do not allow negative values
	if tank1_qty  < 0 then tank1_qty  = 0 end
	if tank2L_qty < 0 then tank2L_qty = 0 end
	if tank2R_qty < 0 then tank2R_qty = 0 end
	if tank3L_qty < 0 then tank3L_qty = 0 end
	if tank3R_qty < 0 then tank3R_qty = 0 end
	if tank4_qty  < 0 then tank4_qty  = 0 end

	-- fuel temp
	local air_temp = get(tat)
	fuel_temp_act_1 = fuel_temp_act_1 + (air_temp - fuel_temp_act_1) * passed * 0.000022  * (2 - (tank2L_qty + tank3L_qty) / (9550 + 5425))
	fuel_temp_act_2 = fuel_temp_act_2 + (air_temp - fuel_temp_act_2) * passed * 0.00002201 * (2 - (tank2R_qty + tank3R_qty) / (9550 + 5425))

	if start_timer < 60 then
		fuel_temp_act_1 = air_temp
		fuel_temp_act_2 = air_temp
	end

	set(tank1_w,  tank1_qty)
	set(tank4_w,  tank4_qty)
	set(tank2L_w, tank2L_qty)
	set(tank2R_w, tank2R_qty)
	set(tank3L_w, tank3L_qty)
	set(tank3R_w, tank3R_qty)

	set(fuel_temp_1, fuel_temp_act_1)
	set(fuel_temp_2, fuel_temp_act_2)

	-- publish the two valve states the transfer above depended on
	set(porc_open_out, bool2int(porc_open))
	set(trans_pos_out, trans_pos)

	-- fix stupid failures
	set(rel_fuelcap, 0)

end
