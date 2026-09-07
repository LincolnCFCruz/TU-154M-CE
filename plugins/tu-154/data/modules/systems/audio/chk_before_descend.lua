-- this is before descend checklist
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

-- Source

defineProperty("cg_pos_actual", globalPropertyf("tu-154/misc/cg_pos_actual")) -- actual CG position
defineProperty("weight_actual", globalPropertyf("tu-154/misc/weight_actual")) -- actual mass

defineProperty("course_mk_1", globalPropertyf("tu-154/tks/course_mk_1")) -- heading on MK5
defineProperty("course_mk_2", globalPropertyf("tu-154/tks/course_mk_2")) -- heading on MK5

defineProperty("course_ga_1", globalPropertyf("tu-154/tks/course_ga_1")) -- heading on GA1
defineProperty("course_ga_2", globalPropertyf("tu-154/tks/course_ga_2")) -- heading on GA2

defineProperty("radioalt_dh_left", globalPropertyf("tu-154/gauges/alt/radioalt_dh_left")) -- captain's radio altimeter DH pointer

defineProperty("fuel_meter_summ", globalPropertyf("tu-154/gauges/fuel/fuel_meter_summ")) -- total fuel mass










local angle2alt = {
{-100000, 0},
{0, 0},
{30, 20},
{80, 50},
{160, 100},
{314, 700},
{340, 800},
{8000000, 1000}
}


local checklist_started = false
local stage = 0
local stage_status = 0 -- 0 question, 1+ - answers. 1 usually is false.

local speak_timer = 0

function checklist_6()

	--local passed = get(frame_time)
	
	--print(checklist_started)
	
	-- start the checklist
	if not checklist_started and get(checklist_selected) == 6 then 
		checklist_started = true 
		stage = 1
		
		-- declare checklist
		local num = find_empty()
		phrases_tbl[num] = {nav_tbl["TOD"][lang], 2}
		speak_timer = 2
		
	end
	
	-- another checklist started
	if get(checklist_selected) ~= 6 then 
		checklist_started = false
		stage = 0
		stage_status = 0 
	end
	
	-- move stages
	if checklist_started then
		if stage == 1 and get(fishka_8) == 0 then stage = 2 stage_status = 0 end -- move further if cap is closed
		if stage == 2 and get(fishka_9) == 0 then stage = 3 stage_status = 0 end -- move further if cap is closed
		if stage == 3 and get(fishka_10) == 0 then stage = 4 stage_status = 0 end -- move further if cap is closed
		if stage == 4 and get(fishka_11) == 0 then stage = 5 stage_status = 0 end -- move further if cap is closed
		if stage == 5 and get(fishka_12) == 0 then 
			stage = 100 stage_status = 0 
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["checklist_completed"][lang], 2}
		end -- end checklist
	end
	--print(stage)
	
	---------------------------------
	-- question 1. Charts --
	---------------------------------
	if stage == 1 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["plan"][lang], 1}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		--[[
		-- false answer
		if stage_status == 1 and get(mars_on) ~= 1 and get(bus27_volt_left) < 13 and get(bus27_volt_right) < 13 then
			-- say false answer once
			stage_status = 2
		end
		--]]
		-- true answer
		if (stage_status == 1 or stage_status == 2) then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["read"][lang], 2}
			
			speak_timer = 3
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 8
	if stage == 1 and stage_status == 10 and speak_timer < 0.1 then set(fishka_8, 0) end


	---------------------------------
	-- question 2. Landing data --
	---------------------------------
	if stage == 2 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["landing_date"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		--[[
		-- false answer
		if stage_status == 1 and get(mars_on) ~= 1 and get(bus27_volt_left) < 13 and get(bus27_volt_right) < 13 then
			-- say false answer once
			stage_status = 2
		end
		--]]
		-- true answer
		if (stage_status == 1 or stage_status == 2) then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["weight"][lang], 1}
			
			cop_say_num(math.floor(get(weight_actual)/1000 + 0.5), 3, lang)
			
			phrases_tbl[num+4] = {cop_tbl["cg_pos"][lang], 1}
			
			cop_say_num(math.floor(get(cg_pos_actual)+0.5), 2, lang)
			
			speak_timer = 5
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 9
	if stage == 2 and stage_status == 10 and speak_timer < 0.1 then set(fishka_9, 0) end

	

	---------------------------------
	-- question 3. TKS --
	---------------------------------
	if stage == 3 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["TKS"][lang], 1}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and get(mars_on) ~= 1 and (math.abs(get(course_mk_1) - get(course_ga_1)) > 3 or math.abs(get(course_mk_2) - get(course_ga_2)) > 3) then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and math.abs(get(course_mk_1) - get(course_ga_1)) < 3 and math.abs(get(course_mk_2) - get(course_ga_2)) < 3 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["TKS_aligned"][lang], 5}
			
			speak_timer = 6
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 10
	if stage == 3 and stage_status == 10 and speak_timer < 0.1 then set(fishka_10, 0) end




	---------------------------------
	-- question 4. RV setting --
	---------------------------------
	if stage == 4 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["RV"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		local DH = interpolate(angle2alt, get(radioalt_dh_left))
		
		-- false answer
		if stage_status == 1 and get(mars_on) ~= 1 and DH < 400 then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and DH >= 400 then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["rv_setting"][lang], 1}
			
			cop_say_num(math.floor(DH/10+0.5)*10, 3, lang)
			
			speak_timer = 4
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 11
	if stage == 4 and stage_status == 10 and speak_timer < 0.1 then set(fishka_11, 0) end



	---------------------------------
	-- question 5. Fuel --
	---------------------------------
	if stage == 5 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fuel_quantity"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		local DH = interpolate(angle2alt, get(radioalt_dh_left))
		--[[
		-- false answer
		if stage_status == 1 and get(mars_on) ~= 1 and DH < 400 then
			-- say false answer once
			stage_status = 2
		end
		-=]]
		-- true answer
		if (stage_status == 1 or stage_status == 2) then
			
			eng_say_num(math.floor(get(fuel_meter_summ) * 0.001 + 0.5), 2, lang)
			
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["tonns"][lang], 1}
			
			speak_timer = 4
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 12
	if stage == 5 and stage_status == 10 and speak_timer < 0.1 then set(fishka_12, 0) end


	
	
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
	
	--print(checklist_started)




end