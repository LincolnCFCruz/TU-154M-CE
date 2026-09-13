-- gauges and controlls
defineProperty("apu_main_switch", globalPropertyi("tu-154/switchers/eng/apu_main_switch")) -- APU switch
defineProperty("apu_start_mode", globalPropertyi("tu-154/switchers/eng/apu_start_mode")) -- APU start mode
defineProperty("apu_air_bleed", globalPropertyi("tu-154/switchers/eng/apu_air_bleed")) -- bleed air valve switching. -1 - close, 0 - neutral, +1 - open
defineProperty("apu_start", globalPropertyi("tu-154/buttons/eng/apu_start")) -- APU start button
defineProperty("apu_stop", globalPropertyi("tu-154/buttons/eng/apu_stop")) -- APU stop button


defineProperty("apu_rpm", globalPropertyf("tu-154/gauges/eng/apu_rpm")) -- APU rpm. 0-100%
defineProperty("apu_egt_gau", globalPropertyf("tu-154/gauges/eng/apu_egt")) -- APU EGT. 0 - 900 C
defineProperty("apu_oil_temp", globalPropertyf("tu-154/gauges/eng/apu_oil_temp")) -- APU oil temperature -50 - 150 C


-- lamps
defineProperty("low_oil", globalPropertyf("tu-154/lights/apu/low_oil")) -- oil low
defineProperty("low_oil_press", globalPropertyf("tu-154/lights/apu/low_oil_press")) -- Oil P
defineProperty("high_temp", globalPropertyf("tu-154/lights/apu/high_temp")) -- limit temperature
defineProperty("high_rpm", globalPropertyf("tu-154/lights/apu/high_rpm")) -- limit rpm
defineProperty("pta6_fail", globalPropertyf("tu-154/lights/apu/pta6_fail")) -- PTA 6A failed
defineProperty("doors_open", globalPropertyf("tu-154/lights/apu/doors_open")) -- doors open
defineProperty("fuel_press", globalPropertyf("tu-154/lights/apu/fuel_press")) -- Fuel P
defineProperty("start_ready", globalPropertyf("tu-154/lights/apu/start_ready")) -- Ready to start
defineProperty("work_mode", globalPropertyf("tu-154/lights/apu/work_mode")) -- Reaching the rated mode
defineProperty("start_apu", globalPropertyf("tu-154/lights/apu/start_apu")) -- start the APU


-- internal datarefs
defineProperty("apu_n1", globalPropertyf("tu-154/eng/apu_n1")) -- APU rpm
defineProperty("apu_oil_t", globalPropertyf("tu-154/eng/apu_oil_t")) -- APU oil temperature
defineProperty("apu_oil_q", globalPropertyf("tu-154/eng/apu_oil_q")) -- APU oil quantity
defineProperty("apu_oil_p", globalPropertyf("tu-154/eng/apu_oil_p")) -- aircraft oil pressure
defineProperty("apu_egt", globalPropertyf("tu-154/eng/apu_egt")) -- APU exhaust gas temperature
defineProperty("apu_air_press", globalPropertyf("tu-154/eng/apu_air_press")) -- air pressure for engine start

defineProperty("apu_air_doors", globalPropertyf("tu-154/eng/apu_air_doors")) -- air inflation door position
defineProperty("apu_fuel_p", globalPropertyf("tu-154/eng/apu_fuel_p")) -- APU fuel pressure

defineProperty("apu_start_bus", globalPropertyf("tu-154/elec/apu_start_bus")) -- APU bus voltage
defineProperty("apu_start_cc", globalPropertyf("tu-154/elec/apu_start_cc")) -- current draw of the APU starter
defineProperty("apu_start_seq", globalPropertyi("tu-154/elec/apu_start_seq")) -- APU start in progress

defineProperty("apu_doors", globalPropertyf("tu-154/anim/apu_doors")) -- APU door position. 0 - closed, 1 - open.

defineProperty("cockpit_window_left", globalPropertyf("tu-154/anim/cockpit_window_left")) -- side window opening
defineProperty("cockpit_window_right", globalPropertyf("tu-154/anim/cockpit_window_right")) -- side window opening

-- other sources
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))


-- lamp sources
defineProperty("test_lamps", globalPropertyi("tu-154/buttons/lamp_test_apu")) -- APU panel lamp test button
defineProperty("day_night_set", globalPropertyf("tu-154/lights/day_night_set")) -- day/night switch. 0 = day, 1 = night. dims the annunciator lamps.
defineProperty("gear_vent_set", globalPropertyi("tu-154/switchers/eng/gear_fan")) -- landing gear bay ventilation

-- enviroment

-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- The sim-side APU datarefs (APU_generator_on, APU_starter_switch, APU_N1_percent,
-- APU_running, rel_APU_press, bleed_air_mode) are NOT bound here any more.
-- apu_logic.lua owns that synchronisation and runs immediately before this module,
-- so the default_APU() that used to live here simply overwrote everything it had
-- just computed - in particular forcing APU_starter_switch to 2 (crank) the whole
-- time the APU was stopped. APU_generator_on belongs to
-- systems/electrical/generators_logic.lua.

