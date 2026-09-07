createGlobalPropertyi("tu-154/lang/hide_rus_objects", 0) -- hide the Russian cockpit objects
createGlobalPropertyi("tu-154/lang/hide_eng_objects", 1) -- hide the English cockpit objects
createGlobalPropertyi("tu-154/have_pedals", 0) -- pedals with brakes are present
createGlobalPropertyi("tu-154/sounds_voulme", 1000) -- master sound volume
createGlobalPropertyf("tu-154/elec/bat_volt_1", 25																) -- battery voltage
createGlobalPropertyf("tu-154/elec/bat_volt_2", 25																) -- battery voltage
createGlobalPropertyf("tu-154/elec/bat_volt_3", 25																) -- battery voltage
createGlobalPropertyf("tu-154/elec/bat_volt_4", 25																) -- battery voltage
createGlobalPropertyf("tu-154/elec/bat_amp_1", 0																) -- battery current
createGlobalPropertyf("tu-154/elec/bat_amp_2", 0																) -- battery current
createGlobalPropertyf("tu-154/elec/bat_amp_3", 0																) -- battery current
createGlobalPropertyf("tu-154/elec/bat_amp_4", 0																) -- battery current
createGlobalPropertyf("tu-154/elec/bat_cc_1", 0																) -- battery charge current
createGlobalPropertyf("tu-154/elec/bat_cc_2", 0																) -- battery charge current
createGlobalPropertyf("tu-154/elec/bat_cc_3", 0																) -- battery charge current
createGlobalPropertyf("tu-154/elec/bat_cc_4", 0																) -- battery charge current
createGlobalPropertyf("tu-154/elec/bat_therm_1", 20																) -- battery temperature
createGlobalPropertyf("tu-154/elec/bat_therm_2", 20																) -- battery temperature
createGlobalPropertyf("tu-154/elec/bat_therm_3", 20																) -- battery temperature
createGlobalPropertyf("tu-154/elec/bat_therm_4", 20																) -- battery temperature
createGlobalPropertyf("tu-154/elec/vu1_volt", 27																) -- rectifier unit (VU) running
createGlobalPropertyf("tu-154/elec/vu2_volt", 27																) -- rectifier unit (VU) running
createGlobalPropertyf("tu-154/elec/vu_res_volt", 27																) -- rectifier unit (VU) running
createGlobalPropertyf("tu-154/elec/vu1_amp", 0																) -- VU current
createGlobalPropertyf("tu-154/elec/vu2_amp", 0																) -- VU current
createGlobalPropertyf("tu-154/elec/vu_res_amp", 0																) -- VU current
createGlobalPropertyi("tu-154/elec/vu_res_to_L", 0																) -- standby VU connected to the left bus
createGlobalPropertyi("tu-154/elec/vu_res_to_R", 0																) -- standby VU connected to the right bus
createGlobalPropertyf("tu-154/elec/bus27_volt_left", 27																) -- left 27 V bus voltage
createGlobalPropertyf("tu-154/elec/bus27_amp_left", 27																) -- left 27 V bus voltage
createGlobalPropertyf("tu-154/elec/bus27_amp_right", 0																) -- right 27 V bus current
createGlobalPropertyf("tu-154/elec/bus27_volt_right", 0																) -- right 27 V bus current
createGlobalPropertyi("tu-154/elec/bus27_source_left", 1																) -- left bus power source. 0 - nothing. 1 - VU1, 2 - VU standby, 3 - batteries 1 and 3, 4 - bat 1, 5 - bat 2
createGlobalPropertyi("tu-154/elec/bus27_source_right", 0																) -- right bus power source. 0 - nothing. 1 - VU2, 2 - VU standby, 3 - batteries 1 and 3, 4 - bat 1, 5 - bat 2
createGlobalPropertyi("tu-154/elec/bat_is_source_1", 1																) -- battery is the power source
createGlobalPropertyi("tu-154/elec/bat_is_source_2", 1																) -- battery is the power source
createGlobalPropertyi("tu-154/elec/bat_is_source_3", 1																) -- battery is the power source
createGlobalPropertyi("tu-154/elec/bat_is_source_4", 1																) -- battery is the power source
createGlobalPropertyi("tu-154/elec/bus_connected", 0																) -- buses tied
createGlobalPropertyf("tu-154/elec/bus36_volt_left", 36																) -- left 36 V bus voltage
createGlobalPropertyf("tu-154/elec/bus36_volt_right", 36																) -- right 36 V bus voltage
createGlobalPropertyf("tu-154/elec/bus36_volt_pts250_1", 36																) -- 36 V bus voltage, PTS 1
createGlobalPropertyf("tu-154/elec/bus36_volt_pts250_2", 36																) -- 36 V bus voltage, PTS 2
createGlobalPropertyf("tu-154/elec/bus36_amp_left", 0																) -- left 36 V bus current
createGlobalPropertyf("tu-154/elec/bus36_amp_right", 0																) -- right 36 V bus current
createGlobalPropertyf("tu-154/elec/bus36_amp_pts250_1", 0																) -- PTS250 current, 36 V bus 1
createGlobalPropertyf("tu-154/elec/bus36_amp_pts250_2", 0																) -- PTS250 current, 36 V bus 2
createGlobalPropertyi("tu-154/elec/bus36_tr1_work", 1																) -- transformer 1 running
createGlobalPropertyi("tu-154/elec/bus36_tr2_work", 1																) -- transformer 2 running
createGlobalPropertyi("tu-154/elec/bus36_pts1_work", 1																) -- PTS250 1 running
createGlobalPropertyi("tu-154/elec/bus36_pts2_work", 0																) -- PTS250 2 running
createGlobalPropertyi("tu-154/elec/bus36_src_L", 0																) -- left bus source. 0 = TR1, 1 = TR2
createGlobalPropertyi("tu-154/elec/bus36_src_R", 0																) -- right bus source. 0 = TR2, 1 = TR1
createGlobalPropertyi("tu-154/elec/gen1_work", 1																) -- generator 1 running
createGlobalPropertyi("tu-154/elec/gen2_work", 1																) -- generator 2 running
createGlobalPropertyi("tu-154/elec/gen3_work", 1																) -- generator 3 running
createGlobalPropertyi("tu-154/elec/gen4_work", 0																) -- APU generator running
createGlobalPropertyi("tu-154/elec/gpu_work", 0																) -- RAP running
createGlobalPropertyi("tu-154/elec/gen1_overload", 0																) -- generator 1 overload
createGlobalPropertyi("tu-154/elec/gen2_overload", 0																) -- generator 2 overload
createGlobalPropertyi("tu-154/elec/gen3_overload", 0																) -- generator 3 overload
createGlobalPropertyi("tu-154/elec/gen4_overload", 0																) -- APU generator running
createGlobalPropertyi("tu-154/elec/gpu_overload", 0																) -- RAP overload
createGlobalPropertyf("tu-154/elec/gen1_volt", 115																) -- generator voltage
createGlobalPropertyf("tu-154/elec/gen2_volt", 115																) -- generator voltage
createGlobalPropertyf("tu-154/elec/gen3_volt", 115																) -- generator voltage
createGlobalPropertyf("tu-154/elec/gen4_volt", 115																) -- generator voltage
createGlobalPropertyf("tu-154/elec/gpu_volt", 115																) -- generator voltage
createGlobalPropertyf("tu-154/elec/bus115_1_volt", 115																) -- 115 V bus voltage
createGlobalPropertyf("tu-154/elec/bus115_2_volt", 115																) -- 115 V bus voltage
createGlobalPropertyf("tu-154/elec/bus115_3_volt", 115																) -- 115 V bus voltage
createGlobalPropertyf("tu-154/elec/bus115_em_1_volt", 115																) -- emergency 115 V bus voltage
createGlobalPropertyf("tu-154/elec/bus115_em_2_volt", 115																) -- emergency 115 V bus voltage
createGlobalPropertyf("tu-154/elec/bus115_1_amp", 0																) -- 115 V bus current
createGlobalPropertyf("tu-154/elec/bus115_2_amp", 0																) -- 115 V bus current
createGlobalPropertyf("tu-154/elec/bus115_3_amp", 0																) -- 115 V bus current
createGlobalPropertyf("tu-154/elec/bus115_em_1_amp", 0																) -- 115 V bus current
createGlobalPropertyf("tu-154/elec/bus115_em_2_amp", 0																) -- 115 V bus current
createGlobalPropertyf("tu-154/elec/bus115_freq", 0																) -- 115 V bus current
createGlobalPropertyf("tu-154/elec/gen1_amp", 0																) -- generator load
createGlobalPropertyf("tu-154/elec/gen2_amp", 0																) -- generator load
createGlobalPropertyf("tu-154/elec/gen3_amp", 0																) -- generator load
createGlobalPropertyf("tu-154/elec/gen4_amp", 0																) -- generator load
createGlobalPropertyf("tu-154/elec/gpu_amp", 0																) -- generator load
createGlobalPropertyf("tu-154/thermo/cockpit_temp", 20																) -- cabin temperature
createGlobalPropertyf("tu-154/thermo/cabin1_temp", 20																) -- cabin 1 temperature
createGlobalPropertyf("tu-154/thermo/cabin2_temp", 20																) -- cabin 2 temperature
createGlobalPropertyf("tu-154/elec/apu_start_bus", 27																) -- APU bus voltage
createGlobalPropertyf("tu-154/elec/apu_start_cc", 0																) -- APU starter current
createGlobalPropertyi("tu-154/elec/apu_start_seq", 0																) -- APU start in progress
createGlobalPropertyf("tu-154/elec/apu_burning_fuel", 0																) -- APU starter current
createGlobalPropertyf("tu-154/elec/cockpit_light_cc_left", 0																) -- left bus load from the cockpit lighting
createGlobalPropertyf("tu-154/elec/cockpit_light_cc_right", 0																) -- right bus load from the cockpit lighting
createGlobalPropertyf("tu-154/elec/cockpit_light_cc_115", 0																) -- 115 V bus load from the cockpit lighting
createGlobalPropertyf("tu-154/elec/ext_light_cc_left", 0																) -- left bus load from the exterior lighting
createGlobalPropertyf("tu-154/elec/ext_light_cc_right", 0																) -- left bus load from the exterior lighting
createGlobalPropertyf("tu-154/elec/ext_light_cc_115", 0																) -- left bus load from the exterior lighting
createGlobalPropertyf("tu-154/eng/apu_n1", 0																) -- APU rpm
createGlobalPropertyf("tu-154/eng/apu_oil_t", 0																) -- APU oil temperature
createGlobalPropertyf("tu-154/eng/apu_oil_q", 0																) -- APU oil quantity
createGlobalPropertyf("tu-154/eng/apu_oil_p", 0																) -- APU oil pressure
createGlobalPropertyf("tu-154/eng/apu_fuel_p", 0																) -- APU fuel pressure
createGlobalPropertyf("tu-154/eng/apu_egt", 0																) -- APU exhaust gas temperature
createGlobalPropertyf("tu-154/eng/apu_air_press", 0																) -- air pressure for engine start
createGlobalPropertyf("tu-154/eng/apu_air_doors", 0																) -- air inflation door position
createGlobalPropertyi("tu-154/eng/apu_system_on", 0																) -- APU system on
createGlobalPropertyf("tu-154/eng/apu_fuel_last", 0 ) -- APU residual fuel in the combustion chamber, 0..1.2
createGlobalPropertyi("tu-154/eng/apu_start_phase", 0 ) -- APU start phase. 0 none, 1 cold crank, 2 starter, 3 combustion, 4 overshoot, 5 warm-up, 6 running
createGlobalPropertyf("tu-154/eng/apu_cooldown", 0 ) -- APU cooldown interval timer, seconds

