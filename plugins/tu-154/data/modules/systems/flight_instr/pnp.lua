-- this is PNP gauge


-- sources
defineProperty("gauge_num", 0) -- instrument number

defineProperty("absu_zpu_sel", globalPropertyi("tu-154/switchers/console/absu_zpu_sel")) -- desired-track (ZPU) selector. left - right

defineProperty("course_ga", globalPropertyf("tu-154/tks/course_ga_1")) -- heading to the gyro unit
defineProperty("course_bgmk", globalPropertyf("tu-154/tks/course_bgmk_1")) -- heading on the BGMK
defineProperty("diss_slip_angle", globalPropertyf("tu-154/nvu/diss_slip_angle")) -- drift angle from the DISS

defineProperty("nav_cs_1", globalPropertyf("tu-154/radio/nav1_cs"))
defineProperty("nav_gs_1", globalPropertyf("tu-154/radio/nav1_gs"))

defineProperty("nav_cs_flag_1", globalPropertyi("tu-154/radio/nav1_cs_flag"))
defineProperty("nav_gs_flag_1", globalPropertyi("tu-154/radio/nav1_gs_flag"))

defineProperty("nav_cs_2", globalPropertyf("tu-154/radio/nav2_cs"))
defineProperty("nav_gs_2", globalPropertyf("tu-154/radio/nav2_gs"))

defineProperty("nav_cs_flag_2", globalPropertyi("tu-154/radio/nav2_cs_flag"))
defineProperty("nav_gs_flag_2", globalPropertyi("tu-154/radio/nav2_gs_flag"))

defineProperty("obs", globalPropertyf("tu-154/gauges/compas/pkp_obs_set_L"))  -- set the course

defineProperty("obs_side", globalPropertyf("tu-154/gauges/compas/pkp_obs_set_R"))  -- set the course


defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- flight time


defineProperty("gyro_fail", globalPropertyi("tu-154/tks/fail_left")) -- failure flag


defineProperty("absu_use_second_nav", globalPropertyi("tu-154/absu_use_second_nav")) -- the ABSU uses the second Kurs-MP

defineProperty("roll_sub_mode", globalPropertyi("tu-154/absu/roll_sub_mode")) -- ABSU roll mode. 0 - off, 1 - stab, 2 - ZK, 3 - NVU, 4 - AZ1, 5 - AZ2, 6 - approach
defineProperty("pitch_sub_mode", globalPropertyi("tu-154/absu/pitch_sub_mode")) -- ABSU pitch mode. 0 - off, 1 - stab, 2 - V, 3 - M, 4 - H, 5 - glideslope, 6 - go-around

defineProperty("nav_course_1", globalPropertyi("tu-154/rotary/console/nav_1_course")) -- heading set knob
defineProperty("nav_course_2", globalPropertyi("tu-154/rotary/console/nav_2_course")) -- heading set knob

defineProperty("obs1", globalPropertyf("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot")) -- OBS course
defineProperty("obs2", globalPropertyf("sim/cockpit2/radios/actuators/nav2_obs_deg_mag_pilot")) -- OBS course

-- NVU
defineProperty("nvu_res_course", globalPropertyf("tu-154/nvu/nvu_res_course")) -- flight heading from the NVU
defineProperty("nvu_res_z", globalPropertyf("tu-154/nvu/nvu_res_z")) -- offset from the NVU flight track

-- KLN
defineProperty("kln_course", globalPropertyf("tu-154/kln90/kln_course")) -- desired track (LZP) from the KLN
defineProperty("kln_dev", globalPropertyf("tu-154/kln90/kln_dev")) -- cross-track deviation from the desired track, nm
defineProperty("kln_flag", globalPropertyi("tu-154/kln90/kln_flag")) -- KLN course flag. 0 = flag


defineProperty("show_gns", globalPropertyi("tu-154/anim/show_gns"))
defineProperty("show_RXP",globalPropertyi("tu-154/anim/RXP"))

