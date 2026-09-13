defineProperty("airbleed_1", globalPropertyi("tu-154/failures/airbleed_1")) -- engine bleed air failure
defineProperty("airbleed_2", globalPropertyi("tu-154/failures/airbleed_2")) -- engine bleed air failure
defineProperty("airbleed_3", globalPropertyi("tu-154/failures/airbleed_3")) -- engine bleed air failure

defineProperty("psvp_fail_left", globalPropertyi("tu-154/failures/psvp_fail_left")) -- PSVP failure
defineProperty("psvp_fail_right", globalPropertyi("tu-154/failures/psvp_fail_right")) -- PSVP failure

defineProperty("tth_left_fail", globalPropertyi("tu-154/failures/tth_left_fail")) -- turbo-cooler failure
defineProperty("tth_right_fail", globalPropertyi("tu-154/failures/tth_right_fail")) -- turbo-cooler failure

defineProperty("sard_valve_fail", globalPropertyi("tu-154/failures/sard_valve_fail")) -- outflow valve failure





defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))
defineProperty("failures_enabled", globalPropertyi("tu-154/failures/failures_enabled"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control





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
			if get(airbleed_1) ~= 1 then set(airbleed_1, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(airbleed_2) ~= 1 then set(airbleed_2, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(airbleed_3) ~= 1 then set(airbleed_3, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			
			if get(psvp_fail_left) ~= 1 then set(psvp_fail_left, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(psvp_fail_right) ~= 1 then set(psvp_fail_right, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			
			if get(tth_left_fail) ~= 1 then set(tth_left_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(tth_right_fail) ~= 1 then set(tth_right_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			
			if get(sard_valve_fail) ~= 1 then set(sard_valve_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end

			
		
		end
		
		-- dependent failures
		

		
		
	
	
	else
		-- no failures enabled
		fail_counter = 0
		
		set(airbleed_1, 0)
		set(airbleed_2, 0)
		set(airbleed_3, 0)
		
		set(psvp_fail_left, 0)
		set(psvp_fail_right, 0)
		
		set(tth_left_fail, 0)
		set(tth_right_fail, 0)
		
		set(sard_valve_fail, 0)

	
	end
	
	
	
end

end
