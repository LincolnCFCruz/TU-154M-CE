defineProperty("lan_lamp_fail_FL", globalPropertyi("tu-154/failures/lan_lamp_fail_FL")) -- front left landing light failure
defineProperty("lan_lamp_fail_FR", globalPropertyi("tu-154/failures/lan_lamp_fail_FR")) -- front right landing light failure
defineProperty("lan_lamp_fail_WL", globalPropertyi("tu-154/failures/lan_lamp_fail_WL")) -- left wing landing light failure
defineProperty("lan_lamp_fail_WR", globalPropertyi("tu-154/failures/lan_lamp_fail_WR")) -- right wing landing light failure

defineProperty("rel_lites_nav", globalPropertyi("sim/operation/failures/rel_lites_nav"))
defineProperty("rel_lites_beac", globalPropertyi("sim/operation/failures/rel_lites_beac"))



-- sources
defineProperty("sim_lan_FL", globalProperty("sim/cockpit2/switches/landing_lights_switch[7]")) -- front left landing light
defineProperty("sim_lan_FR", globalProperty("sim/cockpit2/switches/landing_lights_switch[6]")) -- front right landing light
defineProperty("sim_lan_WL", globalProperty("sim/cockpit2/switches/landing_lights_switch[5]")) -- wing left landing light
defineProperty("sim_lan_WR", globalProperty("sim/cockpit2/switches/landing_lights_switch[4]")) -- wing right landing light


defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))
defineProperty("failures_enabled", globalPropertyi("tu-154/failures/failures_enabled"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control




local timeToFail_FL = (5 + math.random(5)) * 60 -- 20 minutes + random time up to 20 min
local timeToFail_FR = (5 + math.random(5)) * 60
local timeToFail_WL = (5 + math.random(5)) * 60
local timeToFail_WR = (5 + math.random(5)) * 60

local timer_FL = 0 -- timer to fail
local timer_FR = 0 -- timer to fail
local timer_WL = 0 -- timer to fail
local timer_WR = 0 -- timer to fail

local time_table = {{ -5000, -2},    -- bugs workaround
				  { 0, -2 },   -- 
				  { 0.6, -0.5 },   -- 
            	  { 1.5,  1 },   -- 
          		  { 1000, 1 }}   -- bugs workaround

-- random failures: { flag, k1, k2, failed value } (rollFailures, core/glbl_func.lua)
local RANDOM_FAILS = {
	{ lan_lamp_fail_FL, 0.00001, 0.3, 1 },
	{ lan_lamp_fail_FR, 0.00001, 0.3, 1 },
	{ lan_lamp_fail_WL, 0.00001, 0.3, 1 },
	{ lan_lamp_fail_WR, 0.00001, 0.3, 1 },

	{ rel_lites_nav, 0.00001, 0.3, 6 },
	{ rel_lites_beac, 0.00001, 0.3, 6 },
}

local fail_counter = 0
local check_time = math.random(15, 30)


function update()
	local passed = get(frame_time)

local MASTER = get(ismaster) ~= 1	
	

if MASTER then	
	

	
	local FAIL = get(failures_enabled)
	FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
	if FAIL > 0 then
		
		fail_counter = fail_counter + passed
		
		-- calculate timers
		timer_FL = timer_FL + interpolate(time_table, get(sim_lan_FL)) * passed
		timer_FR = timer_FR + interpolate(time_table, get(sim_lan_FR)) * passed
		timer_WL = timer_WL + interpolate(time_table, get(sim_lan_WL)) * passed
		timer_WR = timer_WR + interpolate(time_table, get(sim_lan_WR)) * passed
		
		-- set fails
		if timer_FL > timeToFail_FL then set(lan_lamp_fail_FL, 1) end
		if timer_FR > timeToFail_FR then set(lan_lamp_fail_FR, 1) end
		if timer_WL > timeToFail_WL then set(lan_lamp_fail_WL, 1) end
		if timer_WR > timeToFail_WR then set(lan_lamp_fail_WR, 1) end
		
		-- set limits
		if timer_FL < 0 then timer_FL = 0 end
		if timer_FR < 0 then timer_FR = 0 end
		if timer_WL < 0 then timer_WL = 0 end
		if timer_WR < 0 then timer_WR = 0 end	
		
		
		
		if fail_counter > check_time then
			fail_counter = 0
			check_time = math.random(15, 30)
			
			-- random failures
			rollFailures(RANDOM_FAILS, FAIL)
			
			
			
		
		end
		
		-- dependent failures
		

		
		
	
	
	else
		-- no failures enabled
		fail_counter = 0
		
		clearFailures(RANDOM_FAILS)
	
	end
	
	
	
end

end