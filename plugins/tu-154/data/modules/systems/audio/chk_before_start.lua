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


-- check sources
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 V bus voltage
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 V bus voltage

defineProperty("mars_on", globalPropertyi("tu-154/switchers/ovhd/mars_on"))  -- MARS

defineProperty("door1", globalPropertyf("tu-154/lights/left_front_pax_door")) -- left front door open
defineProperty("door2", globalPropertyf("tu-154/lights/left_mid_pax_door")) -- left middle door open
defineProperty("door3", globalPropertyf("tu-154/lights/right_mid_pax_door")) -- middle middle door open
defineProperty("door4", globalPropertyf("tu-154/lights/cargo_front_door")) -- forward cargo hatch
defineProperty("door5", globalPropertyf("tu-154/lights/cargo_back_door")) -- aft baggage hatch

defineProperty("msrp_27_L_cc", globalPropertyf("tu-154/msrp/msrp_27_L_cc")) -- bus load
defineProperty("msrp_27_R_cc", globalPropertyf("tu-154/msrp/msrp_27_R_cc")) -- bus load

defineProperty("rv_flag", globalPropertyf("tu-154/gauges/alt/radioalt_flag_left"))  -- RV flag

defineProperty("pump_tank2_left", globalPropertyi("tu-154/switchers/fuel/pump_tank2_left")) -- tank 2 pumps
defineProperty("pump_tank2_right", globalPropertyi("tu-154/switchers/fuel/pump_tank2_right")) -- tank 2 pumps
defineProperty("pump_tank3_left", globalPropertyi("tu-154/switchers/fuel/pump_tank3_left")) -- tank 3 pumps
defineProperty("pump_tank3_right", globalPropertyi("tu-154/switchers/fuel/pump_tank3_right")) -- tank 3 pumps
defineProperty("pump_tank4", globalPropertyi("tu-154/switchers/fuel/pump_tank4")) -- tank 4 pumps
defineProperty("pump_tank1_1", globalPropertyi("tu-154/switchers/fuel/pump_tank1_1")) -- tank 1 pumps
defineProperty("pump_tank1_2", globalPropertyi("tu-154/switchers/fuel/pump_tank1_2")) -- tank 1 pumps
defineProperty("pump_tank1_3", globalPropertyi("tu-154/switchers/fuel/pump_tank1_3")) -- tank 1 pumps
defineProperty("pump_tank1_4", globalPropertyi("tu-154/switchers/fuel/pump_tank1_4")) -- tank 1 pumps

defineProperty("gs_press_1", globalPropertyf("tu-154/hydro/gs_press_1")) -- hydraulic system 1 pressure
defineProperty("gs_press_2", globalPropertyf("tu-154/hydro/gs_press_2")) -- hydraulic system 2 pressure
defineProperty("gs_press_3", globalPropertyf("tu-154/hydro/gs_press_3")) -- hydraulic system 3 pressure
defineProperty("gs_press_4", globalPropertyf("tu-154/hydro/gs_press_4")) -- hydraulic system 4 pressure

defineProperty("gear_brake_press_L", globalPropertyf("tu-154/gauges/console/gear_brake_press_L")) -- left brake pressure
defineProperty("gear_brake_press_R", globalPropertyf("tu-154/gauges/console/gear_brake_press_R")) -- right brake pressure

defineProperty("trimm_zero_course", globalPropertyf("tu-154/lights/trimm_zero_course")) -- heading neutral
defineProperty("trimm_zero_roll", globalPropertyf("tu-154/lights/trimm_zero_roll")) -- roll neutral
defineProperty("trimm_zero_pitch", globalPropertyf("tu-154/lights/trimm_zero_pitch")) -- pitch neutral

defineProperty("cg_pos_actual", globalPropertyf("tu-154/misc/cg_pos_actual")) -- actual CG position
defineProperty("weight_actual", globalPropertyf("tu-154/misc/weight_actual")) -- actual mass

defineProperty("v1_15", globalPropertyi("tu-154/speeds/v1_15"))
defineProperty("vr_15", globalPropertyi("tu-154/speeds/vr_15"))
defineProperty("v2_15", globalPropertyi("tu-154/speeds/v2_15"))
defineProperty("v1_28", globalPropertyi("tu-154/speeds/v1_28"))
defineProperty("vr_28", globalPropertyi("tu-154/speeds/vr_28"))
defineProperty("v2_28", globalPropertyi("tu-154/speeds/v2_28"))