-- GNS
defineProperty("GNS430_dtk", globalPropertyf("tu-154/SC/GNS430_dtk")) -- heading on the GNS
defineProperty("GNS430_dev", globalPropertyf("tu-154/SC/GNS430_dev")) -- cross-track deviation from the GNS
defineProperty("GNS430_flag", globalPropertyi("tu-154/SC/GNS430_flag")) -- cross-track deviation from the GNS
defineProperty("gps_power", globalPropertyi("sim/cockpit2/radios/actuators/gps_power")) -- GPS power

-- RXP
defineProperty("RXP_course", globalPropertyf("RXP/radios/indicators/gps_course_degtm")) -- desired track (LZP) from the KLN
defineProperty("RXP_dev", globalPropertyf("RXP/radios/indicators/gps_cross_track_nm")) -- cross-track deviation from the desired track, nm
defineProperty("RXP_flag", globalPropertyf("RXP/radios/indicators/hsi_flag_from_to_pilot")) -- flag


-- controls
defineProperty("pnp_mode", globalPropertyi("tu-154/switchers/ovhd/curs_pnp_mode_1")) -- PNP heading mode. 0 = GMK, 1 = GPK
defineProperty("pkp_obs_knob", globalPropertyf("tu-154/gauges/compas/pkp_obs_knob_L")) -- heading tuning knob

defineProperty("absu_pnp_mode", globalPropertyi("tu-154/absu/absu_pnp_mode_1")) -- PNP display mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = landing system
defineProperty("absu_pnp_mode_2", globalPropertyi("tu-154/absu/absu_pnp_mode_2")) -- PNP display mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = landing system
defineProperty("nav_select", globalPropertyi("tu-154/switchers/nav_select")) -- NVU-SNS toggle 0 - NVU, 1 - SNS

