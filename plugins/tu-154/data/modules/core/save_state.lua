defineProperty("reset_state",globalPropertyi("tu-154/reset_state")) -- reset the aircraft state
defineProperty("save_state", globalPropertyi("tu-154/save_state")) -- force-save the aircraft state

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

defineProperty("starter_torq", globalPropertyf("sim/aircraft/engine/acf_starter_torque_ratio")) -- starter power. 0.18 for a normal start

defineProperty("hardware_cockpit", globalPropertyi("tu-154/hardware_cockpit")) -- The aircraft is prepared for the iron cockpit
defineProperty("fuel_q_1", globalProperty("sim/flightmodel/weight/m_fuel[0]")) -- fuel quantity for tank 1
defineProperty("fuel_q_4", globalProperty("sim/flightmodel/weight/m_fuel[1]")) -- fuel quantity for tank 4
defineProperty("fuel_q_2R", globalProperty("sim/flightmodel/weight/m_fuel[2]")) -- fuel quantity for tank 2R
defineProperty("fuel_q_2L", globalProperty("sim/flightmodel/weight/m_fuel[3]")) -- fuel quantity for tank 2L
defineProperty("fuel_q_3R", globalProperty("sim/flightmodel/weight/m_fuel[4]")) -- fuel quantity for tank 3R
defineProperty("fuel_q_3L", globalProperty("sim/flightmodel/weight/m_fuel[5]")) -- fuel quantity for tank 3L

defineProperty("hide_rus_objects", globalPropertyi("tu-154/lang/hide_rus_objects")) -- hide the Russian cockpit objects
defineProperty("hide_eng_objects", globalPropertyi("tu-154/lang/hide_eng_objects")) -- hide the English cockpit objects

defineProperty("sounds_voulme", globalPropertyi("tu-154/sounds_voulme")) -- master sound volume
defineProperty("enable_crew_vo", globalPropertyi("tu-154/sounds/enable_crew_vo")) -- crew callouts enabled

defineProperty("failures_enabled", globalPropertyi("tu-154/failures/failures_enabled")) -- failures enabled
defineProperty("have_pedals", globalPropertyi("tu-154/have_pedals"))
defineProperty("show_gns", globalPropertyi("tu-154/anim/show_gns"))
defineProperty("show_RXP",globalPropertyi("tu-154/anim/RXP"))

defineProperty("pnp_1_crs", globalPropertyf("tu-154/gauges/compas/pkp_obs_set_L"))
defineProperty("pnp_2_crs", globalPropertyf("tu-154/gauges/compas/pkp_obs_set_R"))

defineProperty("pnp_1_obs", globalPropertyf("tu-154/gauges/compas/pkp_helper_course_L"))
defineProperty("pnp_2_obs", globalPropertyf("tu-154/gauges/compas/pkp_helper_course_R"))

defineProperty("ark_1_channel", globalPropertyi("tu-154/switchers/ovhd/ark_1_channel"))
defineProperty("ark_1_hundr_left", globalPropertyi("tu-154/switchers/ovhd/ark_1_hundr_left"))
defineProperty("ark_1_tens_left", globalPropertyi("tu-154/switchers/ovhd/ark_1_tens_left"))
defineProperty("ark_1_ones_left", globalPropertyi("tu-154/switchers/ovhd/ark_1_ones_left"))
defineProperty("ark_1_hundr_right", globalPropertyi("tu-154/switchers/ovhd/ark_1_hundr_right"))
defineProperty("ark_1_tens_right", globalPropertyi("tu-154/switchers/ovhd/ark_1_tens_right"))
defineProperty("ark_1_ones_right", globalPropertyi("tu-154/switchers/ovhd/ark_1_ones_right"))

defineProperty("ark_2_channel", globalPropertyi("tu-154/switchers/ovhd/ark_2_channel"))
defineProperty("ark_2_hundr_left", globalPropertyi("tu-154/switchers/ovhd/ark_2_hundr_left"))
defineProperty("ark_2_tens_left", globalPropertyi("tu-154/switchers/ovhd/ark_2_tens_left"))
defineProperty("ark_2_ones_left", globalPropertyi("tu-154/switchers/ovhd/ark_2_ones_left"))
defineProperty("ark_2_hundr_right", globalPropertyi("tu-154/switchers/ovhd/ark_2_hundr_right"))
defineProperty("ark_2_tens_right", globalPropertyi("tu-154/switchers/ovhd/ark_2_tens_right"))
defineProperty("ark_2_ones_right", globalPropertyi("tu-154/switchers/ovhd/ark_2_ones_right"))

defineProperty("vd15_pressure_left", globalPropertyf("tu-154/gauges/alt/vd15_pressure_left")) -- pressure on the captain's VD15
defineProperty("vd15_pressure_right", globalPropertyf("tu-154/gauges/alt/vd15_pressure_right")) -- pressure on the copilot's VD15
defineProperty("vd15_pressure_eng", globalPropertyf("tu-154/gauges/alt/vd15_pressure_eng")) -- pressure on the flight engineer's VD15
defineProperty("uvid_pressure_knob", globalPropertyf("tu-154/gauges/alt/uvid_pressure_knob"))  -- pressure setting knob

defineProperty("tks_lat_set", globalPropertyf("tu-154/rotary/ovhd/tks_lat_set"))

-- failures
defineProperty("ppd_3_heat_fail", globalPropertyi("tu-154/antiice/ppd_3_heat_fail"))

