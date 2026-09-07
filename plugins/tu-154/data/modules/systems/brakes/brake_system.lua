-- this is the improved brakes system for XP12 (Cold/Wet conditions + Anti-skid)jeni

defineProperty("have_pedals", globalPropertyi("tu-154/have_pedals"))

-- hydro
defineProperty("gs_press_1", globalPropertyf("tu-154/hydro/gs_press_1")) 
defineProperty("gs_press_2", globalPropertyf("tu-154/hydro/gs_press_2")) 
defineProperty("gs_press_3", globalPropertyf("tu-154/hydro/gs_press_3")) 
defineProperty("gs_press_4", globalPropertyf("tu-154/hydro/gs_press_4")) 

-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) 

-- sim brakes
defineProperty("l_brake_add", globalPropertyf("sim/flightmodel/controls/l_brake_add")) 
defineProperty("r_brake_add", globalPropertyf("sim/flightmodel/controls/r_brake_add")) 
defineProperty("parkbrake", globalPropertyf("sim/flightmodel/controls/parkbrake")) 
-- xp11 reported the wheel chocks on sim/cockpit2/controls/parking_brake_ratio; xp12 marks
-- that dataref REPLACED by sim/flightmodel/controls/parkbrake, so a "parkbrake_2" handle
-- would alias "parkbrake" above and its write would silently clobber the lever state that
-- BetterPushback / X-RAAS / SmartCopilot read. Chocks are folded into the single write in
-- update() instead.

-- wheels speed for anti-skid (m/s)
defineProperty("wheel_spd_L", globalProperty("sim/flightmodel/parts/tire_speed_now[1]")) 
defineProperty("wheel_spd_R", globalProperty("sim/flightmodel/parts/tire_speed_now[2]"))

-- controls
defineProperty("gear_blocks", globalPropertyf("tu-154/anim/gear_blocks")) 
defineProperty("brake_emerg", globalPropertyf("tu-154/controlls/brake_emerg")) 
defineProperty("brake_emerg_L", globalPropertyf("tu-154/controlls/brake_emerg_L")) 
defineProperty("brake_emerg_R", globalPropertyf("tu-154/controlls/brake_emerg_R")) 

-- animation
defineProperty("parking_brake", globalPropertyi("tu-154/controll/parking_brake")) 
defineProperty("brake_L", globalPropertyf("tu-154/controlls/brake_L")) 
defineProperty("brake_R", globalPropertyf("tu-154/controlls/brake_R")) 

defineProperty("int_brakes_L", globalPropertyf("tu-154/brakes/int_brakes_L")) 
defineProperty("int_brakes_R", globalPropertyf("tu-154/brakes/int_brakes_R")) 

-- sim/operation/override/override_gearbrake
defineProperty("overr", globalPropertyi("sim/operation/override/override_gearbrake")) 

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 

-- failures
defineProperty("brake_heat_left", globalPropertyf("tu-154/failures/brake_heat_left")) 
defineProperty("brake_heat_right", globalPropertyf("tu-154/failures/brake_heat_right")) 
defineProperty("brake_runtime_left", globalPropertyf("tu-154/failures/brake_runtime_left")) 
defineProperty("brake_runtime_right", globalPropertyf("tu-154/failures/brake_runtime_right")) 

defineProperty("rel_lbrakes", globalPropertyi("sim/operation/failures/rel_lbrakes")) 
defineProperty("rel_rbrakes", globalPropertyi("sim/operation/failures/rel_rbrakes")) 
defineProperty("failures_enabled", globalPropertyi("tu-154/failures/failures_enabled"))

-- enviroment
defineProperty("speed", globalPropertyf("sim/flightmodel/position/groundspeed"))
defineProperty("thermo", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")) 
defineProperty("gear_vent_set", globalPropertyi("tu-154/switchers/eng/gear_fan")) 

defineProperty("gear2_deflect", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))  
defineProperty("gear3_deflect", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))  

set(brake_runtime_left, 1)
set(brake_runtime_right, 1)

-- sound
local brake_hnd_on = loadSample('sounds/parking_on.wav')
local brake_hnd_off = loadSample('sounds/parking_off.wav')

local termo_coef = {
    {0, 1},
    {100, 1.5},
    {200, 2},
    {300, 5},
    {1000, 50},
    {1000000, 500}
}

