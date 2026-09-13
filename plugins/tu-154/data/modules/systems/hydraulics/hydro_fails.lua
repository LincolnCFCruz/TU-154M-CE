defineProperty("hs_leak_1", globalPropertyi("tu-154/failures/hydro_leak_1"))
defineProperty("hs_leak_2", globalPropertyi("tu-154/failures/hydro_leak_2"))
defineProperty("hs_leak_3", globalPropertyi("tu-154/failures/hydro_leak_3"))
defineProperty("hs_leak_4", globalPropertyi("tu-154/failures/hydro_leak_4"))

defineProperty("hydro_pump_fail_11", globalPropertyi("tu-154/failures/hydro_pump_fail_11"))
defineProperty("hydro_pump_fail_12", globalPropertyi("tu-154/failures/hydro_pump_fail_12"))
defineProperty("hydro_pump_fail_2", globalPropertyi("tu-154/failures/hydro_pump_fail_2"))
defineProperty("hydro_pump_fail_3", globalPropertyi("tu-154/failures/hydro_pump_fail_3"))

defineProperty("hydro_elec_fail_2", globalPropertyi("tu-154/failures/hydro_elec_fail_2"))
defineProperty("hydro_elec_fail_3", globalPropertyi("tu-154/failures/hydro_elec_fail_3"))

defineProperty("system_qty_1", globalPropertyf("tu-154/hydro/gs_qty_1")) -- oil remaining in the system
defineProperty("system_qty_2", globalPropertyf("tu-154/hydro/gs_qty_2")) -- oil remaining in the system
defineProperty("system_qty_3", globalPropertyf("tu-154/hydro/gs_qty_3")) -- oil remaining in the system


defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))
defineProperty("failures_enabled", globalPropertyi("tu-154/failures/failures_enabled"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control





-- random failures: { flag, k1, k2, failed value } (rollFailures, core/glbl_func.lua)
local RANDOM_FAILS = {
	{ hs_leak_1, 0.00001, 0.3, 1 },
	{ hs_leak_2, 0.00001, 0.3, 1 },
	{ hs_leak_3, 0.00001, 0.3, 1 },
	{ hs_leak_4, 0.00001, 0.3, 1 },

	{ hydro_pump_fail_11, 0.00001, 0.3, 1 },
	{ hydro_pump_fail_12, 0.00001, 0.3, 1 },
	{ hydro_pump_fail_2, 0.00001, 0.3, 1 },
	{ hydro_pump_fail_3, 0.00001, 0.3, 1 },

	{ hydro_elec_fail_2, 0.00001, 0.3, 1 },
	{ hydro_elec_fail_3, 0.00001, 0.3, 1 },
}

local fail_counter = 0
local check_time = math.random(15, 30)


function update()
	local passed = get(frame_time)
	
local MASTER = get(ismaster) ~= 1	
	

if MASTER then	

	
	local FAIL = get(failures_enabled)
	FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
	if FAIL > 0 then
		
		fail_counter = fail_counter + passed
		
		if fail_counter > check_time then
			fail_counter = 0
			check_time = math.random(15, 30)
			
			-- random failures
			rollFailures(RANDOM_FAILS, FAIL)
			
			
		
		end
		
		-- dependent failures
		

		
		
	
	
	else
		-- no failures enabled
		fail_counter = 0
		
		clearFailures(RANDOM_FAILS)
		
		set(system_qty_1, 58)
		set(system_qty_2, 58)
		set(system_qty_3, 45)
		
		
	end
	
	
	
end

end
