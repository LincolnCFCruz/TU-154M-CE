-- this AOA and G-force indicator
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))
-- define property table
defineProperty("ias", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")) -- ias variable
defineProperty("mach", globalPropertyf("sim/flightmodel/misc/machno")) -- Mach number
defineProperty("gforce", globalPropertyf("sim/flightmodel2/misc/gforce_normal")) -- G overload
defineProperty("alpha", globalPropertyf("sim/flightmodel2/misc/AoA_angle_degrees"))  -- angle of attack
defineProperty("alpha_fail", globalPropertyi("sim/operation/failures/rel_AOA"))  -- angle of attack fail

defineProperty("flap_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_fla1def")) -- inner flaps left
defineProperty("slats", globalPropertyf("sim/flightmodel2/controls/slat1_deploy_ratio")) -- slats position. this one works too
defineProperty("rel_pitot", globalPropertyi("sim/operation/failures/rel_pitot")) -- Pitot 1 - Blockage
defineProperty("deflection_mtr_1", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))


-- controls
defineProperty("lamp_test", globalPropertyi("tu-154/buttons/lamp_test_front")) -- lamp test button

defineProperty("auasp_on", globalPropertyi("tu-154/switchers/ovhd/auasp_on")) -- AUASP
defineProperty("auasp_contr", globalPropertyi("tu-154/switchers/ovhd/auasp_contr")) -- AUASP test

defineProperty("gforce_reset", globalPropertyi("tu-154/buttons/misc/gforce_reset")) -- max-g needle reset button

defineProperty("lamp_test", globalPropertyi("tu-154/buttons/lamp_test_front")) -- front panel lamp test button	0
defineProperty("day_night_set", globalPropertyf("tu-154/lights/day_night_set")) -- day/night switch. 0 = day, 1 = night. dims the annunciator lamps.

-- power
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))
defineProperty("bus115_3_volt", globalPropertyf("tu-154/elec/bus115_3_volt"))
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))


defineProperty("auasp_pow27_cc", globalPropertyf("tu-154/elec/auasp_pow27_cc"))
defineProperty("auasp_pow115_cc", globalPropertyf("tu-154/elec/auasp_pow115_cc"))

-- failures
defineProperty("uap_fail", globalPropertyi("sim/operation/failures/rel_AOA"))
defineProperty("warn_fail", globalPropertyi("sim/operation/failures/rel_stall_warn"))





-- results
defineProperty("aoa_ind", globalPropertyf("tu-154/gauges/misc/aoa_ind")) -- angle of attack indicator
defineProperty("aoa_sector", globalPropertyf("tu-154/gauges/misc/aoa_sector")) -- angle of attack indicator sector
defineProperty("gforce_ind", globalPropertyf("tu-154/gauges/misc/gforce_ind")) -- max g indicator
defineProperty("gforce_max", globalPropertyf("tu-154/gauges/misc/gforce_max")) -- max g indicator
defineProperty("gforce_min", globalPropertyf("tu-154/gauges/misc/gforce_min")) -- minimum g indicator

defineProperty("auasp_lamp", globalPropertyf("tu-154/lights/auasp_lamp")) -- lamp on the AUASP
defineProperty("alpha_high", globalPropertyf("tu-154/lights/alpha_high")) -- limit AoA
defineProperty("g_force_high", globalPropertyf("tu-154/lights/g_force_high")) -- limit g

defineProperty("alpha_critical", globalPropertyi("tu-154/auasp/alpha_critical")) -- signal from the AUASP on critical AoA
defineProperty("gforce_critical", globalPropertyi("tu-154/auasp/gforce_critical")) -- signal from the AUASP on critical AoA

defineProperty("speaker_auasp", globalPropertyi("tu-154/alarm/speaker_auasp")) -- limit angle of attack or g



-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control



local m_tbl = {
{-1000, 12},
{0, 12},
{0.6, 12},
{0.63, 11},
{0.67, 10},
{0.69, 9},
{0.77, 8},
{0.87, 7},
{0.96, 6},
{1, 4.5},
{1.5, 0},
{100000, 0},
}


local sector_ang = 12
local aoa_ang_act = 0
local aoa_ang_need = 0
local lamp_lit = false
local lamp_counter = 0
local mach_act = 0

local gf_act = 0
local gf_max = 0
local gf_min = 0

