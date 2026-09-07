-- this is the flight controls logic 154M

-- sources
--defineProperty("joy_pitch", globalPropertyf("sim/cockpit2/controls/yoke_pitch_ratio")) -- pitch position of joytick
--defineProperty("joy_roll", globalPropertyf("sim/cockpit2/controls/yoke_roll_ratio")) -- roll position of joystick
--defineProperty("joy_yaw", globalPropertyf("sim/cockpit2/controls/yoke_heading_ratio")) -- yaw position of joystick


-- defineProperty("elev_debug1", globalPropertyf("tu-154/controlls/elevator_debug1")) 
-- defineProperty("elev_debug2", globalPropertyf("tu-154/controlls/elevator_debug2")) 

defineProperty("joy_pitch", globalPropertyf("tu-154/SC/yoke_pitch_ratio")) 
defineProperty("joy_roll", globalPropertyf("tu-154/SC/yoke_roll_ratio")) 
defineProperty("joy_yaw", globalPropertyf("tu-154/SC/yoke_heading_ratio")) 


defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- time of frame

defineProperty("overr", globalPropertyf("sim/operation/override/override_control_surfaces")) -- override controls

-- controls
defineProperty("speedbrake_ratio", globalPropertyf("sim/cockpit2/controls/speedbrake_ratio")) -- sim speedbrake lever

defineProperty("elev_trimm_sw", globalPropertyi("tu-154/controll/elev_trimm_switcher")) -- elevator trim control. -1 = nose down, 0 = neutral, +1 = nose up
defineProperty("ail_trimm_sw", globalPropertyi("tu-154/controll/ail_trimm_sw")) -- aileron trim switch
defineProperty("rudd_trimm_sw", globalPropertyi("tu-154/controll/rudd_trimm_sw")) -- rudder trim switch

defineProperty("int_pitch_trim", globalPropertyf("tu-154/trimmers/int_pitch_trim")) -- elevator trim position
defineProperty("int_roll_trim", globalPropertyf("tu-154/trimmers/int_roll_trim")) -- aileron trim position
defineProperty("int_yaw_trim", globalPropertyf("tu-154/trimmers/int_yaw_trim")) -- rudder trim position

defineProperty("buster_on_1", globalPropertyi("tu-154/switchers/console/buster_on_1")) -- booster switch
defineProperty("buster_on_2", globalPropertyi("tu-154/switchers/console/buster_on_2")) -- booster switch
defineProperty("buster_on_3", globalPropertyi("tu-154/switchers/console/buster_on_3")) -- booster switch
defineProperty("busters_cap", globalPropertyi("tu-154/switchers/console/busters_cap")) -- booster switch guard

defineProperty("control_force_pos", globalPropertyf("tu-154/controls/control_force_pos")) -- elevator feel unit position. 0 - disconnected, 1 - connected
defineProperty("control_force_pos_rud", globalPropertyf("tu-154/controls/control_force_pos_rud")) -- rudder feel unit position. 0 - disconnected, 1 - connected

defineProperty("contr_force_set", globalPropertyi("tu-154/controll/contr_force_set")) -- elevator/rudder feel unit selector. -1 = flight, 0 = auto, +1 = takeoff-landing


defineProperty("deploy_ratio_2", globalProperty("sim/flightmodel2/gear/deploy_ratio[1]")) -- 
defineProperty("deploy_ratio_3", globalProperty("sim/flightmodel2/gear/deploy_ratio[2]")) -- 

defineProperty("gear1_deflect", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))  -- vertical deflection of front gear
defineProperty("gear2_deflect", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))  -- vertical deflection of left gear
defineProperty("gear3_deflect", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))  -- vertical deflection of right gear


-- wings --
-- ailerons
defineProperty("ail_L", globalPropertyf("sim/flightmodel/controls/wing3l_ail1def")) -- aileron left Degrees, positive is trailing-edge down. +- 20
defineProperty("ail_R", globalPropertyf("sim/flightmodel/controls/wing3r_ail1def")) -- aileron right Degrees, positive is trailing-edge down. +- 20

-- spoilers
defineProperty("spd_brk_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_spo1def")) -- inner speedbrake left Degrees
defineProperty("spd_brk_inn_R", globalPropertyf("sim/flightmodel/controls/wing1r_spo1def")) -- inner speedbrake right Degrees

defineProperty("spd_brk_inn_anim_L", globalPropertyf("tu-154/anim/spd_brk_inn_left")) -- inner speedbrake left animation Degrees
defineProperty("spd_brk_inn_anim_R", globalPropertyf("tu-154/anim/spd_brk_inn_right")) -- inner speedbrake right animation Degrees


defineProperty("spd_brk_mid_L", globalPropertyf("sim/flightmodel/controls/wing2l_spo2def")) -- middle speedbrake left Degrees
defineProperty("spd_brk_mid_R", globalPropertyf("sim/flightmodel/controls/wing2r_spo2def")) -- middle speedbrake right Degrees

