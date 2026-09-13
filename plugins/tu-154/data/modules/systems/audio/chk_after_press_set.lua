defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- time of frame

defineProperty("side",globalPropertyi("tu-154/checklist/side")) -- which side to show. 0 = before takeoff, 1 = before approach

defineProperty("fishka_1",globalPropertyi("tu-154/checklist/fishka_1")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_2",globalPropertyi("tu-154/checklist/fishka_2")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_3",globalPropertyi("tu-154/checklist/fishka_3")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_4",globalPropertyi("tu-154/checklist/fishka_4")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_5",globalPropertyi("tu-154/checklist/fishka_5")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_6",globalPropertyi("tu-154/checklist/fishka_6")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_7",globalPropertyi("tu-154/checklist/fishka_7")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_8",globalPropertyi("tu-154/checklist/fishka_8")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_9",globalPropertyi("tu-154/checklist/fishka_9")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_10",globalPropertyi("tu-154/checklist/fishka_10")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_11",globalPropertyi("tu-154/checklist/fishka_11")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_12",globalPropertyi("tu-154/checklist/fishka_12")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_13",globalPropertyi("tu-154/checklist/fishka_13")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_14",globalPropertyi("tu-154/checklist/fishka_14")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_15",globalPropertyi("tu-154/checklist/fishka_15")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_16",globalPropertyi("tu-154/checklist/fishka_16")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_17",globalPropertyi("tu-154/checklist/fishka_17")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_18",globalPropertyi("tu-154/checklist/fishka_18")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_19",globalPropertyi("tu-154/checklist/fishka_19")) -- selector position. 0 = left, 1 = right
defineProperty("fishka_20",globalPropertyi("tu-154/checklist/fishka_20")) -- selector position. 0 = left, 1 = right

defineProperty("checklist_selected",globalPropertyi("tu-154/checklist/checklist_selected")) -- checklist selection

-- sources

defineProperty("pressure", globalPropertyf("tu-154/gauges/alt/vbe_press_left"))  -- pressure in hPa

defineProperty("frequency", globalPropertyf("sim/cockpit2/radios/actuators/nav1_frequency_hz"))  -- set the frequency
defineProperty("nav_pow_cc", globalPropertyf("tu-154/radio/nav1_pow_cc")) -- Kurs-MP current draw

defineProperty("obs", globalPropertyf("tu-154/gauges/compas/pkp_obs_set_L"))  -- set the course

defineProperty("ark15_cc_1", globalPropertyf("tu-154/radio/ark15_L_cc")) -- ARK current draw
defineProperty("ark15_cc_2", globalPropertyf("tu-154/radio/ark15_R_cc")) -- ARK current draw


defineProperty("absu_landing_on", globalPropertyi("tu-154/switchers/console/absu_landing_on")) -- landing needles
defineProperty("absu_speed_prepare", globalPropertyi("tu-154/switchers/console/absu_speed_prepare")) -- preparation

defineProperty("at_1_lamp", globalPropertyf("tu-154/lights/small/at_1")) -- AT 1
defineProperty("at_2_lamp", globalPropertyf("tu-154/lights/small/at_2")) -- AT 2


local checklist_started = false
local stage = 0
local stage_status = 0 -- 0 question, 1+ - answers. 1 usually is false.

local speak_timer = 0

function checklist_7()

	
	-- start the checklist
	if not checklist_started and get(checklist_selected) == 7 then 
		checklist_started = true 
		stage = 1
		
		-- declare checklist
		local num = find_empty()
		phrases_tbl[num] = {nav_tbl["pressure_of_the_airfield"][lang], 3}
		speak_timer = 3
		
	end
	
	-- another checklist started
	if get(checklist_selected) ~= 7 then 
		checklist_started = false
		stage = 0
		stage_status = 0 
	end
	
	-- move stages
	if checklist_started then
		if stage == 1 and get(fishka_15) == 0 then stage = 2 stage_status = 0 end -- move further if cap is closed
		if stage == 2 and get(fishka_16) == 0 then stage = 3 stage_status = 0 end -- move further if cap is closed
		if stage == 3 and get(fishka_17) == 0 then stage = 4 stage_status = 0 end -- move further if cap is closed
		if stage == 4 and get(fishka_18) == 0 then stage = 5 stage_status = 0 end -- move further if cap is closed
		if stage == 5 and get(fishka_19) == 0 then 
			stage = 100 stage_status = 0 
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["checklist_completed"][lang], 2}
		end -- end checklist
	end
	
	---------------------------------
	-- question 1. Altimeters --
	---------------------------------
	if stage == 1 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["altimeters"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		-- true answer
		if (stage_status == 1 or stage_status == 2) then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["pressure_set_to"][lang], 1.5}
			capt_say_num(get(pressure), 4, lang)
			
			speak_timer = 5
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 15
	if stage == 1 and stage_status == 10 and speak_timer < 0.1 then set(fishka_15, 0) end


	---------------------------------
	-- question 2. ILS --
	---------------------------------
	if stage == 2 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["course_mp"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
	
		-- false answer
		if stage_status == 1 and get(nav_pow_cc) == 0 then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(nav_pow_cc) ~= 0 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["turned_on2"][lang], 1}
			capt_say_num(get(frequency), 5, lang)
			
			speak_timer = 5
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 16
	if stage == 2 and stage_status == 10 and speak_timer < 0.1 then set(fishka_16, 0) end


	---------------------------------
	-- question 3. Course PNP --
	---------------------------------
	if stage == 3 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["course_PNP"][lang], 3}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(nav_pow_cc) ~= 0 then
			local crs = math.floor(get(obs) + 0.5)
			if crs == 0 then crs = 360 end
			
			capt_say_num(crs, 3, lang)
			
			speak_timer = 3
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 17
	if stage == 3 and stage_status == 10 and speak_timer < 0.1 then set(fishka_17, 0) end


	---------------------------------
	-- question 4. ARK --
	---------------------------------
	if stage == 4 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["ARK"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
	
		-- false answer
		if stage_status == 1 and get(ark15_cc_1) * get(ark15_cc_2) == 0 then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(ark15_cc_1) ~= 0 and get(ark15_cc_2) ~= 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["switch_on_1"][lang], 2}
			
			speak_timer = 3
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 18
	if stage == 4 and stage_status == 10 and speak_timer < 0.1 then set(fishka_18, 0) end


	---------------------------------
	-- question 5. PN5 PN6 --
	---------------------------------
	if stage == 5 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["PN-5_PN-6"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
	
		-- false answer
		if stage_status == 1 and get(absu_landing_on) * get(absu_speed_prepare) * get(at_1_lamp) * get(at_2_lamp) == 0 then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(absu_landing_on) * get(absu_speed_prepare) * get(at_1_lamp) * get(at_2_lamp) ~= 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["prepared"][lang], 2}
			
			speak_timer = 3
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 19
	if stage == 5 and stage_status == 10 and speak_timer < 0.1 then set(fishka_19, 0) end


	speak_timer = speak_timer - passed_time
	
	-- hold timer, if voice que is not empty
	if speak_timer < 0.2 and find_empty() > 1 then speak_timer = phrases_tbl[1][2]
	elseif speak_timer < 0.2 then speak_timer = 0
	end
	

	-- end checklist if all stack moved left
	if checklist_started then
		if stage == 100 then
			checklist_started = false
			set(checklist_selected, 0)
			stage = 0
			stage_status = 0
		end
	
	
	end
	

end
