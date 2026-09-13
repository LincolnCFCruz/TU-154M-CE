-- Flight-controls override for SmartCopilot sync.


defineProperty("yoke_pitch_ratio", globalPropertyf("sim/cockpit2/controls/yoke_pitch_ratio")) -- pitch position of joytick
defineProperty("yoke_roll_ratio", globalPropertyf("sim/cockpit2/controls/yoke_roll_ratio")) -- roll position of joystick
defineProperty("yoke_heading_ratio", globalPropertyf("sim/cockpit2/controls/yoke_heading_ratio")) -- yaw position of joystick


defineProperty("ENGN_thro_0", globalProperty("sim/flightmodel/engine/ENGN_thro[0]")) 
defineProperty("ENGN_thro_1", globalProperty("sim/flightmodel/engine/ENGN_thro[1]")) 
defineProperty("ENGN_thro_2", globalProperty("sim/flightmodel/engine/ENGN_thro[2]")) 

defineProperty("ENGN_propmode_0", globalProperty("sim/flightmodel/engine/ENGN_propmode[0]")) 
defineProperty("ENGN_propmode_2", globalProperty("sim/flightmodel/engine/ENGN_propmode[2]")) 

defineProperty("tire_steer_command_deg", globalProperty("sim/flightmodel2/gear/tire_steer_command_deg[0]")) 

defineProperty("l_brake_add", globalPropertyf("sim/flightmodel/controls/l_brake_add")) 
defineProperty("r_brake_add", globalPropertyf("sim/flightmodel/controls/r_brake_add")) 
defineProperty("int_brakes_L", globalPropertyf("tu-154/brakes/int_brakes_L")) 
defineProperty("int_brakes_R", globalPropertyf("tu-154/brakes/int_brakes_R")) 
defineProperty("parkbrake", globalPropertyf("sim/flightmodel/controls/parkbrake")) 


-- custom datarefs
defineProperty("CS_pitch_ratio", globalPropertyf("tu-154/SC/yoke_pitch_ratio")) 
defineProperty("SC_roll_ratio", globalPropertyf("tu-154/SC/yoke_roll_ratio")) 
defineProperty("SC_heading_ratio", globalPropertyf("tu-154/SC/yoke_heading_ratio")) 

defineProperty("SC_ENGN_thro_0", globalPropertyf("tu-154/SC/engine/ENGN_thro_0")) 
defineProperty("SC_ENGN_thro_1", globalPropertyf("tu-154/SC/engine/ENGN_thro_1")) 
defineProperty("SC_ENGN_thro_2", globalPropertyf("tu-154/SC/engine/ENGN_thro_2")) 


defineProperty("SC_tire_steer", globalPropertyf("tu-154/SC/gear/tire_steer_command_deg")) 





-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control

defineProperty("control_thro_other", globalPropertyf("tu-154/SC/control_thro_other")) -- the other person is controlling the throttles

-- overrides
defineProperty("override_wheel_steer", globalPropertyf("sim/operation/override/override_wheel_steer")) -- wheel steering


local conr_last = true
set(override_wheel_steer, 0)

function update()

	local has_contr = get(hascontrol_1) ~= 1
	local other_tro = get(control_thro_other) == 1

	if conr_last ~= has_contr then set(control_thro_other, 0) end
	
	-- change nosewheel steer once at changing controls
	
	if conr_last ~= has_contr and has_contr then
		set(override_wheel_steer, 0)
	elseif not has_contr then
		set(override_wheel_steer, 1)
	end
	
	
	-- let this client control the acf, if SC plugin gives this ability or no plugin connection at all
	if has_contr then
		
		
		set(CS_pitch_ratio, get(yoke_pitch_ratio))
		set(SC_roll_ratio, get(yoke_roll_ratio))
		set(SC_heading_ratio, get(yoke_heading_ratio))
		
		set(SC_tire_steer, get(tire_steer_command_deg))
		
		
	else
		
		set(tire_steer_command_deg, get(SC_tire_steer))
		
		
	end
	
	conr_last = has_contr
	
	-- let this control the throttles when SC controls on other client and "other" option enabled or no CS connection at all
	if (not has_contr and other_tro) or (has_contr and not other_tro) or get(ismaster) == 0 then
		set(SC_ENGN_thro_0, get(ENGN_thro_0))
		set(SC_ENGN_thro_1, get(ENGN_thro_1))
		set(SC_ENGN_thro_2, get(ENGN_thro_2))
		
		
	end

end

function onModuleDone()
	set(override_wheel_steer, 0)
end
