createGlobalPropertyi("tu-154/save_state_enabled", 1) -- whether saving the aircraft state is enabled
createGlobalPropertyi("tu-154/reset_state", 0) -- reset the aircraft state
createGlobalPropertyi("tu-154/save_state", 0) -- force-save the aircraft state
createGlobalPropertyi("tu-154/hardware_cockpit", 0) -- The aircraft is prepared for the iron cockpit
-- Seconds of SIM time since the previous frame, clamped to 0.1 s, and exactly
-- 0 while the sim is paused. Written only by systems/cockpit/time_logic.lua;
-- read by 131 modules. See CLAUDE.md "Time base" for the full contract.
createGlobalPropertyf("tu-154/time/frame_time", 0)
createGlobalPropertyf("tu-154/anim/cargo_1", 0) -- cargo door 1 position. 0 = closed, 1 = open
createGlobalPropertyf("tu-154/anim/cargo_2", 0) -- baggage door 2 position. 0 - closed, 1 - open
createGlobalPropertyf("tu-154/anim/apu_doors", 0) -- APU door position. 0 - closed, 1 - open.
createGlobalPropertyf("tu-154/anim/pax_door_1", 0) -- front passenger door position
createGlobalPropertyf("tu-154/anim/pax_door_2", 0) -- middle passenger door position
createGlobalPropertyf("tu-154/anim/pax_door_3", 0) -- right emergency door position
createGlobalPropertyf("tu-154/anim/lg/front_pos", 1) -- nose gear position
createGlobalPropertyf("tu-154/anim/lg/front_defl", 0) -- nose strut damper compression
createGlobalPropertyf("tu-154/anim/lg/front_turn", 0) -- nose gear steering
createGlobalPropertyf("tu-154/anim/lg/main_pos_left", 1) -- left main gear position. 0-1 - extension, 1+ - damper compression
createGlobalPropertyf("tu-154/anim/lg/main_rot_left", 0) -- left bogie rotation on the ground
createGlobalPropertyf("tu-154/anim/lg/main_pos_right", 1) -- right main gear position. 0-1 - extension, 1+ - damper compression
createGlobalPropertyf("tu-154/anim/lg/main_rot_right", 0) -- right bogie rotation on the ground
createGlobalPropertyf("tu-154/anim/light_open_left", 0) -- left landing light extension
createGlobalPropertyf("tu-154/anim/light_open_right", 0) -- right landing light extension
createGlobalPropertyf("tu-154/anim/spd_brk_inn_left", 0) -- left inboard speedbrake position
createGlobalPropertyf("tu-154/anim/spd_brk_inn_right", 0) -- right inboard speedbrake position
createGlobalPropertyf("tu-154/anim/wing_flx_left", 0) -- left wing bend angle. positive values - bending upwards
createGlobalPropertyf("tu-154/anim/wing_flx_right", 0) -- right wing bend angle. positive values - bending upwards
createGlobalPropertyf("tu-154/anim/rudder_anim", 0) -- rudder deflection angle for the animation. its physical model deflects through a smaller angle in reverse.
createGlobalPropertyf("tu-154/anim/elev_anim_L", 0) -- elevator deflection angle
createGlobalPropertyf("tu-154/anim/elev_anim_R", 0) -- elevator deflection angle
createGlobalPropertyf("tu-154/anim/cockpit_door", 0) -- opening the door to the cockpit
createGlobalPropertyf("tu-154/anim/cockpit_table_1", 0) -- tables on the pilots' seats
createGlobalPropertyf("tu-154/anim/cockpit_table_2", 0) -- tables on the pilots' seats
createGlobalPropertyf("tu-154/anim/cockpit_vent_1", 0) -- fan rotation angle
createGlobalPropertyf("tu-154/anim/cockpit_vent_2", 0) -- fan rotation angle
createGlobalPropertyf("tu-154/anim/cockpit_vent_3", 0) -- fan rotation angle
createGlobalPropertyf("tu-154/anim/cockpit_window_left", 0) -- side window opening
createGlobalPropertyf("tu-154/anim/cockpit_window_right", 0) -- side window opening
createGlobalPropertyi("tu-154/anim/show_gns", 1) -- a GNS430 is fitted in the aircraft instead of the KLN
createGlobalPropertyi("tu-154/anim/RXP", 0) -- RXP is installed in the system
createGlobalPropertyi("tu-154/anim/show_yokes", 1) -- whether the control columns are visible
createGlobalPropertyi("tu-154/anim/show_chairs", 1) -- whether the seats are visible
createGlobalPropertyf("tu-154/anim/rise_chair_arm_L", 0) -- raise the seat lever
createGlobalPropertyf("tu-154/anim/rise_chair_arm_R", 0) -- raise the seat lever
createGlobalPropertyi("tu-154/anim/table_up_L", 0) -- raise the tables
createGlobalPropertyi("tu-154/anim/table_up_R", 0) -- raise the tables
createGlobalPropertyi("tu-154/anim/gpu_present", 0) -- RAP present
createGlobalPropertyf("tu-154/anim/gpu_work", 0) -- RAP running. the exhaust cover is raised
createGlobalPropertyf("tu-154/anim/ground_stuff_angle", 0) -- pitch angle correction for maintenance
createGlobalPropertyf("tu-154/anim/window_ice_1", 0) -- ice on the windows
createGlobalPropertyf("tu-154/anim/window_ice_2", 0) -- ice on the windows
createGlobalPropertyf("tu-154/anim/window_ice_3", 0) -- ice on the windows
createGlobalPropertyf("tu-154/anim/window_ice_4", 0) -- ice level on the other windows
createGlobalPropertyi("tu-154/anim/gear_blocks", 0) -- landing gear block setting
createGlobalPropertyi("tu-154/anim/sensors_caps", 0) -- fitting the sensor covers
createGlobalPropertyi("tu-154/anim/engine_caps", 0) -- fitting the engine covers
createGlobalPropertyf("tu-154/anim/ladder_1", 500) -- airstairs. 500 - hidden. +50..0 - driving up, 0 - standing next to the aircraft, 0..-50 - driving away
createGlobalPropertyf("tu-154/anim/ladder_2", 500) -- airstairs
createGlobalPropertyf("tu-154/anim/catering", 500) -- galleys
createGlobalPropertyf("tu-154/anim/deice", 500) -- deice
createGlobalPropertyf("tu-154/anim/deice2", 0) -- deice
createGlobalPropertyf("tu-154/anim/fuel_tanker", 500) -- refueller
createGlobalPropertyi("tu-154/anim/ladder_1_call", 0) -- airstairs. 1 drive up, 0 - drive away
createGlobalPropertyi("tu-154/anim/ladder_2_call", 0) -- airstairs
createGlobalPropertyi("tu-154/anim/catering_call", 0) -- galleys
createGlobalPropertyi("tu-154/anim/fuel_tanker_call", 0) -- refueller
createGlobalPropertyf("tu-154/anim/reverse_mid", 0) -- position of the common reverser manipulator
createGlobalPropertyi("tu-154/buttons/clock_24_left", 0) -- left button of the 24-hour clock. 0 - released, 1 - pressed (applies to all the buttons)
createGlobalPropertyi("tu-154/buttons/clock_24_right", 0) -- right button of the 24-hour clock
createGlobalPropertyf("tu-154/gauges/clock_24_hours", 0) -- hour hand
createGlobalPropertyf("tu-154/gauges/clock_24_mins", 0) -- minute hand
createGlobalPropertyf("tu-154/gauges/clock_24_red", 0) -- red needle
createGlobalPropertyi("tu-154/switchers/spu_1_power", 1) -- power selector on the captain's SPU.  -1 - bus 2, 0 - off, 1 - bus 1
createGlobalPropertyi("tu-154/switchers/spu_1_mode", 0) -- mode selector on the captain's SPU. 0 - radio, 1 - SPU
createGlobalPropertyi("tu-154/switchers/spu_1_source", 0) -- source selector on the captain's SPU
createGlobalPropertyi("tu-154/switchers/spu_2_power", 1) -- power selector on the copilot's SPU
createGlobalPropertyi("tu-154/switchers/spu_2_mode", 0) -- mode selector on the copilot's SPU
createGlobalPropertyi("tu-154/switchers/spu_2_source", 0) -- source selector on the copilot's SPU
createGlobalPropertyi("tu-154/switchers/spu_3_power", 1) -- power selector on the navigator's SPU
createGlobalPropertyi("tu-154/switchers/spu_3_mode", 0) -- mode selector on the navigator's SPU
createGlobalPropertyi("tu-154/switchers/spu_3_source", 0) -- source selector on the navigator's SPU
createGlobalPropertyi("tu-154/switchers/spu_4_power", 1) -- power selector on the flight engineer's SPU
createGlobalPropertyi("tu-154/switchers/spu_4_mode", 0) -- mode selector on the flight engineer's SPU
createGlobalPropertyi("tu-154/switchers/spu_4_source", 0) -- source selector on the flight engineer's SPU
createGlobalPropertyi("tu-154/lights/mid_left_panel_int_set", 3) -- captain's front panel integral lighting control
createGlobalPropertyi("tu-154/lights/left_panel_int_set", 3) -- left panel integral lighting control
createGlobalPropertyi("tu-154/lights/right_panel_int_set", 3) -- right panel integral lighting control
createGlobalPropertyi("tu-154/lights/mid_right_panel_int_set", 3) -- copilot's front panel integral lighting control
createGlobalPropertyi("tu-154/lights/ovhd_panel_int_set", 3) -- overhead panel integral lighting control
createGlobalPropertyf("tu-154/lights/left_panel_flood_set", 0.3) -- flood light brightness control, left panel
createGlobalPropertyf("tu-154/lights/right_panel_flood_set", 0.3) -- flood light brightness control, right panel
createGlobalPropertyf("tu-154/lights/mid_panel_flood_set", 0.3) -- flood light brightness control, centre panel
createGlobalPropertyf("tu-154/lights/front_panel_flood_set", 0.3) -- flood light brightness control, front panel
createGlobalPropertyf("tu-154/lights/ovhd_front_panel_flood_set", 0.3) -- flood light brightness control, front part of the overhead
createGlobalPropertyf("tu-154/lights/ovhd_back_panel_flood_set", 0.3) -- flood light brightness control, rear part of the overhead
createGlobalPropertyf("tu-154/lights/eng_panel_flood_set", 0.3) -- flight engineer's panel lighting brightness control
createGlobalPropertyf("tu-154/lights/km_panel_flood_set", 0.3) -- KM panel lighting brightness control
createGlobalPropertyi("tu-154/lights/cabinl_flood_set", 0) -- cockpit lighting switch
createGlobalPropertyi("tu-154/lights/azs_panel_flood_set", 0) -- AZS panel lighting switch
createGlobalPropertyi("tu-154/lights/day_night_set", 0) -- day/night switch. 0 = day, 1 = night. dims the annunciator lamps.
createGlobalPropertyi("tu-154/lights/cargo_light_1_set", 0) -- cargo compartment lighting switch
createGlobalPropertyi("tu-154/lights/cargo_light_2_set", 0) -- cargo compartment lighting switch
createGlobalPropertyi("tu-154/lights/tech_light_set", 0) -- technical compartment lighting switch
createGlobalPropertyi("tu-154/lights/gear_nacelle_light_set", 0) -- landing gear nacelle lighting switch
createGlobalPropertyf("tu-154/lights/cabin_2d_light", 0) -- brightness of the 2D cabin lighting
createGlobalPropertyi("tu-154/lights/nav_lights_set", 1) -- nav lights switch
createGlobalPropertyi("tu-154/lights/strobe_set", 1) -- strobe light switch
createGlobalPropertyi("tu-154/lights/wing_light_left_set", 0) -- wing illumination switch
createGlobalPropertyi("tu-154/lights/wing_light_right_set", 0) -- wing illumination switch
createGlobalPropertyi("tu-154/lights/tail_light_set", 1) -- tail illumination switch
createGlobalPropertyi("tu-154/lights/wing_light_left", 0) -- left wing illumination
createGlobalPropertyi("tu-154/lights/wing_light_right", 0) -- right wing illumination
createGlobalPropertyi("tu-154/lights/tail_light", 0) -- tail illumination
createGlobalPropertyi("tu-154/lights/landing_ext_set_L", 0) -- left landing light extension
createGlobalPropertyi("tu-154/lights/landing_ext_set_R", 0) -- right landing light extension
createGlobalPropertyi("tu-154/lights/landing_mode_set_L", 0) -- left landing light mode. -1 = taxi, 0 = off, +1 = landing
createGlobalPropertyi("tu-154/lights/landing_mode_set_R", 0) -- right landing light mode
createGlobalPropertyi("tu-154/lights/light_signal_set", 0) -- in-flight signal
createGlobalPropertyf("tu-154/controlls/nosewheel_lever", 0) -- nose gear steering lever
createGlobalPropertyf("tu-154/controlls/yoke_pitch", 0) -- control wheel pitch travel
createGlobalPropertyf("tu-154/controlls/yoke_roll", 0) -- control wheel roll deflection
createGlobalPropertyf("tu-154/controlls/pedals", 0) -- pedal deflection
createGlobalPropertyf("tu-154/controlls/brake_L", 0) -- left pedal brake
createGlobalPropertyf("tu-154/controlls/brake_R", 0) -- right pedal brake
createGlobalPropertyf("tu-154/controlls/brake_emerg", 0) -- emergency brake
createGlobalPropertyf("tu-154/controlls/brake_emerg_L", 0) -- left emergency brake
createGlobalPropertyf("tu-154/controlls/brake_emerg_R", 0) -- right emergency brake
createGlobalPropertyf("tu-154/controlls/spoilers_lever", 0) -- spoiler lever
createGlobalPropertyf("tu-154/controlls/throttle_1", 0) -- throttle 1
createGlobalPropertyf("tu-154/controlls/throttle_2", 0) -- throttle 2
createGlobalPropertyf("tu-154/controlls/throttle_3", 0) -- throttle 3
createGlobalPropertyf("tu-154/controlls/throttle_1_ENG", 0) -- flight engineer's throttle 1
createGlobalPropertyf("tu-154/controlls/throttle_2_ENG", 0) -- flight engineer's throttle 2
createGlobalPropertyf("tu-154/controlls/throttle_3_ENG", 0) -- flight engineer's throttle 3
createGlobalPropertyf("tu-154/controlls/revers_L", 0) -- left reverser lever
createGlobalPropertyf("tu-154/controlls/revers_R", 0) -- right reverser lever
createGlobalPropertyf("tu-154/controlls/fuel_cutoff_1", 0) -- fire shutoff valve lever 1
createGlobalPropertyf("tu-154/controlls/fuel_cutoff_2", 0) -- fire shutoff valve lever 2
createGlobalPropertyf("tu-154/controlls/fuel_cutoff_3", 0) -- fire shutoff valve lever 3
createGlobalPropertyf("tu-154/controlls/throttle_lock", 0) -- throttle lock lever
createGlobalPropertyi("tu-154/controll/parking_brake", 0) -- parking brake lock handle
createGlobalPropertyi("tu-154/controll/emerg_gear_ext", 0) -- emergency landing gear extension handle
createGlobalPropertyf("tu-154/controll/flaps_lever", 0) -- flap extension lever. 0-45
createGlobalPropertyi("tu-154/controll/gear_lever", 0) -- landing gear lever. -1 = up, 0 = neutral, +1 = down
createGlobalPropertyi("tu-154/controll/elev_trimm_switcher", 0) -- elevator trim control. -1 = nose down, 0 = neutral, +1 = nose up
createGlobalPropertyi("tu-154/controll/stab_man_cap", 0) -- stabiliser control cover
createGlobalPropertyi("tu-154/controll/stab_manual", 0) -- manual stabiliser control. 0 - neutral, +1 - nose up
createGlobalPropertyi("tu-154/controll/stab_setting", 1) -- CG position for the stabiliser. 0 - aft, 1 - mid, 2 - fwd
createGlobalPropertyi("tu-154/controll/ail_trimm_sw", 0) -- aileron trim switch
createGlobalPropertyi("tu-154/controll/rudd_trimm_sw", 0) -- rudder trim switch
createGlobalPropertyi("tu-154/controll/contr_force_cap", 0) -- elevator/rudder feel unit switch cover
createGlobalPropertyi("tu-154/controll/contr_force_set", 0) -- elevator/rudder feel unit selector. -1 = flight, 0 = auto, +1 = takeoff-landing
createGlobalPropertyi("tu-154/switchers/nosewheel_turn_enable", 1) -- nosewheel steering switch on the control wheel
createGlobalPropertyi("tu-154/switchers/nosewheel_turn_sel", 0) -- nosewheel steering angle selector. 0 = 10, 1 = 63
createGlobalPropertyi("tu-154/switchers/nosewheel_turn_cap", 0) -- steering angle selector cover
createGlobalPropertyi("tu-154/switchers/slat_man", 0) -- manual slat control. -1 - retract, 0 off, +1 - extend
createGlobalPropertyi("tu-154/switchers/slat_man_cap", 0) -- manual slat control cover
createGlobalPropertyi("tu-154/switchers/flaps_sel", 0) -- flap operating mode selection. -1 - off, 0 - auto, +1 - manual
createGlobalPropertyi("tu-154/switchers/flaps_sel_cap", 0) -- flap operation selection cover
createGlobalPropertyi("tu-154/switchers/gears_retr_lock", 0) -- gear retraction lock
createGlobalPropertyi("tu-154/switchers/gears_retr_lock_cap", 0) -- landing gear retraction lock cover
createGlobalPropertyi("tu-154/switchers/gears_ext_3GS", 0) -- gear extension from hydraulic system 3
createGlobalPropertyi("tu-154/switchers/gears_ext_3GS_cap", 0) -- cover for gear extension from hydraulic system 3
createGlobalPropertyi("tu-154/gauges/acs1/left_knob_press", 0) -- left button of the captain's ACHS1 clock
createGlobalPropertyi("tu-154/gauges/acs1/right_knob_press", 0) -- right button of the captain's ACHS1 clock
createGlobalPropertyf("tu-154/gauges/acs1/needle_hours", 0) -- captain's ACHS1 hour hand
createGlobalPropertyf("tu-154/gauges/acs1/needle_mins", 0) -- captain's ACHS1 minute hand
createGlobalPropertyf("tu-154/gauges/acs1/needle_secs", 0) -- captain's ACHS1 second hand
createGlobalPropertyi("tu-154/gauges/acs1/flag_pos", 0) -- red and white flag, captain's ACHS1. -1 - white, 0 - white and red, +1 - red
createGlobalPropertyf("tu-154/gauges/acs1/flight_timer_hours", 0) -- flight timer hour hand
createGlobalPropertyf("tu-154/gauges/acs1/flight_timer_mins", 0) -- flight timer minute hand
createGlobalPropertyf("tu-154/gauges/acs1/stopwatch_mins", 0) -- stopwatch minute hand
createGlobalPropertyi("tu-154/gauges/acs2/left_knob_press", 0) -- left button of the copilot's ACHS1 clock
createGlobalPropertyi("tu-154/gauges/acs2/right_knob_press", 0) -- right button of the copilot's ACHS1 clock
createGlobalPropertyf("tu-154/gauges/acs2/needle_hours", 0) -- copilot's ACHS1 hour hand
createGlobalPropertyf("tu-154/gauges/acs2/needle_mins", 0) -- copilot's ACHS1 minute hand
createGlobalPropertyf("tu-154/gauges/acs2/needle_secs", 0) -- copilot's ACHS1 second hand
createGlobalPropertyi("tu-154/gauges/acs2/flag_pos", 0) -- red and white flag, copilot's ACHS1
createGlobalPropertyf("tu-154/gauges/acs2/flight_timer_hours", 0) -- flight timer hour hand
createGlobalPropertyf("tu-154/gauges/acs2/flight_timer_mins", 0) -- flight timer minute hand
createGlobalPropertyf("tu-154/gauges/acs2/stopwatch_mins", 0) -- stopwatch minute hand
createGlobalPropertyi("tu-154/gauges/acs3/left_knob_press", 0) -- left button of the flight engineer's ACHS1 clock
createGlobalPropertyi("tu-154/gauges/acs3/right_knob_press", 0) -- right button of the flight engineer's ACHS1 clock
createGlobalPropertyf("tu-154/gauges/acs3/needle_hours", 0) -- flight engineer's ACHS1 hour hand
createGlobalPropertyf("tu-154/gauges/acs3/needle_mins", 0) -- flight engineer's ACHS1 minute hand
createGlobalPropertyf("tu-154/gauges/acs3/needle_secs", 0) -- flight engineer's ACHS1 second hand
createGlobalPropertyi("tu-154/gauges/acs3/flag_pos", 0) -- red and white flag, flight engineer's ACHS1
createGlobalPropertyf("tu-154/gauges/acs3/flight_timer_hours", 0) -- flight timer hour hand
createGlobalPropertyf("tu-154/gauges/acs3/flight_timer_mins", 0) -- flight timer minute hand
createGlobalPropertyf("tu-154/gauges/acs3/stopwatch_mins", 0) -- stopwatch minute hand
createGlobalPropertyf("tu-154/gauges/speed/kus_ias_left", 0) -- indicated airspeed on the captain's KUS730
createGlobalPropertyf("tu-154/gauges/speed/kus_tas_left", 0) -- true airspeed on the captain's KUS730
createGlobalPropertyf("tu-154/gauges/speed/kus_ias_right", 0) -- indicated airspeed on the copilot's KUS730
createGlobalPropertyf("tu-154/gauges/speed/kus_tas_right", 0) -- true airspeed on the copilot's KUS730
createGlobalPropertyf("tu-154/gauges/speed/kus_ias_eng", 0) -- indicated airspeed on the flight engineer's KUS730
createGlobalPropertyf("tu-154/gauges/speed/kus_tas_eng", 0) -- true airspeed on the flight engineer's KUS730
createGlobalPropertyf("tu-154/gauges/speed/ias_left", 0) -- indicated airspeed, captain
createGlobalPropertyf("tu-154/gauges/speed/ias_yellow_left", 0) -- yellow marker on the captain's speed indicator
createGlobalPropertyf("tu-154/gauges/speed/ias_right", 0) -- indicated airspeed, copilot
createGlobalPropertyf("tu-154/gauges/speed/ias_yellow_right", 0) -- yellow marker on the copilot's speed indicator
createGlobalPropertyf("tu-154/gauges/speed/mach_left", 0) -- captain's mach
createGlobalPropertyf("tu-154/gauges/speed/mach_right", 0) -- copilot's mach
createGlobalPropertyf("tu-154/gauges/speed/speed_mid_needle", 0) -- speed indicator needle in the centre
createGlobalPropertyi("tu-154/gauges/speed/speed_mid_flag", 0) -- speed indicator flag in the centre 0 - air, 1 - ground
createGlobalPropertyf("tu-154/gauges/alt/var75", 0) -- captain's variometer 75
createGlobalPropertyf("tu-154/gauges/alt/var30", 0) -- flight engineer's variometer 30
createGlobalPropertyf("tu-154/gauges/alt/radioalt_needle_left", 0) -- captain's radio altimeter needle
createGlobalPropertyf("tu-154/gauges/alt/radioalt_dh_left", 0) -- captain's radio altimeter DH pointer
createGlobalPropertyf("tu-154/gauges/alt/radioalt_flag_left", 0) -- captain's radio altimeter flag
createGlobalPropertyi("tu-154/gauges/alt/radioalt_button_left", 0) -- captain's radio altimeter test button
createGlobalPropertyf("tu-154/gauges/alt/radioalt_needle_right", 0) -- copilot's radio altimeter needle
createGlobalPropertyf("tu-154/gauges/alt/radioalt_dh_right", 0) -- copilot's radio altimeter DH pointer
createGlobalPropertyf("tu-154/gauges/alt/radioalt_flag_right", 0) -- copilot's radio altimeter flag
createGlobalPropertyi("tu-154/gauges/alt/radioalt_button_right", 0) -- copilot's radio altimeter test button
createGlobalPropertyf("tu-154/gauges/alt/uvid_needle_left", 0) -- captain's UVID altimeter needle
createGlobalPropertyf("tu-154/gauges/alt/uvid_feet_counter", 0) -- units-of-feet counter drum
createGlobalPropertyf("tu-154/gauges/alt/uvid_hundreads_counter", 0) -- hundreds-of-feet counter drum
createGlobalPropertyf("tu-154/gauges/alt/uvid_thousands_counter", 0) -- thousands-of-feet counter drum.
createGlobalPropertyf("tu-154/gauges/alt/uvid_tens_thousands_counter", 0) -- tens-of-thousands-of-feet counter drum.
createGlobalPropertyf("tu-154/gauges/alt/uvid_pressure_knob", 1013) -- pressure setting knob
createGlobalPropertyf("tu-154/gauges/alt/uvid_pressure_one", 3) -- pressure units
createGlobalPropertyf("tu-154/gauges/alt/uvid_pressure_ten", 1) -- pressure tens
createGlobalPropertyf("tu-154/gauges/alt/uvid_pressure_hund", 0) -- pressure hundreds
createGlobalPropertyf("tu-154/gauges/alt/uvid_pressure_thous", 1) -- pressure thousands
createGlobalPropertyf("tu-154/gauges/alt/vd15_alt_left", 0) -- altitude on the captain's VD15
createGlobalPropertyf("tu-154/gauges/alt/vd15_tri_needle_left", 0) -- correction needle on the captain's VD15
createGlobalPropertyf("tu-154/gauges/alt/vd15_pressure_left", 760) -- pressure on the captain's VD15
createGlobalPropertyf("tu-154/gauges/alt/vd15_alt_right", 0) -- altitude on the copilot's VD15
createGlobalPropertyf("tu-154/gauges/alt/vd15_tri_needle_right", 0) -- correction needle on the copilot's VD15
createGlobalPropertyf("tu-154/gauges/alt/vd15_pressure_right", 760) -- pressure on the copilot's VD15
createGlobalPropertyf("tu-154/gauges/alt/vd15_alt_eng", 0) -- altitude on the flight engineer's VD15
createGlobalPropertyf("tu-154/gauges/alt/vd15_tri_needle_eng", 0) -- correction needle on the flight engineer's VD15
createGlobalPropertyf("tu-154/gauges/alt/vd15_pressure_eng", 760) -- pressure on the flight engineer's VD15
createGlobalPropertyf("tu-154/gauges/alt/vbe_alt_left", 0) -- altitude on the left VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_press_left", 1013) -- pressure on the left VBE
createGlobalPropertyf("tu-154/gauges/alt/vbe_brt_left", 0.7) -- brightness on the left VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_press_knob_left", 0) -- pressure setting knob on the left VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_fl_knob_left", 0) -- flight level setting knob on the left VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_mode_but_left", 0) -- mode selection button on the left VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_mode_left", 0) -- mode on the left VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_std_left", 0) -- standard pressure selection
createGlobalPropertyf("tu-154/gauges/alt/vbe_alt_right", 0) -- altitude on the right VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_press_right", 1013) -- pressure on the right VBE
createGlobalPropertyf("tu-154/gauges/alt/vbe_brt_right", 0.7) -- brightness on the right VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_press_knob_right", 0) -- pressure setting knob on the right VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_fl_knob_right", 0) -- flight level setting knob on the right VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_mode_but_right", 0) -- mode selection button on the right VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_mode_right", 0) -- mode on the right VBE
createGlobalPropertyi("tu-154/gauges/alt/vbe_std_right", 0) -- standard pressure selection
createGlobalPropertyf("tu-154/gauges/vsi/vsi_brt_left", 0.7) -- VSI screen brightness
createGlobalPropertyf("tu-154/gauges/vsi/vsi_brt_right", 0.7) -- VSI screen brightness
createGlobalPropertyf("tu-154/gauges/compas/radiocomp_scale_left", 0) -- heading scale on the captain's radio compass
createGlobalPropertyf("tu-154/gauges/compas/bearing_1_left", 0) -- captain's radio compass needle 1 direction
createGlobalPropertyf("tu-154/gauges/compas/bearing_2_left", 0) -- captain's radio compass needle 2 direction
createGlobalPropertyi("tu-154/gauges/compas/source_1_switch_left", 1) -- captain's radio compass needle 1 selector. 0 - blank, 1 - ARK1, 2 - ARK2, 3 - VOR1, 4 - VOR2, 5 - RSBN
createGlobalPropertyi("tu-154/gauges/compas/source_2_switch_left", 2) -- captain's radio compass needle 2 selector
createGlobalPropertyf("tu-154/gauges/compas/radiocomp_scale_right", 0) -- heading scale on the copilot's radio compass
createGlobalPropertyf("tu-154/gauges/compas/bearing_1_right", 0) -- copilot's radio compass needle 1 direction
createGlobalPropertyf("tu-154/gauges/compas/bearing_2_right", 0) -- copilot's radio compass needle 2 direction
createGlobalPropertyi("tu-154/gauges/compas/source_1_switch_right", 1) -- copilot's radio compass needle 1 selector. 0 - blank, 1 - ARK1, 2 - ARK2, 3 - VOR1, 4 - VOR2, 5 - RSBN
createGlobalPropertyi("tu-154/gauges/compas/source_2_switch_right", 2) -- copilot's radio compass needle 2 selector
createGlobalPropertyf("tu-154/gauges/compas/big_knob", 0) -- turning the ZK knob on the large compass
createGlobalPropertyf("tu-154/gauges/compas/big_course_needle", 0) -- "aircraft" symbol needle
createGlobalPropertyf("tu-154/gauges/compas/big_true_course_needle", 0) -- track angle needle
createGlobalPropertyf("tu-154/gauges/compas/big_tri_needle", 0) -- triangular needle
createGlobalPropertyf("tu-154/gauges/compas/pkp_gyro_course_L", 0) -- gyro heading, captain's PKP
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_L", 0) -- flight heading on the captain's PKP
createGlobalPropertyf("tu-154/gauges/compas/pkp_helper_course_L", 0) -- heading set by the yellow needle on the captain's PKP
createGlobalPropertyf("tu-154/gauges/compas/pkp_slip_angle_L", 0) -- drift angle on the captain's PKP
createGlobalPropertyf("tu-154/gauges/compas/pkp_course_plank_L", 0) -- captain's PKP course bar + bar deflected to the right
createGlobalPropertyf("tu-154/gauges/compas/pkp_gs_plank_L", 0) -- captain's PKP glideslope bar + bar deflected up
createGlobalPropertyi("tu-154/gauges/compas/pkp_course_flag_L", 0) -- course bar failure flag
createGlobalPropertyi("tu-154/gauges/compas/pkp_gs_flag_L", 0) -- glideslope bar failure flag
createGlobalPropertyi("tu-154/gauges/compas/pkp_main_flag_L", 0) -- heading failure flag
createGlobalPropertyi("tu-154/gauges/compas/pkp_obs_flag_L", 0) -- heading counter failure flag
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_one_L", 0) -- heading counter. units
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_ten_L", 0) -- heading counter. tens
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_hundr_L", 0) -- heading counter. hundreds
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_knob_L", 0) -- heading tuning knob
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_set_L", 0) -- PNP heading
createGlobalPropertyf("tu-154/gauges/compas/pkp_gyro_course_R", 0) -- gyro heading, copilot's PKP
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_R", 0) -- flight heading on the copilot's PKP
createGlobalPropertyf("tu-154/gauges/compas/pkp_helper_course_R", 0) -- heading set by the yellow needle on the copilot's PKP
createGlobalPropertyf("tu-154/gauges/compas/pkp_slip_angle_R", 0) -- drift angle on the copilot's PKP
createGlobalPropertyf("tu-154/gauges/compas/pkp_course_plank_R", 0) -- copilot's PKP course bar + bar deflected to the right
createGlobalPropertyf("tu-154/gauges/compas/pkp_gs_plank_R", 0) -- copilot's PKP glideslope bar + bar deflected up
createGlobalPropertyi("tu-154/gauges/compas/pkp_course_flag_R", 0) -- course bar failure flag
createGlobalPropertyi("tu-154/gauges/compas/pkp_gs_flag_R", 0) -- glideslope bar failure flag
createGlobalPropertyi("tu-154/gauges/compas/pkp_main_flag_R", 0) -- heading failure flag
createGlobalPropertyi("tu-154/gauges/compas/pkp_obs_flag_R", 0) -- heading counter failure flag
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_one_R", 0) -- heading counter. units
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_ten_R", 0) -- heading counter. tens
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_hundr_R", 0) -- heading counter. hundreds
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_knob_R", 0) -- heading tuning knob
createGlobalPropertyf("tu-154/gauges/compas/pkp_obs_set_R", 0) -- PNP heading
createGlobalPropertyf("tu-154/gauges/ahz/roll_L", 0) -- bank on the captain's AGD + to the right
createGlobalPropertyf("tu-154/gauges/ahz/pitch_L", 0) -- pitch on the captain's AGD + nose up
createGlobalPropertyf("tu-154/gauges/ahz/dir_roll_L", 0) -- captain's AGD roll director + to the right
createGlobalPropertyf("tu-154/gauges/ahz/dir_pitch_L", 0) -- captain's AGD pitch director + up
createGlobalPropertyf("tu-154/gauges/ahz/course_plank_L", 0) -- captain's AGD course bar + to the right
createGlobalPropertyf("tu-154/gauges/ahz/gs_plank_L", 0) -- captain's AGD glideslope bar + up
createGlobalPropertyf("tu-154/gauges/ahz/speed_plank_L", 0) -- captain's AGD rate of change + up
createGlobalPropertyf("tu-154/gauges/ahz/pitch_corr_L", 0) -- pitch correction on the captain's AGD + to the right
createGlobalPropertyi("tu-154/gauges/ahz/ahz_flag_L", 0) -- captain's AGD failure flag
createGlobalPropertyi("tu-154/gauges/ahz/dir_roll_flag_L", 0) -- captain's AGD roll director failure flag
createGlobalPropertyi("tu-154/gauges/ahz/dir_pitch_flag_L", 0) -- captain's AGD pitch director failure flag
createGlobalPropertyf("tu-154/gauges/ahz/roll_R", 0) -- bank on the copilot's AGD + to the right
createGlobalPropertyf("tu-154/gauges/ahz/pitch_R", 0) -- pitch on the copilot's AGD + nose up
createGlobalPropertyf("tu-154/gauges/ahz/dir_roll_R", 0) -- copilot's AGD roll director + to the right
createGlobalPropertyf("tu-154/gauges/ahz/dir_pitch_R", 0) -- copilot's AGD pitch director + up
createGlobalPropertyf("tu-154/gauges/ahz/course_plank_R", 0) -- copilot's AGD course bar + to the right
createGlobalPropertyf("tu-154/gauges/ahz/gs_plank_R", 0) -- copilot's AGD glideslope bar + up
createGlobalPropertyf("tu-154/gauges/ahz/speed_plank_R", 0) -- copilot's AGD rate of change + up
createGlobalPropertyf("tu-154/gauges/ahz/pitch_corr_R", 0) -- pitch correction on the copilot's AGD + to the right
createGlobalPropertyi("tu-154/gauges/ahz/ahz_flag_R", 0) -- captain's AGD failure flag
createGlobalPropertyi("tu-154/gauges/ahz/dir_roll_flag_R", 0) -- captain's AGD roll director failure flag
createGlobalPropertyi("tu-154/gauges/ahz/dir_pitch_flag_R", 0) -- captain's AGD pitch director failure flag
createGlobalPropertyf("tu-154/gauges/ahz/roll_C", 0) -- AGR roll, + right
createGlobalPropertyf("tu-154/gauges/ahz/pitch_C", 0) -- AGR pitch, + nose up
createGlobalPropertyf("tu-154/gauges/ahz/pitch_corr_C", 0) -- AGR pitch correction, + right
createGlobalPropertyi("tu-154/gauges/ahz/ahz_flag_C", 0) -- AGR flag
createGlobalPropertyf("tu-154/gauges/misc/aoa_ind", 0) -- angle of attack indicator
createGlobalPropertyf("tu-154/gauges/misc/aoa_sector", 0) -- angle of attack indicator sector
createGlobalPropertyf("tu-154/gauges/misc/gforce_ind", 0) -- g indicator
createGlobalPropertyf("tu-154/gauges/misc/gforce_max", 0) -- max g indicator
createGlobalPropertyf("tu-154/gauges/misc/gforce_min", 0) -- minimum g indicator
createGlobalPropertyi("tu-154/buttons/misc/gforce_reset", 0) -- max-g needle reset button
createGlobalPropertyf("tu-154/gauges/engine/rpm_low_1", 0) -- low pressure turbine rpm No.1
createGlobalPropertyf("tu-154/gauges/engine/rpm_low_2", 0) -- low pressure turbine rpm No.2
createGlobalPropertyf("tu-154/gauges/engine/rpm_low_3", 0) -- low pressure turbine rpm No.3
createGlobalPropertyf("tu-154/gauges/engine/rpm_high_1", 0) -- engine 1 high-pressure spool rpm
createGlobalPropertyf("tu-154/gauges/engine/rpm_high_2", 0) -- engine 2 high-pressure spool rpm
createGlobalPropertyf("tu-154/gauges/engine/rpm_high_3", 0) -- engine 3 high-pressure spool rpm
createGlobalPropertyf("tu-154/gauges/misc/stab_ind", 0) -- stabiliser position indicator
createGlobalPropertyf("tu-154/gauges/misc/elevator_ind", 0) -- elevator position indicator
createGlobalPropertyf("tu-154/gauges/misc/flap_left_ind", 0) -- left flap position indicator
createGlobalPropertyf("tu-154/gauges/misc/flap_right_ind", 0) -- right flap position indicator
createGlobalPropertyi("tu-154/switchers/ZK_select", 0) -- "ZK entry" toggle on the front panel. 0-left, 1-right
createGlobalPropertyi("tu-154/switchers/nav_select", 0) -- NVU-SNS toggle 0 - NVU, 1 - SNS
createGlobalPropertyi("tu-154/switchers/vbe_select", 0) -- VBE toggle. 0-left, 1-right
createGlobalPropertyf("tu-154/gauges/hydro/pressure_ind_1", 0) -- hydraulic system 1 pressure indicator
createGlobalPropertyf("tu-154/gauges/hydro/pressure_ind_2", 0) -- hydraulic system 2 pressure indicator
createGlobalPropertyf("tu-154/gauges/hydro/pressure_ind_3", 0) -- hydraulic system 3 pressure indicator
createGlobalPropertyf("tu-154/gauges/hydro/pressure_ind_emerg", 0) -- emergency braking pressure indicator
createGlobalPropertyf("tu-154/gauges/misc/thermo_outside", 0) -- outside air temperature indicator
createGlobalPropertyf("tu-154/gauges/misc/turn_rate_ind", 0) -- turn indicator
createGlobalPropertyf("tu-154/gauges/misc/slip_rate_ind", 0) -- slip indicator
createGlobalPropertyf("tu-154/gauges/misc/rudder_pos_ind", 0) -- rudder position indicator
createGlobalPropertyf("tu-154/gauges/misc/aileron_pos_ind", 0) -- aileron position indicator
createGlobalPropertyf("tu-154/gauges/misc/elevator_pos_ind", 0) -- elevator position indicator
createGlobalPropertyf("tu-154/gauges/misc/fuel_front_ind", 0) -- fuel indicator on the front panel
createGlobalPropertyi("tu-154/buttons/misc/fuel_front_zero", 0) -- fuel indicator on the front panel. zero button
createGlobalPropertyi("tu-154/buttons/misc/fuel_front_max", 0) -- fuel indicator on the front panel. max button
createGlobalPropertyf("tu-154/gauges/misc/rsbn_azimuth_ind", 0) -- RSBN azimuth
createGlobalPropertyf("tu-154/gauges/misc/rsbn_distance_km", 0) -- RSBN distance
createGlobalPropertyf("tu-154/gauges/misc/rsbn_km_one", 0) -- km units drum
createGlobalPropertyf("tu-154/gauges/misc/rsbn_km_ten", 0) -- km tens drum
createGlobalPropertyf("tu-154/gauges/misc/rsbn_km_hun", 0) -- km hundreds drum
createGlobalPropertyf("tu-154/gauges/misc/compas_big_needle", 0) -- long needle on the copilot's compass
createGlobalPropertyf("tu-154/gauges/misc/compas_small_needle", 0) -- short needle on the copilot's compass
createGlobalPropertyf("tu-154/gauges/misc/compas_knob", 0) -- knob on the copilot's compass
createGlobalPropertyf("tu-154/gauges/misc/diss_abs_angle_1", 1) -- angle units drum
createGlobalPropertyf("tu-154/gauges/misc/diss_abs_angle_10", 2) -- angle tens drum
createGlobalPropertyf("tu-154/gauges/misc/diss_abs_angle_100", 3) -- angle hundreds drum
createGlobalPropertyf("tu-154/gauges/misc/diss_plus_angle_1", 0) -- angle units drum
createGlobalPropertyf("tu-154/gauges/misc/diss_plus_angle_10", 0) -- angle tens drum
createGlobalPropertyf("tu-154/gauges/misc/diss_minus_angle_1", 0) -- angle units drum
createGlobalPropertyf("tu-154/gauges/misc/diss_minus_angle_10", 0) -- angle tens drum
createGlobalPropertyf("tu-154/gauges/misc/diss_wind_spd_1", 0) -- wind speed units drum
createGlobalPropertyf("tu-154/gauges/misc/diss_wind_spd_10", 0) -- wind speed tens drum
createGlobalPropertyf("tu-154/gauges/misc/diss_wind_spd_100", 0) -- wind speed hundreds drum
createGlobalPropertyi("tu-154/switchers/ovhd/var_left", 1) -- overhead. left variometer
createGlobalPropertyi("tu-154/switchers/ovhd/var_right", 1) -- overhead. right variometer
createGlobalPropertyi("tu-154/switchers/ovhd/uvid_on", 1) -- UVID switch
createGlobalPropertyi("tu-154/switchers/ovhd/auasp_on", 1) -- overhead. AUASP
createGlobalPropertyi("tu-154/switchers/ovhd/auasp_contr", 0) -- overhead. AUASP test
createGlobalPropertyi("tu-154/switchers/ovhd/eup_on", 1) -- EUP switch
createGlobalPropertyi("tu-154/switchers/ovhd/agr_on", 1) -- AGR switch
createGlobalPropertyi("tu-154/switchers/ovhd/bkk_contr_cap", 0) -- BKK test toggle cover
createGlobalPropertyi("tu-154/switchers/ovhd/bkk_contr", 0) -- BKK test. -1 - 2, 0 - off, +1 - 1
createGlobalPropertyi("tu-154/switchers/ovhd/bkk_on_cap", 0) -- BKK switch cover
createGlobalPropertyi("tu-154/switchers/ovhd/bkk_on", 1) -- BKK switch
createGlobalPropertyi("tu-154/switchers/ovhd/sau_stu_on", 1) -- SAU/STU switch
createGlobalPropertyi("tu-154/switchers/ovhd/sau_stu_cap", 0) -- SAU STU switch cover
createGlobalPropertyi("tu-154/switchers/ovhd/pkp_left_cap", 0) -- left PKP cover
createGlobalPropertyi("tu-154/switchers/ovhd/pkp_left_on", 1) -- left PKP
createGlobalPropertyi("tu-154/switchers/ovhd/pkp_right_cap", 0) -- right PKP cover
createGlobalPropertyi("tu-154/switchers/ovhd/pkp_right_on", 1) -- right PKP
createGlobalPropertyi("tu-154/switchers/ovhd/mgv_contr_cap", 0) -- MGV test cover
createGlobalPropertyi("tu-154/switchers/ovhd/mgv_contr", 1) -- MGV test
createGlobalPropertyi("tu-154/switchers/ovhd/tks_on_1", 1) -- TKS 1 switch
createGlobalPropertyi("tu-154/switchers/ovhd/tks_on_2", 1) -- TKS 2 switch
createGlobalPropertyi("tu-154/switchers/ovhd/tks_heat", 0) -- GA heating
createGlobalPropertyi("tu-154/switchers/ovhd/tks_corr_1", 1) -- BGMK 2 - 1 correction
createGlobalPropertyi("tu-154/switchers/ovhd/tks_corr_2", 1) -- BGMK 2 - 2 correction
createGlobalPropertyi("tu-154/switchers/ovhd/curs_pnp_mode_1", 1) -- PNP heading mode. 0 = GMK, 1 = GPK
createGlobalPropertyi("tu-154/switchers/ovhd/curs_pnp_mode_2", 1) -- PNP heading mode. 0 = GMK, 1 = GPK
createGlobalPropertyi("tu-154/buttons/ovhd/svs_contr", 0) -- SVS test button
createGlobalPropertyi("tu-154/switchers/ovhd/svs_on", 1) -- SVS switch
createGlobalPropertyi("tu-154/switchers/ovhd/svs_heat", 1) -- SVS heating
createGlobalPropertyi("tu-154/switchers/ovhd/kln_on", 1) -- KLN switch
createGlobalPropertyi("tu-154/switchers/ovhd/tcas_on", 1) -- TCAS switch
createGlobalPropertyi("tu-154/switchers/ovhd/emerg_light_cap", 0) -- emergency lighting cover
createGlobalPropertyi("tu-154/switchers/ovhd/emerg_light_on", 0) -- emergency lighting
createGlobalPropertyi("tu-154/switchers/ovhd/vbe_1_on", 1) -- VBE 1
createGlobalPropertyi("tu-154/switchers/ovhd/vbe_2_on", 1) -- VBE 2
createGlobalPropertyi("tu-154/switchers/ovhd/curs_np_on_1", 1) -- Kurs MP 1
createGlobalPropertyi("tu-154/switchers/ovhd/curs_np_on_2", 1) -- Kurs MP 2
createGlobalPropertyi("tu-154/switchers/ovhd/tra_67_on", 1) -- TRA 67
createGlobalPropertyi("tu-154/buttons/ovhd/tks_signal_off", 0) -- release of the TKS signal inhibit
createGlobalPropertyi("tu-154/switchers/ovhd/rsbn_on", 1) -- RSBN power
createGlobalPropertyi("tu-154/switchers/ovhd/rsbn_recon", 1) -- RSBN identification
createGlobalPropertyi("tu-154/switchers/ovhd/rv5_1_on", 1) -- RV5 1
createGlobalPropertyi("tu-154/switchers/ovhd/rv5_2_on", 1) -- RV5 2
createGlobalPropertyi("tu-154/switchers/ovhd/vhf_1_on", 1) -- VHF 1
createGlobalPropertyi("tu-154/switchers/ovhd/vhf_2_on", 1) -- VHF 2
createGlobalPropertyi("tu-154/switchers/ovhd/stabil_ga_main", 1) -- main GA roll stabilisation
createGlobalPropertyi("tu-154/switchers/ovhd/stabil_ga_reserv", 1) -- standby GA stabilisation
createGlobalPropertyi("tu-154/switchers/ovhd/micron_1_on", 1) -- Mikron 1
createGlobalPropertyi("tu-154/switchers/ovhd/micron_2_on", 1) -- Mikron 2
createGlobalPropertyi("tu-154/switchers/ovhd/spu_on", 1) -- SPU intercom
createGlobalPropertyi("tu-154/switchers/ovhd/sgs_on", 1) -- SGS
createGlobalPropertyi("tu-154/switchers/ovhd/sd75_1_on", 1) -- SD75 1
createGlobalPropertyi("tu-154/switchers/ovhd/sd75_2_on", 1) -- SD75 2
createGlobalPropertyi("tu-154/switchers/ovhd/mars_on", 1) -- MARS
createGlobalPropertyi("tu-154/switchers/ovhd/diss_on", 1) -- DISS power
createGlobalPropertyi("tu-154/switchers/ovhd/diss_mode", 1) -- DISS mode. 0 - sea, 1 - land
createGlobalPropertyi("tu-154/switchers/ovhd/nvu_calc_set", 1) -- dead reckoning. -1 - DISS check in flight, 0 - NVU from SVS, 1 - NVU from DISS
createGlobalPropertyi("tu-154/switchers/ovhd/vent_1", 0) -- captain's fan
createGlobalPropertyi("tu-154/switchers/ovhd/vent_2", 0) -- copilot's fan
createGlobalPropertyi("tu-154/switchers/ovhd/vent_3", 0) -- flight engineer's fan
createGlobalPropertyi("tu-154/switchers/ovhd/sign_belts", 1) -- fasten seat belts sign
createGlobalPropertyi("tu-154/switchers/ovhd/sign_nosmoke", 1) -- no smoking annunciator
createGlobalPropertyi("tu-154/switchers/ovhd/sign_exit", 0) -- exit annunciator
createGlobalPropertyi("tu-154/switchers/ovhd/window_heat_1", -1) -- window heating. -1 = low, 0 = off, 1 = high
createGlobalPropertyi("tu-154/switchers/ovhd/window_heat_2", -1) -- window heating. -1 = low, 0 = off, 1 = high
createGlobalPropertyi("tu-154/switchers/ovhd/window_heat_3", -1) -- window heating. -1 = low, 0 = off, 1 = high
createGlobalPropertyi("tu-154/switchers/ovhd/pitot_heat_1", 1) -- left pitot heating
createGlobalPropertyi("tu-154/switchers/ovhd/pitot_heat_2", 1) -- right pitot heating
createGlobalPropertyi("tu-154/switchers/ovhd/pitot_heat_3", 1) -- ABSU pitot heating
createGlobalPropertyi("tu-154/switchers/ovhd/arm406", 1) -- ARM 406
createGlobalPropertyi("tu-154/switchers/ovhd/ushdb_mode_1", 0) -- USHDB and SPU 1. 0 - ARK, 1 - VOR
createGlobalPropertyi("tu-154/switchers/ovhd/ushdb_mode_2", 0) -- pitot heating
createGlobalPropertyi("tu-154/switchers/ovhd/egpws_alarm_1", 1) -- SRPBZ (GPWS) warning, general
createGlobalPropertyi("tu-154/switchers/ovhd/egpws_alarm_2", 1) -- SRPBZ (GPWS) warning
createGlobalPropertyi("tu-154/switchers/ovhd/egpws_alarm_1_cap", 0) -- SRPBZ (GPWS) warning, general
createGlobalPropertyi("tu-154/switchers/ovhd/egpws_alarm_2_cap", 0) -- SRPBZ (GPWS) warning
createGlobalPropertyi("tu-154/switchers/ovhd/egpws_relief", 1) -- terrain
createGlobalPropertyi("tu-154/switchers/ovhd/egpws_mode", 0) -- QNH - QFE
createGlobalPropertyi("tu-154/buttons/ovhd/egpws_control", 0) -- SRPBZ test button
createGlobalPropertyi("tu-154/buttons/ovhd/egpws_contr_gs", 0) -- SRPBZ glideslope test
createGlobalPropertyi("tu-154/buttons/ovhd/rsbn_control_strobe", 0) -- RSBN strobe test
createGlobalPropertyi("tu-154/buttons/ovhd/rsbn_control_azimuth", 0) -- RSBN azimuth zero test
createGlobalPropertyi("tu-154/buttons/ovhd/rsbn_control_distance", 0) -- RSBN range zero test
createGlobalPropertyi("tu-154/buttons/ovhd/rsbn_ch_ten", 0) -- channel tens setting knob
createGlobalPropertyi("tu-154/buttons/ovhd/rsbn_ch_one", 0) -- channel units setting knob
createGlobalPropertyi("tu-154/switchers/ovhd/transponder_mode", 0) -- transponder mode. 0 off, 1 ready, 2 rsp, 3 uvd, 4 uvd-m, 5 as, 6 a.
createGlobalPropertyi("tu-154/buttons/ovhd/transponder_control", 0) -- test button
createGlobalPropertyi("tu-154/buttons/ovhd/transponder_sign", 0) -- sign button
createGlobalPropertyi("tu-154/ovhd/so72_code", 0) -- sign button
createGlobalPropertyi("tu-154/buttons/ovhd/transponder_but_1", 0) -- button 1
createGlobalPropertyi("tu-154/buttons/ovhd/transponder_but_2", 0) -- button 2
createGlobalPropertyi("tu-154/buttons/ovhd/transponder_but_3", 0) -- button 3
createGlobalPropertyi("tu-154/buttons/ovhd/transponder_but_4", 0) -- button 4
createGlobalPropertyi("tu-154/buttons/ovhd/transponder_emerg", 0) -- emergency button
createGlobalPropertyi("tu-154/buttons/ovhd/transponder_emerg_cap", 0) -- emergency button cover
createGlobalPropertyi("tu-154/switchers/ovhd/tks_mode", 1) -- TKS mode. 0 = MK, 1 = GPK, 2 = AK
createGlobalPropertyi("tu-154/switchers/ovhd/tks_mode_left", 1) -- left gyro unit mode. 0 - monitoring, 1 - main
createGlobalPropertyi("tu-154/switchers/ovhd/tks_mode_right", 1) -- right gyro unit mode
createGlobalPropertyi("tu-154/switchers/ovhd/tks_lat_mode", 1) -- latitude setting mode. 0 - auto, 1 - manual
createGlobalPropertyi("tu-154/switchers/ovhd/tks_course_set", 0) -- heading selector
createGlobalPropertyi("tu-154/buttons/ovhd/tks_corrr_button", 0) -- slaving button
createGlobalPropertyf("tu-154/rotary/ovhd/tks_lat_set", 45) -- latitude setting knob
createGlobalPropertyi("tu-154/switchers/ovhd/ark_1_mode", 1) -- ARK 1 mode. 0 = off, 1 = compass, 2 = antenna, 3 = loop
createGlobalPropertyi("tu-154/switchers/ovhd/ark_1_channel", 1) -- ARK 1 channel
createGlobalPropertyi("tu-154/switchers/ovhd/ark_1_hundr_left", 1) -- frequency hundreds 1 - 17
createGlobalPropertyi("tu-154/switchers/ovhd/ark_1_tens_left", 1) -- frequency tens 1 - 10 (0)
createGlobalPropertyi("tu-154/switchers/ovhd/ark_1_ones_left", 0) -- frequency units 0 - 9
createGlobalPropertyi("tu-154/switchers/ovhd/ark_1_hundr_right", 1) -- frequency hundreds 1 - 17
createGlobalPropertyi("tu-154/switchers/ovhd/ark_1_tens_right", 1) -- frequency tens 1 - 10 (0)
createGlobalPropertyi("tu-154/switchers/ovhd/ark_1_ones_right", 0) -- frequency units 0 - 9
createGlobalPropertyi("tu-154/buttons/ovhd/ark_1_ramka", 0) -- loop antenna button
createGlobalPropertyi("tu-154/switchers/ovhd/ark_2_mode", 1) -- ARK 2 mode
createGlobalPropertyi("tu-154/switchers/ovhd/ark_2_channel", 1) -- ARK 2 channel
createGlobalPropertyi("tu-154/switchers/ovhd/ark_2_hundr_left", 1) -- frequency hundreds 1 - 17
createGlobalPropertyi("tu-154/switchers/ovhd/ark_2_tens_left", 1) -- frequency tens 1 - 10 (0)
createGlobalPropertyi("tu-154/switchers/ovhd/ark_2_ones_left", 0) -- frequency units 0 - 9
createGlobalPropertyi("tu-154/switchers/ovhd/ark_2_hundr_right", 1) -- frequency hundreds 1 - 17
createGlobalPropertyi("tu-154/switchers/ovhd/ark_2_tens_right", 1) -- frequency tens 1 - 10 (0)
createGlobalPropertyi("tu-154/switchers/ovhd/ark_2_ones_right", 0) -- frequency units 0 - 9
createGlobalPropertyi("tu-154/buttons/ovhd/ark_2_ramka", 0) -- loop antenna button
createGlobalPropertyi("tu-154/switchers/ovhd/sp50_mode", 0) -- SP50 mode. 0 - ILS, 1 - Katet, 2 - SP-50
createGlobalPropertyi("tu-154/switchers/ovhd/sp50_nav_mode", 0) -- SP50 mode. landing - en route
createGlobalPropertyi("tu-154/switchers/ovhd/sp50_night_day", 1) -- SP50 mode. night - day
createGlobalPropertyi("tu-154/switchers/ovhd/sp50_dme_rsbn", 0) -- SP50 mode. DME - RSBN
createGlobalPropertyi("tu-154/rotary/ovhd/vhf_1_left", 0) -- left radio knob
createGlobalPropertyi("tu-154/rotary/ovhd/vhf_1_right", 0) -- right radio knob
createGlobalPropertyi("tu-154/rotary/ovhd/vhf_2_left", 0) -- left radio knob
createGlobalPropertyi("tu-154/rotary/ovhd/vhf_2_right", 0) -- right radio knob
createGlobalPropertyi("tu-154/switchers/nav_1_mode", 1) -- NAV1 mode. Capture - VOR-DME
createGlobalPropertyi("tu-154/switchers/nav_1_man_auto", 0) -- manual - automatic mode
createGlobalPropertyi("tu-154/switchers/nav_1_mile_km", 1) -- miles/km mode
createGlobalPropertyi("tu-154/rotary/ovhd/nav_1_left", 0) -- left knob
createGlobalPropertyi("tu-154/rotary/ovhd/nav_1_right", 0) -- right knob
createGlobalPropertyi("tu-154/buttons/ovhd/nav_1_but_1", 0) -- button 1
createGlobalPropertyi("tu-154/buttons/ovhd/nav_1_but_2", 0) -- button 2
createGlobalPropertyi("tu-154/buttons/ovhd/nav_1_but_3", 0) -- button 3
createGlobalPropertyi("tu-154/switchers/nav_2_mode", 1) -- NAV1 mode. Capture - VOR-DME
createGlobalPropertyi("tu-154/switchers/nav_2_man_auto", 0) -- manual - automatic mode
createGlobalPropertyi("tu-154/switchers/nav_2_mile_km", 1) -- miles/km mode
createGlobalPropertyi("tu-154/rotary/ovhd/nav_2_left", 0) -- left knob
createGlobalPropertyi("tu-154/rotary/ovhd/nav_2_right", 0) -- right knob
createGlobalPropertyi("tu-154/buttons/ovhd/nav_2_but_1", 0) -- button 1
createGlobalPropertyi("tu-154/buttons/ovhd/nav_2_but_2", 0) -- button 2
createGlobalPropertyi("tu-154/buttons/ovhd/nav_2_but_3", 0) -- button 3
createGlobalPropertyf("tu-154/gauges/eng/fuel_temp_1", 20) -- fuel temperature
createGlobalPropertyf("tu-154/gauges/eng/fuel_temp_2", 20) -- fuel temperature
createGlobalPropertyf("tu-154/gauges/eng/oil_qty_1", 1) -- oil quantity
createGlobalPropertyf("tu-154/gauges/eng/oil_qty_2", 1) -- oil quantity
createGlobalPropertyf("tu-154/gauges/eng/oil_qty_3", 1) -- oil quantity
createGlobalPropertyf("tu-154/gauges/eng/km5_scale_1", 0) -- KM-5 scale rotation
createGlobalPropertyf("tu-154/gauges/eng/km5_needle_1", 0) -- KM5 needle
createGlobalPropertyf("tu-154/gauges/eng/km5_knob_1", 0) -- KM-5 knob
createGlobalPropertyf("tu-154/gauges/eng/km5_scale_2", 0) -- KM-5 scale rotation
createGlobalPropertyf("tu-154/gauges/eng/km5_needle_2", 0) -- KM5 needle
createGlobalPropertyf("tu-154/gauges/eng/km5_knob_2", 0) -- KM-5 knob
createGlobalPropertyi("tu-154/buttons/lamp_test_front", 0) -- front panel lamp test button
createGlobalPropertyi("tu-154/buttons/lamp_test_upper_gear", 0) -- landing gear overhead panel lamp test button
createGlobalPropertyi("tu-154/buttons/lamp_test_eng_up_1", 0) -- lamp test button on the drain nozzle panel
createGlobalPropertyi("tu-154/buttons/lamp_test_eng_up_2", 0) -- lamp test button on the drain nozzle panel
createGlobalPropertyi("tu-154/buttons/lamp_test_msrp", 0) -- MSRP lamp test button
createGlobalPropertyi("tu-154/buttons/lamp_test_pa56", 0) -- lamp test button on the RA-56 hydraulic supply panel
createGlobalPropertyi("tu-154/buttons/lamp_test_fire_panel", 0) -- lamp test button on the fire panel
createGlobalPropertyi("tu-154/buttons/lamp_test_apu", 0) -- lamp test button on the APU panel
createGlobalPropertyi("tu-154/buttons/lamp_test_engines", 0) -- lamp test button on the engine instrument panel
createGlobalPropertyi("tu-154/buttons/lamp_test_hydro", 0) -- lamp test button on the hydraulic panel
createGlobalPropertyi("tu-154/buttons/lamp_test_srd", 0) -- lamp test button on the pressurisation panel
createGlobalPropertyi("tu-154/buttons/lamp_test_doors", 0) -- lamp test button on the door and hatch indication panel
createGlobalPropertyi("tu-154/switchers/eng/wing_light", 1) -- wing ground marker lights
createGlobalPropertyi("tu-154/switchers/eng/door_heat", 0) -- door heating
createGlobalPropertyi("tu-154/switchers/eng/gear_fan", 0) -- landing gear bay ventilation
createGlobalPropertyi("tu-154/switchers/eng/galley_heat", 0) -- galley drain heating
createGlobalPropertyi("tu-154/switchers/eng/lavatory_heat", 0) -- toilet drain heating
createGlobalPropertyi("tu-154/switchers/eng/water_meter", 0) -- water level in the tank
createGlobalPropertyi("tu-154/switchers/eng/water_compressor_1", 0) -- galley drain heating
createGlobalPropertyi("tu-154/switchers/eng/water_compressor_2", 0) -- galley drain heating
createGlobalPropertyf("tu-154/gauges/eng/water_pressure", 0) -- water pressure
createGlobalPropertyi("tu-154/buttons/eng/tail_temp_signal_control_1", 0) -- tail compartment temperature signal test
createGlobalPropertyi("tu-154/buttons/eng/tail_temp_signal_control_2", 0) -- tail compartment temperature signal test
createGlobalPropertyi("tu-154/switchers/eng/tail_temp_signal", 0) -- tail compartment temperature signal
createGlobalPropertyi("tu-154/switchers/eng/tail_temp_heat", 0) -- ARD heating
createGlobalPropertyi("tu-154/switchers/eng/msrp_date_ten", 0) -- MSRP date, day tens
createGlobalPropertyi("tu-154/switchers/eng/msrp_date_one", 0) -- MSRP date, day units
createGlobalPropertyi("tu-154/switchers/eng/msrp_month_ten", 0) -- MSRP date, month tens
createGlobalPropertyi("tu-154/switchers/eng/msrp_month_one", 0) -- MSRP date, month units
createGlobalPropertyi("tu-154/switchers/eng/msrp_year_ten", 0) -- MSRP date, year tens
createGlobalPropertyi("tu-154/switchers/eng/msrp_year_one", 0) -- MSRP date, year units
createGlobalPropertyi("tu-154/switchers/eng/msrp_route_hun", 0) -- MSRP flight number. hundreds
createGlobalPropertyi("tu-154/switchers/eng/msrp_route_ten", 0) -- MSRP flight number. tens
createGlobalPropertyi("tu-154/switchers/eng/msrp_route_one", 0) -- MSRP flight number. units
createGlobalPropertyi("tu-154/switchers/eng/msrp_mlp_1", 1) -- MSRP mlp main
createGlobalPropertyi("tu-154/switchers/eng/msrp_mlp_2", 1) -- MSRP mlp additional
createGlobalPropertyi("tu-154/switchers/eng/msrp_night_day", 1) -- MSRP night - day
createGlobalPropertyi("tu-154/switchers/eng/msrp_main_switch", 1) -- MSRP master switch
createGlobalPropertyi("tu-154/switchers/eng/hydro_trimm_rud_1", 1) -- elevator trim 1
createGlobalPropertyi("tu-154/switchers/eng/hydro_trimm_rud_2", 1) -- elevator trim 2
createGlobalPropertyi("tu-154/switchers/eng/hydro_trimm_rud_1_cap", 0) -- elevator trim 1
createGlobalPropertyi("tu-154/switchers/eng/hydro_trimm_rud_2_cap", 0) -- elevator trim 2
createGlobalPropertyi("tu-154/switchers/eng/emerg_gen_on_1", 0) -- emergency generator activation
createGlobalPropertyi("tu-154/switchers/eng/emerg_gen_on_2", 0) -- emergency generator activation
createGlobalPropertyi("tu-154/switchers/eng/emerg_gen_on_3", 0) -- emergency generator activation
createGlobalPropertyi("tu-154/switchers/eng/emerg_gen_on_1_cap", 0) -- emergency generator activation
createGlobalPropertyi("tu-154/switchers/eng/emerg_gen_on_2_cap", 0) -- emergency generator activation
createGlobalPropertyi("tu-154/switchers/eng/emerg_gen_on_3_cap", 0) -- emergency generator activation
createGlobalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_1", 1) -- RA-56 yaw hydraulic supply
createGlobalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_2", 1) -- RA-56 yaw hydraulic supply
createGlobalPropertyi("tu-154/switchers/eng/hydro_ra56_rud_3", 1) -- RA-56 yaw hydraulic supply
createGlobalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_1", 1) -- RA-56 roll hydraulic supply
createGlobalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_2", 1) -- RA-56 roll hydraulic supply
createGlobalPropertyi("tu-154/switchers/eng/hydro_ra56_ail_3", 1) -- RA-56 roll hydraulic supply
createGlobalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_1", 1) -- RA-56 pitch hydraulic supply
createGlobalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_2", 1) -- RA-56 pitch hydraulic supply
createGlobalPropertyi("tu-154/switchers/eng/hydro_ra56_elev_3", 1) -- RA-56 pitch hydraulic supply
createGlobalPropertyi("tu-154/switchers/eng/hydro_circuit_auto_man", 0) -- crossfeed auto - manual
createGlobalPropertyi("tu-154/switchers/eng/hydro_long_control", 1) -- longitudinal controllability
createGlobalPropertyi("tu-154/switchers/eng/hydro_circuit_auto_man_cap", 0) -- crossfeed auto - manual
createGlobalPropertyi("tu-154/switchers/eng/hydro_long_control_cap", 0) -- longitudinal controllability
createGlobalPropertyi("tu-154/buttons/eng/fire_ext_1", 0) -- fire extinguishing sequence
createGlobalPropertyi("tu-154/buttons/eng/fire_ext_2", 0) -- fire extinguishing sequence
createGlobalPropertyi("tu-154/buttons/eng/fire_ext_3", 0) -- fire extinguishing sequence
createGlobalPropertyi("tu-154/buttons/eng/cold_eng_1", 0) -- halon discharge
createGlobalPropertyi("tu-154/buttons/eng/cold_eng_2", 0) -- halon discharge
createGlobalPropertyi("tu-154/buttons/eng/cold_eng_3", 0) -- halon discharge
createGlobalPropertyi("tu-154/buttons/eng/cold_apu", 0) -- halon discharge
createGlobalPropertyi("tu-154/buttons/eng/neutral_gas", 0) -- neutral gas
createGlobalPropertyi("tu-154/buttons/eng/smoke_test", 0) -- halon discharge
createGlobalPropertyi("tu-154/buttons/eng/ext_test", 0) -- halon discharge
createGlobalPropertyi("tu-154/switchers/eng/fire_sensor_sel", 0) -- sensor group selection
createGlobalPropertyi("tu-154/switchers/eng/fire_place_sel", 0) -- compartment selection
createGlobalPropertyi("tu-154/switchers/eng/fire_main_switch", 1) -- fire system switch
createGlobalPropertyi("tu-154/switchers/eng/fire_buzzer", 1) -- fire siren
createGlobalPropertyi("tu-154/switchers/eng/fire_buzzer_cap", 0) -- fire siren
createGlobalPropertyi("tu-154/switchers/eng/srd_buzzer", 1) -- SRD siren
createGlobalPropertyi("tu-154/switchers/eng/srd_buzzer_cap", 0) -- SRD siren
createGlobalPropertyi("tu-154/buttons/eng/srd_buzzer_test", 0) -- SRD siren test
createGlobalPropertyi("tu-154/switchers/eng/fuel_buzzer", 1) -- 2500 kg fuel remaining siren
createGlobalPropertyi("tu-154/switchers/eng/fuel_buzzer_cap", 0) -- 2500 kg fuel remaining siren
createGlobalPropertyi("tu-154/switchers/eng/soi21_on", 1) -- SOI 21 switch
createGlobalPropertyi("tu-154/buttons/eng/soi21_test", 0) -- SOI 21 test
createGlobalPropertyi("tu-154/switchers/eng/antiice_slats", 0) -- anti-icers
createGlobalPropertyi("tu-154/switchers/eng/antiice_eng_1", 0) -- anti-icers
createGlobalPropertyi("tu-154/switchers/eng/antiice_eng_2", 0) -- anti-icers
createGlobalPropertyi("tu-154/switchers/eng/antiice_eng_3", 0) -- anti-icers
createGlobalPropertyi("tu-154/switchers/eng/antiice_wing", 0) -- anti-icers
createGlobalPropertyf("tu-154/gauges/eng/stab_temp", 20) -- stabiliser temperature
createGlobalPropertyf("tu-154/gauges/eng/wing_temp", 20) -- wing temperature
createGlobalPropertyi("tu-154/switchers/eng/sard_disable", 0) -- air dump valve shutoff
createGlobalPropertyi("tu-154/switchers/eng/sard_disable_cap", 0) -- air dump valve shutoff
createGlobalPropertyf("tu-154/gauges/eng/bus115_freq", 0) -- 115 V bus frequency meter - angle
createGlobalPropertyf("tu-154/gauges/eng/bus115_volt", 0) -- 115 V bus voltmeter - angle
createGlobalPropertyf("tu-154/gauges/eng/bus115_amp", 0) -- 115 V bus ammeter - angle
createGlobalPropertyi("tu-154/switchers/eng/gpu_on", 0) -- RAP switch
createGlobalPropertyi("tu-154/switchers/eng/apu_gen_on", 0) -- APU generator switch
createGlobalPropertyi("tu-154/switchers/eng/bus115_volt_sel", 0) -- voltmeter source selector
createGlobalPropertyi("tu-154/switchers/eng/bus115_volt_phase_sel", 0) -- voltmeter source selector
createGlobalPropertyi("tu-154/switchers/eng/bus115_amp_sel", 0) -- ammeter source selector
createGlobalPropertyi("tu-154/switchers/eng/bus115_amp_phase_sel", 0) -- ammeter source selector
createGlobalPropertyi("tu-154/switchers/eng/gen_1_on", 1) -- generator 1 switch. -1 - test, 0 - off, +1 - on.
createGlobalPropertyi("tu-154/switchers/eng/gen_2_on", 1) -- generator 2 switch. -1 - test, 0 - off, +1 - on.
createGlobalPropertyi("tu-154/switchers/eng/gen_3_on", 1) -- generator 3 switch. -1 - test, 0 - off, +1 - on.
createGlobalPropertyi("tu-154/switchers/eng/emerg_inv115", 0) -- emergency 115 V inverter
createGlobalPropertyi("tu-154/switchers/eng/emerg_inv115_cap", 0) -- emergency 115 V inverter
createGlobalPropertyf("tu-154/gauges/eng/bus36_volt", 0) -- 36 V bus voltmeter - angle
createGlobalPropertyi("tu-154/switchers/eng/bus36_volt_sel", 0) -- 36 V voltmeter selector
createGlobalPropertyi("tu-154/switchers/eng/pts250_sel", 0) -- PTS250 selector. 0 - No.1, 1 - No.2
createGlobalPropertyi("tu-154/switchers/eng/bus36_tr_left_to_right", 0) -- left bus on tr2. 0 - auto, 1 - manual
createGlobalPropertyi("tu-154/switchers/eng/bus36_tr_right_to_left", 0) -- right bus on tr1
createGlobalPropertyi("tu-154/switchers/eng/pts250_on", 0) -- PTS-250 switch
createGlobalPropertyi("tu-154/switchers/eng/pts250_mode", 0) -- PTS-250 mode. auto - manual
createGlobalPropertyi("tu-154/switchers/eng/pts250_on_cap", 0) -- PTS-250 switch
createGlobalPropertyi("tu-154/switchers/eng/pts250_mode_cap", 0) -- PTS-250 mode. auto - manual
createGlobalPropertyf("tu-154/gauges/eng/bus27_volt", 0) -- 27 V bus voltmeter - angle
createGlobalPropertyf("tu-154/gauges/eng/bus27_amp1", 0) -- 27 V bus ammeter - angle
createGlobalPropertyf("tu-154/gauges/eng/bus27_amp2", 0) -- 27 V bus ammeter - angle
createGlobalPropertyi("tu-154/switchers/eng/bus27_volt_sel", 0) -- 27 V voltmeter selector
createGlobalPropertyi("tu-154/switchers/eng/bus27_amp1_sel", 0) -- 27 V ammeter selector
createGlobalPropertyi("tu-154/switchers/eng/bus27_amp2_sel", 0) -- 27 V ammeter selector
createGlobalPropertyi("tu-154/switchers/eng/bus27_connect", 0) -- 27 V bus tie
createGlobalPropertyi("tu-154/switchers/eng/bus27_connect_cap", 0) -- 27 V bus tie
createGlobalPropertyi("tu-154/switchers/eng/bus27_vu1", 1) -- VU1. -1 - standby, 0 - off, +1 - on.
createGlobalPropertyi("tu-154/switchers/eng/bus27_vu2", 1) -- VU2. -1 - standby, 0 - off, +1 - on.
createGlobalPropertyi("tu-154/switchers/eng/bat1_on", 1) -- battery 1
createGlobalPropertyi("tu-154/switchers/eng/bat2_on", 1) -- battery 2
createGlobalPropertyi("tu-154/switchers/eng/bat3_on", 1) -- battery 3
createGlobalPropertyi("tu-154/switchers/eng/bat4_on", 1) -- battery 4
createGlobalPropertyi("tu-154/switchers/eng/apu_main_switch", 0) -- APU switch
createGlobalPropertyi("tu-154/switchers/eng/apu_start_mode", 0) -- APU start mode
createGlobalPropertyi("tu-154/switchers/eng/apu_air_bleed", 0) -- bleed air valve switching. -1 - close, 0 - neutral, +1 - open
createGlobalPropertyi("tu-154/buttons/eng/apu_start", 0) -- APU start button
createGlobalPropertyi("tu-154/buttons/eng/apu_stop", 0) -- APU stop button
createGlobalPropertyf("tu-154/gauges/eng/apu_rpm", 0) -- APU rpm
createGlobalPropertyf("tu-154/gauges/eng/apu_egt", 0) -- APU EGT
createGlobalPropertyf("tu-154/gauges/eng/apu_oil_temp", 0) -- APU oil temperature
createGlobalPropertyf("tu-154/gauges/eng/egt_1", 20) -- EGT engine 1
createGlobalPropertyf("tu-154/gauges/eng/egt_2", 20) -- EGT engine 2
createGlobalPropertyf("tu-154/gauges/eng/egt_3", 20) -- EGT engine 3
createGlobalPropertyf("tu-154/gauges/eng/fuel_press_1", 0) -- engine 1 fuel pressure
createGlobalPropertyf("tu-154/gauges/eng/fuel_press_2", 0) -- engine 2 fuel pressure
createGlobalPropertyf("tu-154/gauges/eng/fuel_press_3", 0) -- engine 3 fuel pressure
createGlobalPropertyf("tu-154/gauges/eng/oil_press_1", 0) -- engine 1 oil pressure
createGlobalPropertyf("tu-154/gauges/eng/oil_press_2", 0) -- engine 2 oil pressure
createGlobalPropertyf("tu-154/gauges/eng/oil_press_3", 0) -- engine 3 oil pressure
createGlobalPropertyf("tu-154/gauges/eng/oil_temp_1", 0) -- engine 1 oil temperature
createGlobalPropertyf("tu-154/gauges/eng/oil_temp_2", 0) -- engine 2 oil temperature
createGlobalPropertyf("tu-154/gauges/eng/oil_temp_3", 0) -- engine 3 oil temperature
createGlobalPropertyf("tu-154/gauges/eng/fuel_flow_1", 0) -- engine 1 fuel flow
createGlobalPropertyf("tu-154/gauges/eng/fuel_flow_2", 0) -- engine 2 fuel flow
createGlobalPropertyf("tu-154/gauges/eng/fuel_flow_3", 0) -- engine 3 fuel flow
createGlobalPropertyf("tu-154/gauges/eng/vibra_1", 0) -- engine 1 vibration
createGlobalPropertyf("tu-154/gauges/eng/vibra_2", 0) -- engine 2 vibration
createGlobalPropertyf("tu-154/gauges/eng/vibra_3", 0) -- engine 3 vibration
createGlobalPropertyi("tu-154/buttons/eng/control_ut", 0) -- UT test button
createGlobalPropertyi("tu-154/buttons/eng/control_vibro_1", 0) -- vibration check button
createGlobalPropertyi("tu-154/buttons/eng/control_vibro_2", 0) -- vibration check button
createGlobalPropertyi("tu-154/buttons/eng/control_vibro_3", 0) -- vibration check button
createGlobalPropertyi("tu-154/switchers/eng/vibro_sel_1", 0) -- vibration indicator selector
createGlobalPropertyi("tu-154/switchers/eng/vibro_sel_2", 0) -- vibration indicator selector
createGlobalPropertyi("tu-154/switchers/eng/vibro_sel_3", 0) -- vibration indicator selector
createGlobalPropertyf("tu-154/gauges/fuel/fuel_meter_summ", 0) -- total fuel mass
createGlobalPropertyf("tu-154/gauges/fuel/fuel_meter_tank1", 0) -- fuel mass in tank 1
createGlobalPropertyf("tu-154/gauges/fuel/fuel_meter_tank2_left", 0) -- fuel mass in tank 2
createGlobalPropertyf("tu-154/gauges/fuel/fuel_meter_tank2_right", 0) -- fuel mass in tank 2
createGlobalPropertyf("tu-154/gauges/fuel/fuel_meter_tank3_left", 0) -- fuel mass in tank 3
createGlobalPropertyf("tu-154/gauges/fuel/fuel_meter_tank3_right", 0) -- fuel mass in tank 3
createGlobalPropertyf("tu-154/gauges/fuel/fuel_meter_tank4", 0) -- fuel mass in tank 4
createGlobalPropertyf("tu-154/gauges/fuel/fuel_meter_mech", 0) -- flowmeter
createGlobalPropertyi("tu-154/buttons/fuel/fuel_meter_summ_zero", 0) -- total fuel mass. zero button
createGlobalPropertyi("tu-154/buttons/fuel/fuel_meter_summ_max", 0) -- total fuel mass. P button
createGlobalPropertyi("tu-154/buttons/fuel/fuel_meter_tank2_zero", 0) -- tank 2 fuel gauge. zero button
createGlobalPropertyi("tu-154/buttons/fuel/fuel_meter_tank2_max", 0) -- tank 2 fuel gauge. P button
createGlobalPropertyi("tu-154/buttons/fuel/fuel_meter_tank3_zero", 0) -- tank 3 fuel gauge. zero button
createGlobalPropertyi("tu-154/buttons/fuel/fuel_meter_tank3_max", 0) -- tank 3 fuel gauge. P button
createGlobalPropertyi("tu-154/buttons/fuel/fuel_meter_tank4_zero", 0) -- tank 4 fuel gauge. zero button
createGlobalPropertyi("tu-154/buttons/fuel/fuel_meter_tank4_max", 0) -- tank 4 fuel gauge. P button
createGlobalPropertyi("tu-154/switchers/fuel/pump_tank2_left", 1) -- tank 2 pumps
createGlobalPropertyi("tu-154/switchers/fuel/pump_tank2_right", 1) -- tank 2 pumps
createGlobalPropertyi("tu-154/switchers/fuel/pump_tank3_left", 1) -- tank 3 pumps
createGlobalPropertyi("tu-154/switchers/fuel/pump_tank3_right", 1) -- tank 3 pumps
createGlobalPropertyi("tu-154/switchers/fuel/pump_tank4", 1) -- tank 4 pumps
createGlobalPropertyi("tu-154/switchers/fuel/pump_tank1_1", 1) -- tank 1 pumps
createGlobalPropertyi("tu-154/switchers/fuel/pump_tank1_2", 1) -- tank 1 pumps
createGlobalPropertyi("tu-154/switchers/fuel/pump_tank1_3", 1) -- tank 1 pumps
createGlobalPropertyi("tu-154/switchers/fuel/pump_tank1_4", 1) -- tank 1 pumps
createGlobalPropertyi("tu-154/switchers/fuel/fuel_trans", 0) -- standby transfer valves
createGlobalPropertyi("tu-154/switchers/fuel/fuel_trans_cap", 0) -- standby transfer valves
createGlobalPropertyi("tu-154/switchers/fuel/fuel_porc", 0) -- forced, metered
createGlobalPropertyi("tu-154/switchers/fuel/fuel_porc_cap", 0) -- forced, metered
createGlobalPropertyi("tu-154/switchers/fuel/fuel_level", 1) -- flare-out computer
createGlobalPropertyi("tu-154/switchers/fuel/fuel_flow_mode", 1) -- flowmeter mode. manual - automatic
createGlobalPropertyi("tu-154/switchers/fuel/fuel_flow_on", 1) -- fuel usage controller
createGlobalPropertyi("tu-154/switchers/fuel/fuel_flow_on_cap", 0) -- fuel usage controller
createGlobalPropertyi("tu-154/switchers/fuel/fuel_meter_on", 1) -- fuel gauge
createGlobalPropertyi("tu-154/switchers/fuel/fuel_meter_mech_on", 1) -- flowmeter
createGlobalPropertyi("tu-154/switchers/fuel/fire_valve_1", 1) -- fire shutoff valve
createGlobalPropertyi("tu-154/switchers/fuel/fire_valve_2", 1) -- fire shutoff valve
createGlobalPropertyi("tu-154/switchers/fuel/fire_valve_3", 1) -- fire shutoff valve
createGlobalPropertyi("tu-154/switchers/fuel/fire_valve_1_cap", 0) -- fire shutoff valve
createGlobalPropertyi("tu-154/switchers/fuel/fire_valve_2_cap", 0) -- fire shutoff valve
createGlobalPropertyi("tu-154/switchers/fuel/fire_valve_3_cap", 0) -- fire shutoff valve
createGlobalPropertyf("tu-154/gauges/hydro/qty_12", 0) -- hydraulic tanks
createGlobalPropertyf("tu-154/gauges/hydro/qty_3", 0) -- hydraulic tanks
createGlobalPropertyi("tu-154/switchers/hydro/connect2to1", 0) -- connect hydraulic system 2 to system 1
createGlobalPropertyi("tu-154/switchers/hydro/connect2to1_cap", 0) -- connect hydraulic system 2 to system 1
createGlobalPropertyi("tu-154/switchers/hydro/pump_2", 0) -- hydraulic pumps 2
createGlobalPropertyi("tu-154/switchers/hydro/pump_3", 0) -- hydraulic pumps 3
createGlobalPropertyi("tu-154/buttons/hydro/qty_test_12", 0) -- level test
createGlobalPropertyi("tu-154/buttons/hydro/qty_test_3", 0) -- level test
createGlobalPropertyi("tu-154/buttons/hydro/accum_fill", 0) -- battery charging
createGlobalPropertyf("tu-154/gauges/airbleed/cabin_alt", 0) -- cabin altitude
createGlobalPropertyf("tu-154/gauges/airbleed/cabin_diff", 0) -- pressure differential
createGlobalPropertyf("tu-154/gauges/airbleed/cabin_vvi", 0) -- cabin variometer. angle
createGlobalPropertyf("tu-154/gauges/airbleed/cockpit_temp", 20) -- cabin temperature
createGlobalPropertyf("tu-154/gauges/airbleed/cabin_temp", 20) -- cabin temperature
createGlobalPropertyf("tu-154/gauges/airbleed/system_temp", 20) -- duct temperature
createGlobalPropertyf("tu-154/gauges/airbleed/air_flow_1", 0) -- air flow. angle
createGlobalPropertyf("tu-154/gauges/airbleed/air_flow_2", 0) -- air flow. angle
createGlobalPropertyi("tu-154/switchers/airbleed/cabin_sel", 0) -- cabin selection
createGlobalPropertyi("tu-154/switchers/airbleed/cockpit_temp_set", 20) -- cockpit temperature setting
createGlobalPropertyi("tu-154/switchers/airbleed/cabin1_temp_set", 20) -- cabin temperature setting
createGlobalPropertyi("tu-154/switchers/airbleed/cabin2_temp_set", 20) -- cabin temperature setting
createGlobalPropertyi("tu-154/switchers/airbleed/cockpit_mode_set", 1) -- heating mode setting. 0 - neutral. 1 - auto, 2 - cold, 3 - hot
createGlobalPropertyi("tu-154/switchers/airbleed/cabin1_mode_set", 1) -- heating mode setting
createGlobalPropertyi("tu-154/switchers/airbleed/cabin2_mode_set", 1) -- heating mode setting
createGlobalPropertyi("tu-154/switchers/airbleed/heat_close", 0) -- heating stopped
createGlobalPropertyi("tu-154/switchers/airbleed/heat_close_cap", 0) -- heating stopped
createGlobalPropertyi("tu-154/switchers/airbleed/left_sys_temp_set", 22) -- left duct temperature setting
createGlobalPropertyi("tu-154/switchers/airbleed/right_sys_temp_set", 22) -- right duct temperature setting
createGlobalPropertyi("tu-154/switchers/airbleed/left_sys_mode_set", 1) -- left duct mode setting
createGlobalPropertyi("tu-154/switchers/airbleed/right_sys_mode_set", 1) -- right duct mode setting
createGlobalPropertyi("tu-154/switchers/airbleed/ground_cond_on", 0) -- ground air conditioning
createGlobalPropertyi("tu-154/switchers/airbleed/ground_cond_on_cap", 0) -- ground air conditioning
createGlobalPropertyi("tu-154/switchers/airbleed/skv_faster_work", 0) -- -1 - cabin cooling, 0 - off, +1 - accelerated heating modes
createGlobalPropertyi("tu-154/switchers/airbleed/skv_faster_work_cap", 0) -- cover
createGlobalPropertyi("tu-154/switchers/airbleed/sys_temp_select", 1) -- thermometer source selection. 0 - door heating, 1 - crew, 2 - cabin 1, 3 - cabin 2, 4 - left duct, 5 - right duct
createGlobalPropertyi("tu-154/switchers/airbleed/psvp_left_on", 1) -- PSVP left
createGlobalPropertyi("tu-154/switchers/airbleed/psvp_right_on", 1) -- PSVP right
createGlobalPropertyi("tu-154/switchers/airbleed/psvp_left_on_cap", 0) -- PSVP left
createGlobalPropertyi("tu-154/switchers/airbleed/psvp_right_on_cap", 0) -- PSVP right
createGlobalPropertyi("tu-154/switchers/airbleed/air_valve_left", 0) -- pressurisation valves. -1 = closed, 0 = neutral, +1 = open
createGlobalPropertyi("tu-154/switchers/airbleed/air_valve_right", 0) -- pressurisation valves. -1 = closed, 0 = neutral, +1 = open
createGlobalPropertyi("tu-154/switchers/airbleed/air_valve_both", 0) -- pressurisation valves. -1 = closed, 0 = neutral, +1 = open
createGlobalPropertyi("tu-154/switchers/airbleed/emerg_decompress", 0) -- pressure release
createGlobalPropertyi("tu-154/switchers/airbleed/emerg_decompress_cap", 0) -- pressure release
createGlobalPropertyi("tu-154/switchers/airbleed/eng_valve_1", 1) -- engine bleed air
createGlobalPropertyi("tu-154/switchers/airbleed/eng_valve_2", 1) -- engine bleed air
createGlobalPropertyi("tu-154/switchers/airbleed/eng_valve_3", 1) -- engine bleed air
createGlobalPropertyi("tu-154/switchers/airbleed/dubler_on", 0) -- standby
createGlobalPropertyi("tu-154/switchers/airbleed/dubler_on_cap", 0) -- standby
createGlobalPropertyf("tu-154/gauges/eng/starter_press", 0) -- pressure in the start system
createGlobalPropertyi("tu-154/switchers/eng/starter_cap", 0) -- start panel cover
createGlobalPropertyi("tu-154/switchers/eng/starter_switch", 0) -- start switch
createGlobalPropertyi("tu-154/switchers/eng/starter_eng_select", 0) -- engine selection
createGlobalPropertyi("tu-154/switchers/eng/starter_mode", 0) -- start mode
createGlobalPropertyi("tu-154/buttons/eng/starter_start", 0) -- start button
createGlobalPropertyi("tu-154/buttons/eng/starter_stop", 0) -- start abort button
createGlobalPropertyi("tu-154/buttons/eng/flight_start_1", 0) -- in-flight start
createGlobalPropertyi("tu-154/buttons/eng/flight_start_2", 0) -- in-flight start
createGlobalPropertyi("tu-154/buttons/eng/flight_start_3", 0) -- in-flight start
createGlobalPropertyi("tu-154/switchers/eng/gauges_on_1", 1) -- engine monitoring instruments
createGlobalPropertyi("tu-154/switchers/eng/gauges_on_2", 1) -- engine monitoring instruments
createGlobalPropertyi("tu-154/switchers/eng/gauges_on_3", 1) -- engine monitoring instruments
createGlobalPropertyi("tu-154/switchers/eng/gauges_on_1_cap", 0) -- engine monitoring instruments
createGlobalPropertyi("tu-154/switchers/eng/gauges_on_2_cap", 0) -- engine monitoring instruments
createGlobalPropertyi("tu-154/switchers/eng/gauges_on_3_cap", 0) -- engine monitoring instruments
createGlobalPropertyi("tu-154/buttons/eng/reserv_pump_test", 0) -- standby fuel pump test
createGlobalPropertyi("tu-154/buttons/console/absu_zk", 0) -- selected heading (ZK) button on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_reset", 0) -- programme reset button on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_nvu", 0) -- NVU button on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_az1", 0) -- AZ 1 button on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_az2", 0) -- AZ 2 button on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_app", 0) -- approach button on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_gs", 0) -- glideslope button on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_stab_m", 0) -- button M on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_stab_v", 0) -- button V on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_stab_h", 0) -- button H on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_stab", 0) -- STAB button on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_stab_speed", 0) -- button C on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_throt_off_1", 0) -- G1 disconnect button on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_throt_off_2", 0) -- G2 disconnect button on the ABSU panel
createGlobalPropertyi("tu-154/buttons/console/absu_throt_off_3", 0) -- G3 disconnect button on the ABSU panel
createGlobalPropertyi("tu-154/gauges/console/absu_roll_mode", 0) -- ABSU operating mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
createGlobalPropertyi("tu-154/gauges/console/absu_pitch_mode", 0) -- ABSU operating mode. 0 = off, 1 = control-wheel steering, 2 = stabilisation
createGlobalPropertyf("tu-154/gauges/console/gear_brake_press_L", 0) -- left brake pressure
createGlobalPropertyf("tu-154/gauges/console/gear_brake_press_R", 0) -- right brake pressure
createGlobalPropertyf("tu-154/gauges/console/map_angle", 0) -- map angle
createGlobalPropertyi("tu-154/switchers/console/buster_on_1", 1) -- booster switch
createGlobalPropertyi("tu-154/switchers/console/buster_on_2", 1) -- booster switch
createGlobalPropertyi("tu-154/switchers/console/buster_on_3", 1) -- booster switch
createGlobalPropertyi("tu-154/switchers/console/busters_cap", 0) -- booster switch guard
createGlobalPropertyi("tu-154/switchers/console/rls_on", 1) -- radar switch
createGlobalPropertyi("tu-154/switchers/console/rls_mode", 0) -- radar modes. 0 - ready, 1 - weather
createGlobalPropertyi("tu-154/switchers/console/rls_distance", 4) -- radar ranges
createGlobalPropertyf("tu-154/switchers/console/rls_brt", 1) -- radar brightness
createGlobalPropertyf("tu-154/switchers/console/rls_contr", 1) -- radar contrast
createGlobalPropertyf("tu-154/switchers/console/rls_signs", 1) -- radar target brightness
createGlobalPropertyi("tu-154/switchers/console/absu_zpu_sel", 0) -- desired-track (ZPU) selector. left - right
createGlobalPropertyi("tu-154/switchers/console/absu_nav_on", 1) -- navigation needles
createGlobalPropertyi("tu-154/switchers/console/absu_landing_on", 0) -- landing needles
createGlobalPropertyi("tu-154/switchers/console/absu_needles_on", 1) -- needles
createGlobalPropertyi("tu-154/switchers/console/absu_speed_mode", 0) -- STU mode. 0 - off, 1 - nvu, 2 - az1, 3 - az2, 4 - landing
createGlobalPropertyi("tu-154/switchers/console/absu_speed_change", 0) -- speed change knob.
createGlobalPropertyi("tu-154/switchers/console/absu_speed_off", 0) -- 1 and 2 disconnect
createGlobalPropertyi("tu-154/switchers/console/absu_speed_prepare", 1) -- preparation
createGlobalPropertyi("tu-154/switchers/console/absu_speed_off_cap", 0) -- 1 and 2 disconnect
createGlobalPropertyi("tu-154/switchers/console/absu_speed_prepare_cap", 0) -- preparation
createGlobalPropertyi("tu-154/switchers/console/absu_speed_us_right_left", 1) -- preparation
createGlobalPropertyi("tu-154/buttons/console/absu_speed_test_1", 0) -- lower STU test button
createGlobalPropertyi("tu-154/buttons/console/absu_speed_test_2", 0) -- upper STU test button
createGlobalPropertyi("tu-154/switchers/console/absu_turn_handle", 0) -- turn knob
createGlobalPropertyf("tu-154/switchers/console/absu_pitch_wheel", 0) -- descend/climb thumbwheel
createGlobalPropertyi("tu-154/switchers/console/absu_roll_ch_on", 1) -- roll channel switch
createGlobalPropertyi("tu-154/switchers/console/absu_pitch_ch_on", 1) -- pitch channel switch
createGlobalPropertyi("tu-154/switchers/console/absu_smooth_on", 0) -- turbulence ("v boltanku") switch
createGlobalPropertyi("tu-154/switchers/console/absu_smooth_on_cap", 0) -- turbulence ("v boltanku") switch
createGlobalPropertyi("tu-154/switchers/console/absu_pitch_wheel_dir", 0) -- direction of the descent/climb wheel
createGlobalPropertyi("tu-154/buttons/console/absu_arrest", 0) -- caging buttons
createGlobalPropertyi("tu-154/buttons/console/absu_arrest_cap", 0) -- caging button cover
createGlobalPropertyi("tu-154/switchers/console/nvu_param_sel", 0) -- NVU parameter entry selector knob. -4 - Z, -3 - S, -2 - Zm, -1 - Sm, 0 - off, 1 - Sn, 2 - Zn, 3 - S, 4 - Z
createGlobalPropertyi("tu-154/switchers/console/nvu_turn_sel", 0) -- turn radius selector knob, -1 - forced, 0 - off, 1 - 5, 2 - 10, 3 - 15, 4 - 20, 5 - 25
createGlobalPropertyi("tu-154/switchers/console/nvu_power_on", 1) -- NVU power
createGlobalPropertyi("tu-154/switchers/console/nvu_calc_on", 0) -- NVU dead reckoning
createGlobalPropertyi("tu-154/switchers/console/nvu_corr_on", 0) -- NVU correction
createGlobalPropertyf("tu-154/nvu/current_Z1_1", 4) -- Z1
createGlobalPropertyf("tu-154/nvu/current_Z1_10", 3) -- Z1
createGlobalPropertyf("tu-154/nvu/current_Z1_100", 2) -- Z1
createGlobalPropertyf("tu-154/nvu/current_Z1_1000", 1) -- Z1
createGlobalPropertyf("tu-154/nvu/current_Z1_min_1", 4) -- Z1
createGlobalPropertyf("tu-154/nvu/current_Z1_min_10", 3) -- Z1
createGlobalPropertyf("tu-154/nvu/current_Z1_min_100", 2) -- Z1
createGlobalPropertyf("tu-154/nvu/current_Z1_min_1000", 1) -- Z1
createGlobalPropertyf("tu-154/nvu/current_S1_1", 4) -- S1
createGlobalPropertyf("tu-154/nvu/current_S1_10", 3) -- S1
createGlobalPropertyf("tu-154/nvu/current_S1_100", 2) -- S1
createGlobalPropertyf("tu-154/nvu/current_S1_1000", 1) -- S1
createGlobalPropertyf("tu-154/nvu/current_S1_min_1", 4) -- S1
createGlobalPropertyf("tu-154/nvu/current_S1_min_10", 3) -- S1
createGlobalPropertyf("tu-154/nvu/current_S1_min_100", 2) -- S1
createGlobalPropertyf("tu-154/nvu/current_S1_min_1000", 1) -- S1
createGlobalPropertyf("tu-154/nvu/next_Z1_1", 4) -- Z1
createGlobalPropertyf("tu-154/nvu/next_Z1_10", 3) -- Z1
createGlobalPropertyf("tu-154/nvu/next_Z1_100", 2) -- Z1
createGlobalPropertyf("tu-154/nvu/next_Z1_1000", 1) -- Z1
createGlobalPropertyf("tu-154/nvu/next_Z1_min_1", 4) -- Z1
createGlobalPropertyf("tu-154/nvu/next_Z1_min_10", 3) -- Z1
createGlobalPropertyf("tu-154/nvu/next_Z1_min_100", 2) -- Z1
createGlobalPropertyf("tu-154/nvu/next_Z1_min_1000", 1) -- Z1
createGlobalPropertyf("tu-154/nvu/next_S1_1", 4) -- S1
createGlobalPropertyf("tu-154/nvu/next_S1_10", 3) -- S1
createGlobalPropertyf("tu-154/nvu/next_S1_100", 2) -- S1
createGlobalPropertyf("tu-154/nvu/next_S1_1000", 1) -- S1
createGlobalPropertyf("tu-154/nvu/next_S1_min_1", 4) -- S1
createGlobalPropertyf("tu-154/nvu/next_S1_min_10", 3) -- S1
createGlobalPropertyf("tu-154/nvu/next_S1_min_100", 2) -- S1
createGlobalPropertyf("tu-154/nvu/next_S1_min_1000", 1) -- S1
createGlobalPropertyf("tu-154/nvu/current_Z2_1", 4) -- Z2
createGlobalPropertyf("tu-154/nvu/current_Z2_10", 3) -- Z2
createGlobalPropertyf("tu-154/nvu/current_Z2_100", 2) -- Z2
createGlobalPropertyf("tu-154/nvu/current_Z2_1000", 1) -- Z2
createGlobalPropertyf("tu-154/nvu/current_S2_1", 4) -- S2
createGlobalPropertyf("tu-154/nvu/current_S2_10", 3) -- S2
createGlobalPropertyf("tu-154/nvu/current_S2_100", 2) -- S2
createGlobalPropertyf("tu-154/nvu/current_S2_1000", 1) -- S2
createGlobalPropertyf("tu-154/nvu/next_Z2_1", 4) -- Z2
createGlobalPropertyf("tu-154/nvu/next_Z2_10", 3) -- Z2
createGlobalPropertyf("tu-154/nvu/next_Z2_100", 2) -- Z2
createGlobalPropertyf("tu-154/nvu/next_Z2_1000", 1) -- Z2
createGlobalPropertyf("tu-154/nvu/next_S2_1", 4) -- S2
createGlobalPropertyf("tu-154/nvu/next_S2_10", 3) -- S2
createGlobalPropertyf("tu-154/nvu/next_S2_100", 2) -- S2
createGlobalPropertyf("tu-154/nvu/next_S2_1000", 1) -- S2
createGlobalPropertyf("tu-154/nvu/current_Z2_min_1", 4) -- Z2
createGlobalPropertyf("tu-154/nvu/current_Z2_min_10", 3) -- Z2
createGlobalPropertyf("tu-154/nvu/current_Z2_min_100", 2) -- Z2
createGlobalPropertyf("tu-154/nvu/current_Z2_min_1000", 1) -- Z2
createGlobalPropertyf("tu-154/nvu/current_S2_min_1", 4) -- S2
createGlobalPropertyf("tu-154/nvu/current_S2_min_10", 3) -- S2
createGlobalPropertyf("tu-154/nvu/current_S2_min_100", 2) -- S2
createGlobalPropertyf("tu-154/nvu/current_S2_min_1000", 1) -- S2
createGlobalPropertyf("tu-154/nvu/next_Z2_min_1", 4) -- Z2
createGlobalPropertyf("tu-154/nvu/next_Z2_min_10", 3) -- Z2
createGlobalPropertyf("tu-154/nvu/next_Z2_min_100", 2) -- Z2
createGlobalPropertyf("tu-154/nvu/next_Z2_min_1000", 1) -- Z2
createGlobalPropertyf("tu-154/nvu/next_S2_min_1", 4) -- S2
createGlobalPropertyf("tu-154/nvu/next_S2_min_10", 3) -- S2
createGlobalPropertyf("tu-154/nvu/next_S2_min_100", 2) -- S2
createGlobalPropertyf("tu-154/nvu/next_S2_min_1000", 1) -- S2
createGlobalPropertyf("tu-154/nvu/zpu1_01", 5) -- ZPU
createGlobalPropertyf("tu-154/nvu/zpu1_1", 3) -- ZPU
createGlobalPropertyf("tu-154/nvu/zpu1_10", 2) -- ZPU
createGlobalPropertyf("tu-154/nvu/zpu1_100", 1) -- ZPU
createGlobalPropertyf("tu-154/nvu/zpu2_01", 5) -- ZPU
createGlobalPropertyf("tu-154/nvu/zpu2_1", 3) -- ZPU
createGlobalPropertyf("tu-154/nvu/zpu2_10", 2) -- ZPU
createGlobalPropertyf("tu-154/nvu/zpu2_100", 1) -- ZPU
createGlobalPropertyf("tu-154/nvu/z1_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/z1_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/s1_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/s1_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/z2_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/z2_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/s2_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/s2_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/z1_next_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/z1_next_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/s1_next_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/s1_next_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/z2_next_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/z2_next_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/s2_next_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu-154/nvu/s2_next_plus_cap", 1) -- digits cap
createGlobalPropertyi("tu-154/buttons/nvu/nvu_left_btn", 0) -- left NVU button
createGlobalPropertyi("tu-154/buttons/nvu/nvu_ctr_btn", 0) -- centre NVU button
createGlobalPropertyi("tu-154/buttons/nvu/nvu_right_btn", 0) -- right NVU button
createGlobalPropertyi("tu-154/buttons/nvu/zpu_1_left_btn", 0) -- left desired-track (ZPU) button
createGlobalPropertyi("tu-154/buttons/nvu/zpu_1_ctr_btn", 0) -- centre desired-track (ZPU) button
createGlobalPropertyi("tu-154/buttons/nvu/zpu_1_right_btn", 0) -- right desired-track (ZPU) button
createGlobalPropertyi("tu-154/buttons/nvu/zpu_2_left_btn", 0) -- left desired-track (ZPU) button
createGlobalPropertyi("tu-154/buttons/nvu/zpu_2_ctr_btn", 0) -- centre desired-track (ZPU) button
createGlobalPropertyi("tu-154/buttons/nvu/zpu_2_right_btn", 0) -- right desired-track (ZPU) button
createGlobalPropertyi("tu-154/rotary/console/nav_1_course", 0) -- nav 1 heading
createGlobalPropertyf("tu-154/rotary/console/nav_1_course_1", 0) -- nav 1 heading
createGlobalPropertyf("tu-154/rotary/console/nav_1_course_10", 0) -- nav 1 heading
createGlobalPropertyf("tu-154/rotary/console/nav_1_course_100", 0) -- nav 1 heading
createGlobalPropertyi("tu-154/rotary/console/nav_2_course", 0) -- nav 2 heading
createGlobalPropertyf("tu-154/rotary/console/nav_2_course_1", 0) -- nav 2 heading
createGlobalPropertyf("tu-154/rotary/console/nav_2_course_10", 0) -- nav 2 heading
createGlobalPropertyf("tu-154/rotary/console/nav_2_course_100", 0) -- nav 2 heading
createGlobalPropertyf("tu-154/rotary/console/wind_set", 0) -- wind setting
createGlobalPropertyi("tu-154/button/console/wind_course_left", 0) -- wind direction set button
createGlobalPropertyi("tu-154/button/console/wind_course_ctr", 0) -- wind direction set button
createGlobalPropertyi("tu-154/button/console/wind_course_right", 0) -- wind direction set button
createGlobalPropertyi("tu-154/button/console/wind_spd_left", 0) -- wind speed set button
createGlobalPropertyi("tu-154/button/console/wind_spd_ctr", 0) -- wind speed set button
createGlobalPropertyi("tu-154/button/console/wind_spd_right", 0) -- wind speed set button
createGlobalPropertyi("tu-154/switchers/console/emerg_elev_trimm", 0) -- emergency trim control
createGlobalPropertyi("tu-154/switchers/console/emerg_elev_trimm_cap", 0) -- emergency trim control
createGlobalPropertyi("tu-154/buttons/console/radio", 0) -- radio button on the pedestal
createGlobalPropertyi("tu-154/buttons/console/pdu406_control", 0) -- standby-monitoring button
createGlobalPropertyi("tu-154/buttons/console/pdu406_sound_off", 0) -- mute button
createGlobalPropertyf("tu-154/switchers/sard/sard_cabin_press_set", 650) -- cabin pressure setting
createGlobalPropertyf("tu-154/switchers/sard/sard_abs_press_set", 1013) -- absolute pressure setting
createGlobalPropertyf("tu-154/switchers/sard/sard_diff_set", 0.6) -- pressure differential setting
createGlobalPropertyf("tu-154/switchers/sard/sard_spd_set", 0.5) -- SARD rate setting
createGlobalPropertyi("tu-154/switchers/tcas/tcas_mode", 4) -- TCAS mode. -1 = test, 0 - stby, 1 = alt off, 2 = alt on, 3 = TA, 4 = TARA
createGlobalPropertyi("tu-154/switchers/tcas/tcas_rot_big", 0) -- large knob
createGlobalPropertyi("tu-154/switchers/tcas/tcas_rot_small", 0) -- small knob
createGlobalPropertyi("tu-154/buttons/tcas/tcas_ident_btn", 0) -- IDENT button
createGlobalPropertyi("tu-154/buttons/tcas/tcas_fcn_btn", 0) -- FCN button
createGlobalPropertyi("tu-154/buttons/tcas/tcas_left_btn", 0) -- < button
createGlobalPropertyi("tu-154/buttons/tcas/tcas_right_btn", 0) -- > button
createGlobalPropertyi("tu-154/buttons/tcas/tcas_ent_btn", 0) -- ENT button
createGlobalPropertyi("tu-154/buttons/tcas/tcas_atc_btn", 0) -- ATC button
createGlobalPropertyi("tu-154/buttons/tcas/tcas_alt_btn", 0) -- ALT button
createGlobalPropertyi("tu-154/buttons/tcas/tcas_rng_dn_btn", 0) -- RNG DN button
createGlobalPropertyi("tu-154/buttons/tcas/tcas_rng_up_btn", 0) -- RNG UP button
createGlobalPropertyi("tu-154/buttons/srpbz/but_view", 0) -- VIEW button
createGlobalPropertyi("tu-154/buttons/srpbz/but_empty", 0) -- "-" button
createGlobalPropertyi("tu-154/buttons/srpbz/but_down", 0) -- scale down button
createGlobalPropertyi("tu-154/buttons/srpbz/but_up", 0) -- scale up button
createGlobalPropertyf("tu-154/rotary/srpbz/brightness", 0.7) -- brightness knob
createGlobalPropertyf("tu-154/light/no_LIT", 0) -- variable for switching off the glow of objects that have a LIT texture but should not glow
createGlobalPropertyf("tu-154/lights/exit_lamp", 0) -- exit lamp
createGlobalPropertyf("tu-154/lights/fasten_seatbelts_lamp", 0) -- fasten seat belts lamp
createGlobalPropertyf("tu-154/lights/nosmoking_lamp", 0) -- no smoking lamp
createGlobalPropertyf("tu-154/lights/toilet_busy_lamp", 0) -- lavatory occupied lamp
createGlobalPropertyf("tu-154/lights/seats_leters_lamp", 0) -- lamps with the seat letters
createGlobalPropertyf("tu-154/lights/mid_left_panel_int", 0) -- pedestal brightness
createGlobalPropertyf("tu-154/lights/left_panel_int", 0) -- integral lighting brightness, captain's panel
createGlobalPropertyf("tu-154/lights/right_panel_int", 0) -- integral lighting brightness, copilot's panel
createGlobalPropertyf("tu-154/lights/mid_right_panel_int", 0) -- integral lighting brightness, centre front panel
createGlobalPropertyf("tu-154/lights/ovhd_panel_int", 0) -- integral lighting brightness, overhead panel
createGlobalPropertyf("tu-154/lights/left_panel_flood", 0) -- flood light brightness, left panel
createGlobalPropertyf("tu-154/lights/right_panel_flood", 0) -- flood light brightness, right panel
createGlobalPropertyf("tu-154/lights/mid_panel_flood", 0) -- flood light brightness, centre panel
createGlobalPropertyf("tu-154/lights/front_panel_flood", 0) -- flood light brightness, front panel
createGlobalPropertyf("tu-154/lights/ovhd_front_panel_flood", 0) -- flood light brightness, front part of the overhead
createGlobalPropertyf("tu-154/lights/ovhd_back_panel_flood", 0) -- flood light brightness, rear part of the overhead
createGlobalPropertyf("tu-154/lights/eng_panel_flood", 0) -- flight engineer's panel lighting brightness
createGlobalPropertyf("tu-154/lights/km_panel_flood", 0) -- KM panel lighting brightness
createGlobalPropertyf("tu-154/lights/azs_panel_flood", 0) -- AZS panel lighting
createGlobalPropertyf("tu-154/lights/cargo_light_1", 0) -- cargo compartment 1 lighting
createGlobalPropertyf("tu-154/lights/cargo_light_2", 0) -- cargo compartment 2 lighting
createGlobalPropertyf("tu-154/lights/tech_light", 0) -- technical compartment lighting
createGlobalPropertyf("tu-154/lights/gear_nacelle_light", 0) -- landing gear nacelle lighting
createGlobalPropertyf("tu-154/lights/left_spotlight_flood", 0) -- left flashlight brightness
createGlobalPropertyf("tu-154/lights/ark1_left_lit", 0) -- ARK 1 left-hand backlighting
createGlobalPropertyf("tu-154/lights/ark1_right_lit", 0) -- ARK 1 right-hand backlighting
createGlobalPropertyf("tu-154/lights/ark1_all_lit", 0) -- ARK 1 backlighting
createGlobalPropertyf("tu-154/lights/ark2_left_lit", 0) -- ARK 2 left-hand backlighting
createGlobalPropertyf("tu-154/lights/ark2_right_lit", 0) -- ARK 2 right-hand backlighting
createGlobalPropertyf("tu-154/lights/ark2_all_lit", 0) -- ARK 2 backlighting
createGlobalPropertyf("tu-154/lights/tks_mode_lit_mk", 0) -- TKS mode lamp - MK
createGlobalPropertyf("tu-154/lights/tks_mode_lit_ak", 0) -- TKS mode lamp - AK
createGlobalPropertyf("tu-154/lights/tks_mode_lit_gpk", 0) -- TKS mode lamp - GPK
createGlobalPropertyf("tu-154/lights/to_not_ready", 0) -- not ready for takeoff
createGlobalPropertyf("tu-154/lights/wrong_trimm", 0) -- false trim
createGlobalPropertyf("tu-154/lights/controll_roll", 0) -- control the roll
createGlobalPropertyf("tu-154/lights/controll_pitch", 0) -- control the pitch
createGlobalPropertyf("tu-154/lights/yoke_sign", 0) -- go-around annunciation in manual mode
createGlobalPropertyf("tu-154/lights/triangle", 0) -- integral warning light
createGlobalPropertyf("tu-154/lights/controll_thrust", 0) -- control the thrust
createGlobalPropertyf("tu-154/lights/course_lim", 0) -- course deviation beyond limits
createGlobalPropertyf("tu-154/lights/gs_lim", 0) -- glideslope deviation beyond limits
createGlobalPropertyf("tu-154/lights/fire", 0) -- FIRE
createGlobalPropertyf("tu-154/lights/no_ag_controll", 0) -- no AG monitoring
createGlobalPropertyf("tu-154/lights/fuel_less_2500", 0) -- fuel remaining 2500
createGlobalPropertyf("tu-154/lights/sso_danger", 0) -- SSO danger
createGlobalPropertyf("tu-154/lights/sso_connect", 0) -- SSO comms
createGlobalPropertyf("tu-154/lights/speed_high", 0) -- speed limit
createGlobalPropertyf("tu-154/lights/roll_left_high", 0) -- left bank excessive
createGlobalPropertyf("tu-154/lights/roll_right_high", 0) -- right bank excessive
createGlobalPropertyf("tu-154/lights/alpha_high", 0) -- limit AoA
createGlobalPropertyf("tu-154/lights/g_force_high", 0) -- limit g
createGlobalPropertyf("tu-154/lights/auasp_lamp", 0) -- lamp on the AUASP
createGlobalPropertyf("tu-154/lights/toga", 0) -- go-around
createGlobalPropertyf("tu-154/lights/decision_height", 0) -- SSO commsdecision height H
createGlobalPropertyf("tu-154/lights/course", 0) -- HEADING
createGlobalPropertyf("tu-154/lights/glideslope", 0) -- GLIDESLOPE
createGlobalPropertyf("tu-154/lights/zk_lamp", 0) -- ZK
createGlobalPropertyf("tu-154/lights/thrust_automat", 0) -- autothrottle
createGlobalPropertyf("tu-154/lights/stab_roll", 0) -- lateral stabilisation
createGlobalPropertyf("tu-154/lights/stab_pitch", 0) -- longitudinal stabilisation
createGlobalPropertyf("tu-154/lights/nvu_lamp", 0) -- NVU
createGlobalPropertyf("tu-154/lights/vor_lamp", 0) -- VOR
createGlobalPropertyf("tu-154/lights/stab_h", 0) -- stab H
createGlobalPropertyf("tu-154/lights/stab_v", 0) -- stab V
createGlobalPropertyf("tu-154/lights/stab_m", 0) -- stab M
createGlobalPropertyf("tu-154/lights/marker_1", 0) -- marker 1
createGlobalPropertyf("tu-154/lights/marker_2", 0) -- marker 2
createGlobalPropertyf("tu-154/lights/marker_3", 0) -- marker 3
createGlobalPropertyf("tu-154/lights/pull_up", 0) -- pull up
createGlobalPropertyf("tu-154/lights/check_alt_left", 0) -- check H
createGlobalPropertyf("tu-154/lights/check_alt_right", 0) -- check H
createGlobalPropertyf("tu-154/lights/sns_lamp", 0) -- SNS
createGlobalPropertyf("tu-154/lights/fp_eng_fail_1", 0) -- engine 1 fail on the front panel
createGlobalPropertyf("tu-154/lights/fp_eng_fail_2", 0) -- engine 2 fail on the front panel
createGlobalPropertyf("tu-154/lights/fp_eng_fail_3", 0) -- engine 3 fail on the front panel
createGlobalPropertyf("tu-154/lights/fp_reverse_1", 0) -- reverser 1 buckets on the front panel
createGlobalPropertyf("tu-154/lights/fp_reverse_3", 0) -- reverser 3 buckets on the front panel
createGlobalPropertyf("tu-154/lights/stab_work", 0) -- stabilisation on
createGlobalPropertyf("tu-154/lights/flaps_1_valve", 0) -- flaps 1 PK
createGlobalPropertyf("tu-154/lights/flaps_2_valve", 0) -- flaps 2 PK
createGlobalPropertyf("tu-154/lights/spoilers_mid_left", 0) -- mid left spoilers
createGlobalPropertyf("tu-154/lights/spoilers_mid_right", 0) -- mid right spoilers
createGlobalPropertyf("tu-154/lights/spoilers_inn_left", 0) -- inboard left spoilers
createGlobalPropertyf("tu-154/lights/spoilers_inn_right", 0) -- inboard right spoilers
createGlobalPropertyf("tu-154/lights/gears_not_ext", 0) -- landing gear not extended
createGlobalPropertyf("tu-154/lights/gears_red_left", 0) -- red landing gear lamp
createGlobalPropertyf("tu-154/lights/gears_red_front", 0) -- red landing gear lamp
createGlobalPropertyf("tu-154/lights/gears_red_right", 0) -- red landing gear lamp
createGlobalPropertyf("tu-154/lights/gears_green_left", 0) -- green landing gear lamp
createGlobalPropertyf("tu-154/lights/gears_green_front", 0) -- green landing gear lamp
createGlobalPropertyf("tu-154/lights/gears_green_right", 0) -- green landing gear lamp
createGlobalPropertyf("tu-154/lights/gears_red_left_eng", 0) -- red landing gear lamp on the flight engineer's panel
createGlobalPropertyf("tu-154/lights/gears_red_front_eng", 0) -- red landing gear lamp on the flight engineer's panel
createGlobalPropertyf("tu-154/lights/gears_red_right_eng", 0) -- red landing gear lamp on the flight engineer's panel
createGlobalPropertyf("tu-154/lights/gears_green_left_eng", 0) -- green landing gear lamp on the flight engineer's panel
createGlobalPropertyf("tu-154/lights/gears_green_front_eng", 0) -- green landing gear lamp on the flight engineer's panel
createGlobalPropertyf("tu-154/lights/gears_green_right_eng", 0) -- green landing gear lamp on the flight engineer's panel
createGlobalPropertyf("tu-154/lights/flaps_unsync", 0) -- flap asymmetry
createGlobalPropertyf("tu-154/lights/slats_unsync", 0) -- slat asymmetry
createGlobalPropertyf("tu-154/lights/slats_extended", 0) -- slats extended
createGlobalPropertyf("tu-154/lights/to_rudder", 0) -- rudder takeoff/landing
createGlobalPropertyf("tu-154/lights/to_elevator", 0) -- elevator takeoff/landing
createGlobalPropertyf("tu-154/lights/trimm_zero_course", 0) -- heading neutral
createGlobalPropertyf("tu-154/lights/trimm_zero_roll", 0) -- roll neutral
createGlobalPropertyf("tu-154/lights/trimm_zero_pitch", 0) -- pitch neutral
createGlobalPropertyf("tu-154/lights/damper_course", 0) -- yaw damper
createGlobalPropertyf("tu-154/lights/damper_roll", 0) -- roll damper
createGlobalPropertyf("tu-154/lights/damper_pitch", 0) -- pitch damper
createGlobalPropertyf("tu-154/lights/no_reserve_c", 0) -- no K standby
createGlobalPropertyf("tu-154/lights/no_reserve_g", 0) -- no G (hydraulic) standby
createGlobalPropertyf("tu-154/lights/pitch_control_fail", 0) -- longitudinal control
createGlobalPropertyf("tu-154/lights/roll_control_fail", 0) -- lateral control
createGlobalPropertyf("tu-154/lights/ga_main_fail", 0) -- gyro unit failure, main
createGlobalPropertyf("tu-154/lights/ga_reserve_fail", 0) -- gyro unit failure, monitoring
createGlobalPropertyf("tu-154/lights/msg_lamp", 0) -- MSG
createGlobalPropertyf("tu-154/lights/wpt_lamp", 0) -- WPT
createGlobalPropertyf("tu-154/lights/stuard_call", 0) -- flight attendant call
createGlobalPropertyf("tu-154/lights/mgv_control_fail", 0) -- MGV monitor failure
-- duplicate of line 1061; SASL3 warns "already exists" and ignores the second
-- call, so it is commented out rather than left to log on every load.
--createGlobalPropertyf("tu-154/lights/sns_lamp", 0) -- SNS
createGlobalPropertyf("tu-154/lights/correct_on", 0) -- correction on
createGlobalPropertyf("tu-154/lights/change_ch_o", 0) -- CHO change
createGlobalPropertyf("tu-154/lights/warning_terrain", 0) -- terrain warning
createGlobalPropertyf("tu-154/lights/gs_low", 0) -- glideslope low
createGlobalPropertyf("tu-154/lights/cockpit_p_low", 0) -- Cabin P low
createGlobalPropertyf("tu-154/lights/nvu_fail", 0) -- NVU failure
createGlobalPropertyf("tu-154/lights/nvu_vor_automat", 0) -- NVU-VOR automatic
createGlobalPropertyf("tu-154/lights/dist_autonom", 0) -- autonomous distance
createGlobalPropertyf("tu-154/lights/diss_memory", 0) -- DISS memory
createGlobalPropertyf("tu-154/lights/azimuth_autonom", 0) -- autonomous azimuth
createGlobalPropertyf("tu-154/lights/srpbz_fail", 0) -- SRPBZ failure
createGlobalPropertyf("tu-154/lights/tcas_ident", 0) -- TCAS identification lamp
createGlobalPropertyf("tu-154/lights/other_hatches", 0) -- lamp for the unused hatches
createGlobalPropertyf("tu-154/lights/left_front_pax_door", 0) -- left front door open
createGlobalPropertyf("tu-154/lights/left_mid_pax_door", 0) -- left middle door open
createGlobalPropertyf("tu-154/lights/right_mid_pax_door", 0) -- middle middle door open
createGlobalPropertyf("tu-154/lights/cargo_front_door", 0) -- forward cargo hatch
createGlobalPropertyf("tu-154/lights/cargo_back_door", 0) -- forward cargo hatch
createGlobalPropertyf("tu-154/lights/turn63_lamp", 0) -- turn 63
createGlobalPropertyf("tu-154/lights/nosewheel_turn_off", 0) -- steering not engaged
createGlobalPropertyf("tu-154/lights/busters_off", 0) -- booster lamp
createGlobalPropertyf("tu-154/lights/water_level_1", 0) -- water level 1
createGlobalPropertyf("tu-154/lights/water_level_12", 0) -- water level 1/2
createGlobalPropertyf("tu-154/lights/water_level_14", 0) -- water level 1/4
createGlobalPropertyf("tu-154/lights/water_level_0", 0) -- water level 0
createGlobalPropertyf("tu-154/lights/ra56_roll_fail_1", 0) -- RA-56 roll failure
createGlobalPropertyf("tu-154/lights/ra56_roll_fail_2", 0) -- RA-56 roll failure
createGlobalPropertyf("tu-154/lights/ra56_roll_fail_3", 0) -- RA-56 roll failure
createGlobalPropertyf("tu-154/lights/ra56_pitch_fail_1", 0) -- RA-56 pitch failure
createGlobalPropertyf("tu-154/lights/ra56_pitch_fail_2", 0) -- RA-56 pitch failure
createGlobalPropertyf("tu-154/lights/ra56_pitch_fail_3", 0) -- RA-56 pitch failure
createGlobalPropertyf("tu-154/lights/ra56_course_fail_1", 0) -- RA-56 yaw failure
createGlobalPropertyf("tu-154/lights/ra56_course_fail_2", 0) -- RA-56 yaw failure
createGlobalPropertyf("tu-154/lights/ra56_course_fail_3", 0) -- RA-56 yaw failure
createGlobalPropertyf("tu-154/lights/nvu_no_reserve", 0) -- no NVU standby
createGlobalPropertyf("tu-154/lights/absu_work", 0) -- ABSU healthy
createGlobalPropertyf("tu-154/lights/fire/smoke_1", 0) -- smoke in the compartments
createGlobalPropertyf("tu-154/lights/fire/smoke_2", 0) -- smoke in the compartments
createGlobalPropertyf("tu-154/lights/fire/smoke_zone2_left", 0) -- smoke in the compartments
createGlobalPropertyf("tu-154/lights/fire/smoke_zone2_right", 0) -- smoke in the compartments
createGlobalPropertyf("tu-154/lights/fire/smoke_zone3", 0) -- smoke in the compartments
createGlobalPropertyf("tu-154/lights/fire/smoke_zone4", 0) -- smoke in the compartments
createGlobalPropertyf("tu-154/lights/fire/smoke_zone5_left", 0) -- smoke in the compartments
createGlobalPropertyf("tu-154/lights/fire/smoke_zone5_right", 0) -- smoke in the compartments
createGlobalPropertyf("tu-154/lights/fire/smoke_zone6", 0) -- smoke in the compartments
createGlobalPropertyf("tu-154/lights/fire/fire_eng_1", 0) -- engine fire
createGlobalPropertyf("tu-154/lights/fire/fire_eng_2", 0) -- engine fire
createGlobalPropertyf("tu-154/lights/fire/fire_eng_3", 0) -- engine fire
createGlobalPropertyf("tu-154/lights/fire/overheat_eng_1", 0) -- engine overheat
createGlobalPropertyf("tu-154/lights/fire/overheat_eng_2", 0) -- engine overheat
createGlobalPropertyf("tu-154/lights/fire/overheat_eng_3", 0) -- engine overheat
createGlobalPropertyf("tu-154/lights/fire/fuel_off_eng_1", 0) -- fuel closed
createGlobalPropertyf("tu-154/lights/fire/fuel_off_eng_2", 0) -- fuel closed
createGlobalPropertyf("tu-154/lights/fire/fuel_off_eng_3", 0) -- fuel closed
createGlobalPropertyf("tu-154/lights/fire/check_overheat", 0) -- check for overheat and smoke
createGlobalPropertyf("tu-154/lights/fire/fire_apu", 0) -- APU fire
createGlobalPropertyf("tu-154/lights/fire/turn_on_spz", 0) -- switch on the SPZ
createGlobalPropertyf("tu-154/lights/apu/low_oil", 0) -- oil low
createGlobalPropertyf("tu-154/lights/apu/low_oil_press", 0) -- Oil P
createGlobalPropertyf("tu-154/lights/apu/high_temp", 0) -- limit temperature
createGlobalPropertyf("tu-154/lights/apu/high_rpm", 0) -- limit rpm
createGlobalPropertyf("tu-154/lights/apu/pta6_fail", 0) -- PTA 6A failed
createGlobalPropertyf("tu-154/lights/apu/doors_open", 0) -- doors open
createGlobalPropertyf("tu-154/lights/apu/fuel_press", 0) -- Fuel P
createGlobalPropertyf("tu-154/lights/apu/start_ready", 0) -- Ready to start
createGlobalPropertyf("tu-154/lights/apu/work_mode", 0) -- Reaching the rated mode
createGlobalPropertyf("tu-154/lights/apu/start_apu", 0) -- start the APU
createGlobalPropertyf("tu-154/lights/engines/eng1_dangerous_vibro", 0) -- dangerous vibration
createGlobalPropertyf("tu-154/lights/engines/eng1_oil_level", 0) -- oil level
createGlobalPropertyf("tu-154/lights/engines/eng1_oil_p", 0) -- oil pressure
createGlobalPropertyf("tu-154/lights/engines/eng1_bypass_valve", 0) -- bypass valves
createGlobalPropertyf("tu-154/lights/engines/eng1_vna33", 0) -- IGV 33
createGlobalPropertyf("tu-154/lights/engines/eng1_reverse_lock", 0) -- reverser lock
createGlobalPropertyf("tu-154/lights/engines/eng1_high_vibro", 0) -- vibration high
createGlobalPropertyf("tu-154/lights/engines/eng1_chips", 0) -- chip in the oil
createGlobalPropertyf("tu-154/lights/engines/eng1_fuel_p", 0) -- fuel pressure
createGlobalPropertyf("tu-154/lights/engines/eng1_filter_fail", 0) -- filter clogged
createGlobalPropertyf("tu-154/lights/engines/eng1_vna0", 0) -- IGV 0
createGlobalPropertyf("tu-154/lights/engines/eng1_reverse_doors", 0) -- reverser buckets
createGlobalPropertyf("tu-154/lights/engines/eng2_dangerous_vibro", 0) -- dangerous vibration
createGlobalPropertyf("tu-154/lights/engines/eng2_oil_level", 0) -- oil level
createGlobalPropertyf("tu-154/lights/engines/eng2_oil_p", 0) -- oil pressure
createGlobalPropertyf("tu-154/lights/engines/eng2_bypass_valve", 0) -- bypass valves
createGlobalPropertyf("tu-154/lights/engines/eng2_vna33", 0) -- IGV 33
createGlobalPropertyf("tu-154/lights/engines/eng_at_on", 0) -- AT engaged
createGlobalPropertyf("tu-154/lights/engines/eng2_high_vibro", 0) -- vibration high
createGlobalPropertyf("tu-154/lights/engines/eng2_chips", 0) -- chip in the oil
createGlobalPropertyf("tu-154/lights/engines/eng2_fuel_p", 0) -- fuel pressure
createGlobalPropertyf("tu-154/lights/engines/eng2_filter_fail", 0) -- filter clogged
createGlobalPropertyf("tu-154/lights/engines/eng2_vna0", 0) -- IGV 0
createGlobalPropertyf("tu-154/lights/engines/eng_block", 0) -- release the sector
createGlobalPropertyf("tu-154/lights/engines/eng3_dangerous_vibro", 0) -- dangerous vibration
createGlobalPropertyf("tu-154/lights/engines/eng3_oil_level", 0) -- oil level
createGlobalPropertyf("tu-154/lights/engines/eng3_oil_p", 0) -- oil pressure
createGlobalPropertyf("tu-154/lights/engines/eng3_bypass_valve", 0) -- bypass valves
createGlobalPropertyf("tu-154/lights/engines/eng3_vna33", 0) -- IGV 33
createGlobalPropertyf("tu-154/lights/engines/eng3_reverse_lock", 0) -- reverser lock
createGlobalPropertyf("tu-154/lights/engines/eng3_high_vibro", 0) -- vibration high
createGlobalPropertyf("tu-154/lights/engines/eng3_chips", 0) -- chip in the oil
createGlobalPropertyf("tu-154/lights/engines/eng3_fuel_p", 0) -- fuel pressure
createGlobalPropertyf("tu-154/lights/engines/eng3_filter_fail", 0) -- filter clogged
createGlobalPropertyf("tu-154/lights/engines/eng3_vna0", 0) -- IGV 0
createGlobalPropertyf("tu-154/lights/engines/eng3_reverse_doors", 0) -- reverser buckets
createGlobalPropertyf("tu-154/lights/small/transponder1_fail", 0) -- left panel. transmitter failure
createGlobalPropertyf("tu-154/lights/small/transponder1_kd", 0) -- left panel. KD
createGlobalPropertyf("tu-154/lights/small/transponder1_kp", 0) -- left panel. KP
createGlobalPropertyf("tu-154/lights/small/leftside_yellow", 0) -- yellow lamp on the left
createGlobalPropertyf("tu-154/lights/small/turn_on_aux", 0) -- switch on the standby one
createGlobalPropertyf("tu-154/lights/small/front_hydr_fail_1", 0) -- hydraulic system 1 low pressure. front panel
createGlobalPropertyf("tu-154/lights/small/front_hydr_fail_2", 0) -- hydraulic system 2 low pressure. front panel
createGlobalPropertyf("tu-154/lights/small/front_hydr_fail_3", 0) -- hydraulic system 3 low pressure. front panel
createGlobalPropertyf("tu-154/lights/small/front_hydr_fail_4", 0) -- emergency hydraulic system low pressure. front panel
createGlobalPropertyf("tu-154/lights/small/rv5_left_dh", 0) -- DH on the left RV5
createGlobalPropertyf("tu-154/lights/small/rv5_right_dh", 0) -- DH on the right RV5
createGlobalPropertyf("tu-154/lights/small/vd15_lamp", 0) -- lamp next to the altimeter on the front panel
createGlobalPropertyf("tu-154/lights/small/bkk_ok", 0) -- BKK healthy lamp on the overhead panel
createGlobalPropertyf("tu-154/lights/small/heat_ok_1", 0) -- heating healthy lamp
createGlobalPropertyf("tu-154/lights/small/heat_ok_2", 0) -- heating healthy lamp
createGlobalPropertyf("tu-154/lights/small/heat_ok_3", 0) -- heating healthy lamp
createGlobalPropertyf("tu-154/lights/small/sp50_c1", 0) -- SP50 panel - course 1
createGlobalPropertyf("tu-154/lights/small/sp50_g1", 0) -- SP50 panel - glideslope 1
createGlobalPropertyf("tu-154/lights/small/sp50_c2", 0) -- SP50 panel - course 2
createGlobalPropertyf("tu-154/lights/small/sp50_g2", 0) -- SP50 panel - glideslope 2
createGlobalPropertyf("tu-154/lights/small/transponder_red", 0) -- red lamp on the transponder
createGlobalPropertyf("tu-154/lights/small/transponder_green", 0) -- green lamp on the transponder
createGlobalPropertyf("tu-154/lights/small/tks_main_fail", 0) -- main GA failure on the TKS
createGlobalPropertyf("tu-154/lights/small/tks_contr_fail", 0) -- control GA failure on the TKS
createGlobalPropertyf("tu-154/lights/small/rls_ready", 0) -- radar ready
createGlobalPropertyf("tu-154/lights/small/rls_weather", 0) -- weather radar
createGlobalPropertyf("tu-154/lights/small/stu_roll", 0) -- STU lateral
createGlobalPropertyf("tu-154/lights/small/stu_pitch", 0) -- STU longitudinal
createGlobalPropertyf("tu-154/lights/small/stu_toga", 0) -- GO-AROUND
createGlobalPropertyf("tu-154/lights/small/at_2", 0) -- AT 2
createGlobalPropertyf("tu-154/lights/small/at_1", 0) -- AT 1
createGlobalPropertyf("tu-154/lights/small/nvu_on", 0) -- NVU healthy
createGlobalPropertyf("tu-154/lights/small/nvu_corr", 0) -- NVU CORR
createGlobalPropertyf("tu-154/lights/small/nav_1_to", 0) -- NAV 1 TO
createGlobalPropertyf("tu-154/lights/small/nav_1_from", 0) -- NAV 1 FROM
createGlobalPropertyf("tu-154/lights/small/nav_2_to", 0) -- NAV 2 TO
createGlobalPropertyf("tu-154/lights/small/nav_2_from", 0) -- NAV 2 FROM
createGlobalPropertyf("tu-154/lights/small/apu_gen_on", 0) -- RAP connected
createGlobalPropertyf("tu-154/lights/small/bus_npk_1", 0) -- left NPK buses on 3
createGlobalPropertyf("tu-154/lights/small/bus_npk_2", 0) -- right NPK buses on 1
createGlobalPropertyf("tu-154/lights/small/emerg_inv_115", 0) -- emergency 115 V inverter
createGlobalPropertyf("tu-154/lights/small/gen_fail_1", 0) -- generator not running
createGlobalPropertyf("tu-154/lights/small/gen_fail_2", 0) -- generator not running
createGlobalPropertyf("tu-154/lights/small/gen_fail_3", 0) -- generator not running
createGlobalPropertyf("tu-154/lights/small/bus_connected", 0) -- buses tied
createGlobalPropertyf("tu-154/lights/small/left_bus_use_bat", 0) -- left bus from the batteries
createGlobalPropertyf("tu-154/lights/small/right_bus_use_bat", 0) -- right bus from the batteries
createGlobalPropertyf("tu-154/lights/small/turn_off_bat_1", 0) -- switch the battery off
createGlobalPropertyf("tu-154/lights/small/turn_off_bat_3", 0) -- switch the battery off
createGlobalPropertyf("tu-154/lights/small/turn_off_bat_2", 0) -- switch the battery off
createGlobalPropertyf("tu-154/lights/small/turn_off_bat_4", 0) -- switch the battery off
createGlobalPropertyf("tu-154/lights/small/vu_on_1", 0) -- VU1
createGlobalPropertyf("tu-154/lights/small/vu_on_2", 0) -- VU1
createGlobalPropertyf("tu-154/lights/small/left_bus_on_tr2", 0) -- left bus on tr 2
createGlobalPropertyf("tu-154/lights/small/right_bus_on_tr1", 0) -- right bus on tr 1
createGlobalPropertyf("tu-154/lights/small/pts250_n1", 0) -- PTS 250 not running
createGlobalPropertyf("tu-154/lights/small/pts250_n2", 0) -- PTS 250 on the bus
createGlobalPropertyf("tu-154/lights/small/throttle_1_fire", 0) -- fire lamp on the throttle
createGlobalPropertyf("tu-154/lights/small/throttle_2_fire", 0) -- fire lamp on the throttle
createGlobalPropertyf("tu-154/lights/small/throttle_3_fire", 0) -- fire lamp on the throttle
createGlobalPropertyf("tu-154/lights/small/oil_meter_1", 0) -- green oil lamp on the oil quantity gauges
createGlobalPropertyf("tu-154/lights/small/oil_meter_2", 0) -- green oil lamp on the oil quantity gauges
createGlobalPropertyf("tu-154/lights/small/oil_meter_3", 0) -- green oil lamp on the oil quantity gauges
createGlobalPropertyf("tu-154/lights/small/starter_high_rpm_1", 0) -- dangerous starter rpm
createGlobalPropertyf("tu-154/lights/small/starter_high_rpm_2", 0) -- dangerous starter rpm
createGlobalPropertyf("tu-154/lights/small/starter_high_rpm_3", 0) -- dangerous starter rpm
createGlobalPropertyf("tu-154/lights/small/fuel_2500", 0) -- fuel remaining 2500
createGlobalPropertyf("tu-154/lights/small/fuel_tank1_used", 0) -- usage from tank 1
createGlobalPropertyf("tu-154/lights/small/fuel_tank3_left_fail", 0) -- red lamp, tank 3 left
createGlobalPropertyf("tu-154/lights/small/fuel_tank2_left_fail", 0) -- red lamp, tank 2 left
createGlobalPropertyf("tu-154/lights/small/fuel_tank2_right_fail", 0) -- red lamp, tank 2 right
createGlobalPropertyf("tu-154/lights/small/fuel_tank3_right_fail", 0) -- red lamp, tank 3 right
createGlobalPropertyf("tu-154/lights/small/fuel_pump_left_5", 0) -- tank 5 pump, left
createGlobalPropertyf("tu-154/lights/small/fuel_pump_left_6", 0) -- tank 6 pump, left
createGlobalPropertyf("tu-154/lights/small/fuel_pump_left_7", 0) -- tank 7 pump, left
createGlobalPropertyf("tu-154/lights/small/fuel_pump_left_8", 0) -- tank 8 pump, left
createGlobalPropertyf("tu-154/lights/small/fuel_pump_left_9", 0) -- tank 9 pump, left
createGlobalPropertyf("tu-154/lights/small/fuel_pump_right_5", 0) -- tank 5 pump, right
createGlobalPropertyf("tu-154/lights/small/fuel_pump_right_6", 0) -- tank 6 pump, right
createGlobalPropertyf("tu-154/lights/small/fuel_pump_right_7", 0) -- tank 7 pump, right
createGlobalPropertyf("tu-154/lights/small/fuel_pump_right_8", 0) -- tank 8 pump, right
createGlobalPropertyf("tu-154/lights/small/fuel_pump_right_9", 0) -- tank 9 pump, right
createGlobalPropertyf("tu-154/lights/small/fuel_pump_10", 0) -- tank 10 pump
createGlobalPropertyf("tu-154/lights/small/fuel_pump_11", 0) -- tank 11 pump
createGlobalPropertyf("tu-154/lights/small/fuel_pump_1", 0) -- tank 1 pump
createGlobalPropertyf("tu-154/lights/small/fuel_pump_2", 0) -- tank 2 pump
createGlobalPropertyf("tu-154/lights/small/fuel_pump_3", 0) -- tank 3 pump
createGlobalPropertyf("tu-154/lights/small/fuel_pump_4", 0) -- tank 4 pump
createGlobalPropertyf("tu-154/lights/small/fuel_cut_off_1", 0) -- shutoff valves
createGlobalPropertyf("tu-154/lights/small/fuel_cut_off_2", 0) -- shutoff valves
createGlobalPropertyf("tu-154/lights/small/fuel_cut_off_3", 0) -- shutoff valves
createGlobalPropertyf("tu-154/lights/small/fuel_flow_from_2", 0) -- fuel usage order
createGlobalPropertyf("tu-154/lights/small/fuel_flow_from_3", 0) -- fuel usage order
createGlobalPropertyf("tu-154/lights/small/fuel_flow_from_4", 0) -- fuel usage order
createGlobalPropertyf("tu-154/lights/small/fuel_flow_auto_fail", 0) -- the fuel usage controller is not working
createGlobalPropertyf("tu-154/lights/small/fuel_reserv_trans_left", 0) -- standby transfer into tank 1
createGlobalPropertyf("tu-154/lights/small/fuel_reserv_trans_right", 0) -- standby transfer into tank 1
createGlobalPropertyf("tu-154/lights/small/fuel_porc_reserv", 0) -- metering
createGlobalPropertyf("tu-154/lights/small/fuel_level_automat", 0) -- flare-out computer
createGlobalPropertyf("tu-154/lights/small/skv_overheat", 0) -- SKV overheat
createGlobalPropertyf("tu-154/lights/small/skv_overpress_left", 0) -- overpressure
createGlobalPropertyf("tu-154/lights/small/skv_overpress_right", 0) -- overpressure
createGlobalPropertyf("tu-154/lights/small/skv_tail_temp", 0) -- tail compartment temperature high
createGlobalPropertyf("tu-154/lights/small/skv_bleed_fail_1", 0) -- bleed air failure
createGlobalPropertyf("tu-154/lights/small/skv_bleed_fail_2", 0) -- bleed air failure
createGlobalPropertyf("tu-154/lights/small/skv_bleed_fail_3", 0) -- bleed air failure
createGlobalPropertyf("tu-154/lights/small/skv_bleed_closed_1", 0) -- bleed air closed
createGlobalPropertyf("tu-154/lights/small/skv_bleed_closed_2", 0) -- bleed air closed
createGlobalPropertyf("tu-154/lights/small/skv_bleed_closed_3", 0) -- bleed air closed
createGlobalPropertyf("tu-154/lights/small/apd_work_1", 0) -- APD start unit running
createGlobalPropertyf("tu-154/lights/small/apd_work_2", 0) -- APD start unit running
createGlobalPropertyf("tu-154/lights/small/apd_work_3", 0) -- APD start unit running
createGlobalPropertyf("tu-154/lights/small/eng_hydr_fail_1", 0) -- hydraulic system 1 low pressure. flight engineer's panel
createGlobalPropertyf("tu-154/lights/small/eng_hydr_fail_2", 0) -- hydraulic system 2 low pressure. flight engineer's panel
createGlobalPropertyf("tu-154/lights/small/eng_hydr_fail_3", 0) -- hydraulic system 3 low pressure. flight engineer's panel
createGlobalPropertyf("tu-154/lights/small/eng_hydr_fail_4", 0) -- emergency hydraulic system low pressure. flight engineer's panel
createGlobalPropertyf("tu-154/lights/small/tail_temp_high", 0) -- tail compartment temperature high
createGlobalPropertyf("tu-154/lights/small/lavatory_heat", 0) -- lavatory drain heating
createGlobalPropertyf("tu-154/lights/small/galley_heat", 0) -- galley drain heating
createGlobalPropertyf("tu-154/lights/small/msrp_mlp_main", 0) -- MSRP. MLP main
createGlobalPropertyf("tu-154/lights/small/msrp_mlp_aux", 0) -- MSRP. MLP additional
createGlobalPropertyf("tu-154/lights/small/msrp_up2", 0) -- MSRP. UP2
createGlobalPropertyf("tu-154/lights/small/msrp_mars", 0) -- MSRP. MARS
createGlobalPropertyf("tu-154/lights/small/srd_low_press", 0) -- cabin pressure low
createGlobalPropertyf("tu-154/lights/small/srd_overpress", 0) -- cabin overpressure
createGlobalPropertyf("tu-154/lights/small/soi_work", 0) -- SOI healthy
createGlobalPropertyf("tu-154/lights/small/soi_ice_detected", 0) -- SOI icing
createGlobalPropertyf("tu-154/lights/small/antiice_slats", 0) -- anti-icer flaps
createGlobalPropertyf("tu-154/lights/small/antiice_eng_1", 0) -- anti-icer flaps
createGlobalPropertyf("tu-154/lights/small/antiice_eng_2", 0) -- anti-icer flaps
createGlobalPropertyf("tu-154/lights/small/antiice_eng_3", 0) -- anti-icer flaps
createGlobalPropertyf("tu-154/lights/small/antiice_wings", 0) -- anti-icer flaps
createGlobalPropertyf("tu-154/lights/small/close_toilet", 0) -- close the lavatory
createGlobalPropertyf("tu-154/lights/small/pnp_sp_left", 0) -- SP lamp on the left PNP
createGlobalPropertyf("tu-154/lights/small/pnp_vor_left", 0) -- VOR lamp on the left PNP
createGlobalPropertyf("tu-154/lights/small/pnp_nv_left", 0) -- NV lamp on the left PNP
createGlobalPropertyf("tu-154/lights/small/pnp_rsbn_left", 0) -- RSBN lamp on the left PNP
createGlobalPropertyf("tu-154/lights/small/pnp_sp_right", 0) -- SP lamp on the right PNP
createGlobalPropertyf("tu-154/lights/small/pnp_vor_right", 0) -- VOR lamp on the right PNP
createGlobalPropertyf("tu-154/lights/small/pnp_nv_right", 0) -- NV lamp on the right PNP
createGlobalPropertyf("tu-154/lights/small/pnp_rsbn_right", 0) -- RSBN lamp on the right PNP
createGlobalPropertyf("tu-154/lights/small/dme_mile_left", 0) -- miles lamp on the left DME
createGlobalPropertyf("tu-154/lights/small/dme_km_left", 0) -- km lamp on the left DME
createGlobalPropertyf("tu-154/lights/small/dme_mile_right", 0) -- miles lamp on the right DME
createGlobalPropertyf("tu-154/lights/small/dme_km_right", 0) -- km lamp on the right DME
createGlobalPropertyf("tu-154/lights/button/absu_zk", 0) -- ABSU selected heading (ZK)
createGlobalPropertyf("tu-154/lights/button/absu_reset", 0) -- ABSU reset
createGlobalPropertyf("tu-154/lights/button/absu_nvu", 0) -- ABSU NVU
createGlobalPropertyf("tu-154/lights/button/absu_az1", 0) -- ABSU AZ1
createGlobalPropertyf("tu-154/lights/button/absu_az2", 0) -- ABSU AZ2
createGlobalPropertyf("tu-154/lights/button/absu_app", 0) -- ABSU approach
createGlobalPropertyf("tu-154/lights/button/absu_gz", 0) -- ABSU glideslope
createGlobalPropertyf("tu-154/lights/button/absu_stab_m", 0) -- ABSU stab M
createGlobalPropertyf("tu-154/lights/button/absu_stab_v", 0) -- ABSU stab V
createGlobalPropertyf("tu-154/lights/button/absu_stab_h", 0) -- ABSU stab H
createGlobalPropertyf("tu-154/lights/button/absu_stab", 0) -- ABSU stab H
createGlobalPropertyf("tu-154/lights/button/absu_stab_spd", 0) -- ABSU speed stabilisation
createGlobalPropertyf("tu-154/lights/button/absu_thro1", 0) -- ABSU G1 off
createGlobalPropertyf("tu-154/lights/button/absu_thro2", 0) -- ABSU G2 off
createGlobalPropertyf("tu-154/lights/button/absu_thro3", 0) -- ABSU G3 off
createGlobalPropertyf("tu-154/lights/button/dejur_contr", 0) -- standby monitoring
createGlobalPropertyf("tu-154/lights/button/sound_off", 0) -- sound off
createGlobalPropertyf("tu-154/lights/button/fire_eng_1", 0) -- engine 1 fire extinguishing
createGlobalPropertyf("tu-154/lights/button/fire_eng_2", 0) -- engine 2 fire extinguishing
createGlobalPropertyf("tu-154/lights/button/fire_eng_3", 0) -- engine 3 fire extinguishing
createGlobalPropertyf("tu-154/lights/button/fire_apu", 0) -- APU fire extinguishing
createGlobalPropertyf("tu-154/lights/button/fire_ng", 0) -- neutral gas fire extinguishing
createGlobalPropertyf("tu-154/lights/button/fire_turn_3", 0) -- fire extinguishing, shot 3
createGlobalPropertyf("tu-154/lights/button/fire_turn_2", 0) -- fire extinguishing, shot 2
createGlobalPropertyf("tu-154/lights/button/fire_turn_1", 0) -- fire extinguishing, shot 1
createGlobalPropertyi("tu-154/lights/white_light_left", 1) -- brightness of the left white wing light
createGlobalPropertyi("tu-154/lights/white_light_right", 1) -- brightness of the right white wing light
createGlobalPropertyi("tu-154/lights/beacon_light_B", 1) -- brightness of the lower red beacon
createGlobalPropertyi("tu-154/lights/beacon_light_T", 1) -- brightness of the upper red beacon
createGlobalPropertyf("tu-154/lights/sard_panel_lit", 0) -- SARD panel brightness
createGlobalPropertyf("tu-154/lights/nvu_1_active", 0) -- active NVU panel brightness
createGlobalPropertyf("tu-154/lights/nvu_2_active", 0) -- active NVU panel brightness
createGlobalPropertyf("tu-154/lights/oil_qty_work_1", 1) -- brightness of the lamp on the oil gauge
createGlobalPropertyf("tu-154/lights/oil_qty_work_2", 1) -- brightness of the lamp on the oil gauge
createGlobalPropertyf("tu-154/lights/oil_qty_work_3", 1) -- brightness of the lamp on the oil gauge
createGlobalPropertyi("tu-154/rotary/KLN90/3D_L_Angle", 0) -- turning the KLN90 left knob
createGlobalPropertyi("tu-154/rotary/KLN90/3D_R_Angle", 0) -- turning the KLN90 right knob
createGlobalPropertyi("tu-154/rotary/KLN90/power_knob", 0) -- pulling the power knob out
createGlobalPropertyi("tu-154/rotary/KLN90/power_knob_angle", 0) -- turning the KLN90 power knob
createGlobalPropertyi("tu-154/rotary/KLN90/scan_knob", 0) -- pulling the scan knob out
createGlobalPropertyi("tu-154/switchers/wiper_left", 0) -- windscreen wiper mode selector. -1 - slow, 0 - off, +1 - fast
createGlobalPropertyi("tu-154/switchers/wiper_right", 0) -- windscreen wiper mode selector. -1 - slow, 0 - off, +1 - fast
createGlobalPropertyf("tu-154/anim/wiper_angle_left", 0) -- wiper angle from the edge. 0 - 62
createGlobalPropertyf("tu-154/anim/wiper_angle_right", 0) -- wiper angle from the edge. 0 - 62
createGlobalPropertyi("tu-154/switchers/kln_knob_out", 0) -- pulling the KLN knob out
createGlobalPropertyi("tu-154/switchers/kln_power_knob", 0) -- pushing the KLN power knob in
createGlobalPropertyi("tu-154/lights/landing_light_off", 0) -- landing light switch
createGlobalPropertyi("tu-154/lights/landing_light_off_cap", 0) -- landing light switch
createGlobalPropertyf("tu-154/lights/gns430_lit", 1) -- GNS panel brightness
createGlobalPropertyi("tu-154/rotary/GNS430/LB_angle", 0) -- turning the GN430 left large knob
createGlobalPropertyi("tu-154/rotary/GNS430/LS_angle", 0) -- turning the GN430 left small knob
createGlobalPropertyi("tu-154/rotary/GNS430/RB_angle", 0) -- turning the GN430 right large knob
createGlobalPropertyi("tu-154/rotary/GNS430/RS_angle", 0) -- turning the GN430 right small knob
createGlobalPropertyf("tu-154/egpws/dis_sound", 0)
createGlobalPropertyf("tu-154/egpws/dis_gs", 0)
createGlobalPropertyf("tu-154/egpws/dis_rppz", 0)
createGlobalPropertyf("tu-154/egpws/dis_flaps", 0)
createGlobalPropertyf("tu-154/egpws/dis_gear", 0)
createGlobalPropertyf("tu-154/b2/kontur_on", 0) 
createGlobalPropertyf("tu-154/b2/spb_inn_anim", 0) 
createGlobalPropertyi("tu-154/b2/elev_trimm_1_pk", 0) -- elevator trim PK breaker 1. No writer yet
createGlobalPropertyi("tu-154/b2/elev_trimm_2_pk", 0) -- elevator trim PK breaker 2. No writer yet
createGlobalPropertyf("tu-154/kontur/srpbz", 0) 
createGlobalPropertyf("tu-154/gauges/airbleed/cabin_alt_new", 0) 
createGlobalPropertyf("tu-154/gauges/airbleed/cabin_diff_new", 0) 
createGlobalPropertyf("tu-154/vyzov_bp_ready", 0) 
createGlobalPropertyi("tu-154/buttons/console/absu_nvu_arm", 0)
createGlobalPropertyi("tu-154/buttons/console/absu_az1_arm", 0)
createGlobalPropertyi("tu-154/buttons/console/absu_az2_arm", 0)
createGlobalPropertyf("tu-154/controlls/elev_coeff",0.6)
createGlobalPropertyf("tu-154/controlls/yoke_offset",0)
createGlobalPropertyf("tu-154/controlls/elev_L_phys", 0)
createGlobalPropertyf("tu-154/controlls/elev_R_phys", 0)
createGlobalPropertyf("tu-154/controlls/debug1", 1)
createGlobalPropertyf("tu-154/controlls/debug2", 1)
createGlobalPropertyf("tu-154/controlls/debug3", 1)
createGlobalPropertyf("tu-154/controlls/target_n2_1",0)
createGlobalPropertyf("tu-154/controlls/target_n2_2",0)
createGlobalPropertyf("tu-154/controlls/target_n2_3",0)
createGlobalPropertyf("tu-154/engine/max_KVD",0)
createGlobalPropertyf("tu-154/engine/kpp_up",0)
createGlobalPropertyf("tu-154/engine/kpp_dn",0)
createGlobalPropertyf("tu-154/engine/hotstart_1",0) -- engine 1 hot-start severity 0..1, slows the spool. No writer yet
createGlobalPropertyf("tu-154/engine/hotstart_2",0) -- engine 2 hot-start severity 0..1, slows the spool. No writer yet
createGlobalPropertyf("tu-154/engine/hotstart_3",0) -- engine 3 hot-start severity 0..1, slows the spool. No writer yet
createGlobalPropertyi("tu-154/absu_power_27", 0)
createGlobalPropertyf("tu-154/engines/d_isa_temp", 0)
createGlobalPropertyf("tu-154/engines/engine2_case_temp", 0)
-- ail_*_phys and spoil_*_phys are never written. flight_controls.lua writes the
-- surfaces straight to sim/flightmodel/controls/wing3*_ail1def (ailerons),
-- wing2*_spo2def (middle spoilers) and wing1*_spo1def (inner spoilers), in
-- degrees and with the failure applied, and those are what to read.
createGlobalPropertyf("tu-154/controlls/ail_L_phys", 0)
createGlobalPropertyf("tu-154/controlls/ail_R_phys", 0)
createGlobalPropertyf("tu-154/controlls/spoil_L_phys", 0)
createGlobalPropertyf("tu-154/controlls/spoil_R_phys", 0)
createGlobalPropertyf("tu-154/controlls/rudder_coeff",1) -- rudder authority: Mach schedule x reverser blanking (flight_controls.lua)