defineProperty("roll_spoil_L", globalPropertyf("sim/flightmodel/controls/wing2l_spo1def")) -- roll spoiler left Degrees
defineProperty("roll_spoil_R", globalPropertyf("sim/flightmodel/controls/wing2r_spo1def")) -- roll spoiler right Degrees

-- flaps and slats
defineProperty("flap_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_fla1def")) -- inner flaps left
defineProperty("flap_inn_R", globalPropertyf("sim/flightmodel/controls/wing1r_fla1def")) -- inner flaps right

defineProperty("flap_mid_L", globalPropertyf("sim/flightmodel/controls/wing2l_fla2def")) -- middle flaps left
defineProperty("flap_mid_R", globalPropertyf("sim/flightmodel/controls/wing2r_fla2def")) -- middle flaps right

--defineProperty("slats", globalPropertyf("sim/flightmodel/controls/slatrat")) -- slats position. this one works
defineProperty("slats", globalPropertyf("sim/flightmodel2/controls/slat1_deploy_ratio")) -- slats position. this one works too


-- tail --
defineProperty("elevator_L", globalPropertyf("sim/flightmodel/controls/hstab1_elv1def")) -- Degrees, positive is trailing-edge down.
defineProperty("elevator_R", globalPropertyf("sim/flightmodel/controls/hstab2_elv1def")) -- Degrees, positive is trailing-edge down.
defineProperty("rudder", globalPropertyf("sim/flightmodel/controls/vstab2_rud1def")) -- degrees, positive is trailing-edge left
defineProperty("stab_ratio", globalPropertyf("sim/cockpit2/controls/elevator_trim")) -- sim pitch trimmer

--defineProperty("stap_pos_real", globalProperty("sim/flightmodel2/wing/elevator2_deg[0]")) -- sim stab position
--defineProperty("elev_pos_real", globalProperty("sim/flightmodel2/wing/elevator1_deg[0]")) -- sim elevator position

-- hydraulics
defineProperty("gs_press_1", globalPropertyf("tu-154/hydro/gs_press_1")) -- hydraulic system 1 pressure
defineProperty("gs_press_2", globalPropertyf("tu-154/hydro/gs_press_2")) -- hydraulic system 2 pressure
defineProperty("gs_press_3", globalPropertyf("tu-154/hydro/gs_press_3")) -- hydraulic system 3 pressure


-- animations
defineProperty("yoke_pitch", globalPropertyf("tu-154/controlls/yoke_pitch")) -- control wheel pitch travel
defineProperty("yoke_roll", globalPropertyf("tu-154/controlls/yoke_roll")) -- control wheel pitch travel
defineProperty("pedals_turn", globalPropertyf("tu-154/controlls/pedals")) -- control wheel pitch travel
defineProperty("spoilers_lever", globalPropertyf("tu-154/controlls/spoilers_lever")) -- spoiler lever

defineProperty("revers_flap_L", globalProperty("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[0]")) -- reverse on left engine
defineProperty("revers_flap_R", globalProperty("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[2]")) -- reverse on right engine
defineProperty("rpm_high_1", globalPropertyf("tu-154/gauges/engine/rpm_high_1")) -- engine 1 high-pressure spool rpm
defineProperty("rpm_high_3", globalPropertyf("tu-154/gauges/engine/rpm_high_3")) -- engine 3 high-pressure spool rpm


-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 V bus voltage
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 V bus voltage

defineProperty("bus115_1_volt", globalPropertyf("tu-154/elec/bus115_1_volt")) -- 115 V bus voltage
defineProperty("bus115_3_volt", globalPropertyf("tu-154/elec/bus115_3_volt")) -- 115 V bus voltage

defineProperty("bus36_volt_left", globalPropertyf("tu-154/elec/bus36_volt_left")) -- 36 V left bus voltage
defineProperty("bus36_volt_right", globalPropertyf("tu-154/elec/bus36_volt_right")) -- 36 V right bus voltage
defineProperty("bus36_volt_pts250_1", globalPropertyf("tu-154/elec/bus36_volt_pts250_1")) -- 36 V bus voltage, PTS 1
defineProperty("bus36_volt_pts250_2", globalPropertyf("tu-154/elec/bus36_volt_pts250_2")) -- 36 V bus voltage, PTS 2


defineProperty("anim_rud1", globalPropertyf("tu-154/controlls/throttle_1")) -- throttle 1
defineProperty("anim_rud2", globalPropertyf("tu-154/controlls/throttle_2")) -- throttle 2
defineProperty("anim_rud3", globalPropertyf("tu-154/controlls/throttle_3")) -- throttle 3

defineProperty("anim_rud1_ENG", globalPropertyf("tu-154/controlls/throttle_1_ENG")) -- flight engineer's throttle 1
defineProperty("anim_rud2_ENG", globalPropertyf("tu-154/controlls/throttle_2_ENG")) -- flight engineer's throttle 2
defineProperty("anim_rud3_ENG", globalPropertyf("tu-154/controlls/throttle_3_ENG")) -- flight engineer's throttle 3