defineProperty("rel_ice_inlet_heat1", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat"))
defineProperty("rel_ice_inlet_heat2", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat2"))
defineProperty("rel_ice_inlet_heat3", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat3"))

defineProperty("rel_ice_pitot_heat1", globalPropertyi("sim/operation/failures/rel_ice_pitot_heat1"))
defineProperty("rel_ice_pitot_heat2", globalPropertyi("sim/operation/failures/rel_ice_pitot_heat2"))

defineProperty("rel_ice_surf_heat", globalPropertyi("sim/operation/failures/rel_ice_surf_heat"))
defineProperty("rel_ice_surf_heat2", globalPropertyi("sim/operation/failures/rel_ice_surf_heat2"))

defineProperty("rio_fail", globalPropertyi("tu-154/failures/rio_fail"))

defineProperty("window_heat_fail_1", globalPropertyi("tu-154/failures/window_heat_fail_1"))
defineProperty("window_heat_fail_2", globalPropertyi("tu-154/failures/window_heat_fail_2"))
defineProperty("window_heat_fail_3", globalPropertyi("tu-154/failures/window_heat_fail_3"))

defineProperty("apu_start_fail",globalPropertyi("tu-154/failures/apu_start_fail")) -- starter failure
defineProperty("apu_runtime",globalPropertyf("tu-154/failures/apu_runtime")) -- operating time
defineProperty("apu_fail",globalPropertyi("tu-154/failures/apu_fail")) -- wear-out failure
defineProperty("apu_press_fail", globalPropertyi("tu-154/failures/apu_press_fail")) -- engine bleed air failure


defineProperty("brake_runtime_left", globalPropertyf("tu-154/failures/brake_runtime_left")) -- brake pad wear
defineProperty("brake_runtime_right", globalPropertyf("tu-154/failures/brake_runtime_right")) -- brake pad wear

defineProperty("rel_lbrakes", globalPropertyi("sim/operation/failures/rel_lbrakes")) -- brake failure
defineProperty("rel_rbrakes", globalPropertyi("sim/operation/failures/rel_rbrakes")) -- brake failure

defineProperty("ail_fail_left", globalPropertyi("tu-154/failures/ail_fail_left"))
defineProperty("ail_fail_right", globalPropertyi("tu-154/failures/ail_fail_right"))

defineProperty("fail_spoil_inn_left", globalPropertyi("tu-154/failures/fail_spoil_inn_left"))
defineProperty("fail_spoil_inn_right", globalPropertyi("tu-154/failures/fail_spoil_inn_right"))
defineProperty("fail_spoil_mid_left", globalPropertyi("tu-154/failures/fail_spoil_mid_left"))
defineProperty("fail_spoil_mid_right", globalPropertyi("tu-154/failures/fail_spoil_mid_right"))
defineProperty("fail_spoil_out_left", globalPropertyi("tu-154/failures/fail_spoil_out_left"))
defineProperty("fail_spoil_out_right", globalPropertyi("tu-154/failures/fail_spoil_out_right"))

defineProperty("rudder_fail", globalPropertyi("tu-154/failures/rudder_fail"))
defineProperty("elev_fail_left", globalPropertyi("tu-154/failures/elev_fail_left"))
defineProperty("elev_fail_right", globalPropertyi("tu-154/failures/elev_fail_right"))

defineProperty("rel_trim_rud", globalPropertyi("sim/operation/failures/rel_trim_rud"))
defineProperty("rel_trim_ail", globalPropertyi("sim/operation/failures/rel_trim_ail"))
defineProperty("rel_trim_elv", globalPropertyi("sim/operation/failures/rel_trim_elv"))
defineProperty("trim_emerg_elv_fail", globalPropertyi("tu-154/failures/trim_emerg_elv_fail"))

defineProperty("flap_fail_left", globalPropertyi("tu-154/failures/flap_fail_left"))
defineProperty("flap_fail_right", globalPropertyi("tu-154/failures/flap_fail_right"))

defineProperty("stab_eng_fail", globalPropertyi("tu-154/failures/stab_eng_fail"))
defineProperty("stab_automatic_fail", globalPropertyi("tu-154/failures/stab_automatic_fail"))
defineProperty("slats_fail", globalPropertyi("tu-154/failures/slats_fail"))

defineProperty("retract1_fail", globalPropertyi("sim/operation/failures/rel_lagear1")) -- fail of retract gear
defineProperty("retract2_fail", globalPropertyi("sim/operation/failures/rel_lagear2")) -- fail of retract gear
defineProperty("retract3_fail", globalPropertyi("sim/operation/failures/rel_lagear3")) -- fail of retract gear
defineProperty("actuator_fail", globalPropertyi("sim/operation/failures/rel_gear_act")) -- actuator fail. bugs workaround

defineProperty("rel_genera0", globalPropertyi("sim/operation/failures/rel_genera0"))
defineProperty("rel_genera1", globalPropertyi("sim/operation/failures/rel_genera1"))
defineProperty("rel_genera2", globalPropertyi("sim/operation/failures/rel_genera2"))
defineProperty("apu_gen_fail", globalPropertyi("tu-154/failures/apu_gen_fail"))

defineProperty("vu1_fail", globalPropertyi("tu-154/failures/vu1_fail"))
defineProperty("vu2_fail", globalPropertyi("tu-154/failures/vu2_fail"))
defineProperty("vu3_fail", globalPropertyi("tu-154/failures/vu3_fail"))

defineProperty("tr1_fail", globalPropertyi("tu-154/failures/tr1_fail"))
defineProperty("tr2_fail", globalPropertyi("tu-154/failures/tr2_fail"))

defineProperty("pts250_1_fail", globalPropertyi("tu-154/failures/pts250_1_fail"))
defineProperty("pts250_2_fail", globalPropertyi("tu-154/failures/pts250_2_fail"))
defineProperty("inv115_fail", globalPropertyi("tu-154/failures/inv115_fail"))

defineProperty("bat_1_fail", globalPropertyi("tu-154/failures/bat_1_fail"))
defineProperty("bat_2_fail", globalPropertyi("tu-154/failures/bat_2_fail"))
defineProperty("bat_3_fail", globalPropertyi("tu-154/failures/bat_3_fail"))
defineProperty("bat_4_fail", globalPropertyi("tu-154/failures/bat_4_fail"))

defineProperty("bat_1_kz", globalPropertyi("tu-154/failures/bat_1_kz"))
defineProperty("bat_2_kz", globalPropertyi("tu-154/failures/bat_2_kz"))
defineProperty("bat_3_kz", globalPropertyi("tu-154/failures/bat_3_kz"))
defineProperty("bat_4_kz", globalPropertyi("tu-154/failures/bat_4_kz"))

defineProperty("rel_engfai0", globalPropertyi("sim/operation/failures/rel_engfai0"))
defineProperty("rel_engfai1", globalPropertyi("sim/operation/failures/rel_engfai1"))
defineProperty("rel_engfai2", globalPropertyi("sim/operation/failures/rel_engfai2"))

defineProperty("engine_runtime_1", globalPropertyf("tu-154/failures/engine_runtime_1"))
defineProperty("engine_runtime_2", globalPropertyf("tu-154/failures/engine_runtime_2"))
defineProperty("engine_runtime_3", globalPropertyf("tu-154/failures/engine_runtime_3"))

defineProperty("eng_fuel_pmp_fail_1", globalPropertyi("tu-154/failures/eng_fuel_pmp_fail_1"))
defineProperty("eng_fuel_pmp_fail_2", globalPropertyi("tu-154/failures/eng_fuel_pmp_fail_2"))
defineProperty("eng_fuel_pmp_fail_3", globalPropertyi("tu-154/failures/eng_fuel_pmp_fail_3"))

defineProperty("engn_oil_qty_1", globalPropertyf("tu-154/failures/engn_oil_qty_1")) 
defineProperty("engn_oil_qty_2", globalPropertyf("tu-154/failures/engn_oil_qty_2")) 
defineProperty("engn_oil_qty_3", globalPropertyf("tu-154/failures/engn_oil_qty_3"))

defineProperty("engn_oil_leak_1", globalPropertyi("tu-154/failures/engn_oil_leak_1"))
defineProperty("engn_oil_leak_2", globalPropertyi("tu-154/failures/engn_oil_leak_2"))
defineProperty("engn_oil_leak_3", globalPropertyi("tu-154/failures/engn_oil_leak_3"))

defineProperty("rel_oilpmp0", globalPropertyi("sim/operation/failures/rel_oilpmp0"))
defineProperty("rel_oilpmp1", globalPropertyi("sim/operation/failures/rel_oilpmp1"))
defineProperty("rel_oilpmp2", globalPropertyi("sim/operation/failures/rel_oilpmp2"))

defineProperty("rel_eng_lo0", globalPropertyi("sim/operation/failures/rel_eng_lo0"))
defineProperty("rel_eng_lo1", globalPropertyi("sim/operation/failures/rel_eng_lo1"))
defineProperty("rel_eng_lo2", globalPropertyi("sim/operation/failures/rel_eng_lo2"))

defineProperty("rel_startr0", globalPropertyi("sim/operation/failures/rel_startr0"))
defineProperty("rel_startr1", globalPropertyi("sim/operation/failures/rel_startr1"))
defineProperty("rel_startr2", globalPropertyi("sim/operation/failures/rel_startr2"))

defineProperty("rel_ignitr0", globalPropertyi("sim/operation/failures/rel_ignitr0"))
defineProperty("rel_ignitr1", globalPropertyi("sim/operation/failures/rel_ignitr1"))
defineProperty("rel_ignitr2", globalPropertyi("sim/operation/failures/rel_ignitr2"))

defineProperty("rel_revers0", globalPropertyi("sim/operation/failures/rel_revers0"))
defineProperty("rel_revers2", globalPropertyi("sim/operation/failures/rel_revers2"))

defineProperty("fuel_pump_2l_fail", globalPropertyi("tu-154/failures/fuel_pump_2l_fail"))
defineProperty("fuel_pump_2r_fail", globalPropertyi("tu-154/failures/fuel_pump_2r_fail"))
defineProperty("fuel_pump_3l_fail", globalPropertyi("tu-154/failures/fuel_pump_3l_fail"))
defineProperty("fuel_pump_3r_fail", globalPropertyi("tu-154/failures/fuel_pump_3r_fail"))
defineProperty("fuel_pump_1_fail", globalPropertyi("tu-154/failures/fuel_pump_1_fail"))
defineProperty("fuel_pump_4_fail", globalPropertyi("tu-154/failures/fuel_pump_4_fail"))

defineProperty("fuel_auto_fail", globalPropertyi("tu-154/failures/fuel_auto_fail"))
defineProperty("fuel_level_fail", globalPropertyi("tu-154/failures/fuel_level_fail"))
defineProperty("fuel_porc_fail", globalPropertyi("tu-154/failures/fuel_porc_fail"))

defineProperty("fuel_meter_2l_fail", globalPropertyi("tu-154/failures/fuel_meter_2l_fail"))
defineProperty("fuel_meter_2r_fail", globalPropertyi("tu-154/failures/fuel_meter_2r_fail"))
defineProperty("fuel_meter_3l_fail", globalPropertyi("tu-154/failures/fuel_meter_3l_fail"))
defineProperty("fuel_meter_3r_fail", globalPropertyi("tu-154/failures/fuel_meter_3r_fail"))
defineProperty("fuel_meter_1_fail", globalPropertyi("tu-154/failures/fuel_meter_1_fail"))
defineProperty("fuel_meter_4_fail", globalPropertyi("tu-154/failures/fuel_meter_4_fail"))
defineProperty("fuel_meter_summ", globalPropertyi("tu-154/failures/fuel_meter_summ"))

defineProperty("fuel_flowmeter_1_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_1_fail"))
defineProperty("fuel_flowmeter_2_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_2_fail"))
defineProperty("fuel_flowmeter_3_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_3_fail"))