-- APU ground heater (systems/apu/apu_heater.lua). Declared here rather than in
-- that module so they exist before apu_logic.lua binds apu_heater/active.
createGlobalPropertyi("tu-154/apu_heater/on", 0 ) -- ground heater on/off
createGlobalPropertyf("tu-154/apu_heater/target_t", 30 ) -- ground heater target oil temperature, C
createGlobalPropertyi("tu-154/apu_heater/active", 0 ) -- ground heater is actually heating right now
createGlobalPropertyf("tu-154/eng/vibration_1", 0																) -- engine vibration
createGlobalPropertyf("tu-154/eng/vibration_2", 0																) -- engine vibration
createGlobalPropertyf("tu-154/eng/vibration_3", 0																) -- engine vibration
createGlobalPropertyi("tu-154/fuel/eng_fuel_press_1", 1																) -- fuel can reach the engine. ignores the shutoff cocks
createGlobalPropertyi("tu-154/fuel/eng_fuel_press_2", 1																) -- fuel can reach the engine. ignores the shutoff cocks
createGlobalPropertyi("tu-154/fuel/eng_fuel_press_3", 1																) -- fuel can reach the engine. ignores the shutoff cocks
createGlobalPropertyi("tu-154/fuel/pump_tank2_left_work1", 1																) -- tank 2 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank2_right_work1", 1																) -- tank 2 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank2_left_work2", 1																) -- tank 2 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank2_right_work2", 1																) -- tank 2 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank3_left_work1", 1																) -- tank 3 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank3_right_work1", 1																) -- tank 3 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank3_left_work2", 1																) -- tank 3 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank3_right_work2", 1																) -- tank 3 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank3_left_work3", 1																) -- tank 3 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank3_right_work3", 1																) -- tank 3 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank4_work1", 1																) -- tank 4 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank4_work2", 1																) -- tank 4 pumps
-- Aggregate pump state per tank: the number of pumps running with that tank's
-- failures already subtracted, which the numbered datarefs above do not carry.
-- Written by fuel/fuel_pumps.lua, read by powerplant/engines_panel.lua.
createGlobalPropertyi("tu-154/fuel/pump_tank2_left_work", 2 ) -- tank 2 pumps running, left
createGlobalPropertyi("tu-154/fuel/pump_tank2_right_work", 2 ) -- tank 2 pumps running, right
createGlobalPropertyi("tu-154/fuel/pump_tank3_left_work", 3 ) -- tank 3 pumps running, left
createGlobalPropertyi("tu-154/fuel/pump_tank3_right_work", 3 ) -- tank 3 pumps running, right
createGlobalPropertyi("tu-154/fuel/pump_tank4_work", 2 ) -- tank 4 pumps running
createGlobalPropertyi("tu-154/fuel/pump_tank1_1_work", 1																) -- tank 1 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank1_2_work", 1																) -- tank 1 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank1_3_work", 1																) -- tank 1 pumps
createGlobalPropertyi("tu-154/fuel/pump_tank1_4_work", 1																) -- tank 1 pumps
createGlobalPropertyi("tu-154/fuel/reserv_trans", 0																) -- standby transfer on
createGlobalPropertyi("tu-154/fuel/auto_tanks_turn", 0																) -- the tanks in the current usage order. 0, 1 - not working, 2, 3, 4
createGlobalPropertyi("tu-154/fuel/auto_tank_level_2", 0) -- balancing in tanks 2. -1 = L, 0 = none, +1 = R
createGlobalPropertyi("tu-154/fuel/auto_tank_level_3", 0															) -- balancing in tanks 3. -1 = L, 0 = none, +1 = R
createGlobalPropertyf("tu-154/fuel/fire_vlv_open_1", 1																) -- fire shutoff valve open
createGlobalPropertyf("tu-154/fuel/fire_vlv_open_2", 1																) -- fire shutoff valve open
createGlobalPropertyf("tu-154/fuel/fire_vlv_open_3", 1																) -- fire shutoff valve open
createGlobalPropertyf("tu-154/elec/fuel_pumps_115_1_cc", 0																) -- bus 1 load from the fuel pumps
createGlobalPropertyf("tu-154/elec/fuel_pumps_115_3_cc", 0																) -- bus 3 load from the fuel pumps
createGlobalPropertyf("tu-154/elec/fuel_pumps_27_cc", 0																) -- 27 V bus load from the fuel pumps
createGlobalPropertyf("tu-154/hydro/gs_press_1", 0																) -- hydraulic system 1 pressure
createGlobalPropertyf("tu-154/hydro/gs_press_2", 0																) -- hydraulic system 2 pressure
createGlobalPropertyf("tu-154/hydro/gs_press_3", 0																) -- hydraulic system 3 pressure
createGlobalPropertyf("tu-154/hydro/gs_press_4", 0																) -- pressure in the emergency brake system
createGlobalPropertyf("tu-154/hydro/gs_qty_1", 55																) -- oil remaining in the system
createGlobalPropertyf("tu-154/hydro/gs_qty_2", 55																) -- oil remaining in the system
createGlobalPropertyf("tu-154/hydro/gs_qty_3", 49																) -- oil remaining in the system
createGlobalPropertyf("tu-154/hydro/gs_qty_12_show", 48																) -- fluid remaining in the hydraulic tank
createGlobalPropertyf("tu-154/hydro/gs_qty_3_show", 24																) -- fluid remaining in the hydraulic tank
createGlobalPropertyf("tu-154/hydro/gs_pump_2_cc", 0																) -- pump station current
createGlobalPropertyf("tu-154/hydro/gs_pump_3_cc", 0																) -- pump station current
createGlobalPropertyf("tu-154/hydro/gs_bak_qty_1", 17.17																) -- oil remaining in the tank
createGlobalPropertyf("tu-154/hydro/gs_bak_qty_2", 17.17																) -- oil remaining in the tank
createGlobalPropertyf("tu-154/hydro/gs_bak_qty_3", 23.8																) -- oil remaining in the tank
createGlobalPropertyf("tu-154/bleed/air_usage_L", 0																) -- left air flow
createGlobalPropertyf("tu-154/bleed/air_usage_R", 0																) -- left air flow
createGlobalPropertyf("tu-154/bleed/eng_airvalve_1", 1																) -- engine bleed air valve opening
createGlobalPropertyf("tu-154/bleed/eng_airvalve_2", 1																) -- engine bleed air valve opening
createGlobalPropertyf("tu-154/bleed/eng_airvalve_3", 1																) -- engine bleed air valve opening
createGlobalPropertyf("tu-154/bleed/hot_tube_t", 100																) -- hot air temperature in the duct
createGlobalPropertyf("tu-154/bleed/door_heat_tube_t", 80																) -- temperature in the door heating duct
createGlobalPropertyf("tu-154/bleed/cockpit_tube_t", 30																) -- temperature in the duct to the cockpit
createGlobalPropertyf("tu-154/bleed/cabin1_tube_t", 30																) -- temperature in the duct to cabin 1
createGlobalPropertyf("tu-154/bleed/cabin2_tube_t", 30																) -- temperature in the duct to cabin 2
createGlobalPropertyf("tu-154/bleed/cold_tube1_t", 30																) -- duct temperature 1
createGlobalPropertyf("tu-154/bleed/cold_tube2_t", 30																) -- duct temperature 2
createGlobalPropertyf("tu-154/bleed/cockpit_temp", 20																) -- cabin temperature
createGlobalPropertyf("tu-154/bleed/cabin_1_temp", 20																) -- cabin 1 temperature
createGlobalPropertyf("tu-154/bleed/cabin_2_temp", 20																) -- cabin 2 temperature
createGlobalPropertyf("tu-154/start/starter_pressure", 0																) -- pressure in the start system
createGlobalPropertyi("tu-154/start/apd_working_1", 0																) -- APD system running
createGlobalPropertyi("tu-154/start/apd_working_2", 0																) -- APD system running
createGlobalPropertyi("tu-154/start/apd_working_3", 0																) -- APD system running
createGlobalPropertyi("tu-154/start/start_sys_work", 0																) -- start system running
createGlobalPropertyi("tu-154/start/fuel_in_1", 1																) -- fuel supply from the start system
createGlobalPropertyi("tu-154/start/fuel_in_2", 1																) -- fuel supply from the start system
createGlobalPropertyi("tu-154/start/fuel_in_3", 1																) -- fuel supply from the start system
createGlobalPropertyf("tu-154/trimmers/int_pitch_trim", 0																) -- elevator trim position
createGlobalPropertyf("tu-154/trimmers/int_roll_trim", 0																) -- aileron trim position
createGlobalPropertyf("tu-154/trimmers/int_yaw_trim", 0																) -- rudder trim position
createGlobalPropertyf("tu-154/controls/control_force_pos", 0) -- elevator feel unit position. 0 - disconnected, 1 - connected
createGlobalPropertyf("tu-154/controls/control_force_pos_rud", 0																	) -- rudder feel unit position. 0 - disconnected, 1 - connected
createGlobalPropertyi("tu-154/fire/ext_used_1", 0																) -- extinguisher used
createGlobalPropertyi("tu-154/fire/ext_used_2", 0																) -- extinguisher used
createGlobalPropertyi("tu-154/fire/ext_used_3", 0																) -- extinguisher used
createGlobalPropertyi("tu-154/fire/ng_used", 0																) -- neutral gas used
createGlobalPropertyi("tu-154/fire/valve_open_1", 0																) -- engine 1 extinguishing valve
createGlobalPropertyi("tu-154/fire/valve_open_2", 0																) -- engine 2 extinguishing valve
createGlobalPropertyi("tu-154/fire/valve_open_3", 0																) -- engine 3 extinguishing valve
createGlobalPropertyi("tu-154/fire/valve_open_4", 0																) -- APU extinguishing valve
createGlobalPropertyi("tu-154/fire/fire_siren", 0																) -- fire siren running
createGlobalPropertyi("tu-154/fire/engine_fire_state_1", 0																) -- engine state. 0 = normal, 1 = overheat, 2 = fire
createGlobalPropertyi("tu-154/fire/engine_fire_state_2", 0																) -- engine state. 0 = normal, 1 = overheat, 2 = fire
createGlobalPropertyi("tu-154/fire/engine_fire_state_3", 0																) -- engine state. 0 = normal, 1 = overheat, 2 = fire
createGlobalPropertyi("tu-154/fire/engine_fire_state_4", 0																) -- APU state. 0 - normal, 1 - overheat, 2 - fire
createGlobalPropertyi("tu-154/fire/engine_fuel_cut_1", 0																) -- fuel shut off
createGlobalPropertyi("tu-154/fire/engine_fuel_cut_2", 0																) -- fuel shut off
createGlobalPropertyi("tu-154/fire/engine_fuel_cut_3", 0																) -- fuel shut off
createGlobalPropertyi("tu-154/fire/fire_detected", 0																) -- fire detected
createGlobalPropertyf("tu-154/fire/fire_sys_cc", 0																) -- system current draw
createGlobalPropertyf("tu-154/antiice/wing_heat_t", 15																) -- wing anti-ice temperature
createGlobalPropertyf("tu-154/antiice/stab_heat_t", 15																) -- stabiliser anti-ice temperature
createGlobalPropertyi("tu-154/antiice/ice_detected", 0																) -- ice detected
createGlobalPropertyi("tu-154/antiice/ice_detect_ok", 0																) -- SOI system running
createGlobalPropertyi("tu-154/antiice/wing_heating", 1																) -- wing heating running
createGlobalPropertyi("tu-154/antiice/slat_heating", 1																) -- wing heating running
createGlobalPropertyf("tu-154/antiice/ai_27_L_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/antiice/ai_27_R_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/antiice/ai_115_1_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/antiice/ai_115_2_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/antiice/ai_115_3_cc", 0) -- bus load
createGlobalPropertyi("tu-154/antiice/eng_heat_open_1", 0) -- engine heating flap open
createGlobalPropertyi("tu-154/antiice/eng_heat_open_2", 0) -- engine heating flap open
createGlobalPropertyi("tu-154/antiice/eng_heat_open_3", 0															) -- engine heating flap open
createGlobalPropertyi("tu-154/msrp/msrp_power", 1																) -- MSRP power for the clock indicator
createGlobalPropertyi("tu-154/msrp/msrp_recording", 1																) -- MSRP power for the clock indicator
createGlobalPropertyf("tu-154/msrp/msrp_27_L_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/msrp/msrp_27_R_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/control/ctr_27_L_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/control/ctr_27_R_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/control/ctr_115_1_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/control/ctr_115_2_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/control/ctr_115_3_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/control/ctr_36L_cc", 0																) -- bus load
createGlobalPropertyf("tu-154/control/ctr_36R_cc", 0																) -- bus load
createGlobalPropertyi("tu-154/auasp/alpha_critical", 0																) -- signal from the AUASP on critical AoA
createGlobalPropertyi("tu-154/auasp/gforce_critical", 0																) -- signal from the AUASP on critical g
createGlobalPropertyf("tu-154/gyro/mgv_contr_roll", 0																) -- bank of the monitoring gyro
createGlobalPropertyf("tu-154/gyro/mgv_contr_pitch", 0																) -- pitch of the monitoring gyro
createGlobalPropertyi("tu-154/gyro/mgv_contr_flag", 0																) -- MGV monitor failure flag
createGlobalPropertyi("tu-154/bkk/left_roll_big", 0																) -- signal from the BKK - left bank excessive
createGlobalPropertyi("tu-154/bkk/right_roll_big", 0																) -- signal from the BKK - right bank excessive
createGlobalPropertyi("tu-154/bkk/mgv_contr_fail", 0																) -- signal from the BKK: control MGV failure
createGlobalPropertyi("tu-154/bkk/no_contr_ag", 0																) -- signal from the BKK - no AG monitoring
createGlobalPropertyi("tu-154/bkk/pkp_fail_left", 0																) -- signal from the BKK: left PKP failure
createGlobalPropertyi("tu-154/bkk/pkp_fail_right", 0																) -- signal from the BKK: left PKP failure
createGlobalPropertyf("tu-154/bkk/pkp_roll_left", 0																) -- bank on the left MGV
createGlobalPropertyf("tu-154/bkk/pkp_roll_right", 0																) -- bank on the right MGV
createGlobalPropertyf("tu-154/bkk/pkp_left_power_cc", 0																) -- PKP current draw
createGlobalPropertyf("tu-154/bkk/pkp_right_power_cc", 0																) -- PKP current draw
createGlobalPropertyf("tu-154/bkk/mgv_ctr_power_cc", 0																) -- PKP current draw
createGlobalPropertyf("tu-154/gyro/ahz_pitch_int_L", 0) -- pitch on the left gyro
createGlobalPropertyf("tu-154/gyro/ahz_pitch_int_R", 0																		) -- pitch on the right gyro
createGlobalPropertyi("tu-154/tcas/range_set", 3																) -- display range. 0 = 3, 1 = 5, 2 = 10, 3 = 15 nm
createGlobalPropertyi("tu-154/tcas/mode_set", 4																) -- TCAS mode. -1 = test, 0 - stby, 1 = alt off, 2 = alt on, 3 = TA, 4 = TARA
createGlobalPropertyi("tu-154/tcas/screen_mode", 0																) -- display mode on the screen.  -1 = error, 0 = transponder code, 1 = above mode, 2 = FL mode, 3 = FLT ID, 4 = PLN BIT, 5 = test, 6 = range set, 11-14 = code set, 100 = no power
createGlobalPropertyi("tu-154/tcas/level_mode", 0																) -- 1 = above, 0 = normal, -1 = below
createGlobalPropertyi("tu-154/tcas/fl_mode", 0																) -- fl mode. 0 = absolute, 1 = relative
createGlobalPropertyi("tu-154/tcas/flt_id", 0																) -- flight ID. 0 = cover, 1 = show / change code
createGlobalPropertyi("tu-154/tcas/ra_scale_set", 0																) -- RA mode scale set. 0 = none.
createGlobalPropertyi("tu-154/tcas/traffic_det", 0																) -- yellow or red targets appear
createGlobalPropertyf("tu-154/svs/altitude", 0																) -- altitude supplied by the SVS
createGlobalPropertyf("tu-154/svs/machno", 0																) -- mach number supplied by the SVS
createGlobalPropertyf("tu-154/svs/true_airspeed", 0																) -- TAS supplied by the SVS
createGlobalPropertyf("tu-154/svs/power_27cc", 0																) -- current drawn by the SVS
createGlobalPropertyf("tu-154/svs/power_36cc", 0																) -- current drawn by the SVS
createGlobalPropertyf("tu-154/svs/power_115cc", 0																) -- current drawn by the SVS
createGlobalPropertyf("tu-154/elec/auasp_pow27_cc", 0																) -- current drawn by the AUASP
createGlobalPropertyf("tu-154/elec/auasp_pow115_cc", 0																) -- current drawn by the AUASP
createGlobalPropertyf("tu-154/elec/rv5_left_cc", 0																) -- current drawn by the RV-5
createGlobalPropertyf("tu-154/elec/rv5_right_cc", 0																) -- current drawn by the RV-5
createGlobalPropertyf("tu-154/misc/rv5_alt_left", 0																) -- altitude on the left altimeter
createGlobalPropertyf("tu-154/misc/rv5_alt_right", 0) -- altitude on the right altimeter
createGlobalPropertyi("tu-154/misc/rv5_dh_signal_left", 0																) -- DH signal
createGlobalPropertyi("tu-154/misc/rv5_dh_signal_right", 0																) -- DH signal
createGlobalPropertyi("tu-154/taws/mode_set", 1																) -- screen mode. 0 = off, 1 = terrain map, 2 = side view, 3 = clock, 4 = power-up sequence
createGlobalPropertyi("tu-154/taws/distance_set", 0																) -- map drawing range, km. 0 = 10, 1 = 20, 2 = 40, 3 = 80, 4 = 160, 5 = 320, 6 = 640
createGlobalPropertyf("tu-154/taws/taws_cc", 0																) -- current draw of the SRPBZ system
createGlobalPropertyi("tu-154/taws/taws_message", 0																) -- SRPBZ messages. 0 - none, 1 - Pull UP, 2 - alt callout, 3 - Pull Up, 4 - Terrain, 5 - Terrain Ahead, 6 - Too low, Terrain, 7 - Alt collout, 8 - Too low, Gear, 9 - Too low, Flaps, 10 - Check altitude, 11 - Sink Rate, 12 - Don't sink, 13 - Glideslope
createGlobalPropertyi("tu-154/taws/taws_english", 0																) -- system language. 0 - Russian, 1 - English
createGlobalPropertyf("tu-154/taws/gs_msg_int", 5																) -- GLIDESLOPE alert interval
createGlobalPropertyf("tu-154/taws/gs_msg_vol", 1																) -- GLIDESLOPE alert volume
createGlobalPropertyi("tu-154/taws/taws_alt_left", 0																) -- compare the altitude on the left altimeter
createGlobalPropertyi("tu-154/taws/taws_alt_right", 0																) -- compare the altitude on the right altimeter
createGlobalPropertyf("tu-154/tks/course_mk_1", 0																) -- heading on MK5
createGlobalPropertyf("tu-154/tks/course_mk_2", 0																) -- heading on MK5
createGlobalPropertyf("tu-154/tks/course_ga_1", 0																) -- heading on GA1
createGlobalPropertyf("tu-154/tks/course_ga_2", 0																) -- heading on GA1
createGlobalPropertyf("tu-154/tks/course_bgmk_1", 0																) -- heading on BGMK1
createGlobalPropertyf("tu-154/tks/course_bgmk_2", 0																) -- heading on BGMK1
createGlobalPropertyf("tu-154/tks/course_gpk", 0																) -- resulting TKS heading - GPK
createGlobalPropertyf("tu-154/tks/course_gmk", 0																) -- resulting TKS heading - GMK
createGlobalPropertyi("tu-154/tks/fail_left", 0																) -- failure flag
createGlobalPropertyi("tu-154/tks/fail_right", 0																) -- failure flag
createGlobalPropertyf("tu-154/nvu/diss_wind_course", 0																) -- wind direction from the DISS
createGlobalPropertyf("tu-154/nvu/diss_wind_spd", 0																) -- wind speed from the DISS
createGlobalPropertyf("tu-154/nvu/diss_groundspeed", 0																) -- ground speed from the DISS
createGlobalPropertyf("tu-154/nvu/diss_slip_angle", 0																) -- drift angle from the DISS
createGlobalPropertyi("tu-154/nvu/diss_mode", 1																) -- DISS mode. 0 - off, 1 - operate, 2 - memory
createGlobalPropertyf("tu-154/rsbn/distance", 0																) -- slant range from the beacon
createGlobalPropertyf("tu-154/rsbn/azimuth", 0																) -- azimuth from the beacon
createGlobalPropertyf("tu-154/radio/adf_bear_1", 0																) -- bearing to the ADF beacon
createGlobalPropertyf("tu-154/radio/adf_bear_2", 0																) -- bearing to the ADF beacon
createGlobalPropertyf("tu-154/radio/vor_bear_1", 0																) -- bearing to the VOR beacon
createGlobalPropertyf("tu-154/radio/vor_bear_2", 0																) -- bearing to the VOR beacon
createGlobalPropertyf("tu-154/radio/vor_dme_1", 0																) -- distance to the VOR
createGlobalPropertyf("tu-154/radio/vor_dme_2", 0																) -- distance to the VOR
createGlobalPropertyf("tu-154/radio/nav1_cs", 0																) -- course bar deflection
createGlobalPropertyf("tu-154/radio/nav1_gs", 0																) -- glideslope bar deflection
createGlobalPropertyf("tu-154/radio/nav2_cs", 0																) -- course bar deflection
createGlobalPropertyf("tu-154/radio/nav2_gs", 0																) -- glideslope bar deflection
createGlobalPropertyi("tu-154/radio/nav1_cs_flag", 0																) -- course flag
createGlobalPropertyi("tu-154/radio/nav2_cs_flag", 0																) -- course flag
createGlobalPropertyi("tu-154/radio/nav1_gs_flag", 0																) -- glideslope flag
createGlobalPropertyi("tu-154/radio/nav2_gs_flag", 0																) -- glideslope flag
createGlobalPropertyf("tu-154/nvu/current_Z1", 0																) -- Z1
createGlobalPropertyf("tu-154/nvu/current_S1", 0																) -- S1
createGlobalPropertyf("tu-154/nvu/next_Z1", 0																) -- Z1
createGlobalPropertyf("tu-154/nvu/next_S1", 0																) -- S1
createGlobalPropertyf("tu-154/nvu/current_Z2", 0																) -- Z2
createGlobalPropertyf("tu-154/nvu/current_S2", 0																) -- S2
createGlobalPropertyf("tu-154/nvu/next_Z2", 0																) -- Z2
createGlobalPropertyf("tu-154/nvu/next_S2", 0																) -- S2
createGlobalPropertyf("tu-154/nvu/zpu1", 0																) -- Z2
createGlobalPropertyf("tu-154/nvu/zpu2", 0																) -- S2
createGlobalPropertyi("tu-154/nvu/nvu_mode", 1																) -- NVU mode. 0 = off, 1 = ready, 2 = dead reckoning, 3 = correction
createGlobalPropertyi("tu-154/nvu/nvu_active", 1																) -- active NVU set. 1 - 2
createGlobalPropertyf("tu-154/nvu/nvu_res_course", 0																) -- flight heading from the NVU
createGlobalPropertyf("tu-154/nvu/nvu_res_z", 0																) -- offset from the NVU flight track
createGlobalPropertyi("tu-154/nvu/nvu_changing_ort", 0																) -- CHO change
createGlobalPropertyi("tu-154/nvu/nvu_fail", 0																) -- failure or not enough systems for the NVU
createGlobalPropertyi("tu-154/absu/roll_main_mode", 1																) -- ABSU main roll mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
createGlobalPropertyi("tu-154/absu/pitch_main_mode", 1																) -- ABSU main pitch mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
createGlobalPropertyi("tu-154/absu/roll_sub_mode", 0																) -- ABSU roll mode. 0 - off, 1 - stab, 2 - ZK, 3 - NVU, 4 - AZ1, 5 - AZ2, 6 - approach
createGlobalPropertyi("tu-154/absu/pitch_sub_mode", 0																) -- ABSU pitch mode. 0 - off, 1 - stab, 2 - V, 3 - M, 4 - H, 5 - glideslope, 6 - go-around
createGlobalPropertyf("tu-154/absu/contr_pitch", 0																) -- RA-56 pitch actuator rod travel
createGlobalPropertyf("tu-154/absu/contr_roll", 0																) -- RA-56 roll actuator rod travel
createGlobalPropertyf("tu-154/absu/contr_yaw", 0																) -- RA-56 yaw actuator rod travel
createGlobalPropertyf("tu-154/bkk/bkk_pitch", 0																) -- resulting pitch from the BKK
createGlobalPropertyf("tu-154/bkk/bkk_roll", 0																) -- resulting bank from the BKK
createGlobalPropertyi("tu-154/absu/absu_pitch_trimm", 0																) -- trim command from the ABSU. +1 = up, -1 = down
createGlobalPropertyf("tu-154/absu/rud_1_spd", 0																) -- lever movement rate
createGlobalPropertyf("tu-154/absu/rud_2_spd", 0																) -- lever movement rate
createGlobalPropertyf("tu-154/absu/rud_3_spd", 0																) -- lever movement rate
createGlobalPropertyf("tu-154/absu/absu_roll_ind", 0																) -- roll director indication
createGlobalPropertyf("tu-154/absu/absu_pitch_ind", 0																) -- pitch director indication
createGlobalPropertyi("tu-154/absu/absu_roll_flag", 1																) -- roll director flag
createGlobalPropertyi("tu-154/absu/absu_pitch_flag", 1																) -- pitch director flag
createGlobalPropertyi("tu-154/absu/absu_pnp_mode_1", 0																) -- PNP display mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = landing system
createGlobalPropertyi("tu-154/absu/absu_pnp_mode_2", 0																) -- PNP display mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = landing system
createGlobalPropertyi("tu-154/absu/stu_mode", 0) -- autothrottle modes. 0 = off, 1 = on, 2 = armed, 3 = stabilisation, 4 = go-around
createGlobalPropertyi("tu-154/absu/toga_comm", 0																) -- GO-AROUND mode
createGlobalPropertyf("tu-154/absu_at_dif_left", 0																) -- speed difference for the PKP indication
createGlobalPropertyf("tu-154/absu_at_dif_right", 0																) -- speed difference for the PKP indication
createGlobalPropertyi("tu-154/absu_course_out", 0																) -- flying outside the course limits
createGlobalPropertyi("tu-154/absu_gs_out", 0																) -- flying outside the glideslope limits
createGlobalPropertyf("tu-154/absu_power_cc", 0	) -- ABSU current draw
createGlobalPropertyf("tu-154/absu_at_power_cc", 0) -- ABSU current draw
createGlobalPropertyi("tu-154/absu_use_second_nav", 0) -- the ABSU switched to the second KursMP
createGlobalPropertyi("tu-154/absu/damp_roll_lamp", 0) -- signal to the lamp. roll damper failure
createGlobalPropertyi("tu-154/absu/damp_pitch_lamp", 0) -- signal to the lamp. pitch damper failure
createGlobalPropertyi("tu-154/absu/damp_yaw_lamp", 0) -- signal to the lamp. yaw damper failure
createGlobalPropertyi("tu-154/absu/roll_contr_lamp", 0) -- signal to the lamp. roll control failure
createGlobalPropertyi("tu-154/absu/pitch_contr_lamp", 0) -- signal to the lamp. pitch control failure
createGlobalPropertyi("tu-154/absu/man_roll_lamp", 0) -- signal to the lamp. control the roll
createGlobalPropertyi("tu-154/absu/man_pitch_lamp", 0) -- signal to the lamp. control the pitch
createGlobalPropertyi("tu-154/absu/man_toga_lamp", 0) -- signal to the lamp. fly the go-around
createGlobalPropertyi("tu-154/absu/triangle_lamp_signal", 0) -- signal to the lamp. triangle
createGlobalPropertyi("tu-154/absu/absu_fail_signal", 0															) -- signal to the siren
createGlobalPropertyf("tu-154/kln90/kln_course", 0																) -- desired track (LZP) from the KLN
createGlobalPropertyf("tu-154/kln90/kln_dev", 0																) -- cross-track deviation from the desired track, nm
createGlobalPropertyi("tu-154/kln90/kln_flag", 0																) -- KLN course flag. 0 = no flag, 1 = flag
createGlobalPropertyf("tu-154/radio/vhf1_cc", 0) -- radio current draw
createGlobalPropertyf("tu-154/radio/vhf2_cc", 0) -- radio current draw
createGlobalPropertyf("tu-154/tks/km5_1_cc", 0) -- KM-5 current draw
createGlobalPropertyf("tu-154/tks/km5_2_cc", 0) -- KM-5 current draw
createGlobalPropertyf("tu-154/tks/ga_1_cc", 0) -- gyro unit current draw
createGlobalPropertyf("tu-154/tks/ga_2_cc", 0) -- gyro unit current draw
createGlobalPropertyf("tu-154/tks/ga_heat_cc", 0) -- gyro unit heating current draw
createGlobalPropertyf("tu-154/tks/bgmk_1_cc", 0) -- BGMK current draw
createGlobalPropertyf("tu-154/tks/bgmk_2_cc", 0) -- BGMK current draw
createGlobalPropertyf("tu-154/tks/ush_cc", 0) -- USH current draw
createGlobalPropertyf("tu-154/ahz/agr_cc", 0) -- AGR current draw
createGlobalPropertyf("tu-154/nvu/nvu_cc", 0) -- NVU current draw
createGlobalPropertyf("tu-154/radio/ark15_L_cc", 0) -- ARK current draw
createGlobalPropertyf("tu-154/radio/ark15_R_cc", 0) -- ARK current draw
createGlobalPropertyf("tu-154/nvu/diss_cc", 0) -- DISS current draw
createGlobalPropertyf("tu-154/radio/nav1_pow_cc", 0) -- Kurs-MP current draw
createGlobalPropertyf("tu-154/radio/nav2_pow_cc", 0) -- Kurs-MP current draw
createGlobalPropertyf("tu-154/radio/radar_cc", 0) -- current draw from the Groza radar
createGlobalPropertyf("tu-154/radio/rsbn_cc", 0) -- current draw from the RSBN
createGlobalPropertyi("tu-154/payload/crew_num", 4) -- crew in the cockpit
createGlobalPropertyi("tu-154/payload/zone_1", 9) -- passengers
createGlobalPropertyi("tu-154/payload/zone_2", 22) -- passengers
createGlobalPropertyi("tu-154/payload/cabin_num", 4) -- crew in the cabin
createGlobalPropertyi("tu-154/payload/zone_4", 24) -- passengers
createGlobalPropertyi("tu-154/payload/zone_5", 21) -- passengers
createGlobalPropertyi("tu-154/payload/zone_6", 7) -- passengers
createGlobalPropertyi("tu-154/payload/cargo_1", 2500) -- baggage 1
createGlobalPropertyi("tu-154/payload/cargo_2", 1200) -- baggage 2
createGlobalPropertyi("tu-154/payload/kitchens", 300) -- galley load
createGlobalPropertyi("tu-154/payload/various", 50) -- other
createGlobalPropertyi("tu-154/payload/main_dist", 1000) -- distance to the destination airfield
createGlobalPropertyi("tu-154/payload/alt_dist", 500) -- distance to the alternate airfield
createGlobalPropertyi("tu-154/payload/main_fl", 380) -- flight level to the destination
createGlobalPropertyi("tu-154/payload/alt_fl", 320) -- flight level to the alternate
createGlobalPropertyi("tu-154/payload/nav_fuel", 2500) -- navigation reserve
createGlobalPropertyi("tu-154/payload/taxi_fuel", 100) -- taxi fuel
createGlobalPropertyi("tu-154/payload/tank_1", 3300) -- fuel in the tank
createGlobalPropertyi("tu-154/payload/tank_4", 0) -- fuel in the tank
createGlobalPropertyi("tu-154/payload/tank_2L", 1500) -- fuel in the tank
createGlobalPropertyi("tu-154/payload/tank_2R", 1500) -- fuel in the tank
createGlobalPropertyi("tu-154/payload/tank_3L", 3225) -- fuel in the tank
createGlobalPropertyi("tu-154/payload/tank_3R", 3225) -- fuel in the tank
createGlobalPropertyi("tu-154/payload/load_fuel_btn", 0) -- fuel load button
createGlobalPropertyi("tu-154/payload/load_fast_btn", 0) -- fast load button
createGlobalPropertyi("tu-154/payload/load_slow_btn", 0) -- slow load button
createGlobalPropertyf("tu-154/payload/paylod_set", 0) -- needs loading
createGlobalPropertyf("tu-154/payload/cg_set", 0) -- needs loading
createGlobalPropertyi("tu-154/sounds/taws_eng_phrase", 0) -- SRPBZ phrase number in English
createGlobalPropertyi("tu-154/sounds/taws_rus_phrase", 0) -- SRPBZ phrase number in Russian
createGlobalPropertyi("tu-154/sounds/enable_crew_vo", 1) -- crew callouts enabled
createGlobalPropertyi("tu-154/alarm/main_gear_flaps", 0) -- flaps not in the takeoff position or gear not extended
createGlobalPropertyi("tu-154/alarm/main_pressure", 0) -- cabin depressurisation or overpressure
createGlobalPropertyi("tu-154/alarm/speaker_auasp", 0) -- limit angle of attack or g
createGlobalPropertyi("tu-154/alarm/speaker_fuel", 0) -- 2500 of fuel remaining in tank 1
createGlobalPropertyi("tu-154/alarm/speaker_speed", 0) -- limit speed
createGlobalPropertyi("tu-154/alarm/speaker_absu", 0) -- mode disengagement or ABSU failures
createGlobalPropertyi("tu-154/checklist/side", 0) -- which side to show. 0 = before takeoff, 1 = before approach
createGlobalPropertyi("tu-154/checklist/fishka_1", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_2", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_3", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_4", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_5", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_6", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_7", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_8", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_9", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_10", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_11", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_12", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_13", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_14", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_15", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_16", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_17", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_18", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_19", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/checklist/fishka_20", 1) -- selector position. 0 = left, 1 = right
createGlobalPropertyi("tu-154/panels/show_load_panel", 0) -- show the loading panel
createGlobalPropertyi("tu-154/panels/show_absu_panel", 0) -- show the ABSU panel
createGlobalPropertyi("tu-154/panels/show_ohvd_panel", 0) -- show the overhead panel
createGlobalPropertyi("tu-154/panels/show_nvu_panel", 0) -- show the NVU panel
createGlobalPropertyi("tu-154/panels/show_checklist_panel", 0) -- show the KKP panel
createGlobalPropertyi("tu-154/panels/show_ground_panel", 0) -- show the ground services panel
createGlobalPropertyi("tu-154/panels/show_phone", 0) -- show the telephone panel
createGlobalPropertyi("tu-154/panels/show_cam", 0) -- show the camera panel
createGlobalPropertyi("tu-154/panels/show_palette", 0) -- show the card
createGlobalPropertyi("tu-154/panels/show_fail_panel", 0) -- show the failures card
createGlobalPropertyf("tu-154/misc/cg_pos_actual", 0) -- actual CG position
createGlobalPropertyf("tu-154/misc/weight_actual", 0) -- actual mass
createGlobalPropertyf("tu-154/anim/rain_glass_1", 0) -- brightness of the rain mask on the window
createGlobalPropertyf("tu-154/anim/rain_glass_2", 0) -- brightness of the rain mask on the window
createGlobalPropertyf("tu-154/anim/rain_glass_1_w_1_L", 0) -- brightness of the rain mask on the left window, sector 1
createGlobalPropertyf("tu-154/anim/rain_glass_1_w_2_L", 0) -- brightness of the rain mask on the left window, sector 2
createGlobalPropertyf("tu-154/anim/rain_glass_1_w_3_L", 0) -- brightness of the rain mask on the left window, sector 3
createGlobalPropertyf("tu-154/anim/rain_glass_1_w_4_L", 0) -- brightness of the rain mask on the left window, sector 4
createGlobalPropertyf("tu-154/anim/rain_glass_1_w_5_L", 0) -- brightness of the rain mask on the left window, sector 5
createGlobalPropertyf("tu-154/anim/rain_glass_2_w_1_L", 0) -- brightness of the rain mask on the left window, sector 1
createGlobalPropertyf("tu-154/anim/rain_glass_2_w_2_L", 0) -- brightness of the rain mask on the left window, sector 2
createGlobalPropertyf("tu-154/anim/rain_glass_2_w_3_L", 0) -- brightness of the rain mask on the left window, sector 3
createGlobalPropertyf("tu-154/anim/rain_glass_2_w_4_L", 0) -- brightness of the rain mask on the left window, sector 4
createGlobalPropertyf("tu-154/anim/rain_glass_2_w_5_L", 0) -- brightness of the rain mask on the left window, sector 5
createGlobalPropertyf("tu-154/anim/rain_glass_1_w_1_R", 0) -- brightness of the rain mask on the left window, sector 1
createGlobalPropertyf("tu-154/anim/rain_glass_1_w_2_R", 0) -- brightness of the rain mask on the left window, sector 2
createGlobalPropertyf("tu-154/anim/rain_glass_1_w_3_R", 0) -- brightness of the rain mask on the left window, sector 3
createGlobalPropertyf("tu-154/anim/rain_glass_1_w_4_R", 0) -- brightness of the rain mask on the left window, sector 4
createGlobalPropertyf("tu-154/anim/rain_glass_1_w_5_R", 0) -- brightness of the rain mask on the left window, sector 5
createGlobalPropertyf("tu-154/anim/rain_glass_2_w_1_R", 0) -- brightness of the rain mask on the left window, sector 1
createGlobalPropertyf("tu-154/anim/rain_glass_2_w_2_R", 0) -- brightness of the rain mask on the left window, sector 2
createGlobalPropertyf("tu-154/anim/rain_glass_2_w_3_R", 0) -- brightness of the rain mask on the left window, sector 3
createGlobalPropertyf("tu-154/anim/rain_glass_2_w_4_R", 0) -- brightness of the rain mask on the left window, sector 4
createGlobalPropertyf("tu-154/anim/rain_glass_2_w_5_R", 0) -- brightness of the rain mask on the left window, sector 5
createGlobalPropertyf("tu-154/anim/net_rain_ratio", 0) -- the actual amount of precipitation on the windows
createGlobalPropertyf("tu-154/misc/water_level", 0) -- water level
createGlobalPropertyf("tu-154/gauges/alt/vbe_flightlevel_left", 0) -- selected altitude on the VBE
createGlobalPropertyf("tu-154/gauges/alt/vbe_flightlevel_right", 0) -- selected altitude on the VBE
createGlobalPropertyf("tu-154/brakes/int_brakes_L", 0) -- actual brake position
createGlobalPropertyf("tu-154/brakes/int_brakes_R", 0) -- actual brake position
createGlobalPropertyf("tu-154/gauges/vvi_left", 0) -- variometer reading
createGlobalPropertyf("tu-154/gauges/vvi_right", 0) -- variometer reading
createGlobalPropertyi("tu-154/SC/control_thro_other", 0) -- the other person is controlling the throttles
createGlobalPropertyf("tu-154/SC/yoke_pitch_ratio", 0) -- pitch control
createGlobalPropertyf("tu-154/SC/yoke_roll_ratio", 0) -- roll control
createGlobalPropertyf("tu-154/SC/yoke_heading_ratio", 0) -- pedal control
createGlobalPropertyf("tu-154/SC/engine/ENGN_thro_0", 0) -- throttle control
createGlobalPropertyf("tu-154/SC/engine/ENGN_thro_1", 0) -- throttle control
createGlobalPropertyf("tu-154/SC/engine/ENGN_thro_2", 0) -- throttle control
createGlobalPropertyf("tu-154/SC/engine/ENGN_propmode_0", 0) -- reverser control
createGlobalPropertyf("tu-154/SC/engine/ENGN_propmode_2", 0) -- reverser control
createGlobalPropertyf("tu-154/SC/gear/tire_steer_command_deg", 0) -- nose gear steering
createGlobalPropertyf("tu-154/SC/controls/l_brake_add", 0) -- brake control
createGlobalPropertyf("tu-154/SC/controls/r_brake_add", 0) -- brake control
createGlobalPropertyf("tu-154/SC/brakes/int_brakes_L", 0) -- brake control
createGlobalPropertyf("tu-154/SC/brakes/int_brakes_R", 0) -- brake control
createGlobalPropertyf("tu-154/SC/controls/parkbrake", 0) -- brake control
createGlobalPropertyi("tu-154/speeds/v1_15", 0) -- V1 speed
createGlobalPropertyi("tu-154/speeds/vr_15", 0) -- Vr speed
createGlobalPropertyi("tu-154/speeds/v2_15", 0) -- V2 speed
createGlobalPropertyi("tu-154/speeds/v1_28", 0) -- V1 speed
createGlobalPropertyi("tu-154/speeds/vr_28", 0) -- Vr speed
createGlobalPropertyi("tu-154/speeds/v2_28", 0) -- V2 speed
createGlobalPropertyi("tu-154/checklist/checklist_selected", 0) -- checklist selection.
createGlobalPropertyi("tu-154/checklist/to_ready", 0) -- lamp lit
createGlobalPropertyi("tu-154/sound/reset_crew", 0) -- reset the command phrases
createGlobalPropertyf("tu-154/SC/GNS430_dtk", 0) -- heading on the GNS
createGlobalPropertyf("tu-154/SC/GNS430_dev", 0) -- cross-track deviation from the GNS
createGlobalPropertyi("tu-154/SC/GNS430_flag", 0) -- flag on the GNS
createGlobalPropertyi("tu-154/elec/apu_apd_working",0)
createGlobalPropertyf("tu-154/absu/cmd_pitch", 0																) -- RA-56 pitch actuator rod travel
createGlobalPropertyf("tu-154/absu/cmd_roll", 0																) -- RA-56 roll actuator rod travel
createGlobalPropertyf("tu-154/absu/cmd_yaw", 0																) -- RA-56 yaw actuator rod travel
createGlobalPropertyf("tu-154/absu/d_ra1_p",0)
createGlobalPropertyf("tu-154/absu/d_ra2_p",0)
createGlobalPropertyf("tu-154/absu/d_ra3_p",0)
createGlobalPropertyf("tu-154/absu/d_ra1_r",0)
createGlobalPropertyf("tu-154/absu/d_ra2_r",0)
createGlobalPropertyf("tu-154/absu/d_ra3_r",0)
createGlobalPropertyf("tu-154/absu/d_ra1_y",0)
createGlobalPropertyf("tu-154/absu/d_ra2_y",0)
createGlobalPropertyf("tu-154/absu/d_ra3_y",0)
createGlobalPropertyi("tu-154/failures/rsbn_rec",0)-- RSBN is receiving signal
createGlobalPropertyi("tu-154/fire/fire_bag1",0)
createGlobalPropertyi("tu-154/fire/fire_bag2",0)
createGlobalPropertyi("tu-154/fire/eng1_ext_used",0)
createGlobalPropertyi("tu-154/fire/eng2_ext_used",0)
createGlobalPropertyi("tu-154/fire/eng3_ext_used",0)
createGlobalPropertyi("tu-154/fire/apu_ext_used",0)
createGlobalPropertyf("tu-154/elec/avto_L_volt",0)
createGlobalPropertyf("tu-154/elec/avto_R_volt",0)
createGlobalPropertyf("tu-154/elec/avto_L_amp",0)
createGlobalPropertyf("tu-154/elec/avto_R_amp",0)
createGlobalPropertyf("tu-154/elec/fuel_pumps_115_aL_cc",0) 
createGlobalPropertyf("tu-154/elec/fuel_pumps_115_aR_cc",0)
createGlobalPropertyi("tu-154/SC/engine/rt_stop1",0)
createGlobalPropertyf("tu-154/SC/engine/rt_red1",0)
createGlobalPropertyi("tu-154/SC/engine/rt_stop2",0)
createGlobalPropertyf("tu-154/SC/engine/rt_red2",0)
createGlobalPropertyi("tu-154/SC/engine/rt_stop3",0)
createGlobalPropertyf("tu-154/SC/engine/rt_red3",0)
createGlobalPropertyf("tu-154/lights/engines/eng1_t_high",0)
createGlobalPropertyf("tu-154/lights/engines/eng2_t_high",0)
createGlobalPropertyf("tu-154/lights/engines/eng3_t_high",0)
createGlobalPropertyf("tu-154/lights/engines/egt_nk8_1",0)
createGlobalPropertyf("tu-154/lights/engines/egt_nk8_2",0)
createGlobalPropertyf("tu-154/lights/engines/egt_nk8_3",0)
createGlobalPropertyi("tu-154/engines/rna_1",0)
createGlobalPropertyi("tu-154/engines/rna_2",0)
createGlobalPropertyi("tu-154/engines/rna_3",0)
createGlobalPropertyf("tu-154/engines/flight_idle",0)
createGlobalPropertyf("tu-154/engines/flight_idle_rpm",0)
createGlobalPropertyf("tu-154/engines/delta_FF",0)
createGlobalPropertyf("tu-154/engines/FuelFlow_1",0)
createGlobalPropertyf("tu-154/engines/FuelFlow_2",0)
createGlobalPropertyf("tu-154/engines/FuelFlow_3",0)
createGlobalPropertyi("tu-154/antiice/stab_heat_open", 0)
createGlobalPropertyf("tu-154/engines/nk_rotation_1",0)
createGlobalPropertyf("tu-154/engines/nk_rotation_3",0)
createGlobalPropertyf("tu-154/engines/knd_1",0) -- engine 1 KND spool speed, written by powerplant/engine_gauges.lua
createGlobalPropertyf("tu-154/engines/knd_3",0) -- engine 3 KND spool speed, written by powerplant/engine_gauges.lua
createGlobalPropertyf("tu-154/anim/tiller_pos",0)
createGlobalPropertyi("tu-154/hydro/nosewheel_turn_power", 0)
createGlobalPropertyf("tu-154/SC/engine/nk8_kvd1", 0)
createGlobalPropertyf("tu-154/SC/engine/nk8_kvd2", 0)
createGlobalPropertyf("tu-154/SC/engine/nk8_kvd3", 0)
createGlobalPropertyf("tu-154/absu/d_H_integral", 0) 
createGlobalPropertyf("tu-154/absu/d_V_integral", 0) 
createGlobalPropertyf("tu-154/absu/d_M_integral", 0) 
createGlobalPropertyi("tu-154/failures/absu_bdg_tet_1_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bdg_tet_2_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bdg_tet_3_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bdg_gam_1_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bdg_gam_2_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bdg_gam_3_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bdg_psi_1_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bdg_psi_2_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bdg_psi_3_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bap_thet_1_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bap_thet_2_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bap_thet_3_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bap_gam_1_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bap_gam_2_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_bap_gam_3_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_stu_thet_1_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_stu_thet_2_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_stu_thet_3_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_stu_gam_1_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_stu_gam_2_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_stu_gam_3_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_vu1_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_vu2_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_vu3_fail", 0) 
createGlobalPropertyi("tu-154/failures/mgv_thet_1_fail", 0) 
createGlobalPropertyi("tu-154/failures/mgv_thet_2_fail", 0) 
createGlobalPropertyi("tu-154/failures/mgv_thet_3_fail", 0) 
createGlobalPropertyi("tu-154/failures/mgv_gam_1_fail", 0) 
createGlobalPropertyi("tu-154/failures/mgv_gam_2_fail", 0) 
createGlobalPropertyi("tu-154/failures/mgv_gam_3_fail", 0) 
createGlobalPropertyi("tu-154/failures/absu_vkv_fail", 0)
createGlobalPropertyi("tu-154/failures/absu_alt_speed_fail", 0)
createGlobalPropertyi("tu-154/failures/absu_at_fail", 0)
createGlobalPropertyi("tu-154/failures/absu_man_at", 0)
createGlobalPropertyi("tu-154/failures/absu_bdlu_fail", 0)
createGlobalPropertyi("tu-154/failures/absu_work_state", 0)
createGlobalPropertyi("tu-154/failures/absu_at_chan1_fail", 0)
createGlobalPropertyi("tu-154/failures/absu_at_chan2_fail", 0)
createGlobalPropertyi("tu-154/failures/ute_1_fail", 0)
createGlobalPropertyi("tu-154/failures/ute_2_fail", 0) 
createGlobalPropertyi("tu-154/failures/ute_1_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/ute_2_fail_mem", 0) 
createGlobalPropertyi("tu-154/absu/at_fail_signal", 0) 
createGlobalPropertyi("tu-154/failures/bshu_tet_1_fail", 0)
createGlobalPropertyi("tu-154/failures/bshu_tet_2_fail", 0)
createGlobalPropertyi("tu-154/failures/bshu_tet_3_fail", 0)
createGlobalPropertyi("tu-154/failures/bshu_tet_1_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bshu_tet_2_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bshu_tet_3_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bshu_gam_1_fail", 0)
createGlobalPropertyi("tu-154/failures/bshu_gam_2_fail", 0)
createGlobalPropertyi("tu-154/failures/bshu_gam_3_fail", 0)
createGlobalPropertyi("tu-154/failures/bshu_gam_1_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bshu_gam_2_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bshu_gam_3_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bshu_tet_fail", 0)
createGlobalPropertyi("tu-154/failures/bshu_gam_fail", 0)
createGlobalPropertyi("tu-154/failures/absu_at_blocked", 0)
createGlobalPropertyi("tu-154/absu/ppn_search_delay", 0) 
createGlobalPropertyf("tu-154/kskv/ard_temp", 0)
createGlobalPropertyi("tu-154/failures/bns_tet_1_fail", 0)
createGlobalPropertyi("tu-154/failures/bns_tet_2_fail", 0)
createGlobalPropertyi("tu-154/failures/bns_tet_3_fail", 0)
createGlobalPropertyi("tu-154/failures/bns_tet_1_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bns_tet_2_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bns_tet_3_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bns_gam_1_fail", 0)
createGlobalPropertyi("tu-154/failures/bns_gam_2_fail", 0)
createGlobalPropertyi("tu-154/failures/bns_gam_3_fail", 0)
createGlobalPropertyi("tu-154/failures/bns_gam_1_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bns_gam_2_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bns_gam_3_fail_mem", 0)
createGlobalPropertyi("tu-154/failures/bns_tet_fail", 0)
createGlobalPropertyi("tu-154/failures/bns_gam_fail", 0)
createGlobalPropertyi("tu-154/failures/nvu_vor_avtomat_fail", 0)
createGlobalPropertyi("tu-154/eng/apu_ready", 0	)