-- sim/aircraft/overflow/acf_has_APU_switch does not exist in XP12. The "aircraft has
-- an APU" flag now lives in tu154.acf (acf/_has_APU_switch 1), so there is nothing
-- to write here and the binding only produced a findDataRef warning.

-- start phase from apu_logic.lua: 0 none, 1 cold crank, 2 starter, 3 combustion,
-- 4 overshoot, 5 warm-up, 6 running
defineProperty("apu_start_phase", globalPropertyi("tu-154/eng/apu_start_phase"))

-- coordinates of airplane and camera
defineProperty("local_x", globalPropertyf("sim/flightmodel/position/local_x")) -- position X
defineProperty("local_y", globalPropertyf("sim/flightmodel/position/local_y")) -- position Y
defineProperty("local_z", globalPropertyf("sim/flightmodel/position/local_z")) -- position Z

defineProperty("view_x", globalPropertyf("sim/graphics/view/view_x")) -- camera position X
defineProperty("view_y", globalPropertyf("sim/graphics/view/view_y")) -- camera position Y
defineProperty("view_z", globalPropertyf("sim/graphics/view/view_z")) -- camera position Z


-- failures
defineProperty("apu_start_fail",globalPropertyi("tu-154/failures/apu_start_fail")) -- starter failure
defineProperty("apu_gen_fail",globalPropertyi("tu-154/failures/apu_gen_fail")) -- generator failure
defineProperty("apu_fail_oilt",globalPropertyi("tu-154/failures/apu_fail_oilt")) -- failure on oil temperature
defineProperty("apu_fail_egt",globalPropertyi("tu-154/failures/apu_fail_egt")) -- failure on EGT
defineProperty("apu_fail_fuel_left",globalPropertyi("tu-154/failures/apu_fail_fuel_left")) -- failure on residual fuel in the chamber at start
defineProperty("apu_fail",globalPropertyi("tu-154/failures/apu_fail")) -- wear-out failure
defineProperty("apu_press_fail", globalPropertyi("tu-154/failures/apu_press_fail")) -- engine bleed air failure


-- sounds
local switcher_sound = loadSample('sounds/metal_switch.wav')
local button_sound = loadSample('sounds/plastic_btn.wav')

local passed = get(frame_time)


local n1_table_start = {{ -5000, 0},    -- bugs workaround
				  { 0, 0 },
				  { 8, 0 },
				  { 12, 15 },
				  { 14, 5 },
				  { 16, 18 },
				  { 18, 15 },
				  { 20, 20 },
				  { 110, 110 },
          		  { 1000, 110 }}   -- bugs workaround

local n1_table_off = {{ -5000, 0},    -- bugs workaround
				  { 0, 0 },
				  { 110, 110 },
          		  { 1000, 110 }}   -- bugs workaround

local n1_actual = 0
local EGT_actual = 0
local oil_t_actual = -60

local function gauges()
	local n1_angle = 0
	local EGT_angle = 0
	local oil_t_angle = -60
	local n1 = get(apu_n1)
	if n1 > n1_actual then n1_angle = interpolate(n1_table_start, n1) -- if starting, add needle trembling
	else n1_angle = interpolate(n1_table_off, n1) end
	EGT_angle = get(apu_egt)
	
	if EGT_angle < -10 then EGT_angle = -10 end
	
	if get(bus27_volt_right) > 13 then
		oil_t_angle = get(apu_oil_t)
	else
		oil_t_angle = -75
	end
	

	n1_actual = n1_actual + (n1_angle - n1_actual) * passed * 5
	EGT_actual = EGT_actual + (EGT_angle - EGT_actual) * passed * 3
	oil_t_actual = oil_t_actual + (oil_t_angle - oil_t_actual) * passed * 3
	
	set(apu_rpm, n1_actual)
	set(apu_egt_gau, EGT_actual)
	set(apu_oil_temp, oil_t_actual)
	
end


local apu_main_last = get(apu_main_switch)
local apu_start_mod_last = get(apu_start_mode)
local apu_air_last = get(apu_air_bleed)
local apu_start_last = get(apu_start)
local apu_stop_last = get(apu_stop)
local test_lamps_last = get(test_lamps)

local function check_controls()
	
	local apu_main_sw = get(apu_main_switch)
	local apu_start_mod_sw = get(apu_start_mode)
	local apu_air_sw = get(apu_air_bleed)
	local apu_start_but = get(apu_start)
	local apu_stop_but = get(apu_stop)
	local test_lamps_but = get(test_lamps)
	
	local changes_sw = apu_main_sw + apu_start_mod_sw + apu_air_sw - apu_main_last - apu_start_mod_last - apu_air_last
	local changes_but = apu_start_but + apu_stop_but + test_lamps_but - apu_start_last - apu_stop_last - test_lamps_last

	if changes_sw ~= 0 then playSample(switcher_sound, false) end
	if changes_but ~= 0 then playSample(button_sound, false) end
	
	apu_main_last = apu_main_sw
	apu_start_mod_last = apu_start_mod_sw
	apu_air_last = apu_air_sw
	apu_start_last = apu_start_but
	apu_stop_last = apu_stop_but
	test_lamps_last = test_lamps_but