defineProperty("hydro_leak_1", globalPropertyi("tu-154/failures/hydro_leak_1"))
defineProperty("hydro_leak_2", globalPropertyi("tu-154/failures/hydro_leak_2"))
defineProperty("hydro_leak_3", globalPropertyi("tu-154/failures/hydro_leak_3"))
defineProperty("hydro_leak_4", globalPropertyi("tu-154/failures/hydro_leak_4"))

defineProperty("hydro_pump_fail_11", globalPropertyi("tu-154/failures/hydro_pump_fail_11"))
defineProperty("hydro_pump_fail_12", globalPropertyi("tu-154/failures/hydro_pump_fail_12"))
defineProperty("hydro_pump_fail_2", globalPropertyi("tu-154/failures/hydro_pump_fail_2"))
defineProperty("hydro_pump_fail_3", globalPropertyi("tu-154/failures/hydro_pump_fail_3"))

defineProperty("hydro_elec_fail_2", globalPropertyi("tu-154/failures/hydro_elec_fail_2"))
defineProperty("hydro_elec_fail_3", globalPropertyi("tu-154/failures/hydro_elec_fail_3"))

defineProperty("gs_qty_1", globalPropertyf("tu-154/hydro/gs_qty_1")) -- oil remaining in the system
defineProperty("gs_qty_2", globalPropertyf("tu-154/hydro/gs_qty_2")) -- oil remaining in the system
defineProperty("gs_qty_3", globalPropertyf("tu-154/hydro/gs_qty_3")) -- oil remaining in the system


