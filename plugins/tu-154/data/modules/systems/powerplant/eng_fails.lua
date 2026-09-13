defineProperty("engine_runtime_1", globalPropertyf("tu-154/failures/engine_runtime_1")) 
defineProperty("engine_runtime_2", globalPropertyf("tu-154/failures/engine_runtime_2")) 
defineProperty("engine_runtime_3", globalPropertyf("tu-154/failures/engine_runtime_3"))

defineProperty("engn_oil_qty_1", globalPropertyf("tu-154/failures/engn_oil_qty_1")) 
defineProperty("engn_oil_qty_2", globalPropertyf("tu-154/failures/engn_oil_qty_2")) 
defineProperty("engn_oil_qty_3", globalPropertyf("tu-154/failures/engn_oil_qty_3"))

defineProperty("engn_oil_leak_1", globalPropertyi("tu-154/failures/engn_oil_leak_1")) 
defineProperty("engn_oil_leak_2", globalPropertyi("tu-154/failures/engn_oil_leak_2")) 
defineProperty("engn_oil_leak_3", globalPropertyi("tu-154/failures/engn_oil_leak_3"))

defineProperty("oil_pump_fail_1", globalPropertyi("sim/operation/failures/rel_oilpmp0")) 
defineProperty("oil_pump_fail_2", globalPropertyi("sim/operation/failures/rel_oilpmp1")) 
defineProperty("oil_pump_fail_3", globalPropertyi("sim/operation/failures/rel_oilpmp2"))

defineProperty("fuel_flowmeter_1_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_1_fail"))
defineProperty("fuel_flowmeter_2_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_2_fail"))
defineProperty("fuel_flowmeter_3_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_3_fail"))


defineProperty("eng_fail_1", globalPropertyi("sim/operation/failures/rel_engfai0"))
defineProperty("eng_fail_2", globalPropertyi("sim/operation/failures/rel_engfai1"))
defineProperty("eng_fail_3", globalPropertyi("sim/operation/failures/rel_engfai2"))

defineProperty("eng_fire_1", globalPropertyi("sim/operation/failures/rel_engfir0"))
defineProperty("eng_fire_2", globalPropertyi("sim/operation/failures/rel_engfir1"))
defineProperty("eng_fire_3", globalPropertyi("sim/operation/failures/rel_engfir2"))

defineProperty("eng_flame_1", globalPropertyi("sim/operation/failures/rel_engfla0"))
defineProperty("eng_flame_2", globalPropertyi("sim/operation/failures/rel_engfla1"))
defineProperty("eng_flame_3", globalPropertyi("sim/operation/failures/rel_engfla2"))

defineProperty("eng_stall_1", globalPropertyi("sim/operation/failures/rel_comsta0"))
defineProperty("eng_stall_2", globalPropertyi("sim/operation/failures/rel_comsta1"))
defineProperty("eng_stall_3", globalPropertyi("sim/operation/failures/rel_comsta2"))

defineProperty("eng_fuel_pmp_fail_1", globalPropertyi("tu-154/failures/eng_fuel_pmp_fail_1"))
defineProperty("eng_fuel_pmp_fail_2", globalPropertyi("tu-154/failures/eng_fuel_pmp_fail_2"))
defineProperty("eng_fuel_pmp_fail_3", globalPropertyi("tu-154/failures/eng_fuel_pmp_fail_3"))


defineProperty("eng_filter_1", globalPropertyi("sim/operation/failures/rel_eng_lo0"))
defineProperty("eng_filter_2", globalPropertyi("sim/operation/failures/rel_eng_lo1"))
defineProperty("eng_filter_3", globalPropertyi("sim/operation/failures/rel_eng_lo2"))

defineProperty("eng_start_1", globalPropertyi("sim/operation/failures/rel_startr0"))
defineProperty("eng_start_2", globalPropertyi("sim/operation/failures/rel_startr1"))
defineProperty("eng_start_3", globalPropertyi("sim/operation/failures/rel_startr2"))

