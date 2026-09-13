-- USh-3: large course indicator

-- sources
defineProperty("course_ga_1", globalPropertyf("tu-154/tks/course_ga_1")) -- heading on GA1
defineProperty("course_ga_2", globalPropertyf("tu-154/tks/course_ga_2")) -- heading on GA2
defineProperty("diss_slip_angle", globalPropertyf("tu-154/nvu/diss_slip_angle")) -- drift angle from the DISS
defineProperty("tks_mode", globalPropertyi("tu-154/switchers/ovhd/tks_mode")) -- TKS mode. 0 = MK, 1 = GPK, 2 = AK

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- power
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))


-- lamps
defineProperty("tks_mode_lit_mk", globalPropertyf("tu-154/lights/tks_mode_lit_mk")) -- TKS mode lamp - MK
defineProperty("tks_mode_lit_ak", globalPropertyf("tu-154/lights/tks_mode_lit_ak")) -- TKS mode lamp - AK
defineProperty("tks_mode_lit_gpk", globalPropertyf("tu-154/lights/tks_mode_lit_gpk")) -- TKS mode lamp - GPK


-- results
defineProperty("big_course_needle", globalPropertyf("tu-154/gauges/compas/big_course_needle")) -- "aircraft" symbol needle
defineProperty("big_true_course_needle", globalPropertyf("tu-154/gauges/compas/big_true_course_needle")) -- track angle needle
defineProperty("big_tri_needle", globalPropertyf("tu-154/gauges/compas/big_tri_needle")) -- triangular needle

defineProperty("ush_cc", globalPropertyf("tu-154/tks/ush_cc")) -- USH current draw


local course_main = math.random(-180, 180)
local course_aux = math.random(-180, 180)
local course_pu = course_main

function update()
	
	local passed = get(frame_time)
	
	local power = get(bus27_volt_right) > 13

	local main_ga = get(course_ga_1)
	local aux_ga = get(course_ga_2)
	local slip = get(diss_slip_angle)
	
	if power then
	
		local delta_main = course_main - main_ga
		
		while delta_main > 180 do delta_main = delta_main - 360 end
		while delta_main < -180 do delta_main = delta_main + 360 end
		
		if delta_main > 1 then course_main = course_main - passed * 30
		elseif delta_main < -1 then course_main = course_main + passed * 30
		else course_main = course_main - delta_main * passed * 20
		end
		
		
		local delta_aux = course_aux - aux_ga

		while delta_aux > 180 do delta_aux = delta_aux - 360 end
		while delta_aux < -180 do delta_aux = delta_aux + 360 end
		
		if delta_aux > 1 then course_aux = course_aux - passed * 30
		elseif delta_aux < -1 then course_aux = course_aux + passed * 30
		else course_aux = course_aux - delta_aux * passed * 20
		end
		
		
		local delta_pu = course_pu - course_main - slip

		while delta_pu > 180 do delta_pu = delta_pu - 360 end
		while delta_pu < -180 do delta_pu = delta_pu + 360 end
		
		if delta_pu > 1 then course_pu = course_pu - passed * 30
		elseif delta_pu < -1 then course_pu = course_pu + passed * 30
		else course_pu = course_pu - delta_pu * passed * 20
		end
		
		-- lamps
		local mode = get(tks_mode)
		if mode == 0 then -- MK mode
			set(tks_mode_lit_mk, 1)
			set(tks_mode_lit_gpk, 0)
			set(tks_mode_lit_ak, 0)
		elseif mode == 1 then -- GPK mode
			set(tks_mode_lit_mk, 0)
			set(tks_mode_lit_gpk, 1)
			set(tks_mode_lit_ak, 0)
		else -- AK mode
			set(tks_mode_lit_mk, 0)
			set(tks_mode_lit_gpk, 0)
			set(tks_mode_lit_ak, 1)
		end
	
	else -- no power
		set(tks_mode_lit_mk, 0)
		set(tks_mode_lit_gpk, 0)
		set(tks_mode_lit_ak, 0)
	
	end
	
	
	set(big_course_needle, course_main)
	set(big_tri_needle, course_aux)
	set(big_true_course_needle, course_pu)

	set(ush_cc, bool2int(power))

end