defineProperty("tth_left_fail", globalPropertyi("tu-154/failures/tth_left_fail")) -- turbo-cooler failure
defineProperty("tth_right_fail", globalPropertyi("tu-154/failures/tth_right_fail")) -- turbo-cooler failure

defineProperty("airbleed_1", globalPropertyi("tu-154/failures/airbleed_1")) -- engine bleed air failure
defineProperty("airbleed_2", globalPropertyi("tu-154/failures/airbleed_2")) -- engine bleed air failure
defineProperty("airbleed_3", globalPropertyi("tu-154/failures/airbleed_3")) -- engine bleed air failure

defineProperty("psvp_fail_left", globalPropertyi("tu-154/failures/psvp_fail_left")) -- PSVP failure
defineProperty("psvp_fail_right", globalPropertyi("tu-154/failures/psvp_fail_right")) -- PSVP failure
defineProperty("sard_valve_fail", globalPropertyi("tu-154/failures/sard_valve_fail")) -- outflow valve failure

defineProperty("lan_lamp_fail_FL", globalPropertyi("tu-154/failures/lan_lamp_fail_FL")) -- front left landing light failure
defineProperty("lan_lamp_fail_FR", globalPropertyi("tu-154/failures/lan_lamp_fail_FR")) -- front right landing light failure
defineProperty("lan_lamp_fail_WL", globalPropertyi("tu-154/failures/lan_lamp_fail_WL")) -- left wing landing light failure
defineProperty("lan_lamp_fail_WR", globalPropertyi("tu-154/failures/lan_lamp_fail_WR")) -- right wing landing light failure
defineProperty("rel_lites_nav", globalPropertyi("sim/operation/failures/rel_lites_nav")) -- nav lights failure
defineProperty("rel_lites_beac", globalPropertyi("sim/operation/failures/rel_lites_beac")) -- nav lights failure

defineProperty("main_alarm_fail", globalPropertyi("tu-154/failures/main_alarm_fail")) -- siren failure
defineProperty("speaker_alarm_fail", globalPropertyi("tu-154/failures/speaker_alarm_fail")) -- siren failure

defineProperty("absu_ra56_roll_fail", globalPropertyi("tu-154/failures/absu_ra56_roll_fail")) -- RA-56 failure
defineProperty("absu_ra56_pitch_fail", globalPropertyi("tu-154/failures/absu_ra56_pitch_fail")) -- RA-56 failure
defineProperty("absu_ra56_yaw_fail", globalPropertyi("tu-154/failures/absu_ra56_yaw_fail")) -- RA-56 failure

defineProperty("absu_at1_fail", globalPropertyi("tu-154/failures/absu_at1_fail")) -- autothrottle failure
defineProperty("absu_at2_fail", globalPropertyi("tu-154/failures/absu_at2_fail")) -- autothrottle failure

