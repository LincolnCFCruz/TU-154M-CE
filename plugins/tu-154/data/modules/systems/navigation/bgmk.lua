-- this is BGMK logic

-- sources
defineProperty("course_ga_1", globalPropertyf("tu-154/tks/course_ga_1")) -- heading on GA1
defineProperty("course_ga_2", globalPropertyf("tu-154/tks/course_ga_2")) -- heading on GA2

defineProperty("course_mk_1", globalPropertyf("tu-154/tks/course_mk_1")) -- heading on MK5
defineProperty("course_mk_2", globalPropertyf("tu-154/tks/course_mk_2")) -- heading on MK5



defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- flight time

-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))

defineProperty("bus36_volt_left", globalPropertyf("tu-154/elec/bus36_volt_left")) -- 36 V left bus voltage
defineProperty("bus36_volt_right", globalPropertyf("tu-154/elec/bus36_volt_right")) -- 36 V right bus voltage
defineProperty("bus36_volt_pts250_1", globalPropertyf("tu-154/elec/bus36_volt_pts250_1")) -- 36 V bus voltage, PTS 1
defineProperty("bus36_volt_pts250_2", globalPropertyf("tu-154/elec/bus36_volt_pts250_2")) -- 36 V bus voltage, PTS 2


-- controls
defineProperty("tks_mode", globalPropertyi("tu-154/switchers/ovhd/tks_mode")) -- TKS mode. 0 = MK, 1 = GPK, 2 = AK
defineProperty("tks_corrr_button", globalPropertyi("tu-154/buttons/ovhd/tks_corrr_button")) -- slaving button

defineProperty("tks_corr_1", globalPropertyi("tu-154/switchers/ovhd/tks_corr_1")) -- BGMK 2 - 1 correction
defineProperty("tks_corr_2", globalPropertyi("tu-154/switchers/ovhd/tks_corr_2")) -- BGMK 2 - 2 correction

defineProperty("tks_user", globalPropertyi("tu-154/switchers/ovhd/tks_mode_left")) -- consumers. 0 = control, 1 = main

-- fails
defineProperty("fail1", globalPropertyi("tu-154/failures/tks_bgmk1_fail")) -- failure
defineProperty("fail2", globalPropertyi("tu-154/failures/tks_bgmk2_fail")) -- failure

-- result
defineProperty("course_bgmk_1", globalPropertyf("tu-154/tks/course_bgmk_1")) -- heading on BGMK1
defineProperty("course_bgmk_2", globalPropertyf("tu-154/tks/course_bgmk_2")) -- heading on BGMK2

defineProperty("course_gpk", globalPropertyf("tu-154/tks/course_gpk")) -- resulting TKS heading - GPK
defineProperty("course_gmk", globalPropertyf("tu-154/tks/course_gmk")) -- resulting TKS heading - GMK

defineProperty("bgmk_1_cc", globalPropertyf("tu-154/tks/bgmk_1_cc")) -- BGMK current draw
defineProperty("bgmk_2_cc", globalPropertyf("tu-154/tks/bgmk_2_cc")) -- BGMK current draw

-- engines
defineProperty("eng1_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")) -- engine 1 rpm
defineProperty("eng2_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")) -- engine 2 rpm
defineProperty("eng3_N1", globalProperty("sim/flightmodel/engine/ENGN_N1_[2]")) -- engine 3 rpm




-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control



local bgmk_corr_1 = 0
local bgmk_corr_2 = 0




local notLoaded = true
local start_timer = 0

local function sw_reset()

	if get(eng1_N1) < 5 and get(eng2_N1) < 5 and get(eng3_N1) < 5 then
		bgmk_corr_1 = math.random(-180, 180)
		bgmk_corr_2 = math.random(-180, 180)
	end
	
	

end


