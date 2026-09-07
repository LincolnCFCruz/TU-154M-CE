-- this is power counters logic


-- busses currents. results
defineProperty("bus27_amp_left", globalPropertyf("tu-154/elec/bus27_amp_left")) -- 27 V bus current
defineProperty("bus27_amp_right", globalPropertyf("tu-154/elec/bus27_amp_right")) -- 27 V bus current

defineProperty("bus36_amp_left", globalPropertyf("tu-154/elec/bus36_amp_left")) -- left 36 V bus current
defineProperty("bus36_amp_right", globalPropertyf("tu-154/elec/bus36_amp_right")) -- right 36 V bus current
defineProperty("bus36_amp_pts250_1", globalPropertyf("tu-154/elec/bus36_amp_pts250_1")) -- PTS250 current, 36 V bus 1
defineProperty("bus36_amp_pts250_2", globalPropertyf("tu-154/elec/bus36_amp_pts250_2")) -- PTS250 current, 36 V bus 2

defineProperty("bus115_1_amp", globalPropertyf("tu-154/elec/bus115_1_amp"))
defineProperty("bus115_2_amp", globalPropertyf("tu-154/elec/bus115_2_amp"))
defineProperty("bus115_3_amp", globalPropertyf("tu-154/elec/bus115_3_amp"))

defineProperty("bus115_em_1_amp", globalPropertyf("tu-154/elec/bus115_em_1_amp"))
defineProperty("bus115_em_2_amp", globalPropertyf("tu-154/elec/bus115_em_2_amp"))






-- sources
-- bus 27v
defineProperty("bat_amp_cc_1", globalPropertyf("tu-154/elec/bat_cc_1")) -- battery charge current
defineProperty("bat_amp_cc_2", globalPropertyf("tu-154/elec/bat_cc_2")) -- battery charge current
defineProperty("bat_amp_cc_3", globalPropertyf("tu-154/elec/bat_cc_3")) -- battery charge current
defineProperty("bat_amp_cc_4", globalPropertyf("tu-154/elec/bat_cc_4")) -- battery charge current
defineProperty("cockpit_light_cc_left", globalPropertyf("tu-154/elec/cockpit_light_cc_left"))-- left bus load from the cockpit lighting
defineProperty("cockpit_light_cc_right", globalPropertyf("tu-154/elec/cockpit_light_cc_right"))-- right bus load from the cockpit lighting
defineProperty("ext_light_cc_left", globalPropertyf("tu-154/elec/ext_light_cc_left"))-- left bus load
defineProperty("ext_light_cc_right", globalPropertyf("tu-154/elec/ext_light_cc_right"))-- right bus load
defineProperty("apu_start_cc", globalPropertyf("tu-154/elec/apu_start_cc")) -- current draw of the APU starter
defineProperty("fuel_pumps_27_cc", globalPropertyf("tu-154/elec/fuel_pumps_27_cc")) -- 27 V bus load from the fuel pumps

defineProperty("ai_27_L_cc", globalPropertyf("tu-154/antiice/ai_27_L_cc")) -- bus load
defineProperty("ai_27_R_cc", globalPropertyf("tu-154/antiice/ai_27_R_cc")) -- bus load

defineProperty("ctr_27_L_cc", globalPropertyf("tu-154/control/ctr_27_L_cc")) -- bus load
defineProperty("ctr_27_R_cc", globalPropertyf("tu-154/control/ctr_27_R_cc")) -- bus load

defineProperty("msrp_27_L_cc", globalPropertyf("tu-154/msrp/msrp_27_L_cc")) -- bus load
defineProperty("msrp_27_R_cc", globalPropertyf("tu-154/msrp/msrp_27_R_cc")) -- bus load

defineProperty("svs27_cc", globalPropertyf("tu-154/svs/power_27cc")) -- current draw

defineProperty("auasp_pow27_cc", globalPropertyf("tu-154/elec/auasp_pow27_cc"))

defineProperty("rv_cc_1", globalPropertyf("tu-154/elec/rv5_left_cc"))  -- RV
defineProperty("rv_cc_2", globalPropertyf("tu-154/elec/rv5_right_cc"))  -- RV

defineProperty("taws_cc", globalPropertyf("tu-154/taws/taws_cc")) -- current draw of the SRPBZ system

defineProperty("fire_sys_cc", globalPropertyf("tu-154/fire/fire_sys_cc")) -- fire system current draw

defineProperty("vhf1_cc", globalPropertyf("tu-154/radio/vhf1_cc"))
defineProperty("vhf2_cc", globalPropertyf("tu-154/radio/vhf2_cc"))