defineProperty("stab_setting", globalPropertyi("tu-154/controll/stab_setting")) -- CG position for the stabiliser. 0 = aft, 1 = mid, 2 = fwd	1


local checklist_started = false
local stage = 0
local stage_status = 0 -- 0 question, 1+ - answers. 1 usually is false.

local speak_timer = 0

function checklist_1()

	
	-- start the checklist
	if not checklist_started and get(checklist_selected) == 1 then 
		checklist_started = true 
		stage = 1
		
		-- declare checklist
		local num = find_empty()
		phrases_tbl[num] = {nav_tbl["befor_eng_run"][lang], 2}
		speak_timer = 2
		
	end
	
	-- another checklist started
	if get(checklist_selected) ~= 1 then 
		checklist_started = false
		stage = 0
		stage_status = 0 
	end
	
	-- move stages
	if checklist_started then
		if stage == 1 and get(fishka_1) == 0 then stage = 2 stage_status = 0 end -- move further if cap is closed
		if stage == 2 and get(fishka_2) == 0 then stage = 3 stage_status = 0 end -- move further if cap is closed
		if stage == 3 and get(fishka_3) == 0 then stage = 4 stage_status = 0 end -- move further if cap is closed
		if stage == 4 and get(fishka_4) == 0 then stage = 5 stage_status = 0 end -- move further if cap is closed
		if stage == 5 and get(fishka_5) == 0 then stage = 6 stage_status = 0 end -- move further if cap is closed
		if stage == 6 and get(fishka_6) == 0 then stage = 7 stage_status = 0 end -- move further if cap is closed
		if stage == 7 and get(fishka_7) == 0 then stage = 8 stage_status = 0 end -- move further if cap is closed
		if stage == 8 and get(fishka_8) == 0 then stage = 9 stage_status = 0 end -- move further if cap is closed
		if stage == 9 and get(fishka_9) == 0 then 
			stage = 100 stage_status = 0 
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["checklist_completed"][lang], 2}
		end -- end checklist
	end
	
	------------------------------
	-- question 1. Recorder --
	---------------------------------
	if stage == 1 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["recorder"][lang], 1}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and get(mars_on) ~= 1 and get(bus27_volt_left) < 13 and get(bus27_volt_right) < 13 then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(mars_on) == 1 and (get(bus27_volt_left) > 13 or get(bus27_volt_right) > 13) then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["turned_on"][lang], 2}
			
			speak_timer = 3
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 1
	if stage == 1 and stage_status == 10 and speak_timer < 0.1 then set(fishka_1, 0) end
	

	--------------------------------
	-- question 2. Keys, Rod --
	---------------------------------
	if stage == 2 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["plugs_keys_rod"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) then
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["on_board"][lang], 1}
			
			speak_timer = 2
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 2
	if stage == 2 and stage_status == 10 and speak_timer < 0.1 then set(fishka_2, 0) end	
	
	
	------------------------------
	-- question 3. Doors --
	---------------------------------
	if stage == 3 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["doors"][lang], 1}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and get(door1) + get(door2) + get(door3) + get(door4) + get(door5) > 0 then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(door1) + get(door2) + get(door3) + get(door4) + get(door5) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["closed_tablo_off"][lang], 3}
			
			speak_timer = 3
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 3
	if stage == 3 and stage_status == 10 and speak_timer < 0.1 then set(fishka_3, 0) end	
	
	
	------------------------------
	-- question 4. MSRP, SSOS, RV #1 --
	---------------------------------
	if stage == 4 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["msrp_ssos_rv1"][lang], 3}
	
			stage_status = 1 -- question asked
			speak_timer = 3 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and (get(msrp_27_L_cc) + get(msrp_27_R_cc) == 0 or get(rv_flag) == 1) then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(msrp_27_L_cc) + get(msrp_27_R_cc) > 0 and get(rv_flag) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["switch_on_date"][lang], 3}
			
			speak_timer = 3
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 4
	if stage == 4 and stage_status == 10 and speak_timer < 0.1 then set(fishka_4, 0) end		

	
	------------------------------
	-- question 5. Fuel pumps --
	---------------------------------
	if stage == 5 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fuel_pumps"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and (get(pump_tank1_1) + get(pump_tank1_2) + get(pump_tank1_3) + get(pump_tank1_4) < 4 or 
			get(pump_tank2_left) + get(pump_tank2_right) + get(pump_tank3_left) + get(pump_tank3_right) < 4) then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(pump_tank1_1) + get(pump_tank1_2) + get(pump_tank1_3) + get(pump_tank1_4) == 4 and 
			get(pump_tank2_left) + get(pump_tank2_right) + get(pump_tank3_left) + get(pump_tank3_right) == 4 then
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["pumps_on"][lang], 3}
			
			speak_timer = 3
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 5
	if stage == 5 and stage_status == 10 and speak_timer < 0.1 then set(fishka_5, 0) end	
	
	
	------------------------------
	-- question 6. Hydraulics --
	---------------------------------
	if stage == 6 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["pressure_hydraulic_systems"][lang], 4}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and (get(gs_press_1) < 200 or get(gs_press_2) < 200 or get(gs_press_3) < 200) then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(gs_press_1) >= 200 and get(gs_press_2) >= 200 and get(gs_press_3) >= 200 then
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["210"][lang], 2}
			
			speak_timer = 2
			stage_status = 3 -- next
		end


		-- false answer
		if stage_status == 3 and (get(gear_brake_press_L) < 100 or get(gear_brake_press_R) < 100) then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 4
		end
		
		-- true answer
		if (stage_status == 3 or stage_status == 4) and get(gear_brake_press_L) >= 100 and get(gear_brake_press_R) >= 100 then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["120"][lang], 2}
			
			speak_timer = 2
			stage_status = 5 -- next
		end


		-- false answer
		if stage_status == 5 and get(gs_press_4) < 180 then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 6
		end
		
		-- true answer
		if (stage_status == 5 or stage_status == 6) and get(gs_press_4) >= 180 then
			local num = find_empty()
			if get(gs_press_4) >= 200 then phrases_tbl[num] = {eng_tbl["210"][lang], 2}
			else phrases_tbl[num] = {eng_tbl["180"][lang], 2} end
			
			speak_timer = 2
			stage_status = 10 -- finish
		end		
	
	end
	
	-- move fishka 6
	if stage == 6 and stage_status == 10 and speak_timer < 0.1 then set(fishka_6, 0) end		
	
	
	------------------------------
	-- question 7. Trimmers --
	------------------------------
	if stage == 7 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["trim"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and (get(trimm_zero_course) < 0.2 or get(trimm_zero_roll) < 0.2 or get(trimm_zero_pitch) < 0.2) then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and get(trimm_zero_course) > 0.2 and get(trimm_zero_roll) > 0.2 and get(trimm_zero_pitch) > 0.2 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["neutral"][lang], 2}
			
			speak_timer = 2
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 7
	if stage == 7 and stage_status == 10 and speak_timer < 0.1 then set(fishka_7, 0) end


	------------------------------
	-- question 8. Takeoff data --
	---------------------------------
	if stage == 8 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["takeoff_data"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end

		
		-- true answer
		if stage_status == 1 then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["weight"][lang], 1}
			
			cop_say_num(math.floor(get(weight_actual)/1000 + 0.5), 3, lang)
			
			phrases_tbl[num+4] = {cop_tbl["cg_pos"][lang], 1}
			
			cop_say_num(math.floor(get(cg_pos_actual)+0.5), 2, lang)
			
			
			phrases_tbl[num+7] = {nav_tbl["V1"][lang], 1}
			
			nav_say_num(math.floor(get(v1_15)+0.5), 3, lang)
			
			
			phrases_tbl[num+11] = {nav_tbl["Vr"][lang], 1}
			
			nav_say_num(math.floor(get(vr_15)+0.5), 3, lang)
			
			
			phrases_tbl[num+15] = {nav_tbl["V2"][lang], 1}
			
			nav_say_num(math.floor(get(v2_15)+0.5), 3, lang)
			
			speak_timer = 13
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 8
	if stage == 8 and stage_status == 10 and speak_timer < 0.1 then set(fishka_8, 0) end


	------------------------------
	-- question 9. Stab setting --
	------------------------------
	if stage == 9 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["stabilizer"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end

		
		-- true answer
		if (stage_status == 1 or stage_status == 2) then
			local num = find_empty()
			
			if get(stab_setting) == 0 then
				phrases_tbl[num] = {cpt_tbl["stab_set_b"][lang], 2}
			elseif get(stab_setting) == 1 then
				phrases_tbl[num] = {cpt_tbl["stab_set_m"][lang], 2}
			else 
				phrases_tbl[num] = {cpt_tbl["stab_set_f"][lang], 2}
			end
			speak_timer = 2
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 9
	if stage == 9 and stage_status == 10 and speak_timer < 0.1 then set(fishka_9, 0) end


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