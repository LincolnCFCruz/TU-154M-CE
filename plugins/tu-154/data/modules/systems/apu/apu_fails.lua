-- Modeled failure scenarios:
--   * oil temperature above 115 C burns the oil and destroys the APU (possible fire)
--   * starting the APU while it is above 150 C destroys it (possible fire)
--   * fuel pooled inside the APU before start spikes EGT and may destroy it (possible fire)

defineProperty("failures_enabled", globalPropertyi("tu-154/failures/failures_enabled"))
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master

-- failures
defineProperty("apu_start_fail",globalPropertyi("tu-154/failures/apu_start_fail")) -- starter failure
defineProperty("apu_gen_fail",globalPropertyi("tu-154/failures/apu_gen_fail")) -- generator failure
defineProperty("apu_fail_oilt",globalPropertyi("tu-154/failures/apu_fail_oilt")) -- failure on oil temperature
defineProperty("apu_fail_egt",globalPropertyi("tu-154/failures/apu_fail_egt")) -- failure on EGT
defineProperty("apu_fail_fuel_left",globalPropertyi("tu-154/failures/apu_fail_fuel_left")) -- failure on residual fuel in the chamber at start
defineProperty("apu_fail",globalPropertyi("tu-154/failures/apu_fail")) -- wear-out failure
defineProperty("apu_press_fail", globalPropertyi("tu-154/failures/apu_press_fail")) -- engine bleed air failure
defineProperty("apu_runtime",globalPropertyf("tu-154/failures/apu_runtime")) -- APU operating time. read below for the wear-out failure



local fail_counter = 0
local check_time = math.random(15, 30)


function update()
	
	local passed = get(frame_time)
	

	
if get(ismaster) ~= 1 then
	
	
	
	local FAIL = get(failures_enabled)
	
	FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
	if FAIL > 0 then
		
		fail_counter = fail_counter + passed
		
		if fail_counter > check_time then
			fail_counter = 0
			check_time = math.random(15, 30)
			
			-- random failures
			if get(apu_start_fail) ~= 1 then set(apu_start_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(apu_gen_fail) ~= 1 then set(apu_gen_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			--if get(apu_fail_oilt) ~= 1 then set(apu_fail_oilt, bool2int(math.random() < 0.000001) * 1) end
			--if get(apu_fail_egt) ~= 1 then set(apu_fail_egt, bool2int(math.random() < 0.000001) * 1) end
			--if get(apu_fail_fuel_left) ~= 1 then set(apu_fail_fuel_left, bool2int(math.random() < 0.000001) * 1) end
			if get(apu_fail) ~= 1 then set(apu_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			--if get(apu_press_fail) ~= 1 then set(apu_press_fail, bool2int(math.random() < 0.000001) * 1) end
			
			-- runtime failure
			if get(apu_runtime) == 0 then
				if get(apu_fail) ~= 1 then set(apu_fail, bool2int(math.random() < 0.01 * FAIL * 0.3) * 1) end
			end
			
			
		
		end
	
	
	else
		-- no failures enabled
		fail_counter = 0
		
		set(apu_start_fail, 0)
		set(apu_gen_fail, 0)
		set(apu_fail_oilt, 0)
		set(apu_fail_egt, 0)
		set(apu_fail_fuel_left, 0)
		set(apu_fail, 0)
		set(apu_press_fail, 0)
	
	
	end


end



end