defineProperty("km5_1_cc", globalPropertyf("tu-154/tks/km5_1_cc")) -- KM-5 current draw
defineProperty("km5_2_cc", globalPropertyf("tu-154/tks/km5_1_cc")) -- KM-5 current draw

defineProperty("ga_1_cc", globalPropertyf("tu-154/tks/ga_1_cc")) -- gyro unit current draw, main
defineProperty("ga_2_cc", globalPropertyf("tu-154/tks/ga_2_cc")) -- gyro unit current draw, monitoring
defineProperty("ga_heat_cc", globalPropertyf("tu-154/tks/ga_heat_cc")) -- current draw
defineProperty("bgmk_1_cc", globalPropertyf("tu-154/tks/bgmk_1_cc")) -- BGMK current draw
defineProperty("bgmk_2_cc", globalPropertyf("tu-154/tks/bgmk_2_cc")) -- BGMK current draw

defineProperty("ush_cc", globalPropertyf("tu-154/tks/ush_cc")) -- USH current draw

defineProperty("agr_cc", globalPropertyf("tu-154/ahz/agr_cc")) -- current
defineProperty("ark15_L_cc", globalPropertyf("tu-154/radio/ark15_L_cc")) -- ARK current draw
defineProperty("ark15_R_cc", globalPropertyf("tu-154/radio/ark15_R_cc")) -- ARK current draw

defineProperty("diss_cc", globalPropertyf("tu-154/nvu/diss_cc")) -- DISS current draw
defineProperty("radar_cc", globalPropertyf("tu-154/radio/radar_cc")) -- current draw from the Groza radar
defineProperty("rsbn_cc", globalPropertyf("tu-154/radio/rsbn_cc")) -- current draw from the RSBN


-- bus 36v
defineProperty("ctr_36L_cc", globalPropertyf("tu-154/control/ctr_36L_cc")) -- bus load
defineProperty("ctr_36R_cc", globalPropertyf("tu-154/control/ctr_36R_cc")) -- bus load

defineProperty("svs36_cc", globalPropertyf("tu-154/svs/power_36cc")) -- current draw
defineProperty("absu_power_cc", globalPropertyf("tu-154/absu_power_cc")) -- ABSU current draw

defineProperty("pkp_left_power_cc", globalPropertyf("tu-154/bkk/pkp_left_power_cc")) -- PKP current draw
defineProperty("pkp_right_power_cc", globalPropertyf("tu-154/bkk/pkp_right_power_cc")) -- PKP current draw
defineProperty("mgv_ctr_power_cc", globalPropertyf("tu-154/bkk/mgv_ctr_power_cc")) -- PKP current draw

defineProperty("absu_at_power_cc", globalPropertyf("tu-154/absu_at_power_cc")) -- ABSU current draw
defineProperty("nvu_cc", globalPropertyf("tu-154/nvu/nvu_cc")) -- NVU current draw

defineProperty("nav1_pow_cc", globalPropertyf("tu-154/radio/nav1_pow_cc")) -- Kurs-MP current draw
defineProperty("nav2_pow_cc", globalPropertyf("tu-154/radio/nav2_pow_cc")) -- Kurs-MP current draw


-- bus 115v
defineProperty("vu1_amp", globalPropertyf("tu-154/elec/vu1_amp")) -- rectifier unit (VU) running
defineProperty("vu2_amp", globalPropertyf("tu-154/elec/vu2_amp")) -- rectifier unit (VU) running
defineProperty("vu3_amp", globalPropertyf("tu-154/elec/vu_res_amp")) -- rectifier unit (VU) running
defineProperty("cockpit_light_cc_115", globalPropertyf("tu-154/elec/cockpit_light_cc_115"))-- 115 V bus load from the cockpit lighting
defineProperty("fuel_pumps_115_1_cc", globalPropertyf("tu-154/elec/fuel_pumps_115_1_cc")) -- bus 1 load from the fuel pumps
defineProperty("fuel_pumps_115_3_cc", globalPropertyf("tu-154/elec/fuel_pumps_115_3_cc")) -- bus 3 load from the fuel pumps
defineProperty("gs_pump_2_cc", globalPropertyf("tu-154/hydro/gs_pump_2_cc")) -- pump station current
defineProperty("gs_pump_3_cc", globalPropertyf("tu-154/hydro/gs_pump_3_cc")) -- pump station current

defineProperty("ai_115_1_cc", globalPropertyf("tu-154/antiice/ai_115_1_cc")) -- bus load
defineProperty("ai_115_2_cc", globalPropertyf("tu-154/antiice/ai_115_2_cc")) -- bus load
defineProperty("ai_115_3_cc", globalPropertyf("tu-154/antiice/ai_115_3_cc")) -- bus load

