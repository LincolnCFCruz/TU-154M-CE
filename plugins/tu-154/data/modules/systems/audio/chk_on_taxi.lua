
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

defineProperty("antiice_slats", globalPropertyi("tu-154/switchers/eng/antiice_slats")) -- anti-icers
defineProperty("antiice_eng_1", globalPropertyi("tu-154/switchers/eng/antiice_eng_1")) -- anti-icers
defineProperty("antiice_eng_2", globalPropertyi("tu-154/switchers/eng/antiice_eng_2")) -- anti-icers
defineProperty("antiice_eng_3", globalPropertyi("tu-154/switchers/eng/antiice_eng_3")) -- anti-icers
defineProperty("antiice_wing", globalPropertyi("tu-154/switchers/eng/antiice_wing")) -- anti-icers





local checklist_started = false
local stage = 0
local stage_status = 0 -- 0 question, 1+ - answers. 1 usually is false.

local speak_timer = 0

function checklist_3()

	--local passed = get(frame_time)
	
	--print(checklist_started)
	
	-- start the checklist
	if not checklist_started and get(checklist_selected) == 3 then 
		checklist_started = true 
		stage = 1
		
		-- declare checklist
		local num = find_empty()
		phrases_tbl[num] = {nav_tbl["on_taxiing"][lang], 2}
		speak_timer = 2
		
	end
	
	-- another checklist started
	if get(checklist_selected) ~= 3 then 
		checklist_started = false
		stage = 0
		stage_status = 0 
	end

	-- move stages
	if checklist_started then
		if stage == 1 and get(fishka_1) == 1 then stage = 2 stage_status = 0 end -- move further if cap is closed
		if stage == 2 and get(fishka_2) == 1 then stage = 3 stage_status = 0 end -- move further if cap is closed
		if stage == 3 and get(fishka_3) == 1 then 
			stage = 100 stage_status = 0 
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["checklist_completed"][lang], 2}
		end -- end checklist
	end


	
	---------------------------------
	-- question 1. Brakes --
	---------------------------------
	if stage == 1 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["brake"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and not v_var["check_brk_said"] then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and v_var["check_brk_said"] then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["checked"][lang], 2}
			
			speak_timer = 2
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 1
	if stage == 1 and stage_status == 10 and speak_timer < 0.1 then set(fishka_1, 1) end	
	
		
	
	---------------------------------
	-- question 2. Deicers --
	---------------------------------
	if stage == 2 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["deicing"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		--[[
		-- false answer
		if stage_status == 1 and get(window_heat_1) + get(window_heat_2) + get(window_heat_3) > -3 and get(window_heat_1) + get(window_heat_2) + get(window_heat_3) < 3 then
			-- say false answer once
			stage_status = 2
		end
		--]]
		-- true answer
	if (stage_status == 1 or stage_status == 2) then
			local num = find_empty()
			
			-- change to engineer.
			-- check wings and engines de-icers
			
			if get(antiice_slats) + get(antiice_eng_1) + get(antiice_eng_2) + get(antiice_eng_3) + get(antiice_wing) > 0 then
				phrases_tbl[num] = {eng_tbl["turned_on_2"][lang], 2}
			else 
				phrases_tbl[num] = {eng_tbl["turned_off_2"][lang], 2}
			end
			
			speak_timer = 2
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 2
	if stage == 2 and stage_status == 10 and speak_timer < 0.1 then set(fishka_2, 1) end		
	
	
	
	---------------------------------
	-- question 3. EUP --
	---------------------------------
	if stage == 3 and speak_timer == 0 then
		
		-- ask question
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["EUP"][lang], 2}
	
			stage_status = 1 -- question asked
			speak_timer = 2 -- set up time before answer
		end
		
		-- false answer
		if stage_status == 1 and not v_var["eup_chk_said"] then
			-- say false answer once
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		
		-- true answer
		if (stage_status == 1 or stage_status == 2) and v_var["eup_chk_said"] then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["turned_on_chk"][lang], 2}
			
			speak_timer = 2
			stage_status = 10 -- finish
		end
		
	
	end
	
	-- move fishka 2
	if stage == 3 and stage_status == 10 and speak_timer < 0.1 then set(fishka_3, 1) end	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
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