defineProperty("eng_ign_1", globalPropertyi("sim/operation/failures/rel_ignitr0"))
defineProperty("eng_ign_2", globalPropertyi("sim/operation/failures/rel_ignitr1"))
defineProperty("eng_ign_3", globalPropertyi("sim/operation/failures/rel_ignitr2"))

defineProperty("eng_revrs_1", globalPropertyi("sim/operation/failures/rel_revers0"))
defineProperty("eng_revrs_3", globalPropertyi("sim/operation/failures/rel_revers2"))

-- reverser travel, engines 1 and 3 only - engine 2 (tail) has no reverser.
-- Used for the continuous-reverse time limit below.
defineProperty("revers_deploy_1", globalProperty("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[0]"))
defineProperty("revers_deploy_3", globalProperty("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[2]"))

defineProperty("ENGN_oil_q_1", globalProperty("sim/flightmodel/engine/ENGN_oil_quan[0]"))
defineProperty("ENGN_oil_q_2", globalProperty("sim/flightmodel/engine/ENGN_oil_quan[1]"))
defineProperty("ENGN_oil_q_3", globalProperty("sim/flightmodel/engine/ENGN_oil_quan[2]"))


defineProperty("fuel_fluct_1", globalPropertyi("sim/operation/failures/rel_fuelfl0")) -- Fuel Flow Fluctuation
defineProperty("fuel_fluct_2", globalPropertyi("sim/operation/failures/rel_fuelfl1")) -- Fuel Flow Fluctuation
defineProperty("fuel_fluct_3", globalPropertyi("sim/operation/failures/rel_fuelfl2")) -- Fuel Flow Fluctuation

defineProperty("sim_egt_1", globalProperty("sim/cockpit2/engine/indicators/EGT_deg_cel[0]")) -- EGT from sim
defineProperty("sim_egt_2", globalProperty("sim/cockpit2/engine/indicators/EGT_deg_cel[1]")) -- EGT from sim
defineProperty("sim_egt_3", globalProperty("sim/cockpit2/engine/indicators/EGT_deg_cel[2]")) -- EGT from sim



-- engines data
defineProperty("rpm_high_1", globalPropertyf("tu-154/gauges/engine/rpm_high_1")) -- engine 1 high-pressure spool rpm
defineProperty("rpm_high_2", globalPropertyf("tu-154/gauges/engine/rpm_high_2")) -- engine 2 high-pressure spool rpm
defineProperty("rpm_high_3", globalPropertyf("tu-154/gauges/engine/rpm_high_3")) -- engine 3 high-pressure spool rpm

defineProperty("eng_work_1", globalProperty("sim/flightmodel2/engines/engine_is_burning_fuel[0]"))
defineProperty("eng_work_2", globalProperty("sim/flightmodel2/engines/engine_is_burning_fuel[1]"))
defineProperty("eng_work_3", globalProperty("sim/flightmodel2/engines/engine_is_burning_fuel[2]"))


defineProperty("alpha", globalPropertyf("sim/flightmodel2/misc/AoA_angle_degrees"))  -- angle of attack
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  -- phisical altitude MSL. meters
defineProperty("msl_press", globalPropertyf("sim/weather/region/sealevel_pressure_pas"))  -- sea level pressure in Pa (XP12)
defineProperty("pressure", globalPropertyf("tu-154/gauges/alt/vbe_press_left"))  -- pressure in hPa

-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