local joy_value_L = globalProperty("sim/joystick/joy_mapped_axis_value[6]")
local joy_value_R = globalProperty("sim/joystick/joy_mapped_axis_value[7]")

local sim_brake = 0
local passed = 0
local left_brk = 0
local right_brk = 0

local regular_brk_comm = findCommand("sim/flight_controls/brakes_regular")
local max_brk_comm = findCommand("sim/flight_controls/brakes_max")
local park_brk_max_comm = findCommand("sim/flight_controls/brakes_toggle_max")
local park_brk_reg_comm = findCommand("sim/flight_controls/brakes_toggle_regular")
local left_brk_cmd = findCommand("sim/flight_controls/left_brake")
local right_brk_cmd = findCommand("sim/flight_controls/right_brake")

local termo_left = get(thermo)
local termo_right = get(thermo)

-- COMMAND HANDLERS
function regular_brk_hnd(phase)
    if 1 == phase then 
        set(parking_brake, 0)
        sim_brake = math.min(sim_brake + passed, 1)
    else 
        sim_brake = 0
        if get(hascontrol_1) ~= 1 then
            set(l_brake_add, 0)
            set(r_brake_add, 0)
        end
    end
    return 0
end
registerCommandHandler(regular_brk_comm, 0, regular_brk_hnd)

function max_brk_hnd(phase)
    if 1 == phase then 
        set(parking_brake, 0)
        sim_brake = math.min(sim_brake + passed * 4, 1)
    else 
        sim_brake = 0
        if get(hascontrol_1) ~= 1 then
            set(l_brake_add, 0)
            set(r_brake_add, 0)
        end
    end
    return 0
end
registerCommandHandler(max_brk_comm, 0, max_brk_hnd)

function park_brk_toggle_hnd(phase)
    if 0 == phase then 
        local brk = 1 - get(parking_brake)
        if brk == 0 and get(hascontrol_1) ~= 1 then
            set(l_brake_add, 0)
            set(r_brake_add, 0)
        end
        set(parking_brake, brk)
    end
    return 0
end
registerCommandHandler(park_brk_max_comm, 0, park_brk_toggle_hnd)
registerCommandHandler(park_brk_reg_comm, 0, park_brk_toggle_hnd)

function left_brk_cmd_hnd(phase)
    if 1 == phase then 
        left_brk = math.min(left_brk + passed * 2, 1)
        set(parking_brake, 0)
    else left_brk = 0 end
    return 0
end
function right_brk_cmd_hnd(phase)
    if 1 == phase then 
        right_brk = math.min(right_brk + passed * 2, 1)
        set(parking_brake, 0)
    else right_brk = 0 end
    return 0
end
registerCommandHandler(left_brk_cmd, 0, left_brk_cmd_hnd)
registerCommandHandler(right_brk_cmd, 0, right_brk_cmd_hnd)

set(parking_brake, 1)
set(overr, 1)

local park_lever_last = get(parking_brake)
local e_brake_last = get(brake_emerg)
local fail_counter = 0
local check_time = math.random(15, 30)

-- Anti-skid variables
local antiskid_L = 1.0
local antiskid_R = 1.0

