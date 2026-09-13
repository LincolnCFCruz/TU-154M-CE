defineProperty("gyro_fail_1", globalPropertyi("sim/operation/failures/rel_ss_dgy"))
defineProperty("gyro_fail_2", globalPropertyi("sim/operation/failures/rel_cop_dgy"))

defineProperty("tks_km1_fail", globalPropertyi("tu-154/failures/tks_km1_fail"))
defineProperty("tks_km2_fail", globalPropertyi("tu-154/failures/tks_km2_fail"))
defineProperty("tks_bgmk1_fail", globalPropertyi("tu-154/failures/tks_bgmk1_fail"))
defineProperty("tks_bgmk2_fail", globalPropertyi("tu-154/failures/tks_bgmk2_fail"))





defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))
defineProperty("failures_enabled", globalPropertyi("tu-154/failures/failures_enabled"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control





-- random failures: { flag, k1, k2, failed value } (rollFailures, core/glbl_func.lua)
local RANDOM_FAILS = {
	{ gyro_fail_1, 0.0001, 0.3, 6 },
	{ gyro_fail_2, 0.0001, 0.3, 6 },

	{ tks_km1_fail, 0.0001, 0.3, 1 },
	{ tks_km2_fail, 0.0001, 0.3, 1 },
	{ tks_bgmk1_fail, 0.0001, 0.3, 1 },
	{ tks_bgmk2_fail, 0.0001, 0.3, 1 },
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


	
	end
	
	
	
end

end