defineProperty("failures_enabled", globalPropertyi("tu-154/failures/failures_enabled"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master

-- put oil before every flight
set(engn_oil_qty_1, math.random() + 26)
set(engn_oil_qty_2, math.random() + 26)
set(engn_oil_qty_3, math.random() + 26)


set(engine_runtime_1, math.random(280,320) * 3600)
set(engine_runtime_2, math.random(280,320) * 3600)
set(engine_runtime_3, math.random(280,320) * 3600)



local engnRuntimeCoef = {
  {-1000, 0},
  {0, 0.5},
  {30, 1},
  {90, 1},
  {100, 2},
  {1000, 10} 
  }

local oilLeak1 = math.random(20, 100)
local oilLeak2 = math.random(20, 100)
local oilLeak3 = math.random(20, 100)

local minusTimer1 = 0
local minusTimer2 = 0
local minusTimer3 = 0


-- random failures: { flag, k1, k2, failed value } (rollFailures, core/glbl_func.lua)
local RANDOM_FAILS_A = {
	{ engn_oil_leak_1, 0.00001, 0.3, 1 },
	{ engn_oil_leak_2, 0.00001, 0.3, 1 },
	{ engn_oil_leak_3, 0.00001, 0.3, 1 },

	{ oil_pump_fail_1, 0.00001, 0.3, 6 },
	{ oil_pump_fail_2, 0.00001, 0.3, 6 },
	{ oil_pump_fail_3, 0.00001, 0.3, 6 },

	{ fuel_flowmeter_1_fail, 0.00001, 0.3, 1 },
	{ fuel_flowmeter_2_fail, 0.00001, 0.3, 1 },
	{ fuel_flowmeter_3_fail, 0.00001, 0.3, 1 },
}

local RANDOM_FAILS_B = {
	{ eng_fuel_pmp_fail_1, 0.00001, 0.3, 1 },
	{ eng_fuel_pmp_fail_2, 0.00001, 0.3, 1 },
	{ eng_fuel_pmp_fail_3, 0.00001, 0.3, 1 },

	{ eng_filter_1, 0.00001, 0.3, 6 },
	{ eng_filter_2, 0.00001, 0.3, 6 },
	{ eng_filter_3, 0.00001, 0.3, 6 },

	{ eng_start_1, 0.00001, 0.3, 6 },
	{ eng_start_2, 0.00001, 0.3, 6 },
	{ eng_start_3, 0.00001, 0.3, 6 },

	{ eng_ign_1, 0.00001, 0.3, 6 },
	{ eng_ign_2, 0.00001, 0.3, 6 },
	{ eng_ign_3, 0.00001, 0.3, 6 },

	{ eng_revrs_1, 0.00001, 0.3, 6 },
	{ eng_revrs_3, 0.00001, 0.3, 6 },
}

local fail_counter = 0
local stall_counter = 0
local check_time = math.random(15, 30)
local stall_time = math.random()

local engToCounter1 = 0
local engToCounter2 = 0
local engToCounter3 = 0

-- Continuous time spent on reverse thrust, engines 1 and 3.
-- RLE 8.1.1 row (15) and engine RE 072.00.00 sect.5.9.2 (p.19) both give the
-- same limit: no more than 1.0 min continuously on reverse.
local engRevCounter1 = 0
local engRevCounter3 = 0




function update()
    
    
	local passed = get(frame_time)
 
if get(ismaster) ~= 1 then		
	
	
	local FAIL = get(failures_enabled)
	FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
	
	if FAIL > 0 then
		
		
		-- check engine stall
		stall_counter = stall_counter + passed
		
		if stall_counter > stall_time then
			stall_counter = 0
			stall_time = math.random()
			
			
			local aoa = get(alpha) - 2
			
			local AOA_coef = 0
			
			if aoa > -80 and aoa < 80 then
				
				aoa = math.max(0, (math.abs(aoa) - 10))
				AOA_coef = math.tan(math.rad(aoa)) / 5.671
			
			else AOA_coef = 1 end
			
			
			local msl = get(msl_alt) * 3.28083 -- real alt MSL in feet
			-- msl_press is now in Pa (XP12), converted to inHg: 1 inHg = 3386.389 Pa
			local msl_press_inhg = get(msl_press) / 3386.389
			local altitude_ft = msl + (get(pressure) * 0.0295300586467 - msl_press_inhg) * 1000  -- barometric altitude in feet
			local alt_mtr = altitude_ft * 0.3048
			local ALT_coef = math.max(0, alt_mtr - 8000) / 10000
			
			local RPM_coef_1 = math.max(0, get(rpm_high_1) * 0.01 - 0.7) * 3
			local RPM_coef_2 = math.max(0, get(rpm_high_2) * 0.01 - 0.7) * 3
			local RPM_coef_3 = math.max(0, get(rpm_high_3) * 0.01 - 0.7) * 3
			
			if get(eng_stall_1) ~= 6 then set(eng_stall_1, bool2int(math.random() < 1 * AOA_coef * ALT_coef * RPM_coef_1) * 6) end
			if get(eng_stall_2) ~= 6 then set(eng_stall_2, bool2int(math.random() < 1 * AOA_coef * ALT_coef * RPM_coef_2) * 6) end
			if get(eng_stall_3) ~= 6 then set(eng_stall_3, bool2int(math.random() < 1 * AOA_coef * ALT_coef * RPM_coef_3) * 6) end
			
			-- reset stall, if engine is not working
			if get(eng_work_1) == 0 then set(eng_stall_1, 0) end
			if get(eng_work_2) == 0 then set(eng_stall_2, 0) end
			if get(eng_work_3) == 0 then set(eng_stall_3, 0) end
			
		
		end
		
		
		
		
		
		fail_counter = fail_counter + passed
		
		if fail_counter > check_time then
			fail_counter = 0
			check_time = math.random(15, 30)
			
			-- random failures
			rollFailures(RANDOM_FAILS_A, FAIL)
			
			-- engToCounter > 300 s = the 5 min takeoff-power limit (RLE 8.1.1 row 10)
			-- engRevCounter > 60 s = the 1 min continuous-reverse limit (row 15)
			if get(eng_fail_1) ~= 6 then set(eng_fail_1, bool2int(math.random() < 0.00001 * FAIL * 0.3 + bool2int(engToCounter1 > 300) * 0.0001 + bool2int(engRevCounter1 > 60) * 0.0001) * 6) end
			if get(eng_fail_2) ~= 6 then set(eng_fail_2, bool2int(math.random() < 0.00001 * FAIL * 0.3 + bool2int(engToCounter2 > 300) * 0.0001) * 6) end
			if get(eng_fail_3) ~= 6 then set(eng_fail_3, bool2int(math.random() < 0.00001 * FAIL * 0.3 + bool2int(engToCounter3 > 300) * 0.0001 + bool2int(engRevCounter3 > 60) * 0.0001) * 6) end
			
			if get(eng_work_1) == 1 then
				if get(eng_fire_1) ~= 6 then set(eng_fire_1, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
				if get(eng_fire_1) ~= 6 and get(sim_egt_1) > 600 then set(eng_fire_1, bool2int(math.random() < 0.001 * FAIL * 0.3) * 6) end
			end
			
			if get(eng_work_2) == 1 then
				if get(eng_fire_2) ~= 6 then set(eng_fire_2, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
				if get(eng_fire_2) ~= 6 and get(sim_egt_2) > 600 then set(eng_fire_2, bool2int(math.random() < 0.001 * FAIL * 0.3) * 6) end
			end
			
			if get(eng_work_3) == 1 then
				if get(eng_fire_3) ~= 6 then set(eng_fire_3, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
				if get(eng_fire_3) ~= 6 and get(sim_egt_3) > 600 then set(eng_fire_3, bool2int(math.random() < 0.001 * FAIL * 0.3) * 6) end
			end
			

			
			rollFailures(RANDOM_FAILS_B, FAIL)
			
			
		
		end
		
		-- dependent failures
		
		-- OIL
		-- normal usage = 1 litre/h
		set(engn_oil_qty_1, math.max(0, get(engn_oil_qty_1) - get(rpm_high_1) * 0.01 * passed / 3600))
		set(engn_oil_qty_2, math.max(0, get(engn_oil_qty_2) - get(rpm_high_2) * 0.01 * passed / 3600))
		set(engn_oil_qty_3, math.max(0, get(engn_oil_qty_3) - get(rpm_high_3) * 0.01 * passed / 3600))
		
		-- oil leak
		set(engn_oil_qty_1, get(engn_oil_qty_1) - get(engn_oil_leak_1) * passed / 3600 * oilLeak1)
		set(engn_oil_qty_2, get(engn_oil_qty_2) - get(engn_oil_leak_2) * passed / 3600 * oilLeak2)
		set(engn_oil_qty_3, get(engn_oil_qty_3) - get(engn_oil_leak_3) * passed / 3600 * oilLeak3)
		
		-- oil pump fail if engine work
		-- Floor lowered 4 l -> 2 l so the documented cues come in the documented
		-- order: the OIL LEVEL lamp lights at 8 l (engines_panel.lua, matching
		-- engine RE 072.90.00 and RLE 8.1.1), the crew has the 8...0 l band to act
		-- in as the manual intends, and the pump only actually fails if that whole
		-- band is ignored. At 4 l the failure used to fire while a crew following
		-- the book would still be running the engine at reduced power.
		if get(engn_oil_qty_1) < 2 and get(rpm_high_1) > 20 then set(oil_pump_fail_1, 6) end
		if get(engn_oil_qty_2) < 2 and get(rpm_high_2) > 20 then set(oil_pump_fail_2, 6) end
		if get(engn_oil_qty_3) < 2 and get(rpm_high_3) > 20 then set(oil_pump_fail_3, 6) end
		
		-- sim oil sync
		-- The subtrahend must stay equal to the pump-failure floor above, so that
		-- X-Plane's own "no oil" point and our pump failure coincide; otherwise the
		-- band between them is a state where the stock engine model sees a dry
		-- engine while our own failure has not fired yet. Moved 4 -> 2 with it
		-- (span 23 -> 25 keeps the full tank mapping to 1.0).
		set(ENGN_oil_q_1, math.max(0, (get(engn_oil_qty_1) - 2)/25))
		set(ENGN_oil_q_2, math.max(0, (get(engn_oil_qty_2) - 2)/25))
		set(ENGN_oil_q_3, math.max(0, (get(engn_oil_qty_3) - 2)/25))
		
		
		-- engine runtime
		minusTimer1 = minusTimer1 + interpolate(engnRuntimeCoef, get(rpm_high_1)) * passed
		minusTimer2 = minusTimer2 + interpolate(engnRuntimeCoef, get(rpm_high_2)) * passed
		minusTimer3 = minusTimer3 + interpolate(engnRuntimeCoef, get(rpm_high_3)) * passed
		
		if minusTimer1 >= 1 then
			minusTimer1 = 0
			set(engine_runtime_1, math.max(0, get(engine_runtime_1) - 1))
		end
		
		if minusTimer2 >= 1 then
			minusTimer2 = 0
			set(engine_runtime_2, math.max(0, get(engine_runtime_2) - 1))
		end

		if minusTimer3 >= 1 then
			minusTimer3 = 0
			set(engine_runtime_3, math.max(0, get(engine_runtime_3) - 1))
		end
		
		-- TakeOff mode limits
		-- RLE 8.1.1 row (10): max 5 min continuously at takeoff power - the 300 s
		-- threshold this counter is checked against above is exactly that limit.
		if get(rpm_high_1) > 95 or get(engn_oil_qty_1) < 4 then engToCounter1 = engToCounter1 + passed
		else engToCounter1 = engToCounter1 - passed end
		if engToCounter1 < 0 then engToCounter1 = 0 end
		
		if get(rpm_high_2) > 95 or get(engn_oil_qty_2) < 4 then engToCounter2 = engToCounter2 + passed
		else engToCounter2 = engToCounter2 - passed end
		if engToCounter2 < 0 then engToCounter2 = 0 end
		
		if get(rpm_high_3) > 95 or get(engn_oil_qty_3) < 4 then engToCounter3 = engToCounter3 + passed
		else engToCounter3 = engToCounter3 - passed end
		if engToCounter3 < 0 then engToCounter3 = 0 end

		-- Continuous-reverse time limit, 1.0 min (RLE 8.1.1 row 15, engine RE p.19).
		-- Same shape as the takeoff-power counter above: it accumulates while the
		-- buckets are deployed and the engine is running, decays once they stow,
		-- and past 60 s starts raising that engine's failure odds. Engine 2 is
		-- excluded because it has no reverser.
		if get(revers_deploy_1) > 0.5 and get(eng_work_1) == 1 then engRevCounter1 = engRevCounter1 + passed
		else engRevCounter1 = engRevCounter1 - passed end
		if engRevCounter1 < 0 then engRevCounter1 = 0 end

		if get(revers_deploy_3) > 0.5 and get(eng_work_3) == 1 then engRevCounter3 = engRevCounter3 + passed
		else engRevCounter3 = engRevCounter3 - passed end
		if engRevCounter3 < 0 then engRevCounter3 = 0 end
		
		-- fuel fluctuation
		set(fuel_fluct_1, get(eng_filter_1))
		set(fuel_fluct_2, get(eng_filter_2))
		set(fuel_fluct_3, get(eng_filter_3))
		
		-- engine fire
		if get(eng_fire_1) == 6 then set(eng_flame_1, 6) end
		if get(eng_fire_2) == 6 then set(eng_flame_2, 6) end
		if get(eng_fire_3) == 6 then set(eng_flame_3, 6) end
		
		
		
	
	
	else
		-- no failures enabled
		fail_counter = 0
		
		set(engn_oil_leak_1, 0)
		set(engn_oil_leak_2, 0)
		set(engn_oil_leak_3, 0)
		
		set(oil_pump_fail_1, 0)
		set(oil_pump_fail_2, 0)
		set(oil_pump_fail_3, 0)
		
		set(fuel_flowmeter_1_fail, 0)
		set(fuel_flowmeter_2_fail, 0)
		set(fuel_flowmeter_3_fail, 0)
		
		set(eng_fail_1, 0)
		set(eng_fail_2, 0)
		set(eng_fail_3, 0)
		
		set(eng_fire_1, 0)
		set(eng_fire_2, 0)
		set(eng_fire_3, 0)
		
		set(eng_flame_1, 0)
		set(eng_flame_2, 0)
		set(eng_flame_3, 0)
		
		set(eng_stall_1, 0) -- no comp stall if failures are disabled
		set(eng_stall_2, 0)
		set(eng_stall_3, 0)
		
		set(eng_fuel_pmp_fail_1, 0)
		set(eng_fuel_pmp_fail_2, 0)
		set(eng_fuel_pmp_fail_3, 0)
		
		set(eng_filter_1, 0)
		set(eng_filter_2, 0)
		set(eng_filter_3, 0)
		
		set(eng_start_1, 0)
		set(eng_start_2, 0)
		set(eng_start_3, 0)
		
		set(eng_ign_1, 0)
		set(eng_ign_2, 0)
		set(eng_ign_3, 0)
		
		set(eng_revrs_1, 0)
		set(eng_revrs_3, 0)
		
		
		set(engn_oil_qty_1, 26.5)
		set(engn_oil_qty_2, 26.5)
		set(engn_oil_qty_3, 26.5)
		
		set(ENGN_oil_q_1, 0.85)
		set(ENGN_oil_q_2, 0.85)
		set(ENGN_oil_q_3, 0.85)
		
		set(engine_runtime_1, 300*3600)
		set(engine_runtime_2, 300*3600)
		set(engine_runtime_3, 300*3600)

	
	end
	
	
	
	

	

    
    
end   
    
    
    
end