-- spoilers sources
defineProperty("deflection_mtr_2", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]")) -- 
defineProperty("deflection_mtr_3", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]")) -- 
defineProperty("revers_L", globalPropertyf("tu-154/controlls/revers_L")) -- left reverser lever
defineProperty("revers_R", globalPropertyf("tu-154/controlls/revers_R")) -- right reverser lever

defineProperty("ias_L", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")) -- indicated airspeed in KTS
defineProperty("ias_R", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_copilot"))
-- get(ias) * 1.852 -- km/hr

-- currents
defineProperty("ctr_27_L_cc", globalPropertyf("tu-154/control/ctr_27_L_cc")) -- bus load
defineProperty("ctr_27_R_cc", globalPropertyf("tu-154/control/ctr_27_R_cc")) -- bus load

defineProperty("ctr_115_1_cc", globalPropertyf("tu-154/control/ctr_115_1_cc")) -- bus load
defineProperty("ctr_115_2_cc", globalPropertyf("tu-154/control/ctr_115_2_cc")) -- bus load
defineProperty("ctr_115_3_cc", globalPropertyf("tu-154/control/ctr_115_3_cc")) -- bus load

-- ABSU controls
defineProperty("absu_contr_pitch", globalPropertyf("tu-154/absu/contr_pitch")) -- RA-56 pitch actuator rod travel
defineProperty("absu_contr_roll", globalPropertyf("tu-154/absu/contr_roll")) -- RA-56 roll actuator rod travel
defineProperty("absu_contr_yaw", globalPropertyf("tu-154/absu/contr_yaw")) -- RA-56 yaw actuator rod travel

defineProperty("indicated_airspeed", globalPropertyf("sim/flightmodel/position/indicated_airspeed")) -- indicated airspeed
defineProperty("machno", globalPropertyf("sim/flightmodel/misc/machno")) -- Mach number


-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control

-- failures
defineProperty("ail_fail_left", globalPropertyi("tu-154/failures/ail_fail_left")) -- 
defineProperty("ail_fail_right", globalPropertyi("tu-154/failures/ail_fail_right")) -- 
defineProperty("fail_spoil_inn_left", globalPropertyi("tu-154/failures/fail_spoil_inn_left")) -- 
defineProperty("fail_spoil_inn_right", globalPropertyi("tu-154/failures/fail_spoil_inn_right")) -- 
defineProperty("fail_spoil_mid_left", globalPropertyi("tu-154/failures/fail_spoil_mid_left")) -- 
defineProperty("fail_spoil_mid_right", globalPropertyi("tu-154/failures/fail_spoil_mid_right")) -- 
defineProperty("fail_spoil_out_left", globalPropertyi("tu-154/failures/fail_spoil_out_left")) -- 
defineProperty("fail_spoil_out_right", globalPropertyi("tu-154/failures/fail_spoil_out_right")) -- 

defineProperty("rudder_fail", globalPropertyi("tu-154/failures/rudder_fail")) -- 
defineProperty("elev_fail_left", globalPropertyi("tu-154/failures/elev_fail_left")) -- 
defineProperty("elev_fail_right", globalPropertyi("tu-154/failures/elev_fail_right")) -- 
defineProperty("kontur_on", globalPropertyf("tu-154/b2/kontur_on")) -- 
defineProperty("spb_inn_anim", globalPropertyf("tu-154/b2/spb_inn_anim")) -- 

defineProperty("elev_coeff", globalPropertyf("tu-154/controlls/elev_coeff"))

defineProperty("nosewheel_turn_sel", globalPropertyi("tu-154/switchers/nosewheel_turn_sel"))
defineProperty("yoke_offset", globalPropertyf("tu-154/controlls/yoke_offset"))
--defineProperty("on_ground_L", globalProperty("sim/flightmodel2/gear/on_ground[1]"))
--defineProperty("on_ground_R", globalProperty("sim/flightmodel2/gear/on_ground[1]"))

defineProperty("elev_L_ph", globalPropertyf("tu-154/controlls/elev_L_phys"))
defineProperty("elev_R_ph", globalPropertyf("tu-154/controlls/elev_R_phys"))

--defineProperty("db1", globalPropertyf("tu-154/controlls/debug1"))

set(overr, 1) -- initialise some datarefs


local buster_1_ON = 0
local buster_2_ON = 0
local buster_3_ON = 0

local roll_pos_act = 0
local pitch_pos_act = 0
local yaw_pos_act = 0

local left_mid_sp_act = 0
local right_mid_sp_act = 0
local left_inn_sp_act = 0
local right_inn_sp_act = 0

local pitch_add = 0
local yaw_add = 0
local auto_deploy = 0
local spb_inn = 0
local auto_deploy_delay = 0

local passed = get(frame_time)

local pitch_cmd=0
local pitch_joy=0
local pitch_joy_prev=0

local joy_pitch2=0
-- local joy_pitch2_prev=0

local yoke_tbl = {
{-2, -2},
{-1, -1},
{0, 0},
{0.89, 0.89},
{0.9, 1.2}, 
{1, 2},
{2, 2}}

local elev_stall_tbl = {
{-40, -25.5},
{-29, -26},
{-28, -25.5},
{-27, -25},
{-26, -24.5},
{-25, -24}, 
{-24, -23.5},
{-22, -22}, 
{-20, -20},
{-10, -10},
{0, 0},
{40, 40}}


function update()
	
	local MASTER = get(ismaster) ~= 1
	
	--print(MASTER)
	
	passed = get(frame_time)

	local ias = get(indicated_airspeed) * 1.852
	
	local mach = get(machno)
		
	local elev_coef = 0.6
		
	set(elev_coeff,elev_coef)
	
	-- check power
	local power_27_L = get(bus27_volt_left) > 13
	local power_27_R = get(bus27_volt_right) > 13
	
	-- set busters work status
	if power_27_L then
		buster_1_ON = get(buster_on_1)
		buster_2_ON = get(buster_on_2)
	end
	
	if power_27_R then
		buster_3_ON = get(buster_on_3)
	end
	
	-- check hydraulics
	local HS1 = math.min(get(gs_press_1) / 63, 1) -- should start to slow down at 63 atm
	local HS2 = math.min(get(gs_press_2) / 63, 1)
	local HS3 = math.min(get(gs_press_3) / 63, 1)



	
	--------------------------
	-- ailerons and roll-spoilers --
	local cockpit_yoke_roll = get(joy_roll) + get(int_roll_trim)
	if cockpit_yoke_roll > 1 then cockpit_yoke_roll = 1
	elseif cockpit_yoke_roll < -1 then cockpit_yoke_roll = -1 end
	
	local roll_cmd = cockpit_yoke_roll + get(absu_contr_roll)
	
	if roll_cmd > 1 then roll_cmd = 1
	elseif roll_cmd < -1 then roll_cmd = -1 end
	
	if HS1 > 0.01 or HS2 > 0.01 or HS3 > 0.01 then
		roll_pos_act = roll_pos_act + (roll_cmd - roll_pos_act) * math.max(HS1 * buster_1_ON, HS2 * buster_2_ON, HS3 * buster_3_ON) * passed * 7
	end
	
	local left_ail_pos = roll_pos_act * 20 * line(mach, 0, 1, 0.8, 0.5) -- can add failures here
	local right_ail_pos = -roll_pos_act * 20 * line(mach, 0, 1, 0.8, 0.5) -- can add failures here
	
	local roll_sp_L = 0
	if left_ail_pos <= -1.5 then roll_sp_L = -((left_ail_pos + 1.5) / 18.5) * 45 end

	
	local roll_sp_R = 0
	if right_ail_pos <= -1.5 then roll_sp_R = -((right_ail_pos + 1.5) / 18.5) * 45 end
	
	
	-- set results
	
if MASTER then
	set(ail_L, left_ail_pos * (1 - get(ail_fail_left)))
	set(ail_R, right_ail_pos * (1 - get(ail_fail_right)))
	
	set(roll_spoil_L, roll_sp_L * (1 - get(fail_spoil_out_left)))
	set(roll_spoil_R, roll_sp_R * (1 - get(fail_spoil_out_right)))
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ --spoilers new logic Tu154B from Silver jeni backap \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
	---------------------------------
	-- spoilers logic --
--	local gears = get(deflection_mtr_2) > 0.01 and get(deflection_mtr_3) > 0.01
--	local ruds_iddle = get(anim_rud1) < 0.1 and get(anim_rud2) < 0.1 and get(anim_rud3) < 0.1
    
--   if gears and get(speedbrake_ratio) > 0.95 then
--       if spb_inn < 1 then
--            spb_inn=spb_inn + 0.7*passed
--        end
--    else
--       if spb_inn > 0 then
--            spb_inn=spb_inn - 0.7*passed
--       end
--   end
    
--    set(spb_inn_anim,spb_inn)
       
	
--   if get(kontur_on) > 0 then
        
--       local flaps_to = (get(flap_inn_L)+get(flap_inn_R))/2 < 31
--       local revers = get(revers_L) > 0.1 and get(revers_R) > 0.1
--       if power_27_L and get(gs_press_1) > 50 and gears and ((get(speedbrake_ratio) > 0.95) or revers) and auto_deploy == 0 and auto_deploy_delay == 0 then
--            auto_deploy = 1
--       end
--      if auto_deploy == 1 then
--           if flaps_to then
--               if (get(speedbrake_ratio) < 0.05 or not ruds_iddle) and not revers then
--                    auto_deploy = 0
--               end
--           else
--                if (get(revers_L) > 0.6 and get(revers_R) > 0.6) or not ruds_iddle then
--                    auto_deploy = 0
--                    auto_deploy_delay = 1
--                end
--            end
--       end  
--        if auto_deploy_delay == 1 then
--            if not revers then
--                auto_deploy_delay = 0
--            end
--        end
--    else
--        local revers = get(revers_L) > 0.44 and get(revers_R) > 0.66
--        if power_27_L and get(gs_press_1) > 50 and gears and ((get(speedbrake_ratio) > 0.95) or revers) and auto_deploy < 1 then
--			auto_deploy = 1
			-- if auto_deploy>1 then
				-- auto_deploy=1
--			-- end
--        end
--        if auto_deploy == 1 and get(speedbrake_ratio) < 0.95 and (get(revers_L) < 0.05 and get(revers_R) < 0.05) then
--            auto_deploy = 0
--        end
--    end
	
	
	---------------------------------
	-- middle spoilers --

	
--	local spd_brk_cmd = get(speedbrake_ratio) --  add automatic logic here, controlling the lever itself
	
--	local spd_brk_L = spd_brk_cmd * 45 * bool2int(power_27_L)
--	local spd_brk_R = spd_brk_cmd * 45 * bool2int(power_27_L)
--	if HS1 > 0.01 then
--		if (spd_brk_L - left_mid_sp_act)<=0 then
--			if math.abs(spd_brk_L - left_mid_sp_act)>1 then
--				left_mid_sp_act = left_mid_sp_act - 31.5 * HS1 * passed 
--			else
--				left_mid_sp_act = left_mid_sp_act +(spd_brk_L - left_mid_sp_act) * HS1 * passed * 31.5
--			end
--		elseif (spd_brk_L - left_mid_sp_act)>0 then
--			if math.abs(spd_brk_L - left_mid_sp_act)>1 then
--				left_mid_sp_act = left_mid_sp_act + 31.5* HS1 * passed*math.max(1-get(ias_L)/500*math.min(left_mid_sp_act/20,1),0.7)*1.5
--			else
--				left_mid_sp_act = left_mid_sp_act + (spd_brk_L - left_mid_sp_act) * HS1 * passed * 31.5*math.max(1-get(ias_L)/500*math.min(left_mid_sp_act/20,1),0.7)*1.5
--			end
--		end
--		if (spd_brk_R - right_mid_sp_act)<=0 then
--			if math.abs(spd_brk_R - right_mid_sp_act)>1 then
--				right_mid_sp_act = right_mid_sp_act - 31.5 * HS1 * passed
--			else
--				right_mid_sp_act = right_mid_sp_act +(spd_brk_R - right_mid_sp_act) * HS1 * passed * 31.5
--			end
--		elseif (spd_brk_R - right_mid_sp_act)>0 then
--			if math.abs(spd_brk_R - right_mid_sp_act)>1 then
--				right_mid_sp_act = right_mid_sp_act + 31.5 * HS1 * passed*math.max(1-get(ias_L)/500*math.min(right_mid_sp_act/20,1),0.7)*1.5
--			else
--				right_mid_sp_act = right_mid_sp_act + (spd_brk_R - right_mid_sp_act) * HS1 * passed * 31.5*math.max(1-get(ias_L)/500*math.min(right_mid_sp_act/20,1),0.7)*1.5
--			end
--		end
--	end

--if MASTER then	
--	set(spd_brk_mid_L, left_mid_sp_act * (1 - get(fail_spoil_mid_left)))
--	set(spd_brk_mid_R, right_mid_sp_act * (1 - get(fail_spoil_mid_right)))
--end	
	
	---------------------------------
	-- inner spoilers --
--	local spoilers_cmd = auto_deploy -- add automatic logic here
	
--	local spoil_L = spoilers_cmd * 50 * bool2int(power_27_L)
--	local spoil_R = spoilers_cmd * 50 * bool2int(power_27_L)
--	if HS1 > 0.01 then
		-- if spoilers_cmd == 1 then 
			-- left_inn_sp_act = left_inn_sp_act + (spoil_L - left_inn_sp_act) * HS1 * passed * 1
			-- right_inn_sp_act = right_inn_sp_act + (spoil_R - right_inn_sp_act) * HS1 * passed * 1
		-- else
			-- left_inn_sp_act = left_inn_sp_act + (spoil_L - left_inn_sp_act) * HS1 * passed * 0.7
			-- right_inn_sp_act = right_inn_sp_act + (spoil_R - right_inn_sp_act) * HS1 * passed * 0.7
		-- end
--		if (spoil_L - left_inn_sp_act)<=0 then
--			if math.abs(spoil_L - left_inn_sp_act)>1 then
--				left_inn_sp_act = left_inn_sp_act - 30 * HS1 * passed 
--			else
--				left_inn_sp_act = left_inn_sp_act +(spoil_L - left_inn_sp_act) * HS1 * passed * 30
--			end
--		elseif (spoil_L - left_inn_sp_act)>0 then
--			if math.abs(spoil_L - left_inn_sp_act)>1 then
--				left_inn_sp_act = left_inn_sp_act + 30 * HS1 * passed*math.max(1-get(ias_L)/500*math.min(left_inn_sp_act/20,1),0.1)*1.5
--			else
--				left_inn_sp_act = left_inn_sp_act + (spoil_L - left_inn_sp_act) * HS1 * passed * 30*math.max(1-get(ias_L)/500*math.min(left_inn_sp_act/20,1),0.1)*1.5
--			end
--		end
--		if (spoil_R - right_inn_sp_act)<=0 then
--			if math.abs(spoil_R - right_inn_sp_act)>1 then
--				right_inn_sp_act = right_inn_sp_act - 30* HS1 * passed
--			else
--				right_inn_sp_act = right_inn_sp_act +(spoil_R - right_inn_sp_act) * HS1 * passed * 30
--			end
--		elseif (spoil_R - right_inn_sp_act)>0 then
--			if math.abs(spoil_R - right_inn_sp_act)>1 then
--				right_inn_sp_act = right_inn_sp_act + 30 * HS1 * passed*math.max(1-get(ias_L)/500*math.max(right_inn_sp_act/20,1),0.1)*1.5
--			else
--				right_inn_sp_act = right_inn_sp_act + (spoil_R - right_inn_sp_act) * HS1 * passed * 30*math.max(1-get(ias_L)/500*math.min(right_inn_sp_act/20,1),0.1)*1.5
--			end
--		end
--	end

--if MASTER then	
--	set(spd_brk_inn_L, left_inn_sp_act * (1 - get(fail_spoil_inn_left)))
--	set(spd_brk_inn_R, right_inn_sp_act * (1 - get(fail_spoil_inn_right)))
--end
	
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ --spoilers logic Tu154M Felis to jeni original \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
	---------------------------------
	-- spoilers logic --
	local gears = get(deflection_mtr_2) > 0.01 and get(deflection_mtr_3) > 0.01
	local ruds_iddle = get(anim_rud1) < 0.1 and get(anim_rud2) < 0.1 and get(anim_rud3) < 0.1
	local revers = get(revers_L) > 0.1 and get(revers_R) > 0.1
	local IAS_lim = get(ias_L) > 54 or get(ias_R) > 54
	
	local auto_deploy = power_27_L and gears and ((ruds_iddle and IAS_lim) or revers)
	
	
	---------------------------------
	-- middle spoilers --

	if auto_deploy and MASTER then set(speedbrake_ratio, 1) end
	
	local spd_brk_cmd = get(speedbrake_ratio) --  add automatic logic here, controlling the lever itself
	
	local spd_brk_L = spd_brk_cmd * 45 * bool2int(power_27_L)
	local spd_brk_R = spd_brk_cmd * 45 * bool2int(power_27_L)
	if HS1 > 0.01 then
		left_mid_sp_act = left_mid_sp_act + (spd_brk_L - left_mid_sp_act) * HS1 * passed * 15
		right_mid_sp_act = right_mid_sp_act + (spd_brk_R - right_mid_sp_act) * HS1 * passed * 15
	end

if MASTER then	
	set(spd_brk_mid_L, left_mid_sp_act * (1 - get(fail_spoil_mid_left)))
	set(spd_brk_mid_R, right_mid_sp_act * (1 - get(fail_spoil_mid_right)))
end	
	
	---------------------------------
	-- inner spoilers --
	local spoilers_cmd = bool2int(auto_deploy) -- add automatic logic here
	
	local spoil_L = spoilers_cmd * 50 * bool2int(power_27_L)
	local spoil_R = spoilers_cmd * 50 * bool2int(power_27_L)
	if HS1 > 0.01 then
		if spoilers_cmd == 1 then 
			left_inn_sp_act = left_inn_sp_act + (spoil_L - left_inn_sp_act) * HS1 * passed * 10
			right_inn_sp_act = right_inn_sp_act + (spoil_R - right_inn_sp_act) * HS1 * passed * 10
		else
			left_inn_sp_act = left_inn_sp_act + (spoil_L - left_inn_sp_act) * HS1 * passed * 1
			right_inn_sp_act = right_inn_sp_act + (spoil_R - right_inn_sp_act) * HS1 * passed * 1
		end
	end

if MASTER then	
	set(spd_brk_inn_L, left_inn_sp_act * (1 - get(fail_spoil_inn_left)))
	set(spd_brk_inn_R, right_inn_sp_act * (1 - get(fail_spoil_inn_right)))
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\END\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
	
	-----------------------------------------------------
	-- calculate position of flight controls forcing mech
	
	local force_pos = get(control_force_pos)
	local force_pos_rud = get(control_force_pos_rud) 
	
	-- turn on the forcing
	local forcing_sw = get(contr_force_set)
if MASTER then
	if power_27_L and power_27_R then
		
		-- forcing limit elevator
		if (forcing_sw == 0 and get(flap_inn_L) < 7 and get(flap_inn_R) < 7) or forcing_sw == -1 then 
			force_pos = force_pos + passed * 0.04
			if force_pos < 0.99 then
				set(ctr_27_L_cc, 5)
				set(ctr_27_R_cc, 5)
			else
				set(ctr_27_L_cc, 0)
				set(ctr_27_R_cc, 0)
			end
		else
			force_pos = force_pos - passed * 0.04
			
			if force_pos > 0.01 then
				set(ctr_27_L_cc, 5)
				set(ctr_27_R_cc, 5)
			else
				set(ctr_27_L_cc, 0)
				set(ctr_27_R_cc, 0)
			end
		end
		
		-- forcing limit rudder
		if (forcing_sw == 0 and ((get(flap_inn_L) < 7 and get(flap_inn_R) < 7) and (get(gear2_deflect) < 0.01 and get(gear3_deflect) < 0.01))) or forcing_sw == -1 then 
			force_pos_rud = force_pos_rud + passed * 0.08
			if force_pos_rud < 0.99 then
				set(ctr_27_L_cc, 5)
				set(ctr_27_R_cc, 5)
			else
				set(ctr_27_L_cc, 0)
				set(ctr_27_R_cc, 0)
			end
		else
			force_pos_rud = force_pos_rud - passed * 0.08
			
			if force_pos_rud > 0.01 then
				set(ctr_27_L_cc, 5)
				set(ctr_27_R_cc, 5)
			else
				set(ctr_27_L_cc, 0)
				set(ctr_27_R_cc, 0)
			end
		end
		
	end
	-- set limits
	if force_pos > 1 then force_pos = 1
	elseif force_pos < 0 then force_pos = 0 end
	
	if force_pos_rud > 1 then force_pos_rud = 1
	elseif force_pos_rud < 0 then force_pos_rud = 0 end
	
	set(control_force_pos, force_pos)
	set(control_force_pos_rud, force_pos_rud)
end
	
	--------------------------------
	-- elevator --
	--cockpit_yoke_pitch = pitch_joy*(0.7+0.3*get(nosewheel_turn_sel)) + get(int_pitch_trim)
	cockpit_yoke_pitch = pitch_joy + get(int_pitch_trim)
	if cockpit_yoke_pitch <-0.5517 then
		 cockpit_yoke_pitch =-0.5517
	end
	
	if force_pos>0 and cockpit_yoke_pitch>0.314 and joy_pitch2-pitch_joy_prev>0 then
		pitch_joy = pitch_joy+(joy_pitch2-pitch_joy_prev)*passed*2.5/force_pos*math.max(10*((0.414-cockpit_yoke_pitch)/0.1),5)
	else
		pitch_joy = joy_pitch2
	end
	pitch_joy_prev=pitch_joy
	
	--if get(nosewheel_turn_sel)==0 then
		-- if get(joy_pitch)>0.99 then
			-- if joy_pitch2<1 then
				-- joy_pitch2=joy_pitch2+passed/2
			-- end
		-- elseif get(joy_pitch)<0.99 and joy_pitch2>0.5 then
			-- joy_pitch2=joy_pitch2-passed/2
		-- -- elseif get(joy_pitch)<-0.99 then
			-- -- if joy_pitch2>-1 then
				-- -- joy_pitch2=joy_pitch2-passed/2
			-- -- end
		-- -- elseif get(joy_pitch)>-0.99 and joy_pitch2<-0.5 then
			-- -- joy_pitch2=joy_pitch2+passed/2
		-- else
			-- if math.abs(joy_pitch2*2-get(joy_pitch)-0.15)>0.05 and joy_pitch2>0.5  then
				-- joy_pitch2=joy_pitch2-passed*(joy_pitch2_prev*2-get(joy_pitch))*10
			-- else
				-- joy_pitch2=(get(joy_pitch)+0.15)*0.5
			-- end
		-- end
		--joy_pitch2=(interpolate(yoke_tbl, get(joy_pitch))+get(yoke_offset))*0.5
	--else
		joy_pitch2=get(joy_pitch)+get(yoke_offset)
	--end
	--joy_pitch2_prev=joy_pitch2
	-- overforce the limit mechanism
	-- if pitch_joy > 0.9 and pitch_add < 2 then pitch_add = pitch_add + passed * 0.3 
	-- elseif pitch_joy < -0.9 and pitch_add > -2 then pitch_add = pitch_add - passed * 0.3
	-- elseif math.abs(pitch_joy) < 0.9 then pitch_add = 0 end
	
	-- -- limit joy pitch by forcing
	-- if pitch_joy > (1 - force_pos * 0.5) then pitch_joy = (1 - force_pos * 0.5)
	-- elseif pitch_joy < -(1 - force_pos * 0.4) then pitch_joy = -(1 - force_pos * 0.4) end
	
	
	
	
	
	
	if cockpit_yoke_pitch > 1 then cockpit_yoke_pitch = 1
	elseif cockpit_yoke_pitch < -1 then cockpit_yoke_pitch = -1 end
	
	pitch_cmd = cockpit_yoke_pitch + get(absu_contr_pitch)
	
	local stab_pos = get(stab_ratio)
	
	if pitch_cmd > 1 then pitch_cmd = 1
	elseif pitch_cmd < -1 then pitch_cmd = -1 end
	
	if HS1 > 0.01 or HS2 > 0.01 or HS3 > 0.01 then
		pitch_pos_act = pitch_pos_act + (pitch_cmd - pitch_pos_act) * math.max(HS1 * buster_1_ON, HS2 * buster_2_ON, HS3 * buster_3_ON) * passed * (7-((get(ias_L)+get(ias_R))/2)*0.002)
	end
	local elev_left = 0 
	local elev_right = 0 
	local elev_left_c = 0 
	local elev_right_c = 0 
	
	
	elev_left = -pitch_pos_act * 29 
	elev_right = -pitch_pos_act * 29
	if elev_left>16-stab_pos*1.5 then
		elev_left = 16-stab_pos*1.5 
	end
	if elev_right>16-stab_pos*1.5 then
		elev_right = 16-stab_pos*1.5 
	end
	--elevator stalls above 22° NU
	if elev_left< -22 then
		elev_left_aero=interpolate(elev_stall_tbl,elev_left)
	else
		elev_left_aero=elev_left
	end
	if elev_right< -22 then
		elev_right_aero=interpolate(elev_stall_tbl,elev_right)
	else
		elev_right_aero=elev_right
	end
		set(elev_L_ph,elev_left* (1 - get(elev_fail_left)))
		set(elev_R_ph,elev_right* (1 - get(elev_fail_right)))
	-- calculate correction for elevator
	
	-- if mach < 1 then elev_coef = interpolate(mach_tbl, mach)
	-- else elev_coef = 0.1 end

	
if MASTER then	
	-- set results
	set(elevator_L, elev_left_aero * elev_coef * (1 - get(elev_fail_left)))
	set(elevator_R, elev_right_aero * elev_coef * (1 - get(elev_fail_right)))
end	
	
	--print(get(elevator_L), "  ", get(elevator_R))
	
	-------------------------------------
	-- rudder -- 
	local yaw_joy = get(joy_yaw)
	
	local cockpit_yoke_yaw = yaw_joy + get(int_yaw_trim)-- + yaw_add
	
	if cockpit_yoke_yaw > (1 - force_pos_rud * 0.6) then cockpit_yoke_yaw = (1 - force_pos_rud * 0.6)
	elseif cockpit_yoke_yaw < -(1 - force_pos_rud * 0.6) then cockpit_yoke_yaw = -(1 - force_pos_rud * 0.6) end	
	
	
	-- overforce yaw limit mechanism
	if yaw_joy > 0.9 and yaw_add < 2 then yaw_add = yaw_add + passed * 0.3
	elseif yaw_joy < -0.9 and yaw_add > -2 then yaw_add = yaw_add - passed * 0.3
	elseif math.abs(yaw_joy) < 0.9 then yaw_add = 0 end
	
	cockpit_yoke_yaw = cockpit_yoke_yaw + yaw_add
	
	if cockpit_yoke_yaw > 1 then cockpit_yoke_yaw = 1
	elseif cockpit_yoke_yaw < -1 then cockpit_yoke_yaw = -1 end
	
	
	
	local rud_cmd = -cockpit_yoke_yaw - get(absu_contr_yaw)
	
	
	
	if rud_cmd > 1 then rud_cmd = 1
	elseif rud_cmd < -1 then rud_cmd = -1 end

	
	if HS1 > 0.01 or HS2 > 0.01 or HS3 > 0.01 then
		yaw_pos_act = yaw_pos_act + (rud_cmd - yaw_pos_act) * math.max(HS1 * buster_1_ON, HS2 * buster_2_ON, HS3 * buster_3_ON) * passed * 10
	end
	
	local rudder_pos = yaw_pos_act * 25 * line(mach, 0, 1, 0.8, 0.5) -- can add failures here

	-- rudder --
	local rudder_L = 1 - math.max(get(revers_flap_L) - 0.5, 0) * get(rpm_high_1) * 0.015
	local rudder_R = 1 - math.max(get(revers_flap_R) - 0.5, 0) * get(rpm_high_3) * 0.015

if MASTER then	
	set(rudder, rudder_pos * ((rudder_L + rudder_R) * 0.5) * (1 - get(rudder_fail)))

	
	-------------------------------------
	-- set animations
	set(spd_brk_inn_anim_L, left_inn_sp_act * (1 - get(fail_spoil_inn_left)))
	set(spd_brk_inn_anim_R, right_inn_sp_act * (1 - get(fail_spoil_inn_right)))
	
	set(yoke_pitch, cockpit_yoke_pitch)
	set(yoke_roll, cockpit_yoke_roll)
	set(pedals_turn, cockpit_yoke_yaw)
	
	set(spoilers_lever, spd_brk_cmd)
end	


end




function onModuleDone()
	set(overr, 0)
	print("flight controls released")
end