end


local low_oil_press_sign = 0
local high_temp_sign = 0
local high_rpm_sign = 0

local start_ready_brt = 0

local function lamps()
	
	local test_btn = get(test_lamps) * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	local day_night = 1 - get(day_night_set) * 0.25
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night
	
	local rpm = get(apu_n1)
	local start_seq = get(apu_start_seq) == 1
	local phase = get(apu_start_phase)
	local thermo = get(apu_egt)
	local main_sw = get(apu_main_switch) == 1
	
	-- "OIL P" - lit when the pressure is below normal
	-- on the stand (RPM=0): always lit (pressure=0)
	-- during the spool-up: goes out automatically above RPM > 23% (pressure > 1 kgf/cm2)
	-- in operation (RPM > 45%): lit if the pressure has dropped below normal
	if get(apu_oil_p) < 1 and main_sw then
		low_oil_press_sign = 1
	else
		low_oil_press_sign = 0
	end

	-- temperature and rpm - latched (emergency parameters).
	-- "Starting" is the start phase, not "the starter is energised": the starter
	-- drops out at 45% RPM, so keying off apu_start_seq applied the 570 C running
	-- limit through the rest of the spool-up and the overshoot, where EGT is still
	-- coming down from its peak - latching this lamp on a perfectly normal start.
	-- The threshold matches apu_logic's EGT_START_MAX / EGT_LOAD_STOP.
	local starting = phase >= 2 and phase <= 4
	if (starting and thermo > 680) or (not starting and thermo > 570) then high_temp_sign = 1 end
	if rpm > 105 then high_rpm_sign = 1 end

	-- reset the latched ones at shutdown
	if not main_sw then
		low_oil_press_sign = 0
		high_temp_sign = 0
		high_rpm_sign = 0
	end

	local low_oil_brt = 0
	-- "OIL LEVEL" - lit only when main_sw is on and the oil really is low
	-- not lit when the dataref is uninitialised (oil_q = 0 at startup)
	if main_sw and get(apu_oil_q) > 0 and get(apu_oil_q) < 0.4 then low_oil_brt = 1 end
	low_oil_brt = math.max(low_oil_brt * lamps_brt, test_btn)
	set(low_oil, low_oil_brt)
	
	local low_oil_press_brt = math.max(low_oil_press_sign * lamps_brt, test_btn)
	set(low_oil_press, low_oil_press_brt)

	local high_temp_brt = math.max(high_temp_sign * lamps_brt, test_btn)
	set(high_temp, high_temp_brt)

	local high_rpm_brt = math.max(high_rpm_sign * lamps_brt, test_btn)
	set(high_rpm, high_rpm_brt)
	
	local pta6_fail_brt = math.max(0, test_btn) -- fake for now
	set(pta6_fail, pta6_fail_brt)
	
	local doors_open_brt = 0
	if get(apu_doors) > 0.9 then doors_open_brt = 1 end
	doors_open_brt = math.max(doors_open_brt * lamps_brt, test_btn)
	set(doors_open, doors_open_brt)
	
	local fuel_press_brt = 0
	if get(apu_fuel_p) > 0.8 then fuel_press_brt = 1 end
	fuel_press_brt = math.max(fuel_press_brt * lamps_brt, test_btn)
	set(fuel_press, fuel_press_brt)
	
	
	if get(apu_air_doors) < 0.01 and get(apu_doors) > 0.9 then start_ready_brt = 1 end
	if get(apu_air_doors) >= 0.01 or get(apu_doors) < 0.9 then start_ready_brt = 0 end
	local start_ready_lit = math.max(start_ready_brt * lamps_brt, test_btn)
	set(start_ready, start_ready_lit)
	
	-- "REACHING RATED MODE" lights at 90% per Flight Manual 8.2.1
	-- (apu_logic's RPM_MODE_LAMP); this read 92 and disagreed with both.
	local work_mode_brt = 0
	if rpm > 90 and main_sw then work_mode_brt = 1 end
	work_mode_brt = math.max(work_mode_brt * lamps_brt, test_btn)
	set(work_mode, work_mode_brt)
	
	local start_apu_brt = 0
	if rpm < 92 and get(gear_vent_set) == 1 then start_apu_brt = 1 end
	start_apu_brt = math.max(start_apu_brt * lamps_brt, test_btn) -- landing gear ventilation and when the APU is off.
	set(start_apu, start_apu_brt)

end


function update()
	passed = get(frame_time)
	
	check_controls()
	lamps()
	gauges()

end