defineProperty("absu_damp_roll_fail", globalPropertyi("tu-154/failures/absu_damp_roll_fail")) -- roll damper failure
defineProperty("absu_damp_pitch_fail", globalPropertyi("tu-154/failures/absu_damp_pitch_fail")) -- pitch damper failure
defineProperty("absu_damp_yaw_fail", globalPropertyi("tu-154/failures/absu_damp_yaw_fail")) -- yaw damper failure
defineProperty("absu_contr_roll_fail", globalPropertyi("tu-154/failures/absu_contr_roll_fail")) -- lateral control failure
defineProperty("absu_contr_pitch_fail", globalPropertyi("tu-154/failures/absu_contr_pitch_fail")) -- longitudinal control failure
defineProperty("absu_calc_toga_fail", globalPropertyi("tu-154/failures/absu_calc_toga_fail")) -- go-around computer failure
defineProperty("absu_calc_roll_fail", globalPropertyi("tu-154/failures/absu_calc_roll_fail")) -- STU lateral channel failure
defineProperty("absu_calc_pitch_fail", globalPropertyi("tu-154/failures/absu_calc_pitch_fail")) -- STU longitudinal channel failure


defineProperty("diss_fail", globalPropertyi("tu-154/failures/diss_fail"))
defineProperty("nvu_fail", globalPropertyi("tu-154/failures/nvu_fail"))
defineProperty("radar_fail", globalPropertyi("tu-154/failures/radar_fail"))

defineProperty("ark1_fail", globalPropertyi("sim/operation/failures/rel_adf1"))
defineProperty("ark2_fail", globalPropertyi("sim/operation/failures/rel_adf2"))
defineProperty("nav1fail", globalPropertyi("tu-154/failures/nav1_fail"))
defineProperty("nav2fail", globalPropertyi("tu-154/failures/nav2_fail"))
defineProperty("dme1_fail", globalPropertyi("tu-154/failures/dme1_fail"))
defineProperty("dme2_fail", globalPropertyi("tu-154/failures/dme2_fail"))
defineProperty("mrp_fail", globalPropertyi("tu-154/failures/mrp_fail"))

defineProperty("rsbn_fail", globalPropertyi("tu-154/failures/rsbn_fail"))
defineProperty("taws_fail", globalPropertyi("tu-154/failures/taws_fail"))

defineProperty("tks_ga1_fail", globalPropertyi("sim/operation/failures/rel_ss_dgy"))
defineProperty("tks_ga2_fail", globalPropertyi("sim/operation/failures/rel_cop_dgy"))
defineProperty("tks_km1_fail", globalPropertyi("tu-154/failures/tks_km1_fail"))
defineProperty("tks_km2_fail", globalPropertyi("tu-154/failures/tks_km2_fail"))
defineProperty("tks_bgmk1_fail", globalPropertyi("tu-154/failures/tks_bgmk1_fail"))
defineProperty("tks_bgmk2_fail", globalPropertyi("tu-154/failures/tks_bgmk2_fail"))

defineProperty("alt_1_fail", globalPropertyi("sim/operation/failures/rel_ss_alt"))
defineProperty("alt_2_fail", globalPropertyi("sim/operation/failures/rel_cop_alt"))
defineProperty("eup_fail", globalPropertyi("sim/operation/failures/rel_ss_tsi"))

defineProperty("acs1_fail", globalPropertyi("tu-154/failures/acs1_fail"))
defineProperty("acs2_fail", globalPropertyi("tu-154/failures/acs2_fail"))
defineProperty("acs3_fail", globalPropertyi("tu-154/failures/acs3_fail"))
defineProperty("agr_fail", globalPropertyi("tu-154/failures/agr_fail"))
defineProperty("bkk_fail", globalPropertyi("tu-154/failures/bkk_fail"))

defineProperty("rel_pitot", globalPropertyi("tu-154/failures/pitot1")) -- Pitot 1 - Blockage
defineProperty("rel_pitot2", globalPropertyi("tu-154/failures/pitot2")) -- Pitot 2 - Blockage
defineProperty("static_fail_L", globalPropertyi("tu-154/failures/static1"))
defineProperty("static_fail_R", globalPropertyi("tu-154/failures/static2"))
defineProperty("svs_fail", globalPropertyi("sim/operation/failures/rel_adc_comp")) -- air data computer failure


defineProperty("mgv_fail", globalPropertyi("tu-154/failures/mgv_fail")) -- MGV failure
defineProperty("pkp1fail", globalPropertyi("sim/operation/failures/rel_ss_ahz"))
defineProperty("pkp2fail", globalPropertyi("sim/operation/failures/rel_cop_ahz"))
defineProperty("rv1_fail", globalPropertyi("tu-154/failures/rv1_fail"))
defineProperty("rv2_fail", globalPropertyi("tu-154/failures/rv2_fail"))
defineProperty("uap_fail", globalPropertyi("tu-154/failures/AOA"))
defineProperty("uap_warn_fail", globalPropertyi("sim/operation/failures/rel_stall_warn"))
defineProperty("uvid_fail", globalPropertyi("tu-154/failures/uvid15_fail"))
defineProperty("vvi1_fail", globalPropertyi("sim/operation/failures/rel_ss_vvi"))
defineProperty("vvi2_fail", globalPropertyi("sim/operation/failures/rel_cop_vvi"))


-- Saved panel state. Written under the plugin's own output/ folder rather
-- than at the aircraft root, matching the An-24RV-CE (which keeps
-- an-24_settings.ini and an-24_lamps.ini there). output/ is gitignored.
local stateFileName = pluginDataDir.."/output/saved_state.ini"

local var_table = {}