function update()
    local spd = get(speed)
    passed = get(frame_time)
    local air_temp = get(thermo)

    -- 1. Efficiency in the cold
    local friction_boost = 1.0
    if air_temp < 5 then
        friction_boost = 1.0 + (math.max(0, 5 - air_temp) * 0.03)
        if friction_boost > 1.6 then friction_boost = 1.6 end 
    end

    -- 2. Anti-skid logic (ABS)
    -- Compare the aircraft speed and the wheel speed.
    -- If the wheel speed is below 80% of the aircraft speed, release the pressure.
    antiskid_L = 1.0
    antiskid_R = 1.0
    
    if spd > 5 then -- Works only above 10 knots
        local wheelL = get(wheel_spd_L)
        local wheelR = get(wheel_spd_R)
        
        -- If the wheel has slowed too much (a skid)
        if wheelL < spd * 0.8 then antiskid_L = 0.0 end
        if wheelR < spd * 0.8 then antiskid_R = 0.0 end
    end

    -- Controls & Pressures
    local brake_1 = get(joy_value_L)
    local brake_2 = get(joy_value_R)
    local park_lvr = get(parking_brake)
    local e_brake = get(brake_emerg)
    
    if (park_lever_last ~= park_lvr and park_lvr == 0) then 
        brake_1 = 0
        brake_2 = 0
    end    
    
    if park_lever_last ~= park_lvr then
        if park_lvr == 1 then playSample(brake_hnd_on, false)
        else playSample(brake_hnd_off, false) end
    end
    
    park_lever_last = park_lvr
    e_brake_last = e_brake

    local main_press = math.min(get(gs_press_1) / 120, 1)
    local emer_press = math.min(get(gs_press_4) / 120, 1)
    
    local left_blake_emer = e_brake * emer_press
    local right_blake_emer = e_brake * emer_press

    local left_blake = math.max(brake_1 * main_press, sim_brake * main_press, left_brk * main_press, park_lvr * main_press) 
    local right_blake = math.max(brake_2 * main_press, sim_brake * main_press, right_brk * main_press, park_lvr * main_press) 
    
    local park = math.max(e_brake * emer_press, park_lvr * main_press)
    
    if left_blake < 0.05 then left_blake = 0 end
    if right_blake < 0.05 then right_blake = 0 end
    
    -- Failures
    left_blake = left_blake * bool2int(get(rel_lbrakes) ~= 6)
    right_blake = right_blake * bool2int(get(rel_rbrakes) ~= 6)

    -- Failure Logic (wear handling)
    if get(ismaster) ~= 1 then            
        local FAIL = get(failures_enabled)
        FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
        if FAIL > 0 then
            fail_counter = fail_counter + passed
            if fail_counter > check_time then
                fail_counter = 0
                check_time = math.random(15, 30)
                if get(rel_lbrakes) ~= 1 then set(rel_lbrakes, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
                if get(rel_rbrakes) ~= 1 then set(rel_rbrakes, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
            end
            if get(gear2_deflect) > 0.05 then
                set(brake_runtime_left, math.max(0, get(brake_runtime_left) - passed * left_blake * spd * 0.0000014 * interpolate(termo_coef, math.max(0, termo_left))))
            end
            if get(gear3_deflect) > 0.05 then
                set(brake_runtime_right, math.max(0, get(brake_runtime_right) - passed * right_blake * spd * 0.0000014 * interpolate(termo_coef, math.max(0, termo_right))))
            end
        end
    end    
    
    -- Thermals
    termo_left = termo_left + left_blake * spd * 0.9 * bool2int(get(gear2_deflect) > 0.05) * passed 
    termo_left = termo_left + (air_temp - termo_left) * passed * (1 + get(gear_vent_set) * 4) * 0.01
    termo_right = termo_right + right_blake * spd * 0.9 * bool2int(get(gear3_deflect) > 0.05) * passed 
    termo_right = termo_right + (air_temp - termo_right) * passed * (1 + get(gear_vent_set) * 4) * 0.01
    
    set(brake_heat_left, termo_left)
    set(brake_heat_right, termo_right)
    
    -- FINAL OUTPUT INCLUDING ANTI-SKID
    if get(hascontrol_1) ~= 1 then
        -- Base force * Cold gain * ABS coefficient
        local final_L = math.max(left_blake * friction_boost * antiskid_L, left_blake_emer)
        local final_R = math.max(right_blake * friction_boost * antiskid_R, right_blake_emer)
        
        -- Dynamic correction at very low speeds (a smooth stop)
        local low_spd_factor = 1.0
        if spd < 1.5 then low_spd_factor = 0.4 end
        
        set(l_brake_add, math.min(final_L * low_spd_factor, 1.0))
        set(r_brake_add, math.min(final_R * low_spd_factor, 1.0))
        
        set(int_brakes_L, math.max(left_blake, park))
        set(int_brakes_R, math.max(right_blake, park))
        -- reported to third parties only (BetterPushback, X-RAAS, SmartCopilot); the actual
        -- braking goes through l_brake_add/r_brake_add while override_gearbrake is on.
        -- Chocks hold the aircraft just like the lever does, so both feed this.
        set(parkbrake, math.max(park, get(gear_blocks)))
        
        if brake_1 > 0.8 and brake_2 > 0.8 then set(parking_brake, 0) end 
    end

    -- Pedal animation
    set(brake_L, math.max(left_blake, brake_1, park_lvr))
    set(brake_R, math.max(right_blake, brake_2, park_lvr))
end

function onModuleDone()
    set(overr, 0)
end