-- power
defineProperty("bus27_volt", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus36_volt", globalPropertyf("tu-154/elec/bus36_volt_pts250_2"))
defineProperty("fail_ga", globalPropertyf("sim/operation/failures/rel_ss_dgy"))
defineProperty("tks_on", globalPropertyi("tu-154/switchers/ovhd/tks_on_1")) -- TKS switch


-- results
defineProperty("pkp_gyro_course", globalPropertyf("tu-154/gauges/compas/pkp_gyro_course_L")) -- PKP gyro heading
defineProperty("pkp_obs", globalPropertyf("tu-154/gauges/compas/pkp_obs_L")) -- flight heading on the PKP
defineProperty("pkp_helper_course", globalPropertyf("tu-154/gauges/compas/pkp_helper_course_L")) -- heading set by the yellow needle on the PKP
defineProperty("pkp_slip_angle", globalPropertyf("tu-154/gauges/compas/pkp_slip_angle_L")) -- drift angle on the PKP
defineProperty("pkp_course_plank", globalPropertyf("tu-154/gauges/compas/pkp_course_plank_L")) -- captain's PKP course bar + bar deflected to the right
defineProperty("pkp_gs_plank", globalPropertyf("tu-154/gauges/compas/pkp_gs_plank_L")) -- captain's PKP glideslope bar + bar deflected up
defineProperty("pkp_gs_flag", globalPropertyi("tu-154/gauges/compas/pkp_gs_flag_L")) -- glideslope bar failure flag
defineProperty("pkp_course_flag", globalPropertyi("tu-154/gauges/compas/pkp_course_flag_L")) -- course bar failure flag
defineProperty("pkp_main_flag", globalPropertyi("tu-154/gauges/compas/pkp_main_flag_L")) -- heading failure flag
defineProperty("pkp_obs_flag", globalPropertyi("tu-154/gauges/compas/pkp_obs_flag_L")) -- heading counter failure flag
defineProperty("pkp_obs_one", globalPropertyf("tu-154/gauges/compas/pkp_obs_one_L")) -- heading counter. units
defineProperty("pkp_obs_ten", globalPropertyf("tu-154/gauges/compas/pkp_obs_ten_L")) -- heading counter. tens
defineProperty("pkp_obs_hundr", globalPropertyf("tu-154/gauges/compas/pkp_obs_hundr_L")) -- heading counter. hundreds


-- lapms
defineProperty("pnp_sp_lamp", globalPropertyf("tu-154/lights/small/pnp_sp_left")) -- 
defineProperty("pnp_vor_lamp", globalPropertyf("tu-154/lights/small/pnp_vor_left")) -- 
defineProperty("pnp_nv_lamp", globalPropertyf("tu-154/lights/small/pnp_nv_left")) -- 



-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control






local main_scale_act = math.random(-180, 180)
set(pkp_gyro_course, main_scale_act)

local slip_ang_act = 0

local v_plank_act = 0
local h_plank_act = 0

local obs_actual = 0
local obs_knob_last = 0
local obs_now = get(obs)

local obs_course = get(obs)

function update()
	
	local MASTER = get(ismaster) ~= 1	

	
	local passed = get(frame_time)

	local power = get(bus27_volt) > 13 and get(bus36_volt) > 30 and get(tks_on) == 1 and get(fail_ga) < 6
	
	local mode = get(absu_pnp_mode) -- 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = PS
	local mode_2 = get(absu_pnp_mode_2)
	
	local nav_sel = get(nav_select) -- NVU-SNS toggle 0 - NVU, 1 - SNS
	
	
	--local NVU = get(nvu_mode) > 1 -- temp. must change it to ABSU modes
	
	main_scale_act = get(pkp_gyro_course)
	
	if power then
		
		-- main course --
		local course = get(course_ga)
		if get(pnp_mode) == 0 then course = get(course_bgmk) end
		
		local cur_delta = main_scale_act - course
				
		if cur_delta > 180 then cur_delta = cur_delta - 360
		elseif cur_delta < -180 then cur_delta = cur_delta + 360 end
				
		if cur_delta > 1 then main_scale_act = main_scale_act - passed * 30
		elseif cur_delta < -1 then main_scale_act = main_scale_act + passed * 30
		else main_scale_act = main_scale_act - cur_delta * passed * 20
		end
		
		-- slip angle --
		local slip = get(diss_slip_angle)
		
		slip_ang_act = slip_ang_act + (slip - slip_ang_act) * passed * 10
		
		if slip_ang_act > 30 then slip_ang_act = 30
		elseif slip_ang_act < -30 then slip_ang_act = -30 end
		

	end
	
	
	-- set limits
	if main_scale_act > 180 then main_scale_act = main_scale_act - 360
	elseif main_scale_act < -180 then main_scale_act = main_scale_act + 360 end
	
	-- set course
	if MASTER then set(pkp_gyro_course, main_scale_act) end
	
	-- set slip angle
	if slip_ang_act > 20 then slip_ang_act = 20
	elseif slip_ang_act < -20 then slip_ang_act = -20 end
	
	set(pkp_slip_angle, slip_ang_act)
	
	
	
	
	-- TKS flag logic
	if not power or get(gyro_fail) == 1 then
		set(pkp_main_flag, 1)
	else set(pkp_main_flag, 0)
	end
	

	
	local course_flag = get(nav_cs_flag_1)
	local gs_flag = get(nav_gs_flag_1)
	
	local course_pl = get(nav_cs_1)
	local glidesl_pl = -get(nav_gs_1)
	
	
	
	
	if mode == 2 and power then -- AZ-1 mode

		-- set course and glideslope planks
		course_pl = get(nav_cs_1)
		glidesl_pl = 0
		
		if course_pl > 1.3 then course_pl = 1.3
		elseif course_pl < -1.3 then course_pl = -1.3 end
		
		
		--obs_course = get(obs1)
		obs_course = get(obs)
		set(pkp_obs_flag, 0)
		
		
		if ((get(gauge_num) == 0 and get(absu_zpu_sel) == 1) or (get(gauge_num) == 1 and get(absu_zpu_sel) == 0)) and mode_2 > 1 then
			obs_course = get(obs_side)
			set(pkp_obs_flag, 1)
		end
		
		-- set flags
		course_flag = get(nav_cs_flag_1)
		gs_flag = 1
	
		
	
	elseif mode == 3 and power then -- AZ-2 mode

		-- set course and glideslope planks
		course_pl = get(nav_cs_2)
		glidesl_pl = 0
		
		
		if course_pl > 1.3 then course_pl = 1.3
		elseif course_pl < -1.3 then course_pl = -1.3 end
		
		
		--obs_course = get(obs2)
		obs_course = get(obs)
		set(pkp_obs_flag, 0)
		
		
		if ((get(gauge_num) == 0 and get(absu_zpu_sel) == 1) or (get(gauge_num) == 1 and get(absu_zpu_sel) == 0)) and mode_2 > 1 then
			obs_course = get(obs_side)
			set(pkp_obs_flag, 1)
		end
			
		-- set flags
		course_flag = get(nav_cs_flag_2)
		gs_flag = 1

	
	elseif mode == 4 and power then -- APP

		-- set course and glideslope planks
		course_pl = get(nav_cs_1)
		glidesl_pl = -get(nav_gs_1)
		
		-- switch to second COursMP
		if get(absu_use_second_nav) == 1 then 
			course_pl = get(nav_cs_2) 
			glidesl_pl = -get(nav_gs_2) 
		end
		
		--if get(nav_cs_flag_1) == 1 and get(nav_cs_flag_2) == 0 then course_pl = get(nav_cs_2) end
		--if get(nav_gs_flag_1) == 1 and get(nav_gs_flag_2) == 0 then glidesl_pl = -get(nav_gs_2) end
		
		if course_pl > 1.3 then course_pl = 1.3
		elseif course_pl < -1.3 then course_pl = -1.3 end
		
		
		obs_course = get(obs)
		set(pkp_obs_flag, 0)
		
		
		if ((get(gauge_num) == 0 and get(absu_zpu_sel) == 1) or (get(gauge_num) == 1 and get(absu_zpu_sel) == 0)) and mode_2 > 1 then
			obs_course = get(obs_side)
			set(pkp_obs_flag, 1)
		end
			
		-- set flags
		course_flag = math.min(get(nav_cs_flag_1), get(nav_cs_flag_2))
		gs_flag = math.min(get(nav_gs_flag_1), get(nav_gs_flag_2))
	
		--set(pkp_obs_flag, 0)
		
	elseif power and mode == 1 and nav_sel == 0 then -- NVU
	
		obs_course = get(nvu_res_course)
		
		course_pl = -get(nvu_res_z) * 0.1
		glidesl_pl = 0
		
		
		gs_flag = 1
		course_flag = 0
		
		set(pkp_obs_flag, 1) 
		
	elseif power and mode == 1 and nav_sel == 1 then -- KLN
	
		obs_course = get(kln_course)
		
		course_pl = get(kln_dev) * 0.1852
		glidesl_pl = 0
		
		
		gs_flag = 1
		course_flag = bool2int(get(kln_flag) == 0)
		
		if get(show_gns) == 1 and get(show_RXP) == 0 then -- GNS
			obs_course = get(GNS430_dtk)
			
			course_pl = get(GNS430_dev) * 0.1852 * 2.1
			glidesl_pl = 0
			
			
			gs_flag = 1
			course_flag = get(GNS430_flag)
			
		elseif get(show_gns) == 1 and get(show_RXP) == 1 then -- RXP
			obs_course = get(RXP_course)
			
			course_pl = get(RXP_dev) * 1.852 * 0.5
			glidesl_pl = 0
			
			
			gs_flag = 1
			course_flag = bool2int(get(RXP_flag) == 0)
		end
		
		
		--print(get(kln_flag), course_flag)
		
		set(pkp_obs_flag, 1) 
	
	elseif power then
	
		obs_course = get(obs)
		
		course_pl = 0
		glidesl_pl = 0
		
		gs_flag = 1
		course_flag = 1
	
		set(pkp_obs_flag, 1)	
		
	else
		
		course_pl = 0
		glidesl_pl = 0
		
		gs_flag = 1
		course_flag = 1
	
		set(pkp_obs_flag, 1)		
	
	end
	
	-- set results planks and flags
	-- smooth
	v_plank_act = v_plank_act + (course_pl - v_plank_act) * passed * 5
	h_plank_act = h_plank_act + (glidesl_pl - h_plank_act) * passed * 5
	
	if v_plank_act > 1.1 then v_plank_act = 1.1
	elseif v_plank_act < -1.1 then v_plank_act = -1.1 end
	
	if h_plank_act > 1.1 then h_plank_act = 1.1
	elseif h_plank_act < -1.1 then h_plank_act = -1.1 end
	
	set(pkp_course_plank, v_plank_act)
	set(pkp_gs_plank, h_plank_act)

	set(pkp_gs_flag, gs_flag)
	set(pkp_course_flag, course_flag)

	
	if power then
		local obs_delta = obs_actual - obs_course
					
		if obs_delta > 180 then obs_delta = obs_delta - 360
		elseif obs_delta < -180 then obs_delta = obs_delta + 360 end
					
		if obs_delta > 2 then obs_actual = obs_actual - passed * 30
		elseif obs_delta < -2 then obs_actual = obs_actual + passed * 30
		else obs_actual = obs_actual - obs_delta * passed * 15
		end	
	
	end
	
	while obs_actual > 360 do
		obs_actual = obs_actual - 360
	end
	
	while obs_actual < 0 do 
		obs_actual = obs_actual + 360
	end
	
	set(pkp_obs, obs_actual)
	
	
	
	-- set OBS
	local obs_knob_now = get(pkp_obs_knob)
	
	
	
	while obs_knob_now > 360 do
		obs_knob_now = obs_knob_now - 360
	end
	
	while obs_knob_now < 0 do
		obs_knob_now = obs_knob_now + 360
	end
	
	if MASTER then set(pkp_obs_knob, obs_knob_now) end
	
	
	local knob_diff = obs_knob_now - obs_knob_last
	
	obs_knob_last = obs_knob_now
	
	obs_now = get(obs)
	
	
	if math.abs(knob_diff) < 50 then
		obs_now = obs_now + knob_diff
	end
	
	while obs_now > 360 do
		obs_now = obs_now - 360
	end
	
	while obs_now < 0 do
		obs_now = obs_now + 360
	end
	
	
	
	--if obs_now > 360 then obs_now = obs_now - 360 
	--elseif obs_now < 0 then obs_now = obs_now + 360 end
	
	if MASTER then set(obs, math.floor(obs_now + 0.4)) end
	
	-- set numbers
	local obs_1 = obs_now % 10
	local obs_10 = math.floor((obs_now % 100) * 0.1) + math.max(math.max((obs_1  - 9), 0), 0)
	local obs_100 = math.floor((obs_now % 1000) * 0.01) + math.max(math.max((obs_10 - 9), 0), 0)
	
	set(pkp_obs_hundr, obs_100)
	set(pkp_obs_ten, obs_10)
	set(pkp_obs_one, obs_1)	
	
	-- limit course ZK
	local ZK_crs = get(pkp_helper_course)
	
	while ZK_crs > 360 do
		ZK_crs = ZK_crs - 360
	end
	
	while ZK_crs < 0 do 
		ZK_crs = ZK_crs + 360
	end
	
	set(pkp_helper_course, ZK_crs)
	

	
	
	-- lamps
	if power then
		set(pnp_sp_lamp, bool2int(mode == 4))
		set(pnp_vor_lamp, bool2int(mode == 2 or mode == 3))
		set(pnp_nv_lamp, bool2int(mode == 1))
	
	else
		set(pnp_sp_lamp, 0)
		set(pnp_vor_lamp, 0)
		set(pnp_nv_lamp, 0)
	
	end
	
	
	
	
	
	
	
	
	
end