defineProperty("ctr_115_1_cc", globalPropertyf("tu-154/control/ctr_115_1_cc")) -- bus load
defineProperty("ctr_115_3_cc", globalPropertyf("tu-154/control/ctr_115_3_cc")) -- bus load

defineProperty("svs115_cc", globalPropertyf("tu-154/svs/power_115cc")) -- current draw

defineProperty("auasp_pow115_cc", globalPropertyf("tu-154/elec/auasp_pow115_cc"))



-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control





function update()

local MASTER = get(ismaster) ~= 1	
	

if MASTER then	


	-- bus 27v
	local bus27_L = get(bat_amp_cc_1) + get(bat_amp_cc_3) + get(cockpit_light_cc_left) + get(ext_light_cc_left) + get(fuel_pumps_27_cc) * 0.5 + get(ai_27_L_cc) + get(ctr_27_L_cc) + get(msrp_27_L_cc)
	bus27_L = bus27_L + get(svs27_cc) + get(rv_cc_1) + get(taws_cc) + get(vhf1_cc) + get(km5_1_cc) * 2 + get(ga_1_cc) * 0.5 + get(ga_2_cc) * 0.5 + get(ga_heat_cc) + get(bgmk_1_cc) + get(agr_cc)
	bus27_L = bus27_L + get(nvu_cc) * 10 + get(ark15_L_cc) + get(diss_cc) + get(rsbn_cc) * 5
	--
	local bus27_R = get(bat_amp_cc_2) + get(bat_amp_cc_4) + get(cockpit_light_cc_right) + get(ext_light_cc_right) + get(fuel_pumps_27_cc) * 0.5 + get(ai_27_R_cc) + get(ctr_27_R_cc) + get(msrp_27_R_cc)
	bus27_R = bus27_R + get(auasp_pow27_cc) + get(rv_cc_2) + get(fire_sys_cc) + get(vhf2_cc) + get(km5_2_cc) * 2 + get(bgmk_2_cc) + get(ush_cc) + get(ark15_R_cc) + get(radar_cc) * 3
	
	set(bus27_amp_left, bus27_L)
	set(bus27_amp_right, bus27_R)
	
	
	-- bus 36v

	local bus36_L = get(ctr_36L_cc) + get(svs36_cc) + get(absu_power_cc) * 3 + get(pkp_left_power_cc) + get(absu_at_power_cc) + get(nvu_cc) * 7 + get(ark15_L_cc) + get(diss_cc)
	
	local bus36_R = get(ctr_36R_cc) + get(absu_power_cc) * 3 + get(pkp_right_power_cc) + get(km5_2_cc) * 3 + get(ga_2_cc) * 2 + get(bgmk_2_cc) + get(ark15_R_cc) + get(nav2_pow_cc)
	
	local bus36_pts_1 = get(absu_power_cc) * 3 + get(mgv_ctr_power_cc) + get(agr_cc) + get(radar_cc)
	
	local bus36_pts_2 = get(km5_1_cc) * 3 + get(ga_1_cc) * 2 + get(bgmk_1_cc) + get(nav1_pow_cc)
	
	set(bus36_amp_left, bus36_L)
	set(bus36_amp_right, bus36_R)
	set(bus36_amp_pts250_1, bus36_pts_1)
	set(bus36_amp_pts250_2, bus36_pts_2)
	
	

	-- bus 115v
	local bus115_1 = get(vu1_amp) * 0.25 + get(vu3_amp) * 0.125 + get(cockpit_light_cc_115) * 0.5 + get(fuel_pumps_115_1_cc) + get(gs_pump_2_cc) + get(ai_115_1_cc) + get(ctr_115_1_cc)
	bus115_1 = bus115_1 + get(svs115_cc) + get(rv_cc_1) + get(taws_cc) * 0.2 + get(absu_at_power_cc) + get(nvu_cc) + get(diss_cc) * 3 + get(nav1_pow_cc) * get(rsbn_cc) * 5
	
	--
	local bus115_2 = get(ai_115_2_cc)
	
	--
	local bus115_3 = get(vu2_amp) * 0.25 + get(vu3_amp) * 0.125 + get(cockpit_light_cc_115) * 0.5 + get(fuel_pumps_115_3_cc) + get(gs_pump_3_cc) + get(ai_115_3_cc) + get(ctr_115_3_cc)
	bus115_3 = bus115_3 + get(auasp_pow115_cc) + get(rv_cc_2) + get(absu_power_cc) + get(nav2_pow_cc) + get(radar_cc) * 3
	
	set(bus115_1_amp, bus115_1)
	set(bus115_2_amp, bus115_2)
	set(bus115_3_amp, bus115_3)
	
end
	
end