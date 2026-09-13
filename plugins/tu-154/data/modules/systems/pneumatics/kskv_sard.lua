-- SARD: cabin pressure control

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))


-- internal
defineProperty("air_usage_L", globalPropertyf("tu-154/bleed/air_usage_L")) -- left air flow
defineProperty("air_usage_R", globalPropertyf("tu-154/bleed/air_usage_R")) -- right air flow

defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))

defineProperty("bus115_1_volt", globalPropertyf("tu-154/elec/bus115_1_volt"))
defineProperty("sard_panel_lit", globalPropertyf("tu-154/lights/sard_panel_lit")) -- SARD panel brightness

defineProperty("start_sys_work", globalPropertyf("tu-154/start/start_sys_work")) -- start system running

-- controls
defineProperty("sard_cabin_press_set", globalPropertyf("tu-154/switchers/sard/sard_cabin_press_set")) -- cabin pressure setting
defineProperty("sard_abs_press_set", globalPropertyf("tu-154/switchers/sard/sard_abs_press_set")) --absolute pressure setting
defineProperty("sard_diff_set", globalPropertyf("tu-154/switchers/sard/sard_diff_set")) -- pressure differential setting
defineProperty("sard_spd_set", globalPropertyf("tu-154/switchers/sard/sard_spd_set")) -- SARD rate setting

defineProperty("emerg_decompress", globalPropertyi("tu-154/switchers/airbleed/emerg_decompress")) -- pressure release

defineProperty("sard_disable", globalPropertyi("tu-154/switchers/eng/sard_disable")) -- closing the air dump valve

-- windows
defineProperty("cockpit_window_left", globalPropertyf("tu-154/anim/cockpit_window_left")) -- side window opening
defineProperty("cockpit_window_right", globalPropertyf("tu-154/anim/cockpit_window_right")) -- side window opening

defineProperty("pax_door_1", globalPropertyf("tu-154/anim/pax_door_1")) -- front passenger door position
defineProperty("pax_door_2", globalPropertyf("tu-154/anim/pax_door_2")) -- middle passenger door position
defineProperty("pax_door_3", globalPropertyf("tu-154/anim/pax_door_3")) -- right emergency door position


-- failures
defineProperty("sard_valve_fail", globalPropertyi("tu-154/failures/sard_valve_fail")) -- outflow valve failure


-- current altitude
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  -- phisical altitude MSL. meters
defineProperty("msl_press_pas", globalPropertyf("sim/weather/region/sealevel_pressure_pas"))  -- pressure at sea level, pascals

-- results
defineProperty("dump_to_altitude_on", globalPropertyi("sim/cockpit2/pressurization/actuators/dump_to_altitude_on")) -- Dump pressurization to the current altitude, 0 or 1.
defineProperty("cabin_altitude_ft", globalPropertyf("sim/cockpit2/pressurization/actuators/cabin_altitude_ft")) -- Cabin altitude commanded, feet.
defineProperty("cabin_vvi_fpm", globalPropertyf("sim/cockpit2/pressurization/actuators/cabin_vvi_fpm")) -- Cabin VVI commanded, feet.

defineProperty("dump_all_on", globalPropertyi("sim/cockpit2/pressurization/actuators/dump_all_on"))


-- current state
defineProperty("cabin_alt_now_ft", globalPropertyf("sim/cockpit2/pressurization/indicators/cabin_altitude_ft")) -- Cabin altitude actually occurring, feet
defineProperty("pressure_diff_psi", globalPropertyf("sim/cockpit2/pressurization/indicators/pressure_diffential_psi")) -- pounds/square_inch	Cabin differential pressure, psi.

-- sim/aircraft/view/acf_has_press_controls does not exist in XP12. The
-- pressurisation capability now comes from tu154.acf (acf/_max_press_diff),
-- so there is nothing to write here.


-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control


local press_alt_tbl = {{ -100000, 1000000 },    -- bugs walkaround
{  525, 3000 }, -- 0.0
{ 560, 2500 },   --
{ 597, 2000 }, -- 
{ 635, 1500 }, -- 
{ 674, 1000 }, -- 
{ 714, 500 }, -- 
{ 760, 0 }, -- 
{ 806, -500 }, -- 
{  10000000, -100000 }}    -- bugs walkaround

				  
local press_reg = 0 -- pressure valve position. 0 - closed, 1 - fully open
local cab_alt_need = -200
local decomp_last = 0

function update()
	local passed = get(frame_time)
	
	
	local power_L = get(bus27_volt_left) > 13
	local power_R = get(bus27_volt_right) > 13
	
	-- 1 inHg = 3386.389 Pa
	local msl_press_inhg = get(msl_press_pas) / 3386.389
	
	-- current state
	local acf_alt = get(msl_alt) + (29.92 - msl_press_inhg) * 1000 * 0.3048  -- calculate barometric altitude in meters
	local current_alt = get(cabin_alt_now_ft) * 0.3048 -- cabin alt meters
	
	local airflow = get(air_usage_L) + get(air_usage_R)
	local current_diff = get(pressure_diff_psi) * 0.0778-- 0.07031  -- pressure in kg/cm2
	local alt_set = interpolate(press_alt_tbl, get(sard_cabin_press_set))
	local diff_set = get(sard_diff_set)
	
	
	-- calculate slow decompress of the cabin
	local slow_decomp_coef = 1--(acf_alt / 12000) * (-7) + 8
	local slow_decomp = (acf_alt - current_alt) * passed * slow_decomp_coef

	
	-- calculate airflow
	local flow_alt_coef = 1--acf_alt * 0.017 / 12000 + 0.002 -- 0.002 - 0.019
	local airflow_comp = (acf_alt - 10500 - current_alt) * passed * airflow * flow_alt_coef
	
	-- calculate automatic pressure dump
	if acf_alt < alt_set + 200 then 
		if current_alt < acf_alt - 200 then press_reg = 1
		else press_reg = 0 end
	elseif current_diff < diff_set then
		if current_alt < alt_set then press_reg = 1
		else press_reg = 0  end
	end
	if current_diff > diff_set then press_reg = 1 end
	
	local dumpall = 0
	
	-- calculate fast decompress of the cabin
	local fast_decomp = 0 -- 500 - 100
	local fast_decomp_coef = (acf_alt / 12000) * (-400) + 500
	local start_sys = get(start_sys_work) == 1
	if (get(emerg_decompress) == 1 or press_reg == 1) and get(sard_valve_fail) == 0 and get(sard_disable) == 0 and power_R and not start_sys then 
		fast_decomp = current_alt + (acf_alt - current_alt) * passed * fast_decomp_coef
		dumpall = dumpall + 1
	end	
	
	-- windows open
	local windows_decomp = 0
	local cabin_vvi = 10000
	if get(cockpit_window_left) + get(cockpit_window_right) + get(pax_door_1) + get(pax_door_2) + get(pax_door_3) > 0.2 then
		windows_decomp = current_alt + (acf_alt - current_alt) * passed * 1000
		cabin_vvi = 100000
		dumpall = dumpall + 1
	end
	
	
	-- calculate result alt
	local sys_alt = current_alt + airflow_comp + slow_decomp + fast_decomp + windows_decomp
	

local MASTER = get(ismaster) ~= 1	
	

	set(cabin_vvi_fpm, cabin_vvi)	
	set(cabin_altitude_ft, sys_alt / 0.3048)
	
	if dumpall > 0 then set(dump_all_on, 1) else set(dump_all_on, 0) end

	set(sard_panel_lit, get(bus115_1_volt) / 115)
	
end