-- ---------------------------------------------------------------------------
-- Datarefs that modules bind but nothing writes yet. They were read through
-- core/glbl_func.lua's late-binding wrapper, which silently returned 0 and
-- re-probed every 2 s forever. Creating them at 0 keeps that value identical
-- while making the handle real, so the feature can be wired up later and shows
-- in DataRefTool. See CLAUDE.md section 10.
-- ---------------------------------------------------------------------------

-- PPN-13 test panel, read by autopilot/ra56_{pitch,roll,yaw}_logic.lua
createGlobalPropertyf("tu-154/t154/ppn13_lamp1", 0) -- PPN-13 RA lamp, pitch channel
createGlobalPropertyf("tu-154/t154/ppn13_lamp2", 0) -- PPN-13 RA lamp, roll channel
createGlobalPropertyf("tu-154/t154/ppn13_lamp3", 0) -- PPN-13 RA lamp, yaw channel
createGlobalPropertyf("tu-154/t154/ppn13_lamp25", 0) -- PPN-13 channel 1 lamp
createGlobalPropertyf("tu-154/t154/ppn13_lamp26", 0) -- PPN-13 channel 2 lamp
createGlobalPropertyf("tu-154/t154/ppn13_lamp27", 0) -- PPN-13 channel 3 lamp
createGlobalPropertyf("tu-154/t154/ppn13_sbk_test", 0) -- PPN-13 SBK test inhibit

-- Rudder pedal switches and positions, read by flight_ctrls/trimmers.lua
createGlobalPropertyi("tu-154/other/pedal_left_sw", 0) -- captain's pedal trim switch
createGlobalPropertyi("tu-154/other/pedal_right_sw", 0) -- copilot's pedal trim switch
createGlobalPropertyf("tu-154/other/pedal_left_pos", 0) -- captain's pedal position
createGlobalPropertyf("tu-154/other/pedal_right_pos", 0) -- copilot's pedal position

-- MRP current draw, written by navigation/mrp.lua. Inherited An-24 name.
createGlobalPropertyf("tu-154/xap/An24_gauges/mrp_cc", 0) -- MRP current draw
