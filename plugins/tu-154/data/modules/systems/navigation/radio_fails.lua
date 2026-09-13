defineProperty("rel_adf1", globalPropertyi("sim/operation/failures/rel_adf1"))
defineProperty("rel_adf2", globalPropertyi("sim/operation/failures/rel_adf2"))
defineProperty("nav1_fail", globalPropertyi("tu-154/failures/nav1_fail"))
defineProperty("nav2_fail", globalPropertyi("tu-154/failures/nav2_fail"))
defineProperty("dme1_fail", globalPropertyi("tu-154/failures/dme1_fail"))
defineProperty("dme2_fail", globalPropertyi("tu-154/failures/dme2_fail"))

defineProperty("mrp_fail", globalPropertyi("tu-154/failures/mrp_fail"))






defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))
defineProperty("failures_enabled", globalPropertyi("tu-154/failures/failures_enabled"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control





-- random failures: { flag, k1, k2, failed value } (rollFailures, core/glbl_func.lua)
local RANDOM_FAILS = {
	{ rel_adf1, 0.00001, 0.3, 6 },
	{ rel_adf2, 0.00001, 0.3, 6 },
	{ nav1_fail, 0.00001, 0.3, 1 },
	{ nav2_fail, 0.00001, 0.3, 1 },
	{ dme1_fail, 0.00001, 0.3, 1 },
	{ dme2_fail, 0.00001, 0.3, 1 },

	{ mrp_fail, 0.00001, 0.3, 1 },
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