-- Persisted state, in the order it is written to saved_state.ini. The keys
-- ARE the file format of every user's saved state: never rename one. A plain
-- entry is { key, property }; save/init/load convert the stored value where
-- it is not the property's own value.
local SAVED = {
	{ "rusLang", hide_eng_objects, load = function(v) set(hide_eng_objects, v); set(hide_rus_objects, 1-v) end },
	{ "volume", sounds_voulme },
	{ "starterTRQ", nil, save = function() return math.floor(get(starter_torq)*100) end, init = function() return get(starter_torq) * 100 end, load = function(v) set(starter_torq, v/100) end },
	{ "crewvo", enable_crew_vo },
	{ "hardwareCockpit", hardware_cockpit },
	{ "tankone", fuel_q_1 },
	{ "tankfour", fuel_q_4 },
	{ "tanktwoL", fuel_q_2L },
	{ "tanktwoR", fuel_q_2R },
	{ "tankthreeL", fuel_q_3L },
	{ "tankthreeR", fuel_q_3R },

	{ "enableFailures", failures_enabled },
	{ "useNWaxis", have_pedals },
	{ "gnsInstaled", show_gns },
	{ "RXPInstaled", show_RXP },
	{ "menuVisible", nil, save = function() return (menu_strip.visible and 1 or 0) end, init = function() return menu_strip.visible and 1 or 0 end, load = function(v) menu_strip.visible = (v == 1) end },

	{ "pnpCrs1", pnp_1_crs },
	{ "pnpCrs2", pnp_2_crs },

	{ "pnp1OBS", pnp_1_obs },
	{ "pnp2OBS", pnp_2_obs },

	{ "ark1ch", ark_1_channel },
	{ "ark1hunL", ark_1_hundr_left },
	{ "ark1tenL", ark_1_tens_left },
	{ "ark1oneL", ark_1_ones_left },
	{ "ark1hunR", ark_1_hundr_right },
	{ "ark1tenR", ark_1_tens_right },
	{ "ark1oneR", ark_1_ones_right },

	{ "ark2ch", ark_2_channel },
	{ "ark2hunL", ark_2_hundr_left },
	{ "ark2tenL", ark_2_tens_left },
	{ "ark2oneL", ark_2_ones_left },
	{ "ark2hunR", ark_2_hundr_right },
	{ "ark2tenR", ark_2_tens_right },
	{ "ark2oneR", ark_2_ones_right },

	{ "vdPressL", vd15_pressure_left },
	{ "vdPressR", vd15_pressure_right },
	{ "vdPressE", vd15_pressure_eng },
	{ "uvidPress", uvid_pressure_knob },

	{ "tksLatSet", nil, save = function() return get(tks_lat_set)*1000 end, init = function() return get(tks_lat_set) * 1000 end, load = function(v) set(tks_lat_set, v/1000) end },

	{ "ppd3HeatFail", ppd_3_heat_fail },

	{ "engHeat1", rel_ice_inlet_heat1 },
	{ "engHeat2", rel_ice_inlet_heat2 },
	{ "engHeat3", rel_ice_inlet_heat3 },

	{ "pitotHeatFail1", rel_ice_pitot_heat1 },
	{ "pitotHeatFail2", rel_ice_pitot_heat2 },

	{ "wingHeatFail", rel_ice_surf_heat },
	{ "slatHeatFail", rel_ice_surf_heat2 },

	{ "iceDetFail", rio_fail },

	{ "windowHeatFail1", window_heat_fail_1 },
	{ "windowHeatFail2", window_heat_fail_2 },
	{ "windowHeatFail3", window_heat_fail_3 },

	{ "apuStartFail", apu_start_fail },
	{ "apuRuntime", apu_runtime },
	{ "apuFail", apu_fail },
	{ "apuAirFail", apu_press_fail },

	{ "brakeRunLeft", nil, save = function() return get(brake_runtime_left)*1000 end, init = function() return get(brake_runtime_left) * 1000 end, load = function(v) set(brake_runtime_left, v/1000) end },
	{ "brakeRunRight", nil, save = function() return get(brake_runtime_right)*1000 end, init = function() return get(brake_runtime_right) * 1000 end, load = function(v) set(brake_runtime_right, v/1000) end },

	{ "brakeFailLeft", rel_lbrakes },
	{ "brakeFailRight", rel_rbrakes },

	{ "ailFailLeft", ail_fail_left },
	{ "ailFailRight", ail_fail_right },

	{ "spoilInnLeft", fail_spoil_inn_left },
	{ "spoilInnRight", fail_spoil_inn_right },
	{ "spoilMidLeft", fail_spoil_mid_left },
	{ "spoilMidRight", fail_spoil_mid_right },
	{ "spoilOutLeft", fail_spoil_out_left },
	{ "spoilOutRight", fail_spoil_out_right },

	{ "rudderFail", rudder_fail },
	{ "elevFailLeft", elev_fail_left },
	{ "elevFailRight", elev_fail_right },

	{ "rudtrimFail", rel_trim_rud },
	{ "ailTrimFail", rel_trim_ail },
	{ "elevTrimFail", rel_trim_elv },
	{ "elevEmergTraimFail", trim_emerg_elv_fail },

	{ "flapFailLeft", flap_fail_left },
	{ "flapFailRight", flap_fail_right },

	{ "stabEngFail", stab_eng_fail },
	{ "stabAutoFail", stab_automatic_fail },
	{ "slatFail", slats_fail },

	{ "gearRetrFail1", retract1_fail },
	{ "gearRetrFail2", retract2_fail },
	{ "gearRetrFail3", retract3_fail },
	{ "gearActFail", actuator_fail },

	{ "gen1Fail", rel_genera0 },
	{ "gen2Fail", rel_genera1 },
	{ "gen3Fail", rel_genera2 },
	{ "genApuFail", apu_gen_fail },

	{ "vu1Fail", vu1_fail },
	{ "vu2Fail", vu2_fail },
	{ "vu3Fail", vu3_fail },

	{ "tr1Fail", tr1_fail },
	{ "tr2Fail", tr2_fail },

	{ "pts1Fail", pts250_1_fail },
	{ "pts2Fail", pts250_2_fail },
	{ "inv115Fail", inv115_fail },

	{ "bat1Fail", bat_1_fail },
	{ "bat2Fail", bat_2_fail },
	{ "bat3Fail", bat_3_fail },
	{ "bat4Fail", bat_4_fail },

	{ "bat1KZ", bat_1_kz },
	{ "bat2KZ", bat_2_kz },
	{ "bat3KZ", bat_3_kz },
	{ "bat4KZ", bat_4_kz },

	{ "engFail1", rel_engfai0 },
	{ "engFail2", rel_engfai1 },
	{ "engFail3", rel_engfai2 },

	{ "engRunTime1", engine_runtime_1 },
	{ "engRunTime2", engine_runtime_2 },
	{ "engRunTime3", engine_runtime_3 },

	{ "engFuelPumpFail1", eng_fuel_pmp_fail_1 },
	{ "engFuelPumpFail2", eng_fuel_pmp_fail_2 },
	{ "engFuelPumpFail3", eng_fuel_pmp_fail_3 },

	{ "engOilQty1", engn_oil_qty_1 },
	{ "engOilQty2", engn_oil_qty_2 },
	{ "engOilQty3", engn_oil_qty_3 },

	{ "engOilLeak1", engn_oil_leak_1 },
	{ "engOilLeak2", engn_oil_leak_2 },
	{ "engOilLeak3", engn_oil_leak_3 },

	{ "engOilPumpFail1", rel_oilpmp0 },
	{ "engOilPumpFail2", rel_oilpmp1 },
	{ "engOilPumpFail3", rel_oilpmp2 },

	{ "engFuelFilterFail1", rel_eng_lo0 },
	{ "engFuelFilterFail2", rel_eng_lo1 },
	{ "engFuelFilterFail3", rel_eng_lo2 },

	{ "engStarterFail1", rel_startr0 },
	{ "engStarterFail2", rel_startr1 },
	{ "engStarterFail3", rel_startr2 },

	{ "engIgnitFail1", rel_ignitr0 },
	{ "engIgnitFail2", rel_ignitr1 },
	{ "engIgnitFail3", rel_ignitr2 },

	{ "engReversFail1", rel_revers0 },
	{ "engReversFail3", rel_revers2 },

	{ "fuelPumpFail2L", fuel_pump_2l_fail },
	{ "fuelPumpFail2R", fuel_pump_2r_fail },
	{ "fuelPumpFail3L", fuel_pump_3l_fail },
	{ "fuelPumpFail3R", fuel_pump_3r_fail },
	{ "fuelPumpFail1", fuel_pump_1_fail },
	{ "fuelPumpFail4", fuel_pump_4_fail },

	{ "fuelAutoFail", fuel_auto_fail },
	{ "fuelLvlFail", fuel_level_fail },
	{ "fuelPorcFail", fuel_porc_fail },

	{ "fuelMeterFail2L", fuel_meter_2l_fail },
	{ "fuelMeterFail2R", fuel_meter_2r_fail },
	{ "fuelMeterFail3L", fuel_meter_3l_fail },
	{ "fuelMeterFail3R", fuel_meter_3r_fail },
	{ "fuelMeterFail1", fuel_meter_1_fail },
	{ "fuelMeterFail4", fuel_meter_4_fail },
	{ "fuelMeterFailSumm", fuel_meter_summ },

	{ "FF1fail", fuel_flowmeter_1_fail },
	{ "FF2fail", fuel_flowmeter_2_fail },
	{ "FF3fail", fuel_flowmeter_3_fail },

	{ "hydroLeak1", hydro_leak_1 },
	{ "hydroLeak2", hydro_leak_2 },
	{ "hydroLeak3", hydro_leak_3 },
	{ "hydroLeak4", hydro_leak_4 },

	{ "hydroPmpFail11", hydro_pump_fail_11 },
	{ "hydroPmpFail12", hydro_pump_fail_12 },
	{ "hydroPmpFail2", hydro_pump_fail_2 },
	{ "hydroPmpFail3", hydro_pump_fail_3 },

	{ "HydroElecFail2", hydro_elec_fail_2 },
	{ "HydroElecFail3", hydro_elec_fail_3 },

	{ "hydroQty1", nil, save = function() return get(gs_qty_1)*100000 end, init = function() return get(gs_qty_1) * 100000 end, load = function(v) set(gs_qty_1, v*0.00001) end },
	{ "hydroQty2", nil, save = function() return get(gs_qty_2)*100000 end, init = function() return get(gs_qty_2) * 100000 end, load = function(v) set(gs_qty_2, v*0.00001) end },
	{ "hydroQty3", nil, save = function() return get(gs_qty_3)*100000 end, init = function() return get(gs_qty_3) * 100000 end, load = function(v) set(gs_qty_3, v*0.00001) end },

	{ "tthLeftFail", tth_left_fail },
	{ "tthRightFail", tth_right_fail },

	{ "airbleedFail1", airbleed_1 },
	{ "airbleedFail2", airbleed_2 },
	{ "airbleedFail3", airbleed_3 },

	{ "psvpFailL", psvp_fail_left },
	{ "psvpFailR", psvp_fail_right },
	{ "sardValveFail", sard_valve_fail },

	{ "lanLampFLFail", lan_lamp_fail_FL },
	{ "lanLampFRFail", lan_lamp_fail_FR },
	{ "lanLampWLFail", lan_lamp_fail_WL },
	{ "lanLampWRFail", lan_lamp_fail_WR },
	{ "navLampFail", rel_lites_nav },
	{ "beacLampFail", rel_lites_beac },

	{ "mainAlarmFail", main_alarm_fail },
	{ "spekAlarmFail", speaker_alarm_fail },

	{ "absuRArollFail", absu_ra56_roll_fail },
	{ "absuRApitchFail", absu_ra56_pitch_fail },
	{ "absuRAyawFail", absu_ra56_yaw_fail },

	{ "absuAT1Fail", absu_at1_fail },
	{ "absuAT2Fail", absu_at2_fail },

	{ "absuDampRollFail", absu_damp_roll_fail },
	{ "absuDampPitchFail", absu_damp_pitch_fail },
	{ "absuDampYawFail", absu_damp_yaw_fail },
	{ "absuContrRollFail", absu_contr_roll_fail },
	{ "absuContrPitchFail", absu_contr_pitch_fail },
	{ "absuCalcTogaFail", absu_calc_toga_fail },
	{ "absuCalcRollFail", absu_calc_roll_fail },
	{ "absuCalcPitchFail", absu_calc_pitch_fail },

	{ "dissFail", diss_fail },
	{ "nvuFail", nvu_fail },
	{ "radarFail", radar_fail },

	{ "ark1fail", ark1_fail },
	{ "ark2fail", ark2_fail },
	{ "nav1fail", nav1fail },
	{ "nav2fail", nav2fail },
	{ "dme1Fail", dme1_fail },
	{ "dme2Fail", dme2_fail },
	{ "mrpFail", mrp_fail },

	{ "tksGaFail1", tks_ga1_fail },
	{ "tksGaFail2", tks_ga2_fail },
	{ "tksKMFail1", tks_km1_fail },
	{ "tksKMFail2", tks_km2_fail },
	{ "tksBgmkFail1", tks_bgmk1_fail },
	{ "tksBgmkFail2", tks_bgmk2_fail },

	{ "rsbnFail", rsbn_fail },
	{ "tawsFail", taws_fail },

	{ "alt1fail", alt_1_fail },
	{ "alt2fail", alt_2_fail },
	{ "eupFail", eup_fail },

	{ "acs1fail", acs1_fail },
	{ "acs2fail", acs2_fail },
	{ "acs3fail", acs3_fail },
	{ "agrFail", agr_fail },
	{ "bkkFail", bkk_fail },

	{ "pitot1Fail", rel_pitot },
	{ "pitot2Fail", rel_pitot2 },
	{ "static1Fail", static_fail_L },
	{ "static2Fail", static_fail_R },
	{ "svsFail", svs_fail },

	{ "mgvFail", mgv_fail },
	{ "pkp1fail", pkp1fail },
	{ "pkp2fail", pkp2fail },
	{ "rv1fail", rv1_fail },
	{ "rv2fail", rv2_fail },
	{ "uapFail", uap_fail },
	{ "uapWarnFail", uap_warn_fail },
	{ "uvid15fail", uvid_fail },
	{ "vvi1fail", vvi1_fail },
	{ "vvi2fail", vvi2_fail },
}

	for _, e in ipairs(SAVED) do
		if e.init then var_table[e[1]] = e.init() else var_table[e[1]] = get(e[2]) end
	end
	
	
