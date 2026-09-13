
defineProperty("nav_lights_set", globalPropertyi("tu-154/lights/nav_lights_set")) -- nav lights switch
defineProperty("strobe_set", globalPropertyi("tu-154/lights/strobe_set")) -- red beacon switch
defineProperty("wing_light_left_set", globalPropertyi("tu-154/lights/wing_light_left_set")) -- doorway and wing illumination switch
defineProperty("wing_light_right_set", globalPropertyi("tu-154/lights/wing_light_right_set")) -- doorway and wing illumination switch
defineProperty("tail_light_set", globalPropertyi("tu-154/lights/tail_light_set")) -- tail illumination switch
defineProperty("day_night_set", globalPropertyi("tu-154/lights/day_night_set")) -- day/night switch. 0 = day, 1 = night. dims the annunciator lamps.


defineProperty("landing_ext_set_L", globalPropertyi("tu-154/lights/landing_ext_set_L")) -- left landing light extension
defineProperty("landing_ext_set_R", globalPropertyi("tu-154/lights/landing_ext_set_R")) -- right landing light extension
defineProperty("landing_mode_set_L", globalPropertyi("tu-154/lights/landing_mode_set_L")) -- left landing light mode. -1 = taxi, 0 = off, +1 = landing
defineProperty("landing_mode_set_R", globalPropertyi("tu-154/lights/landing_mode_set_R")) -- right landing light mode


local function setup_hold_command(off_value, on_value, cmd_name, property_ref)

    local function create_handler(off_value, on_value, property_ref)

        return function(phase)                      -- the handler proper, phase == 1 while the button is held
                                                    -- write the new value to the property only if it has changed
            if phase == 0 then                      -- phase == 0 at the moment of the press
                set(property_ref, on_value)
            elseif phase == 2 then                  -- phase == 2 at the moment of release
                set(property_ref, off_value)
            end
            
            return 0                                -- this is the last handler for this command
        end
    end
    
    registerCommandHandler(findCommand(cmd_name) or createCommand(cmd_name, 0), 0, create_handler(off_value, on_value, property_ref))
end


local function setup_toggle_command(off_value, on_value, cmd_name, property_ref)

    local function create_handler(off_value, on_value, property_ref)

        return function(phase)                      -- the handler proper, phase == 1 while the button is held
                                                    -- write the new value to the property only if it has changed
            if phase == 0 then                      -- phase == 0 at the moment of the press
                if get(property_ref) ~= on_value then
					set(property_ref, on_value)
				else
					set(property_ref, off_value)
				end
            end
            
            return 0                                -- this is the last handler for this command
        end
    end
    
    registerCommandHandler(findCommand(cmd_name) or createCommand(cmd_name, 0), 0, create_handler(off_value, on_value, property_ref))
end



-- setup_command(<value in the inactive state (button released)>, <value in the active state (button pressed)>, <command name>, <dataref>)
setup_toggle_command(0, 1, "sim/lights/nav_lights_toggle",   globalPropertyi("tu-154/lights/nav_lights_set"))   -- NAV lights
setup_toggle_command(0, 1, "sim/lights/strobe_lights_toggle",   globalPropertyi("tu-154/lights/strobe_set"))   -- Red becaon lights
setup_toggle_command(0, 1, "sim/lights/spot_lights_toggle",   globalPropertyi("tu-154/lights/tail_light_set"))   -- tail logo




local landing_light_open = findCommand("sim/lights/landing_lights_toggle")

function landing_light_open_hnd(phase)
	if 0 == phase then
		if get(landing_ext_set_L) ~= 1 then
			set(landing_ext_set_L, 1)
			set(landing_ext_set_R, 1)
		else
			set(landing_ext_set_L, 0)
			set(landing_ext_set_R, 0)
		end
		
	end
	return 0
end

registerCommandHandler(landing_light_open, 0, landing_light_open_hnd)

local landing_light_up = findCommand("sim/lights/landing_lights_on")

function landing_light_up_hnd(phase)
	if 0 == phase then
		local a = get(landing_mode_set_L) + 1
		if a > 1 then a = 1 end
		set(landing_mode_set_L, a)
		set(landing_mode_set_R, a)
	else 
		
	end
	return 0
end

registerCommandHandler(landing_light_up, 0, landing_light_up_hnd)


local landing_light_down = findCommand("sim/lights/landing_lights_off")

function landing_light_down_hnd(phase)
	if 0 == phase then
		local a = get(landing_mode_set_L) - 1
		if a < -1 then a = -1 end
		set(landing_mode_set_L, a)
		set(landing_mode_set_R, a)
	else 
		
	end
	return 0
end

registerCommandHandler(landing_light_down, 0, landing_light_down_hnd)




--setup_toggle_command(0, 1, "sasl/test_command",   globalPropertyi("tu-154/lights/nav_lights_set"))   -- NAV lights

--[[
sim/lights/nav_lights_toggle                       Nav lights toggle.
sim/lights/strobe_lights_toggle                    Strobe lights toggle.
sim/lights/spot_lights_toggle                      Spot lights toggle.
sim/lights/landing_lights_toggle                   Landing lights toggle.
sim/lights/landing_lights_on                       Landing lights on.
sim/lights/landing_lights_off                      Landing lights off.



--]]





