function update()
	local passed = get(frame_time)
	
	local MASTER = get(ismaster) ~= 1	
	
	
	
	start_timer = start_timer + passed
	
	if notLoaded and start_timer > 0.3 then
		sw_reset()
		notLoaded = false
	end


	
	local power_1 = get(bus27_volt_left) > 13 and get(bus36_volt_pts250_2) > 30 and get(fail1) == 0
	local power_2 = get(bus27_volt_right) > 13 and get(bus36_volt_right) > 30 and get(fail2) == 0
	
	local mode = get(tks_mode)
	local button = get(tks_corrr_button)
	
	local ga1 = get(course_ga_1)
	local ga2 = get(course_ga_2)
	
	
	-- BGMK - 1 --
	local bgmk_cur_1 = ga1 + bgmk_corr_1
	
	if get(tks_corr_1) == 1 then
		local mag_crs = get(course_mk_1)
		if mode == 0 then -- MK mode
		

		
		elseif mode > 0 then -- GPK mode
			
			local delta = bgmk_cur_1 - mag_crs
			
			while delta > 180 do
				delta = delta - 360
			end
			
			while delta < -180 do
				delta = delta + 360
			end
			
			if delta > 1 then bgmk_corr_1 = bgmk_corr_1 - (passed * 1 + button * passed * 10)
			elseif delta < -1 then bgmk_corr_1 = bgmk_corr_1 + (passed * 1 + button * passed * 10)
			else 
				
				local corr_need = mag_crs - ga1
				
				while corr_need > 180 do
					corr_need = corr_need - 360
				end
				
				while corr_need < -180 do
					corr_need = corr_need + 360
				end
				
				bgmk_corr_1 = bgmk_corr_1 + (corr_need - bgmk_corr_1) * (passed * 0.1 + button * passed * 10)
			end
			
			
		end
		
	
	
	
	end
	
	if bgmk_corr_1 > 180 then bgmk_corr_1 = bgmk_corr_1 - 360
	elseif bgmk_corr_1 < -180 then bgmk_corr_1 = bgmk_corr_1 + 360 end
	
	-- set results
	if bgmk_cur_1 > 180 then bgmk_cur_1 = bgmk_cur_1 - 360
	elseif bgmk_cur_1 < -180 then bgmk_cur_1 = bgmk_cur_1 + 360 end
	
	
	
	
	
	-- BGMK - 2 --
	local bgmk_cur_2 = ga2 + bgmk_corr_2
	
	if get(tks_corr_2) == 1 then
		local mag_crs = get(course_mk_2)
		if mode == 0 then -- MK mode
			
			local delta = bgmk_cur_2 - mag_crs
			
			while delta > 180 do
				delta = delta - 360
			end
			
			while delta < -180 do
				delta = delta + 360
			end
			
			if delta > 1 then bgmk_corr_2 = bgmk_corr_2 - (passed * 0.1)
			elseif delta < -1 then bgmk_corr_2 = bgmk_corr_2 + (passed * 0.1)
			else 
				
				local corr_need = mag_crs - ga2
				
				while corr_need > 180 do
					corr_need = corr_need - 360
				end
				
				while corr_need < -180 do
					corr_need = corr_need + 360
				end
				
				bgmk_corr_2 = bgmk_corr_2 + (corr_need - bgmk_corr_2) * (passed * 0.1)
			end

		
		elseif mode > 0 then -- GPK mode
			
			local delta = bgmk_cur_2 - mag_crs
			
			while delta > 180 do
				delta = delta - 360
			end
			
			while delta < -180 do
				delta = delta + 360
			end
			
			if delta > 1 then bgmk_corr_2 = bgmk_corr_2 - (passed * 1 + button * passed * 10)
			elseif delta < -1 then bgmk_corr_2 = bgmk_corr_2 + (passed * 1 + button * passed * 10)
			else 
				
				local corr_need = mag_crs - get(course_ga_2)
				
				while corr_need > 180 do
					corr_need = corr_need - 360
				end
				
				while corr_need < -180 do
					corr_need = corr_need + 360
				end
				
				bgmk_corr_2 = bgmk_corr_2 + (corr_need - bgmk_corr_2) * (passed * 0.1 + button * passed * 10)
			end
			
			
		end

	
	end
	
	if bgmk_corr_2 > 180 then bgmk_corr_2 = bgmk_corr_2 - 360
	elseif bgmk_corr_2 < -180 then bgmk_corr_2 = bgmk_corr_2 + 360 end
	
	-- set results
	if bgmk_cur_2 > 180 then bgmk_cur_2 = bgmk_cur_2 - 360
	elseif bgmk_cur_2 < -180 then bgmk_cur_2 = bgmk_cur_2 + 360 end
	
	
	
	
	
	-- set res course
if MASTER then	
	set(course_bgmk_1, bgmk_cur_1)
	set(course_bgmk_2, bgmk_cur_2)	
	
	local users = get(tks_user) -- consumers. 0 = control, 1 = main
	
	if users == 1 then
		set(course_gpk, ga1)
		set(course_gmk, bgmk_cur_1)
	else
		set(course_gpk, ga2)
		set(course_gmk, bgmk_cur_2)
	end

end
	
	set(bgmk_1_cc, bool2int(power_1))
	set(bgmk_2_cc, bool2int(power_2))



end