local function write_file()

	local savefile = io.open(stateFileName, "w")
	
	if savefile then
		for _, e in ipairs(SAVED) do
			local v
			if e.save then v = e.save() else v = get(e[2]) end
			savefile:write(e[1] .. "=" .. v .. "\n")
		end
		
		
		savefile:close()
	else
		logWarning("could not write " .. stateFileName)
	end
	
	
	return true

end


local function read_file()
	
	local savefile = io.open(stateFileName, "r")
	
	if savefile then
		local lines = savefile:read("*a")
		-- Parse line by line and let tonumber() decide what is a value. The old
		-- pattern was "(%w+)=(%d+)", which matches unsigned integers ONLY: a
		-- negative value (tksLatSet in the southern hemisphere) matched nothing
		-- and the key was silently dropped, and every fractional value written
		-- here (vdPress*, uvidPress, engOilQty*, apuRuntime, the tank weights)
		-- was truncated to its integer part.
		for line in string.gmatch(lines, "[^\r\n]+") do
			local k, v = string.match(line, "^%s*(%w+)%s*=%s*(%S+)%s*$")
			if k then
				local n = tonumber(v)
				if n then
					var_table[k] = n
				end
			end
		end
		for _, e in ipairs(SAVED) do
			local v = var_table[e[1]]
			if v then
				if e.load then e.load(v) else set(e[2], v) end
			end
		end
		
		
		savefile:close()
		print("reading last state: OK")
	else
		print("error reading state file")
	end
	
	
	return true
	
	
end


local start_counter = 0
local save_counter = 0
local fileReaded = false


function update()

	local passed = get(frame_time)
	start_counter = start_counter + passed
	save_counter = save_counter + passed
	

	-- read the file once after open ACF
	if start_counter > 2 and not fileReaded then
		read_file() 
		fileReaded = true
		
	end
	
	if save_counter > 30 or get(save_state) == 1 then
		write_file()
		save_counter = 0
		set(save_state, 0) -- reset saving state dataref
	end
	

end