function update()
	
	local MASTER = get(ismaster) ~= 1	
	
	local power = bool2int(get(bus27_volt_right) > 13 and get(bus115_3_volt) > 110 and get(auasp_on) == 1 and get(uap_fail) < 6)
	local passed = get(frame_time)
	local mode_sw = get(auasp_contr)
	
	set(auasp_pow27_cc, power * 10)
	set(auasp_pow115_cc, power * 3)
	
	-- critical AOA sector logic
	
	local sector_ang_need = 12
	
	local flaps = get(flap_inn_L)
	local slat = get(slats)
	if get(rel_pitot) < 6 then mach_act = get(mach) end
	
	if mode_sw == 1 then sector_ang_need = 10
	elseif slat > 0.9 and flaps < 25 then sector_ang_need = 14
	elseif flaps >= 25 then sector_ang_need = 12 
	else
		--sector_ang_need = interpolate(m_tbl, mach_act)
		if mach_act <= 0.42 then sector_ang_need = 12
		else sector_ang_need = (0.42 - mach_act) * 6 / 0.48 + 12 end
	end
	
	
	if sector_ang > sector_ang_need + 0.01 then sector_ang = sector_ang - passed * power * 0.4
	elseif sector_ang < sector_ang_need - 0.01 then sector_ang = sector_ang + passed * power * 0.4 end
	
	set(aoa_sector, sector_ang)
	
	-- AOA indicator
	if mode_sw == 1 and get(alpha_fail) < 6 then 
		aoa_ang_need = 10
		--sector_ang_need = 9.8
	elseif mode_sw == -1 then 
		--sector_ang_need = 12
		aoa_ang_need = 0
	else
		if get(ias) > 50 and get(alpha_fail) < 6 then
			aoa_ang_need = get(alpha) + 3
		--elseif get(alpha_fail) < 6 then aoa_ang_need = 9
		--else aoa_ang_need = 6 
		end
	end
	
	aoa_ang_act = aoa_ang_act + (aoa_ang_need - aoa_ang_act) * passed * power * 3

	if aoa_ang_act > 15 then aoa_ang_act = 15
	elseif aoa_ang_act < 0 then aoa_ang_act = 0 end
	
	set(aoa_ind, aoa_ang_act)

	-- G force indicator
	local gf_need = 0
	
	if mode_sw == 1 then gf_need = 2.0
	else
		gf_need = get(gforce)
	end	
	
	gf_act = gf_act + (gf_need - gf_act) * passed * 2 * power

	if gf_act > 3 then gf_act = 3
	elseif gf_act < -1 then gf_act = -1 end		

	set(gforce_ind, gf_act)
	
	-- max and min needles
	local button = get(gforce_reset)
	if gf_max < gf_act then gf_max = gf_act 
	elseif gf_max > gf_act + 0.01 then gf_max = gf_max - passed * button * 2
	end
	
	if gf_min > gf_act then gf_min = gf_act 
	elseif gf_min < gf_act - 0.01 then gf_min = gf_min + passed * button * 2
	end


	

if MASTER then	

	
	set(gforce_max, gf_max)
	set(gforce_min, gf_min)
	
end
	
	-- signals and lamp logic
	local aoa_crit = bool2int(aoa_ang_act >= sector_ang - 0.5) * power
	local gf_crit = bool2int(gf_act >= 1.8 or gf_act <= -0.8) * power                                                                                                                                                   
	
	if aoa_crit + gf_crit > 0 then 
		lamp_counter = lamp_counter + passed
		if lamp_counter > 0.3 then
			lamp_counter = 0
			lamp_lit = not lamp_lit
		end
	else
		lamp_lit = false
	end
		
	
	
	set(alpha_critical, aoa_crit)
	set(gforce_critical, gf_crit)
	
	set(auasp_lamp, bool2int(lamp_lit))
	
	set(speaker_auasp, math.max(aoa_crit, gf_crit) * bool2int(get(warn_fail) < 6))
	
	-- lamps
	local test_btn = get(lamp_test) * math.max(get(bus27_volt_right) - 10 / 18.5, 0)
	local day_night = 1 - get(day_night_set) * 0.25
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night
	
	set(alpha_high, math.max(aoa_crit * lamps_brt, test_btn))
	set(g_force_high, math.max(gf_crit * lamps_brt, test_btn))





end








--[[
by PT
flaps between 2 - 28 - sector at 13
with flaps 28+ - sector at 12


with them retracted - 12
at M 0.6 the sector starts to move
0.63 = 11
0.67 = 10
0.69 = 9
0.77 = 8
0.87 = 7
0.96 = 6
1 = 4.5
1.5 = 0

during the test the sector is at 11, the needle at 11. the lamp flashes
the lamp does not respond to the lamp test button

--]]