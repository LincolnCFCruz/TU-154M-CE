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

defineProperty("stab_ind", globalPropertyf("tu-154/gauges/misc/stab_ind")) -- stabiliser position indicator
defineProperty("elevator_ind", globalPropertyf("tu-154/gauges/misc/elevator_ind")) -- stabiliser position indicator
defineProperty("flap_left_ind", globalPropertyf("tu-154/gauges/misc/flap_left_ind")) -- stabiliser position indicator
defineProperty("flap_right_ind", globalPropertyf("tu-154/gauges/misc/flap_right_ind")) -- stabiliser position indicator
defineProperty("slats_extended", globalPropertyf("tu-154/lights/slats_extended")) -- slats extended

defineProperty("joy_pitch", globalPropertyf("tu-154/SC/yoke_pitch_ratio")) 

defineProperty("gears_green_left", globalPropertyf("tu-154/lights/gears_green_left")) -- landing gear
defineProperty("gears_green_front", globalPropertyf("tu-154/lights/gears_green_front")) -- landing gear
defineProperty("gears_green_right", globalPropertyf("tu-154/lights/gears_green_right")) -- landing gear
defineProperty("gear_lever", globalPropertyi("tu-154/controll/gear_lever")) -- landing gear lever. -1 = up, 0 = neutral, +1 = down

defineProperty("to_rudder", globalPropertyf("tu-154/lights/to_rudder")) -- rudder takeoff/landing
defineProperty("to_elevator", globalPropertyf("tu-154/lights/to_elevator")) -- elevator takeoff/landing

defineProperty("landing_ext_set_L", globalPropertyi("tu-154/lights/landing_ext_set_L")) -- left landing light extension
defineProperty("landing_ext_set_R", globalPropertyi("tu-154/lights/landing_ext_set_R")) -- right landing light extension


local checklist_started = false
local stage = 0
local stage_status = 0 -- 0 question, 1+ - answers. 1 usually is false.

local speak_timer = 0

function checklist_9()

	
	-- start the checklist
	if not checklist_started and get(checklist_selected) == 9 then 
		checklist_started = true 
		stage = 1
		
		-- declare checklist
		local num = find_empty()
		phrases_tbl[num] = {nav_tbl["befor_DPRM"][lang], 3}
		speak_timer = 3
		
	end
	
	-- another checklist started
	if get(checklist_selected) ~= 9 then 
		checklist_started = false
		stage = 0
		stage_status = 0 
	end
	
	-- move stages
	if checklist_started then
		if stage == 1 and get(fishka_10) == 1 then stage = 2 stage_status = 0 end -- move further if cap is closed
		if stage == 2 and get(fishka_11) == 1 then stage = 3 stage_status = 0 end -- move further if cap is closed
		if stage == 3 and get(fishka_12) == 1 then stage = 4 stage_status = 0 end -- move further if cap is closed
		if stage == 4 and get(fishka_13) == 1 then stage = 5 stage_status = 0 end -- move further if cap is closed
		if stage == 5 and get(fishka_14) == 1 then 
			stage = 100 stage_status = 0 
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["checklist_completed"][lang], 2}
		end -- end checklist
	end
	
	---------------------------------
	-- question 1. Flaps and slats --
	---------------------------------
	if stage == 1 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["flaps"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and (get(flap_left_ind) < 26 or get(flap_right_ind) < 26 or get(slats_extended) == 0)  then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(flap_left_ind) > 26 and get(flap_right_ind) > 26 and get(slats_extended) > 0.1  then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["ext_flaps_"][lang], 1.5}
			cop_say_num(math.floor(get(flap_left_ind)+0.5), 2, lang)
			
			speak_timer = 4
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 10
	if stage == 1 and stage_status == 10 and speak_timer < 0.1 then set(fishka_10, 1) end


	---------------------------------
	-- question 2. Stab RV --
	---------------------------------
	if stage == 2 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["stabilizer_RV"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and (math.abs(get(joy_pitch)) > 0.1 or get(elevator_ind) > 6 or get(elevator_ind) < -2) then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and math.abs(get(joy_pitch)) <= 0.1 and get(elevator_ind) < 6 and get(elevator_ind) > -2 then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["synced"][lang], 2}
			
			speak_timer = 2
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 11
	if stage == 2 and stage_status == 10 and speak_timer < 0.1 then set(fishka_11, 1) end


	---------------------------------
	-- question 3. Gears --
	---------------------------------
	if stage == 3 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["gear"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and (get(gears_green_left) * get(gears_green_front) * get(gears_green_right) == 0 or get(gear_lever) ~= 0) then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(gears_green_left) * get(gears_green_front) * get(gears_green_right) ~= 0 and get(gear_lever) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["ext_green_neutr"][lang], 3}
			
			speak_timer = 3
			stage_status = 10 -- finish
		end
		
	end
	
	-- move fishka 12
	if stage == 3 and stage_status == 10 and speak_timer < 0.1 then set(fishka_12, 1) end


	---------------------------------
	-- question 4. Contr force --
	---------------------------------
	if stage == 4 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["RV_RN"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and get(to_rudder) * get(to_elevator) == 0 then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(to_rudder) + get(to_elevator) > 0.2 then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["off_tablo_lit"][lang], 2}

			speak_timer = 3
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 13
	if stage == 4 and stage_status == 10 and speak_timer < 0.1 then set(fishka_13, 1) end


	---------------------------------
	-- question 5. Lights --
	---------------------------------
	if stage == 5 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["landing_lights"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and get(landing_ext_set_L) * get(landing_ext_set_R) == 0 then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(landing_ext_set_L) * get(landing_ext_set_R) == 1 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["extended"][lang], 2}

			speak_timer = 3
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 14
	if stage == 5 and stage_status == 10 and speak_timer < 0.1 then set(fishka_14, 1) end
	
	
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

