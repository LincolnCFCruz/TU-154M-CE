
-- controls
defineProperty("tks_mode", globalPropertyi("tu-154/switchers/ovhd/tks_mode")) -- TKS mode. 0 = MK, 1 = GPK, 2 = AK
defineProperty("tks_user", globalPropertyi("tu-154/switchers/ovhd/tks_mode_left")) -- consumers. 0 = control, 1 = main
defineProperty("tks_source", globalPropertyi("tu-154/switchers/ovhd/tks_mode_right")) --  correction 0 - control, 1 - main
defineProperty("tks_course_set", globalPropertyi("tu-154/switchers/ovhd/tks_course_set")) -- heading selector
defineProperty("tks_corrr_button", globalPropertyi("tu-154/buttons/ovhd/tks_corrr_button")) -- slaving button
defineProperty("tks_lat_set", globalPropertyf("tu-154/rotary/ovhd/tks_lat_set")) -- latitude setting knob

defineProperty("stabil_ga_main", globalPropertyi("tu-154/switchers/ovhd/stabil_ga_main")) -- main GA roll stabilisation
defineProperty("stabil_ga_reserv", globalPropertyi("tu-154/switchers/ovhd/stabil_ga_reserv")) -- standby GA stabilisation

-- sources
defineProperty("fail_left", globalPropertyi("tu-154/tks/fail_left")) -- failure flag
defineProperty("fail_right", globalPropertyi("tu-154/tks/fail_right")) -- failure flag

defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))

defineProperty("mgv_contr_fail", globalPropertyi("tu-154/bkk/mgv_contr_fail")) -- signal from the BKK: control MGV failure

-- lamps
defineProperty("tks_main_fail", globalPropertyf("tu-154/lights/small/tks_main_fail")) -- main GA failure on the TKS
defineProperty("tks_contr_fail", globalPropertyf("tu-154/lights/small/tks_contr_fail")) -- control GA failure on the TKS

defineProperty("ga_main_fail", globalPropertyf("tu-154/lights/ga_main_fail")) -- no G (hydraulic) standby
defineProperty("ga_reserve_fail", globalPropertyf("tu-154/lights/ga_reserve_fail")) -- no G (hydraulic) standby


defineProperty("lamp_test", globalPropertyi("tu-154/buttons/lamp_test_front")) -- front panel lamp test button	0
defineProperty("day_night_set", globalPropertyf("tu-154/lights/day_night_set")) -- day/night switch. 0 = day, 1 = night. dims the annunciator lamps.


-- sounds
local switcher_sound = loadSample('sounds/plastic_switch.wav')
local button_sound = loadSample('sounds/plastic_btn.wav')


local sw_last = 0
local butt_last = get(tks_corrr_button)

local function switchers_check()
	local tks_mode_sw = get(tks_mode)
	local tks_user_sw = get(tks_user)
	local tks_source_sw = get(tks_source)
	local tks_course_set_sw = get(tks_course_set)
	
	local sw_summ = tks_mode_sw + tks_user_sw + tks_source_sw + tks_course_set_sw
	
	if sw_summ ~= sw_last then
		playSample(switcher_sound, false)
	end
	
	sw_last = sw_summ

	local butt_now = get(tks_corrr_button)
	
	if butt_last ~= butt_now then
		playSample(button_sound, false)
	end
	
	butt_last = butt_now

end


local function lamps()
	
	
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0)
	
	
	local fail_main = bool2int(get(fail_left) == 1) --bool2int(get(fail_left) == 1 or (get(stabil_ga_main) == 1 and mgv))
	
	local tks_main_fail_brt = math.max(fail_main * lamps_brt, 0)
	set(tks_main_fail, tks_main_fail_brt)
	
	
	local fail_aux = bool2int(get(fail_right) == 1) --bool2int(get(fail_right) == 1 or (get(stabil_ga_reserv) == 1 and mgv))
	
	local tks_contr_fail_brt = math.max(fail_aux * lamps_brt, 0)
	set(tks_contr_fail, tks_contr_fail_brt)
	
	
	local test_btn = get(lamp_test) * math.max(get(bus27_volt_right) - 10 / 18.5, 0)
	local day_night = 1 - get(day_night_set) * 0.25
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night
	
	local ga_main_fail_brt = math.max(fail_main * lamps_brt, test_btn)
	set(ga_main_fail, ga_main_fail_brt)
	
	local ga_reserve_fail_brt = math.max(fail_aux * lamps_brt, test_btn)
	set(ga_reserve_fail, ga_reserve_fail_brt)
	
	
end


function update()
	
	switchers_check()
	
	lamps()	
	
	
end