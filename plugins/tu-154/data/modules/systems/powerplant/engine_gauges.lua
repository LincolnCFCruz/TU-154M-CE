-- Engine instruments: the sim's spools, temperatures, pressures and flows
-- mapped onto the Tu-154's gauge scales (the source of each table is beside it).

-- controls
defineProperty("control_ut", globalPropertyi("tu-154/buttons/eng/control_ut")) -- UT test button
defineProperty("control_vibro_1", globalPropertyi("tu-154/buttons/eng/control_vibro_1")) -- vibration check button
defineProperty("control_vibro_2", globalPropertyi("tu-154/buttons/eng/control_vibro_2")) -- vibration check button
defineProperty("control_vibro_3", globalPropertyi("tu-154/buttons/eng/control_vibro_3")) -- vibration check button
defineProperty("vibro_sel_1", globalPropertyi("tu-154/switchers/eng/vibro_sel_1")) -- vibration indicator selector
defineProperty("vibro_sel_2", globalPropertyi("tu-154/switchers/eng/vibro_sel_2")) -- vibration indicator selector
defineProperty("vibro_sel_3", globalPropertyi("tu-154/switchers/eng/vibro_sel_3")) -- vibration indicator selector

defineProperty("fuel_meter_on", globalPropertyi("tu-154/switchers/fuel/fuel_meter_mech_on")) -- flowmeter

defineProperty("gauges_on_1", globalPropertyi("tu-154/switchers/eng/gauges_on_1")) -- engine monitoring instruments
defineProperty("gauges_on_2", globalPropertyi("tu-154/switchers/eng/gauges_on_2")) -- engine monitoring instruments
defineProperty("gauges_on_3", globalPropertyi("tu-154/switchers/eng/gauges_on_3")) -- engine monitoring instruments

-- gauges
defineProperty("rpm_low_1", globalPropertyf("tu-154/gauges/engine/rpm_low_1")) -- low pressure turbine rpm No.1
defineProperty("rpm_low_2", globalPropertyf("tu-154/gauges/engine/rpm_low_2")) -- low pressure turbine rpm No.2
defineProperty("rpm_low_3", globalPropertyf("tu-154/gauges/engine/rpm_low_3")) -- low pressure turbine rpm No.3
defineProperty("rpm_high_1", globalPropertyf("tu-154/gauges/engine/rpm_high_1")) -- engine 1 high-pressure spool rpm
defineProperty("rpm_high_2", globalPropertyf("tu-154/gauges/engine/rpm_high_2")) -- engine 2 high-pressure spool rpm
defineProperty("rpm_high_3", globalPropertyf("tu-154/gauges/engine/rpm_high_3")) -- engine 3 high-pressure spool rpm

defineProperty("egt_1", globalPropertyf("tu-154/gauges/eng/egt_1")) -- EGT engine 1
defineProperty("egt_2", globalPropertyf("tu-154/gauges/eng/egt_2")) -- EGT engine 2
defineProperty("egt_3", globalPropertyf("tu-154/gauges/eng/egt_3")) -- EGT engine 3

defineProperty("fuel_press_1", globalPropertyf("tu-154/gauges/eng/fuel_press_1")) -- engine 1 fuel pressure
defineProperty("fuel_press_2", globalPropertyf("tu-154/gauges/eng/fuel_press_2")) -- engine 2 fuel pressure
defineProperty("fuel_press_3", globalPropertyf("tu-154/gauges/eng/fuel_press_3")) -- engine 3 fuel pressure

defineProperty("oil_press_1", globalPropertyf("tu-154/gauges/eng/oil_press_1")) -- engine 1 oil pressure
defineProperty("oil_press_2", globalPropertyf("tu-154/gauges/eng/oil_press_2")) -- engine 2 oil pressure
defineProperty("oil_press_3", globalPropertyf("tu-154/gauges/eng/oil_press_3")) -- engine 3 oil pressure

defineProperty("oil_temp_1", globalPropertyf("tu-154/gauges/eng/oil_temp_1")) -- engine 1 oil temperature
defineProperty("oil_temp_2", globalPropertyf("tu-154/gauges/eng/oil_temp_2")) -- engine 2 oil temperature
defineProperty("oil_temp_3", globalPropertyf("tu-154/gauges/eng/oil_temp_3")) -- engine 3 oil temperature

defineProperty("fuel_flow_1", globalPropertyf("tu-154/gauges/eng/fuel_flow_1")) -- engine 1 fuel flow
defineProperty("fuel_flow_2", globalPropertyf("tu-154/gauges/eng/fuel_flow_2")) -- engine 2 fuel flow
defineProperty("fuel_flow_3", globalPropertyf("tu-154/gauges/eng/fuel_flow_3")) -- engine 3 fuel flow

defineProperty("vibra_1", globalPropertyf("tu-154/gauges/eng/vibra_1")) -- engine 1 vibration
defineProperty("vibra_2", globalPropertyf("tu-154/gauges/eng/vibra_2")) -- engine 2 vibration
defineProperty("vibra_3", globalPropertyf("tu-154/gauges/eng/vibra_3")) -- engine 3 vibration


defineProperty("oil_qty_1", globalPropertyf("tu-154/gauges/eng/oil_qty_1")) -- oil quantity
defineProperty("oil_qty_2", globalPropertyf("tu-154/gauges/eng/oil_qty_2")) -- oil quantity
defineProperty("oil_qty_3", globalPropertyf("tu-154/gauges/eng/oil_qty_3")) -- oil quantity

defineProperty("fuel_temp_1", globalPropertyf("tu-154/gauges/eng/fuel_temp_1")) -- fuel temperature
defineProperty("fuel_temp_2", globalPropertyf("tu-154/gauges/eng/fuel_temp_2")) -- fuel temperature


-- sources xp12 
defineProperty("sim_egt_1", globalProperty("sim/cockpit2/engine/indicators/EGT_deg_cel[0]")) -- EGT from sim
defineProperty("sim_egt_2", globalProperty("sim/cockpit2/engine/indicators/EGT_deg_cel[1]")) -- EGT from sim
defineProperty("sim_egt_3", globalProperty("sim/cockpit2/engine/indicators/EGT_deg_cel[2]")) -- EGT from sim

--sim/cockpit2/engine/indicators/EGT_deg_cel new dataref - - 

defineProperty("ENGN_FF_1", globalProperty("sim/cockpit2/engine/indicators/fuel_flow_kg_sec[0]")) -- FF from sim kg/second
defineProperty("ENGN_FF_2", globalProperty("sim/cockpit2/engine/indicators/fuel_flow_kg_sec[1]")) -- FF from sim kg/second
defineProperty("ENGN_FF_3", globalProperty("sim/cockpit2/engine/indicators/fuel_flow_kg_sec[2]")) -- FF from sim kg/second

defineProperty("fuel_p_1", globalProperty("sim/cockpit2/engine/indicators/fuel_pressure_psi[0]"))
defineProperty("fuel_p_2", globalProperty("sim/cockpit2/engine/indicators/fuel_pressure_psi[1]"))
defineProperty("fuel_p_3", globalProperty("sim/cockpit2/engine/indicators/fuel_pressure_psi[2]"))

defineProperty("oil_p_1", globalProperty("sim/cockpit2/engine/indicators/oil_pressure_psi[0]"))
defineProperty("oil_p_2", globalProperty("sim/cockpit2/engine/indicators/oil_pressure_psi[1]"))
defineProperty("oil_p_3", globalProperty("sim/cockpit2/engine/indicators/oil_pressure_psi[2]"))

defineProperty("oil_t_1", globalProperty("sim/cockpit2/engine/indicators/oil_temperature_deg_C[0]"))
defineProperty("oil_t_2", globalProperty("sim/cockpit2/engine/indicators/oil_temperature_deg_C[1]"))
defineProperty("oil_t_3", globalProperty("sim/cockpit2/engine/indicators/oil_temperature_deg_C[2]"))

defineProperty("vibration_1", globalPropertyf("tu-154/eng/vibration_1")) -- engine vibration
defineProperty("vibration_2", globalPropertyf("tu-154/eng/vibration_2")) -- engine vibration
defineProperty("vibration_3", globalPropertyf("tu-154/eng/vibration_3")) -- engine vibration

defineProperty("engn_oil_qty_1", globalPropertyf("tu-154/failures/engn_oil_qty_1")) -- oil remaining
defineProperty("engn_oil_qty_2", globalPropertyf("tu-154/failures/engn_oil_qty_2")) -- oil remaining
defineProperty("engn_oil_qty_3", globalPropertyf("tu-154/failures/engn_oil_qty_3")) -- oil remaining


-- engines

defineProperty("eng1_N2", globalProperty("sim/flightmodel/engine/ENGN_N2_[0]")) -- engine 1 rpm
defineProperty("eng2_N2", globalProperty("sim/flightmodel/engine/ENGN_N2_[1]")) -- engine 2 rpm
defineProperty("eng3_N2", globalProperty("sim/flightmodel/engine/ENGN_N2_[2]")) -- engine 3 rpm

defineProperty("comsta0", globalPropertyi("sim/operation/failures/rel_comsta0")) -- compressor stall
defineProperty("comsta1", globalPropertyi("sim/operation/failures/rel_comsta1"))
defineProperty("comsta2", globalPropertyi("sim/operation/failures/rel_comsta2"))


-- other sources
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 V bus voltage
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 V bus voltage

defineProperty("emerg_inv115", globalPropertyi("tu-154/switchers/eng/emerg_inv115")) -- emergency 115 V inverter

defineProperty("bus115_1_volt", globalPropertyf("tu-154/elec/bus115_1_volt"))

defineProperty("bus36_volt_left", globalPropertyf("tu-154/elec/bus36_volt_left")) -- 36 V left bus voltage
defineProperty("bus36_volt_right", globalPropertyf("tu-154/elec/bus36_volt_right")) -- 36 V right bus voltage

defineProperty("thermo", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")) -- outside temperature

defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  -- MSL alt in meters

defineProperty("baro_press_pas",  globalPropertyf("sim/weather/region/sealevel_pressure_pas"))   -- sea-level pressure, Pa

-- failures
defineProperty("fuel_flowmeter_1_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_1_fail"))
defineProperty("fuel_flowmeter_2_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_2_fail"))
defineProperty("fuel_flowmeter_3_fail", globalPropertyi("tu-154/failures/fuel_flowmeter_3_fail"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
-- hascontrol_1 removed - it was not used in the code

-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) -- s of sim time this frame, 0 while paused


local MASTER = get(ismaster) ~= 1  -- refreshed at the top of update()

local passed = get(frame_time)

-- [DT] Needle noise on a fixed timebase.
--
-- The jitter/flutter terms below used to call math.random() once per frame.
-- Two consequences: the twitch ran faster at a higher frame rate, and it kept
-- moving while the sim was paused -- the lagged values and every math.sin(T.tme)
-- term freeze correctly at frame_time 0, but a fresh random draw does not, so
-- the N1 and N2 needles carried on twitching on the pause screen during a start
-- or a shutdown runout.
--
-- noise() holds its sample and redraws it on a NOISE_HZ timebase built from
-- frame_time: frame-rate independent, and frozen when the sim is. The range is
-- [-0.5, 0.5), the same as the (math.random() - 0.5) it replaces.
local NOISE_HZ = 20                     -- redraws per simulated second
local NOISE_DT = 1 / NOISE_HZ
local noise_val, noise_acc = {}, {}
local function noise(key, dt)
	local v = noise_val[key]
	local a = (noise_acc[key] or 0) + dt
	if v == nil or a >= NOISE_DT then
		v = math.random() - 0.5
		noise_val[key] = v
		a = 0
	end
	noise_acc[key] = a
	return v
end


-- sea-level pressure in inHg; the standard atmosphere until the sim reports one
local function get_baro_inhg()
	local pas = get(baro_press_pas)
	if pas and pas > 0 then
		return pas / 3386.39
	end
	return 29.92
end

local power_27_L = get(bus27_volt_left) > 13
local power_27_R = get(bus27_volt_right) > 13
local power_36_L = get(bus36_volt_left) > 30
local power_36_R = get(bus36_volt_right) > 30
local power_115 = get(bus115_1_volt) > 110

local gau_1_on = get(gauges_on_1)
local gau_2_on = get(gauges_on_2)
local gau_3_on = get(gauges_on_3)

-- vibration gauges

local vibr_1_actual = 0
local vibr_2_actual = 0
local vibr_3_actual = 0

local function vibra_gau()

	local vibr_1 = 0
	local vibr_2 = 0
	local vibr_3 = 0
	
	local vibrat_1 = get(vibration_1)
	local vibrat_2 = get(vibration_2)
	local vibrat_3 = get(vibration_3)
	
	if power_27_L then
		if get(control_vibro_1) == 1 then
			vibr_1 = 95 * gau_1_on
		elseif get(vibro_sel_1) == 0 then
			vibr_1 = vibrat_1 * gau_1_on * 0.95
		else
			vibr_1 = vibrat_1 * gau_1_on 
		end
	end
	
	if power_27_R then
		if get(control_vibro_2) == 1 then
			vibr_2 = 95 * gau_2_on
		elseif get(vibro_sel_2) == 0 then
			vibr_2 = vibrat_2 * gau_2_on * 0.95
		else
			vibr_2 = vibrat_2 * gau_2_on
		end		
		
		if get(control_vibro_3) == 1 then
			vibr_3 = 95 * gau_3_on
		elseif get(vibro_sel_3) == 0 then
			vibr_3 = vibrat_3 * gau_3_on * 0.95
		else
			vibr_3 = vibrat_3 * gau_3_on
		end
	end
	
	-- smooth movement
	vibr_1_actual = vibr_1_actual + (vibr_1 - vibr_1_actual) * passed * 3
	vibr_2_actual = vibr_2_actual + (vibr_2 - vibr_2_actual) * passed * 3
	vibr_3_actual = vibr_3_actual + (vibr_3 - vibr_3_actual) * passed * 3

	set(vibra_1, vibr_1_actual)
	set(vibra_2, vibr_2_actual)
	set(vibra_3, vibr_3_actual)


end


-- 3 needle gauges

local fuelP_1_actual = 0
local fuelP_2_actual = 0
local fuelP_3_actual = 0

local oilP_1_actual = 0
local oilP_2_actual = 0
local oilP_3_actual = 0

local oilT_1_actual = 0
local oilT_2_actual = 0
local oilT_3_actual = 0

local fuel_P_table = {{ -100000, 0.0 },    -- bugs walkaround
                  {  0, 00 }, -- zero pressure
				  {  40, 30 }, --
				  {  50, 40 }, -- 
           	      {  60, 60 }, -- 
				  {  100, 100 },    -- 
          	      {  1000000000, 110 }}    -- bugs walkaround	

local oil_P_table = {{ -100000, 0.0 },    -- bugs walkaround
                  {  0, 00 }, -- zero pressure
				  {  15, 30 }, -- 
           	      {  45, 41 }, -- 
				  {  80, 80 },    -- 
          	      {  1000000000, 110 }}    -- bugs walkaround	

local function emi3()
	
	local fuelP_1 = 0
	local fuelP_2 = 0
	local fuelP_3 = 0
	
	local oilP_1 = 0
	local oilP_2 = 0
	local oilP_3 = 0
	
	local oilT_1 = -50
	local oilT_2 = -50
	local oilT_3 = -50
	
	if power_36_L then 
		fuelP_1 = interpolate(fuel_P_table, get(fuel_p_1))-- * gau_1_on
		oilP_1 = interpolate(oil_P_table, get(oil_p_1)) * 0.1-- * gau_1_on 
	end	
	
	if power_36_R then
		fuelP_2 = interpolate(fuel_P_table, get(fuel_p_2))-- * gau_2_on
		fuelP_3 = interpolate(fuel_P_table, get(fuel_p_3))-- * gau_3_on
		
		oilP_2 = interpolate(oil_P_table, get(oil_p_2)) * 0.1-- * gau_2_on
		oilP_3 = interpolate(oil_P_table, get(oil_p_3)) * 0.1-- * gau_3_on
	end
	
	if power_27_L then --and gau_1_on == 1 then
		oilT_1 = get(oil_t_1)
	end

	if power_27_R then --and gau_2_on == 1 then
		oilT_2 = get(oil_t_2)
	end

	if power_27_R then --and gau_3_on == 1 then
		oilT_3 = get(oil_t_3)
	end	

	-- smooth movements
	fuelP_1_actual = fuelP_1_actual + (fuelP_1 - fuelP_1_actual) * passed * 3
	fuelP_2_actual = fuelP_2_actual + (fuelP_2 - fuelP_2_actual) * passed * 3
	fuelP_3_actual = fuelP_3_actual + (fuelP_3 - fuelP_3_actual) * passed * 3
	
	oilP_1_actual = oilP_1_actual + (oilP_1 - oilP_1_actual) * passed * 3
	oilP_2_actual = oilP_2_actual + (oilP_2 - oilP_2_actual) * passed * 3
	oilP_3_actual = oilP_3_actual + (oilP_3 - oilP_3_actual) * passed * 3
	
	oilT_1_actual = oilT_1_actual + (oilT_1 - oilT_1_actual) * passed * 3
	oilT_2_actual = oilT_2_actual + (oilT_2 - oilT_2_actual) * passed * 3
	oilT_3_actual = oilT_3_actual + (oilT_3 - oilT_3_actual) * passed * 3
	
	set(fuel_press_1, fuelP_1_actual)
	set(fuel_press_2, fuelP_2_actual)
	set(fuel_press_3, fuelP_3_actual)
	
	set(oil_press_1, oilP_1_actual)
	set(oil_press_2, oilP_2_actual)
	set(oil_press_3, oilP_3_actual)
	
	set(oil_temp_1, oilT_1_actual)
	set(oil_temp_2, oilT_2_actual)
	set(oil_temp_3, oilT_3_actual)


end


-- EGT
local egt_1_actual = 0
local egt_2_actual = 0
local egt_3_actual = 0

local EGT_gau_on_L = 0
local EGT_gau_on_R = 0

local function egt_gauges()
	
	-- check power for EGT gauges

	local emerg_sw = get(emerg_inv115) == 1
	
	local power_L = power_27_L and (power_115 or ((power_27_L or power_27_R) and emerg_sw))
	local power_R = power_27_R and (power_115 or ((power_27_L or power_27_R) and emerg_sw))
	
	local egt_1_need = 0
	local egt_2_need = 0
	local egt_3_need = 0
	
	local stall_1 = 0
	if get(comsta0) == 6 then stall_1 = 1 end
	local stall_2 = 0
	if get(comsta1) == 6 then stall_2 = 1 end
	local stall_3 = 0
	if get(comsta2) == 6 then stall_3 = 1 end
	
	local test_button = get(control_ut) == 1
	
	-- [FIX-EGT] On a compressor stall/surge, EGT rises, but not by 2x -- by 30%
	-- (a realistic overshoot). The 800 C cap is a DISPLAY CLAMP, not a manual
	-- limit: it stops the needle flying past 1200 C when X-Plane's own start
	-- EGT overshoots (raw peaks near 1910 C have been measured). Neither manual
	-- has an 800 C figure. The documented limits are 550 C on a start (exactly
	-- 550 C for no more than 4 s, RLE 8.1.2) and, by outside air temperature,
	-- RLE Table 8.1.3 - takeoff 574 C at -60 C to 666 C at +50 C.
	if power_L then
		egt_1_need = math.min(800, get(sim_egt_1) * (1 + stall_1 * 0.3))
		if test_button then egt_1_need = 120 end
		EGT_gau_on_L = 1
	else
		EGT_gau_on_L = 0
	end
	if power_R then
		egt_2_need = math.min(800, get(sim_egt_2) * (1 + stall_2 * 0.3))
		egt_3_need = math.min(800, get(sim_egt_3) * (1 + stall_3 * 0.3))
		if test_button then egt_2_need = 140 end
		if test_button then egt_3_need = 130 end
		EGT_gau_on_R = 1
	else
		EGT_gau_on_R = 0
	end	
	
	-- smooth needle movement
	egt_1_actual = egt_1_actual + (egt_1_need - egt_1_actual) * passed
	egt_2_actual = egt_2_actual + (egt_2_need - egt_2_actual) * passed
	egt_3_actual = egt_3_actual + (egt_3_need - egt_3_actual) * passed
	
	set(egt_1, egt_1_actual)
	set(egt_2, egt_2_actual)
	set(egt_3, egt_3_actual)

end


-- fuel flow meters
local FF_1 = 200
local FF_2 = 200
local FF_3 = 200

local FF_1_act = 200
local FF_2_act = 200
local FF_3_act = 200

local fuel_flow_gau_on = 0

local function fuel_flow()
	
	-- check power for gauges
	local power = power_27_R and power_115 and get(fuel_meter_on) == 1
	
	if power then 
		FF_1 = get(ENGN_FF_1) * 3600 * (1 - get(fuel_flowmeter_1_fail))
		FF_2 = get(ENGN_FF_2) * 3600 * (1 - get(fuel_flowmeter_2_fail))
		FF_3 = get(ENGN_FF_3) * 3600 * (1 - get(fuel_flowmeter_3_fail))
		fuel_flow_gau_on = 1
	else
		fuel_flow_gau_on = 0
	end
	
	-- set limits
	if FF_1 < 200 then FF_1 = 200 end
	if FF_2 < 200 then FF_2 = 200 end
	if FF_3 < 200 then FF_3 = 200 end
	
	-- set smooth
	FF_1_act = FF_1_act + (FF_1 - FF_1_act) * passed * 3
	FF_2_act = FF_2_act + (FF_2 - FF_2_act) * passed * 3
	FF_3_act = FF_3_act + (FF_3 - FF_3_act) * passed * 3
	
	set(fuel_flow_1, FF_1_act)
	set(fuel_flow_2, FF_2_act)
	set(fuel_flow_3, FF_3_act)

end

-- tachometers (physics-based spin-up logic from B2)
-- All state variables packed into table T to stay under SASL 60-upvalue limit

-- read the current N2 from the simulator at initialisation, so the needles do not spike
local _n2_init_1 = get(globalProperty("sim/flightmodel/engine/ENGN_N2_[0]")) or 0
local _n2_init_2 = get(globalProperty("sim/flightmodel/engine/ENGN_N2_[1]")) or 0
local _n2_init_3 = get(globalProperty("sim/flightmodel/engine/ENGN_N2_[2]")) or 0
local _n1_init_1 = get(globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")) or 0
local _n1_init_2 = get(globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")) or 0
local _n1_init_3 = get(globalProperty("sim/flightmodel/engine/ENGN_N1_[2]")) or 0

local T = {
	-- N2 gauge needle state (high-pressure tachometer) - initialised with the current N2
	ang1 = _n2_init_1, ang2 = _n2_init_2, ang3 = _n2_init_3,
	-- N1 gauge needle state (low-pressure tachometer) - initialised with the current N1
	ang1b = _n1_init_1, ang2b = _n1_init_2, ang3b = _n1_init_3,
	-- last N2 values - initialised with the current N2 so that delta=0 on the first frame
	rpm1_last = _n2_init_1, rpm2_last = _n2_init_2, rpm3_last = _n2_init_3,
	-- IGV (inlet guide vanes) state
	rna1 = 0, rna2 = 0, rna3 = 0,
	-- turbine power coefficients
	cturb1 = 1, cturb2 = 1, cturb3 = 1,
	-- N1 physics integrators - initialised with the current N1
	N2need1 = _n1_init_1, N2need2 = _n1_init_2, N2need3 = _n1_init_3,
	N2need1_old = _n1_init_1, N2need2_old = _n1_init_2, N2need3_old = _n1_init_3,
	N2need1_prev = _n1_init_1, N2need2_prev = _n1_init_2, N2need3_prev = _n1_init_3,
	N1need1 = _n2_init_1, N1need2 = _n2_init_2, N1need3 = _n2_init_3,
	-- N2 windmilling runout - initialised with the current N2
	n2run1 = _n2_init_1, n2run2 = _n2_init_2, n2run3 = _n2_init_3,
	-- needle start-move flags - if the engine is already running, allow movement
	nmove1 = bool2int(_n1_init_1 > 20),
	nmove2 = bool2int(_n1_init_2 > 20),
	nmove3 = bool2int(_n1_init_3 > 20),
	-- dynamic pressure and time
	q = 0, tme = 0, tas_LP = 0,
	-- fan animation angles
	fan1 = math.random()*360, fan3 = math.random()*360,
	-- startup delay counter - if the engines are already running, skip the delay
	start_timer = bool2int(_n2_init_1 > 10 or _n2_init_2 > 10 or _n2_init_3 > 10) * 60,
	-- physics constants - calibrated for the D-30KU-154 (Tu-154M)
	-- D-30KU-154: a two-spool turbofan, thrust 11000 kgf
	-- HP (N2): the starter cuts out at 45%, the anti-surge valves close at 79%
	-- IGV: opens 74.5-92.5% N2, the HP rotor is heavier than the NK-8's
	M_rot   = 0.55,    -- LP rotor mass (the D-30 is heavier than the NK-8)
	c_aero  = 0.0032,  -- LP aerodynamic drag
	c_q_base= 0.00012, -- windmilling coefficient (the big fan)
	c_f     = 0.00018, -- LP friction coefficient
	T_tas   = 10,
	-- HP (N2): the D-30 rotor is heavier, the runout is longer than the NK-8's
	n2_c_aero = 0.00025, -- less drag (a high-rpm rotor)
	-- [TUNED] n2_c_f lowered 0.008 -> 0.005 for compatibility with the 0.20 starter in Plane Maker
	-- (at 0.008 the 0.20 starter could not overcome the initial friction and the rotor stood still)
	n2_c_f    = 0.005,   -- less friction (better bearings)
	n2_c_q    = 0.000018,
	-- RLE 8.1.1 row (11) / 8.1.2 p.8.1.8: time from START to idle = 35 s min,
	-- 80 s max on the ground (120 s in flight). ~40 s target below sits inside it.
	-- n2_M_rot: 0.18 -> 0.32 -> 0.42 -> 0.55 -> 1.0 (target time ~40 s, was 26 s)
	n2_M_rot  = 1.0,    -- D-30 HP rotor mass (calibrated for ~40 s to idle)
	rpm_knd   = 6200/0.97, -- LP rpm at 100% N1 (the D-30 is slightly higher than the NK-8)
	-- lookup tables - calibrated for the D-30KU-154
	-- c_q_tbl: windmilling - the big D-30 fan, slightly less response
	c_q_tbl  = {{-10000,0.25},{80,0.25},{360,1},{20000,1}},
	-- n1s_tbl: N1 physics lockout. Documented figures (RLE 8.1.2, p.8.1.8/8.1.8.1):
	-- the air starter is cut by the NR-30KU governor at N2 = 43 (+1/-2) %, and
	-- 55 % is the self-sustaining floor (below it the RLE calls for shutdown).
	-- The 45 below is the sim-side lockout knee, not the documented cutout.
	n1s_tbl  = {{-100000,0},{0,0},{45,0},{55,1},{1000000000,1}},
	-- e2n1_tbl: tail engine correction (the S-duct of the D-30KU-154)
	-- the tail engine has a longer duct, N1 is 0.6% lower at idle
	e2n1_tbl = {{-100000,0},{55,0.6},{80,0.6},{88,1.1},{94,0.8},{1000,0.6}},
	-- kpp3_tbl: table for the KPP failure on engine 3
	kpp3_tbl = {{-100000,0},{0,0},{17,17},{62,55},{69.5,74.4},{75,80},{85,85},{100,100},{1000000000,100}},
	-- [SCALE] Scaling the sim N2 -> the gauge reading (%)
	-- Calibrated: sim 60 -> 62% (idle), sim 90 -> 96% (takeoff)
	-- Landing configuration sim ~74 -> ~80%
	-- SOURCE for every figure below: Tu-154M RLE (flight manual), Book 2,
	-- Section 8.1 "Engine and its systems", in this repository at
	--   _extras/docs/manuals/real_docs/RUS RLE/Papka_2/Tu-154M_RLE_r8.pdf
	-- Table 8.1.1 = ground regimes, Table 8.1.2 = H=11 km M=0.8,
	-- Table 8.1.3 = max EGT vs OAT, and 8.1.1's own limits table = the redlines.
	--
	-- Table 8.1.1 (ground, Pn=760 mm Hg, tn=15 C, H=0, M=0):
	--   Idle:                 HP 59.5-61.5%  LP 30%
	--   0.42 nominal (approach idle): HP 81.0-83.5%  LP 57.5-60.5%
	--   0.6 nominal:          HP 85.5-88.0%  LP 67.0-70.0%
	--   0.7 nominal:          HP 87.5-90.0%  LP 71.0-74.0%
	--   0.9 nominal:          HP 91.0-92.8%  LP 78.5-81.5%
	--   Nominal:              HP 93.0-95.0%  LP 82.0-85.0%
	--   Takeoff:              HP 94.5-96.0%  LP 85.5-88.0%
	-- Table 8.1.2 (H=11 km, M=0.8): idle HP 78.0%, LP 63.0%, EGT 365 C
	--
	-- NOTE ON SOURCES: the engine maker's own manual (D-30KU-154 RE 59-00-800RE,
	-- 072.00.00 sect.5.9.1.1) runs 0.5 pt lower on two floors -- nominal HP
	-- 92.5-94.5 and takeoff HP 94.0-96.0. The RLE figures above are the ones a
	-- crew is cleared to fly to, so the scales follow the RLE deliberately.
	-- Do not "correct" them to the engine manual; the two documents disagree.
	--
	-- Measured in the simulator: sim~67 -> real idle ~60.5%  =>  k ~ 60.5/67 = 0.903
	-- n2_max / n1_max are the RLE 8.1.1 limits-table redlines, rows (2) and (1).
	n2_max = 98.5, n1_max = 95,
	-- [RECALIBRATED from a measured throttle sweep at UUEE]
	-- The old table's x-axis assumed a raw N2 range of roughly 62...105. X-Plane
	-- actually produces 62...99 for this engine, so the top half of the old
	-- table was never reached: the gauge read ~5 pts high at idle and ~2 pts low
	-- at takeoff, at both ends of the range a crew actually uses.
	--
	-- Each row below is anchored on THRUST, not on a guess, because thrust is
	-- the physical quantity both manuals tabulate per regime. Measured
	-- SL-equivalent thrust gives the raw N2 for each documented regime, and that
	-- raw value is mapped to the documented displayed band midpoint:
	--
	--   regime      documented thrust    raw N2   -> displayed N2 (band mid)
	--   idle              903 kgf         62.23      60.50   (59.5...61.5)
	--   0.42 nominal     4000 kgf         81.78      82.25   (81.0...83.5)
	--   0.6 nominal      5700 kgf         87.51      86.75   (85.5...88.0)
	--   0.7 nominal      6650 kgf         89.89      88.75   (87.5...90.0)
	--   0.9 nominal      8550 kgf         94.55      91.90   (91.0...92.8)
	--   nominal          9500 kgf         96.73      94.00   (93.0...95.0)
	--   takeoff         10500 kgf         99.04      95.25   (94.5...96.0)
	--
	-- This is what n2_scale is for: it absorbs the difference between X-Plane's
	-- thrust/N2 relationship and the real engine's, so that the gauge reads the
	-- documented N2 at the documented thrust. Re-derive it from a fresh sweep if
	-- the throttle curve or acf_tmax change.
	n2_scale = {
		{  0,     0    },
		{ 20,    18    },  -- start region, unmeasured, left as it was
		{ 62.23, 60.5  },  -- ground idle
		{ 81.78, 82.25 },  -- 0.42 nominal (PMG)
		{ 87.51, 86.75 },  -- 0.6 nominal
		{ 89.89, 88.75 },  -- 0.7 nominal
		{ 94.55, 91.9  },  -- 0.9 nominal
		{ 96.73, 94.0  },  -- nominal
		{ 99.30, 95.25 },  -- takeoff. 99.04 was extrapolated from the sweep; the
		                   -- verification run measured the detent at raw 99.3,
		                   -- so the anchor is the measured value. At 99.04 the
		                   -- gauge sat at the top edge of the 94.5...96.0 band
		                   -- and the per-engine +/-0.5 scatter could show 96.2.
		{101,    98.5  },  -- to the RLE 8.1.1 redline; n2_max clamps here anyway
		{200,    98.5  },
	},
	-- N1 (LP compressor) scale per the Flight Manual Table 8.1.1
	-- [FIX] the idle point corrected from {33, 17.5} to {30, 30} - the Tu-154M Flight Manual says exactly 30%
	-- the previous value understated N1 at idle by almost half and made the scale dip
	n1_scale = {
		{  0,    0   },
		{ 20,   18   },
		{ 30,   30   },  -- ground idle (Flight Manual exactly 30%)
		{ 57,   57.5 },  -- 0.42 nominal, lower (Flight Manual 57.5-60.5%)
		{ 66,   67   },  -- 0.6 nominal, lower
		{ 73,   74   },  -- 0.7 nominal, upper
		{ 81,   82   },  -- nominal, lower
		{ 87,   88   },  -- takeoff, upper (Flight Manual 85.5-88.0%)
		{ 95,   95   },  -- LP compressor maximum per the Flight Manual (95%)
		{200,   95   },
	},
	-- [REALISM] needle inertia at shutdown
	ang1_slow = _n2_init_1, ang2_slow = _n2_init_2, ang3_slow = _n2_init_3,
	ang1b_slow = _n1_init_1, ang2b_slow = _n1_init_2, ang3b_slow = _n1_init_3,
	-- [REALISM] reading scatter - the D-30KU-154 allows +/-1% N2, +/-1% N1 per the maintenance manual
	bias_n2_1 = (math.random()-0.5)*1.0,
	bias_n2_2 = (math.random()-0.5)*1.0,
	bias_n2_3 = (math.random()-0.5)*1.0,
	bias_n1_1 = (math.random()-0.5)*1.0,
	bias_n1_2 = (math.random()-0.5)*1.0,
	bias_n1_3 = (math.random()-0.5)*1.0,
	-- [REALISM] N2 hang during the start
	-- D-30KU-154: the hang is more common in the 30-38% range (a heavy rotor)
	hang_timer1 = 0, hang_timer2 = 0, hang_timer3 = 0,
	hang_val1 = 0,   hang_val2 = 0,   hang_val3 = 0,
	hang_active1 = false, hang_active2 = false, hang_active3 = false,
	-- [REALISM] N1 hysteresis on a rapid throttle reduction
	n1_lag1 = _n1_init_1, n1_lag2 = _n1_init_2, n1_lag3 = _n1_init_3,
	-- [LP-LAG] displayed N1, filtered so the LP needle trails the HP needle
	n1_disp1 = _n1_init_1, n1_disp2 = _n1_init_2, n1_disp3 = _n1_init_3,
	-- [NEW-1] Acceleration: N2 leads N1 on a rapid throttle advance
	-- n2_advance: the current N2 "lead" over N1 (decays over time)
	n2_adv1 = 0, n2_adv2 = 0, n2_adv3 = 0,
	-- [NEW-4] LP/HP inertia difference: track the N2 rate of change
	n2_rate1 = 0, n2_rate2 = 0, n2_rate3 = 0,
	-- [NEW-6] Valve surge: needle flutter when crossing the 79% N2 threshold
	-- surge_flutter: the flutter magnitude (decays)
	surge_flutter1 = 0, surge_flutter2 = 0, surge_flutter3 = 0,
	-- track the crossing of the 79% threshold from below
	surge_crossed1 = false, surge_crossed2 = false, surge_crossed3 = false,
	-- [NEW bleed/crossbleed/false_start]
	bleed_drop1 = 0, bleed_drop2 = 0, bleed_drop3 = 0,
	crossbleed_drop1 = 0, crossbleed_drop2 = 0, crossbleed_drop3 = 0,
	false_start1 = false, false_start2 = false, false_start3 = false,
	false_start_n2_1 = 0, false_start_n2_2 = 0, false_start_n2_3 = 0,
	false_start_timer1 = 0, false_start_timer2 = 0, false_start_timer3 = 0,
	flame1_prev = 0, flame2_prev = 0, flame3_prev = 0,
	-- cache of the N2 gauge reading, for limiting N1
	disp_n2_1 = 0, disp_n2_2 = 0, disp_n2_3 = 0,
	-- [STARTUP-SYNC v2] weight of the synchronous mode (1=synchronous, 0=physics)
	-- if the engine is already running at idle, start from 0 (physics), otherwise from 1 (sync)
	n1_sync_w1 = bool2int(_n2_init_1 < 60),
	n1_sync_w2 = bool2int(_n2_init_2 < 60),
	n1_sync_w3 = bool2int(_n2_init_3 < 60),
	-- [N2-JUMP v11] phases of the characteristic "spike" of the large needle (HP) at start:
	-- 0 = waiting (the engine is not started, or the flame has not been introduced yet)
	-- 1 = spike up to 12%
	-- 2 = a slight rollback (the needle settles)
	-- 3 = smooth rise to idle via the starter (normal mode)
	n2_jump_phase_1 = bool2int(_n2_init_1 >= 60) * 3,  -- if already at idle - straight to phase 3
	n2_jump_phase_2 = bool2int(_n2_init_2 >= 60) * 3,
	n2_jump_phase_3 = bool2int(_n2_init_3 >= 60) * 3,
	n2_jump_val_1 = 0, n2_jump_val_2 = 0, n2_jump_val_3 = 0,
}

-- All tachometer datarefs in one table (counts as 1 upvalue)
local Tdr = {
	burn1  = globalProperty("sim/flightmodel2/engines/engine_is_burning_fuel[0]"),
	burn2  = globalProperty("sim/flightmodel2/engines/engine_is_burning_fuel[1]"),
	burn3  = globalProperty("sim/flightmodel2/engines/engine_is_burning_fuel[2]"),
	rho    = globalPropertyf("sim/weather/rho"),
	tas    = globalPropertyf("sim/flightmodel2/position/true_airspeed"),
	tempSL = globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc"),
	wdir   = globalPropertyf("sim/weather/aircraft/wind_now_direction_degt"),
	adir   = globalPropertyf("sim/flightmodel/position/mag_psi"),
	revL   = globalProperty("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[0]"),
	revR   = globalProperty("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[2]"),
	-- custom datarefs (may be nil if not present in this M variant)
	covers = globalPropertyi("tu-154/anim/engine_caps"),
	apd1   = globalPropertyf("tu-154/start/apd_working_1"),
	apd2   = globalPropertyf("tu-154/start/apd_working_2"),
	apd3   = globalPropertyf("tu-154/start/apd_working_3"),
	igv1   = globalPropertyi("tu-154/engines/rna_1"),
	igv2   = globalPropertyi("tu-154/engines/rna_2"),
	igv3   = globalPropertyi("tu-154/engines/rna_3"),
	idle   = globalPropertyf("tu-154/engines/flight_idle"),
	disa   = globalPropertyf("tu-154/engines/d_isa_temp"),
	kpp3f  = globalPropertyf("tu-154/failures/kpp_3_fail"),
	rot1   = globalPropertyf("tu-154/engines/nk_rotation_1"),
	rot3   = globalPropertyf("tu-154/engines/nk_rotation_3"),
	knd1   = globalPropertyf("tu-154/engines/knd_1"),
	knd3   = globalPropertyf("tu-154/engines/knd_3"),
	-- hot start - the datarefs were moved out of the function so they are not created every frame
	hot1   = globalPropertyf("tu-154/engine/hotstart_1"),
	hot2   = globalPropertyf("tu-154/engine/hotstart_2"),
	hot3   = globalPropertyf("tu-154/engine/hotstart_3"),
	-- bleed air: the correct path is sim/cockpit/pressure/bleed_air_mode
	bleed_air = globalPropertyf("sim/cockpit/pressure/bleed_air_mode"),
	-- Engine anti-ice: the enigne->engine typo was fixed (both paths work in XP12)
	anti_ice1 = globalProperty("sim/cockpit/switches/anti_ice_inlet_heat_per_engine[0]"),
	anti_ice2 = globalProperty("sim/cockpit/switches/anti_ice_inlet_heat_per_engine[1]"),
	anti_ice3 = globalProperty("sim/cockpit/switches/anti_ice_inlet_heat_per_engine[2]"),
	-- crossbleed: the correct XP12 dataref
	crossbleed = globalPropertyf("sim/cockpit2/fuel/fuel_crossfeed_selector"),
}

-- safe_get: returns value or fallback if dataref is nil/unavailable
local function safe_get(dr, fallback)
	if dr == nil then return fallback end
	local ok, val = pcall(get, dr)
	if ok and val ~= nil then return val end
	return fallback
end

-- safe_set: silently skips set() if dataref is nil/unavailable
local function safe_set(dr, val)
	if dr == nil then return end
	pcall(set, dr, val)
end

local function n1_from_n2(rpm, d_isa, altitude, tas)
	local knd = 1.35432317320705628561e+01 + 1.05818030992323813821e-01*d_isa - 2.41159426273638954896e-01*rpm - 2.88293089248683933462e-03*d_isa*rpm + 1.17362636037093952257e-02*math.pow(rpm, 2)
	knd = knd + math.max(-2.69166791400897068343e+02 + 2.22049699099214983278e+01*altitude + 1.46945301863934254527e+01*rpm - 9.85089687252083234803e-01*altitude*rpm - 2.96261417738032106772e-01*math.pow(rpm, 2) + 1.41929325403952685813e-02*altitude*math.pow(rpm, 2) + 2.61617340318329736140e-03*math.pow(rpm, 3) - 6.56641350639726608220e-05*altitude*math.pow(rpm, 3) - 8.54680990421439715666e-06*math.pow(rpm, 4), 0) * tas / 850
	return knd
end

local function tachometers()

	local alt_baro = get(msl_alt)
	if alt_baro > 12000 then alt_baro = 12000 end

if MASTER then
	if T.start_timer < 60 then T.start_timer = T.start_timer + passed end

	local flame1 = get(Tdr.burn1)
	local flame2 = get(Tdr.burn2)
	local flame3 = get(Tdr.burn3)

	local rpm_1 = get(eng1_N2)
	local rpm_2 = get(eng2_N2)
	local rpm_3 = get(eng3_N2)

	local idle_rpm = safe_get(Tdr.idle, 68)
	if idle_rpm < 1 then idle_rpm = 68 end
	local dens  = get(Tdr.rho)
	local temp  = get(Tdr.tempSL)
	-- [D-30KU-154] The IGV is controlled by the corrected HP rpm via the DPO-30K
	-- Opens at N2=74.5%, fully open at N2=92.5% - independent of temperature
	local rna_thres = 74.5  -- IGV opening threshold by N2 (D-30KU-154, maintenance manual)
	T.tme    = T.tme + passed
	T.tas_LP = passed / (T.T_tas + passed) * get(Tdr.tas) * 3.6 + T.tas_LP * T.T_tas / (T.T_tas + passed)
	local d_isa = safe_get(Tdr.disa, 0)
	T.q = dens * math.pow((T.tas_LP / 3.6), 2) / 2

	-- [1] Dependence of the spool-up rate on temperature
	-- In hot weather the spool-up is slower, in the cold it is faster
	-- Coefficient: 1.0 at ISA+0, 0.82 at +40 C, 1.18 at -40 C
	local temp_spd_coeff = 1.0 - (temp - 15) * 0.0045
	temp_spd_coeff = math.max(0.75, math.min(1.25, temp_spd_coeff))

	-- [NEW] HP idle temperature correction per the Tu-154M Flight Manual fig. 8.1.1
	-- At +60 C idle is ~57%, at +15 C (ISA) ~60.5%, at -60 C ~71%
	-- Linear approximation: dN2_idle = -0.117 * (t - 15)
	-- The correction is applied only in the idle band (HP 55-72%) and fades out smoothly above it
	-- so as not to break the readings at the takeoff setting (that has its own graph 8.1.2)
	local idle_n2_corr = -0.117 * (temp - 15)
	-- weight: 1.0 at idle, decaying smoothly to 0 above N2 > 75%
	local function temp_corr_weight(n2)
		if n2 < 55 then return 0
		elseif n2 < 65 then return (n2 - 55) / 10  -- smooth build-up 55->65%
		elseif n2 <= 72 then return 1.0             -- the full correction in the idle band
		elseif n2 < 80 then return (80 - n2) / 8    -- smooth fade-out 72->80%
		else return 0 end
	end

	-- N2 windmilling / runout
	-- [TUNED v3] at low rpm (<45%) the friction is 4x stronger - the needle falls to 0 faster
	-- At high rpm the friction is unchanged, the runout from nominal/takeoff stays long
	local function runout_friction(n2)
		if n2 >= 45 then return T.n2_c_f end
		return T.n2_c_f * (1 + (45 - n2) / 45 * 3)  -- x1 at 45% -> x4 at 0%
	end
	if flame1 > 0 or safe_get(Tdr.apd1, 0) > 0 then
		T.n2run1 = rpm_1
	else
		T.n2run1 = math.max(T.n2run1 + (-T.n2_c_aero*dens*math.pow(T.n2run1,2) + T.n2_c_q*T.q - runout_friction(T.n2run1)) / T.n2_M_rot * passed, 0)
		rpm_1 = T.n2run1;  set(eng1_N2, T.n2run1)
	end
	if flame2 > 0 or safe_get(Tdr.apd2, 0) > 0 then
		T.n2run2 = rpm_2
	else
		T.n2run2 = math.max(T.n2run2 + (-T.n2_c_aero*dens*math.pow(T.n2run2,2) + T.n2_c_q*T.q - runout_friction(T.n2run2)) / T.n2_M_rot * passed, 0)
		rpm_2 = T.n2run2;  set(eng2_N2, T.n2run2)
	end
	if flame3 > 0 or safe_get(Tdr.apd3, 0) > 0 then
		T.n2run3 = rpm_3
	else
		T.n2run3 = math.max(T.n2run3 + (-T.n2_c_aero*dens*math.pow(T.n2run3,2) + T.n2_c_q*T.q - runout_friction(T.n2run3)) / T.n2_M_rot * passed, 0)
		rpm_3 = T.n2run3;  set(eng3_N2, T.n2run3)
	end

	-- [2] Hot start - if the engine was shut down recently, N2 spools up more slowly
	-- hot_factor: 1.0 = cold, 0.6 = hot (residual heat slows the spool-up)
	local hot1 = math.max(0.6, 1.0 - safe_get(Tdr.hot1, 0) * 0.4)
	local hot2 = math.max(0.6, 1.0 - safe_get(Tdr.hot2, 0) * 0.4)
	local hot3 = math.max(0.6, 1.0 - safe_get(Tdr.hot3, 0) * 0.4)

	-- [NEW-1b] Bleed air - N2 droop from bleed air
	local bleed_on     = safe_get(Tdr.bleed_air, 0) > 0
	local anti_ice1_on = safe_get(Tdr.anti_ice1, 0) > 0
	local anti_ice2_on = safe_get(Tdr.anti_ice2, 0) > 0
	local anti_ice3_on = safe_get(Tdr.anti_ice3, 0) > 0
	local bleed_load1 = bool2int(flame1>0) * (bool2int(bleed_on)*0.6 + bool2int(anti_ice1_on)*0.5)
	local bleed_load2 = bool2int(flame2>0) * (bool2int(bleed_on)*0.6 + bool2int(anti_ice2_on)*0.5)
	local bleed_load3 = bool2int(flame3>0) * (bool2int(bleed_on)*0.6 + bool2int(anti_ice3_on)*0.5)
	T.bleed_drop1 = T.bleed_drop1 + (bleed_load1 - T.bleed_drop1) * passed * 0.5
	T.bleed_drop2 = T.bleed_drop2 + (bleed_load2 - T.bleed_drop2) * passed * 0.5
	T.bleed_drop3 = T.bleed_drop3 + (bleed_load3 - T.bleed_drop3) * passed * 0.5

	-- [NEW-4b] Crossbleed - droop of the donor's N2 with the valve open
	local xbleed = safe_get(Tdr.crossbleed, 0) > 0
	local xbleed_load1 = bool2int(xbleed and flame1>0 and
		(flame2==0 and safe_get(Tdr.apd2,0)>0 or flame3==0 and safe_get(Tdr.apd3,0)>0)) * 0.8
	local xbleed_load2 = bool2int(xbleed and flame2>0 and flame3==0 and safe_get(Tdr.apd3,0)>0) * 0.8
	T.crossbleed_drop1 = T.crossbleed_drop1 + (xbleed_load1 - T.crossbleed_drop1) * passed * 0.8
	T.crossbleed_drop2 = T.crossbleed_drop2 + (xbleed_load2 - T.crossbleed_drop2) * passed * 0.8
	if flame1>0 then rpm_1 = math.max(0, rpm_1 - T.bleed_drop1 - T.crossbleed_drop1) end
	if flame2>0 then rpm_2 = math.max(0, rpm_2 - T.bleed_drop2 - T.crossbleed_drop2) end
	if flame3>0 then rpm_3 = math.max(0, rpm_3 - T.bleed_drop3) end

	-- [NEW-7] False start - a 12% chance at ignition
	-- N2 rises for a few seconds then falls (the fuel did not ignite)
	for i = 1, 3 do
		local fl    = i==1 and flame1    or (i==2 and flame2    or flame3)
		local fl_pr = i==1 and T.flame1_prev or (i==2 and T.flame2_prev or T.flame3_prev)
		local fs    = i==1 and T.false_start1 or (i==2 and T.false_start2 or T.false_start3)
		local fs_n2 = i==1 and T.false_start_n2_1 or (i==2 and T.false_start_n2_2 or T.false_start_n2_3)
		local fs_t  = i==1 and T.false_start_timer1 or (i==2 and T.false_start_timer2 or T.false_start_timer3)
		local rpm_i = i==1 and rpm_1 or (i==2 and rpm_2 or rpm_3)
		if fl > 0 and fl_pr == 0 and not fs then
			if math.random() < 0.12 then
				fs = true; fs_n2 = rpm_i; fs_t = 4 + math.random() * 4
			end
		end
		if fs then
			fs_t = fs_t - passed
			if fs_t <= 0 or fl == 0 then
				fs = false
			else
				local fake_n2 = fs_n2 + (1 - math.exp(-fs_t * 0.3)) * 8
				if i==1 then rpm_1 = math.min(rpm_1, fake_n2)
				elseif i==2 then rpm_2 = math.min(rpm_2, fake_n2)
				else rpm_3 = math.min(rpm_3, fake_n2) end
			end
		end
		if i==1 then T.false_start1=fs; T.false_start_n2_1=fs_n2; T.false_start_timer1=fs_t; T.flame1_prev=fl
		elseif i==2 then T.false_start2=fs; T.false_start_n2_2=fs_n2; T.false_start_timer2=fs_t; T.flame2_prev=fl
		else T.false_start3=fs; T.false_start_n2_3=fs_n2; T.false_start_timer3=fs_t; T.flame3_prev=fl end
	end

	-- [3] N2 hang during the start
	for i = 1, 3 do
		local rpm_i   = i==1 and rpm_1   or (i==2 and rpm_2   or rpm_3)
		local flame_i = i==1 and flame1  or (i==2 and flame2  or flame3)
		local hang_active = i==1 and T.hang_active1 or (i==2 and T.hang_active2 or T.hang_active3)
		local hang_val    = i==1 and T.hang_val1    or (i==2 and T.hang_val2    or T.hang_val3)
		local hang_timer  = i==1 and T.hang_timer1  or (i==2 and T.hang_timer2  or T.hang_timer3)

		-- [3] N2 hang during the start - D-30KU-154
		-- A heavy HP rotor, a hang at 30-36%, ~10% chance (rarer than on the NK-8)
		-- The starter cuts out at 45%, after which the hang no longer occurs
		if flame_i > 0 and not hang_active and rpm_i > 28 and rpm_i < 38 then
			-- [DT] a per-SECOND hazard rate, not a per-frame one: this used to
			-- roll once per frame, so the hang was about twice as likely at
			-- 120 fps as at 60, and it could fire on the pause screen.
			-- 0.0002 per frame at ~50 fps is 0.01 per second.
			if math.random() < 0.01 * passed then
				hang_active = true
				hang_val    = 30 + math.random() * 6  -- a hang at 30-36%
				hang_timer  = 4 + math.random() * 6   -- for 4-10 seconds
			end
		end
		if hang_active then
			hang_timer = hang_timer - passed
			if hang_timer <= 0 or flame_i == 0 then
				hang_active = false
			end
		end
		if i==1 then T.hang_active1=hang_active; T.hang_val1=hang_val; T.hang_timer1=hang_timer
		elseif i==2 then T.hang_active2=hang_active; T.hang_val2=hang_val; T.hang_timer2=hang_timer
		else T.hang_active3=hang_active; T.hang_val3=hang_val; T.hang_timer3=hang_timer end
	end
	-- apply the hang to N2
	if T.hang_active1 and rpm_1 < T.hang_val1 + 2 then rpm_1 = math.min(rpm_1, T.hang_val1) end
	if T.hang_active2 and rpm_2 < T.hang_val2 + 2 then rpm_2 = math.min(rpm_2, T.hang_val2) end
	if T.hang_active3 and rpm_3 < T.hang_val3 + 2 then rpm_3 = math.min(rpm_3, T.hang_val3) end

	-- helper functions for the needle rates (with temperature correction)
	-- D-30KU-154: ground idle ~62% N2, flight idle ~72% - a slow spool-up to 72%
	-- [TUNED v6] the 20-60% band rises slowly up to idle (user request)
	-- v2: 0.7→1.5  | v3: 0.5→1.0  | v4: 0.35→0.7  | v5: 0.25→0.5  | v6: 0.18→0.36
	-- [TUNED v7] Above 72% - which is the whole normal operating range - this used
	-- to return 7 (tau ~ 0.14 s), so the needle was effectively transparent and just
	-- displayed the raw sim spool. It now carries inertia of its own: 2.5 accelerating
	-- (tau ~ 0.4 s) and 4.0 decelerating, since spool-down is the quicker direction.
	-- Below 72% the start-band behaviour is unchanged.
	local function n2_spd(need, delta)
		if need <= 20 then return 7 end
		if delta <= 0 then return need >= 72 and 4.0 or 7 end
		if need >= 72 then return 2.5 end
		if need <= 60 then
			-- the spool-up band after light-up: a slow, realistic rise
			return (0.18 + (need - 20) / 40 * 0.18) * temp_spd_coeff
		else
			-- the band up to idle and beyond: the acceleration returns to normal
			return (0.36 + (need - 60) / 12 * 6.64) * temp_spd_coeff
		end
	end
	-- As n2_spd. NOTE: this only feeds T.ang*b -> disp_n1_*, which nothing reads any
	-- more (the displayed N1 comes from calc_n1_from_n2 + the LP-LAG filter below).
	-- Kept in step with n2_spd so the chain is correct if it is ever reconnected.
	local function n1_spd(need, delta)
		if need <= 20 then return 14 end
		if delta <= 0 then return need >= 72 and 2.0 or 14 end
		if need >= 72 then return 1.2 end
		return (3 + (need - 20) / 52 * 11) * temp_spd_coeff
	end

	-- [4] Needle inertia at shutdown - the smoothed N2 slows the needle at the start of the decay
	-- While N2 is decreasing the needle follows the smoothed (slow) value
	T.ang1_slow  = T.ang1_slow  + (rpm_1 - T.ang1_slow)  * passed * (rpm_1 > T.ang1_slow  and 8 or 1.5)
	T.ang2_slow  = T.ang2_slow  + (rpm_2 - T.ang2_slow)  * passed * (rpm_2 > T.ang2_slow  and 8 or 1.5)
	T.ang3_slow  = T.ang3_slow  + (rpm_3 - T.ang3_slow)  * passed * (rpm_3 > T.ang3_slow  and 8 or 1.5)

	-- N2 gauge needles
	local target1 = rpm_1 < T.rpm1_last and T.ang1_slow or rpm_1
	local target2 = rpm_2 < T.rpm2_last and T.ang2_slow or rpm_2
	local target3 = rpm_3 < T.rpm3_last and T.ang3_slow or rpm_3

	T.N1need1 = target1
	if ((rpm_1 - T.rpm1_last) > 0 and T.N1need1 < 3.5) or T.N1need1 < 0.3 then
		T.ang1 = T.ang1 - T.ang1 * passed
	elseif (rpm_1 - T.rpm1_last) > 0 and T.N1need1 >= 3.5 and T.N1need1 < 5 then
		T.ang1 = T.ang1 + ((4*math.exp(-(T.N1need1-3.5)*5)*math.sin(10*(T.N1need1-3.5)) + T.N1need1) - T.ang1) * passed * 5
	else
		T.ang1 = T.ang1 + (T.N1need1 + (-0.145*math.pow(T.N1need1,2)+2.425*T.N1need1-8.313)*0.2*math.sin(20*T.tme)*bool2int(T.N1need1>5 and T.N1need1<12) - T.ang1) * passed * n2_spd(T.N1need1, rpm_1-T.rpm1_last) * hot1

	end
	-- [5] Reading scatter + [7] jitter at idle
	-- idle_jitter reduced: a real D-30KU-154 at idle wanders no more than +/-0.5% per the maintenance manual
	-- [NEW-1+6] add the acceleration lead and the valve flutter to the N2 reading
	local surge1_osc = T.surge_flutter1 * math.sin(T.tme * 28) * 0.5
	local idle_jitter1 = bool2int(flame1>0 and math.abs(rpm_1 - idle_rpm) < 3) * noise("idle1", passed) * 0.15
	-- [STARTER-FLUTTER] "Live" needle movement effect during the starter spool-up (0-20% N2)
	-- [TUNED v3] the amplitude reduced by a further ~1.7x at the user's request
	local startup_flutter1 = 0
	if T.disp_n2_1 > 0.5 and T.disp_n2_1 < 20 and (flame1 > 0 or safe_get(Tdr.apd1, 0) > 0) then
		local amp = math.sin(T.disp_n2_1 / 20 * math.pi) * 0.2  -- was 0.35
		startup_flutter1 = math.sin(T.tme * 35) * amp * 0.3
			+ math.sin(T.tme * 12 + 0.5) * amp * 0.2
			+ noise("flut1", passed) * amp * 0.3
	end
	-- [SHUTDOWN-JITTER] N2 twitching effect during the runout (engine shutdown) 0-20%
	-- [TUNED v3] the amplitude reduced by a further ~1.7x
	local shutdown_jitter1 = 0
	if flame1 == 0 and T.disp_n2_1 > 0.5 and T.disp_n2_1 < 20 then
		local amp = math.sin(T.disp_n2_1 / 20 * math.pi) * 0.18  -- was 0.3
		shutdown_jitter1 = noise("shut1", passed) * amp * 0.7
			+ math.sin(T.tme * 18) * amp * 0.2
	end
	local disp_n2_1 = math.min(T.n2_max, interpolate(T.n2_scale, T.ang1 + T.n2_adv1 + surge1_osc))
	disp_n2_1 = disp_n2_1 + idle_n2_corr * temp_corr_weight(disp_n2_1)
	T.disp_n2_1 = disp_n2_1
	-- [N2-JUMP v11] The characteristic "spike" of the large needle (HP) at start:
	-- When start is pressed the starter gives a sharp impulse, the needle jumps to ~12%,
	-- then it catches up with the physics smoothly and goes to idle.
	-- [v14] a delay was added - the spike only fires after 3% rpm has been reached
	-- [v18] the mechanics were reworked: val = the target needle value, guaranteed
	--       exceeds the n2_phys physics (so that the spike is VISIBLE regardless of rate)
	local function n2_with_jump(n2_phys, phase, val, is_starting, dt)
		if not is_starting then
			return n2_phys, 0, 0  -- idle mode, the jump has been reset
		end
		-- PHASE 0: wait until the X-Plane physics reaches 3%
		if phase == 0 then
			if n2_phys >= 3 then
				phase = 1
				val = n2_phys  -- start the spike from the current physics point
			else
				return n2_phys, phase, n2_phys
			end
		end
		-- PHASE 1: spike to 12% - a smooth needle rise above the X-Plane physics
		-- [v18] val rises at 6x the rate (~1.5 s to 12%) INDEPENDENTLY of the physics
		-- The needle always shows max(val, n2_phys) - the spike is guaranteed to be visible
		if phase == 1 then
			val = val + (12 - val) * dt * 6  -- a smooth spike over ~1.5 s
			if val >= 11 then phase = 2 end
			return math.max(val, n2_phys), phase, val
		end
		-- PHASE 2: rollback down to 5%
		if phase == 2 then
			val = val + (5 - val) * dt * 4
			if val <= 5.5 then phase = 3 end
			return math.max(val, n2_phys), phase, val
		end
		-- PHASE 3: show the X-Plane physics (the starter accelerates it smoothly to idle)
		val = val + (n2_phys - val) * dt * 2
		return math.max(val, n2_phys), phase, val
	end

	-- [v16] The spike condition was tightened: it activates ONLY on a cold start
	-- - the engine is still below 5% (definitely cold)
	-- - the starter or the fuel supply is running
	-- - the phase has not reached 3 (the spike has not run in this cycle yet)
	-- Once the needle has reached idle or the engine has stopped, the state is fully reset
	local is_starting1 = (flame1 > 0 or safe_get(Tdr.apd1, 0) > 0)
		and T.disp_n2_1 < 5
		and T.n2_jump_phase_1 < 3
	local in_jump1 = T.n2_jump_phase_1 > 0 and T.n2_jump_phase_1 < 3
	local n2_jump_disp_1 = T.disp_n2_1
	if is_starting1 or in_jump1 then
		-- Activate the spike, or continue one already running
		n2_jump_disp_1, T.n2_jump_phase_1, T.n2_jump_val_1 =
			n2_with_jump(T.disp_n2_1, T.n2_jump_phase_1, T.n2_jump_val_1, true, passed)
	else
		-- Reset the state when the engine is stopped or has left the start band
		if flame1 == 0 or T.disp_n2_1 >= 30 then
			T.n2_jump_phase_1 = 0
			T.n2_jump_val_1 = 0
		end
	end
	set(rpm_high_1, n2_jump_disp_1 + T.bias_n2_1 * bool2int(T.ang1 > 5) + idle_jitter1 + startup_flutter1 + shutdown_jitter1)

	T.N1need2 = target2
	if ((rpm_2 - T.rpm2_last) > 0 and T.N1need2 < 3.5) or T.N1need2 < 0.9 then
		T.ang2 = T.ang2 - T.ang2 * passed * 2
	elseif (rpm_2 - T.rpm2_last) > 0 and T.N1need2 >= 3.5 and T.N1need2 < 5 then
		T.ang2 = T.ang2 + ((4*math.exp(-(T.N1need2-3.5)*5)*math.sin(10*(T.N1need2-3.5)) + T.N1need2) - T.ang2) * passed * 5
	else
		T.ang2 = T.ang2 + (T.N1need2 + (-0.145*math.pow(T.N1need2,2)+2.425*T.N1need2-8.313)*0.17*math.sin(20*T.tme+1.5)*bool2int(T.N1need2>5 and T.N1need2<12) - T.ang2) * passed * n2_spd(T.N1need2, rpm_2-T.rpm2_last) * hot2
	end
	local surge2_osc = T.surge_flutter2 * math.sin(T.tme * 26) * 0.5
	local idle_jitter2 = bool2int(flame2>0 and math.abs(rpm_2 - idle_rpm) < 3) * noise("idle2", passed) * 0.15
	-- [STARTER-FLUTTER] see engine 1
	local startup_flutter2 = 0
	if T.disp_n2_2 and T.disp_n2_2 > 0.5 and T.disp_n2_2 < 20 and (flame2 > 0 or safe_get(Tdr.apd2, 0) > 0) then
		local amp = math.sin(T.disp_n2_2 / 20 * math.pi) * 0.2
		startup_flutter2 = math.sin(T.tme * 33 + 1.2) * amp * 0.3
			+ math.sin(T.tme * 13 + 2.1) * amp * 0.2
			+ noise("flut2", passed) * amp * 0.3
	end
	-- [SHUTDOWN-JITTER] see engine 1
	local shutdown_jitter2 = 0
	if flame2 == 0 and T.disp_n2_2 and T.disp_n2_2 > 0.5 and T.disp_n2_2 < 20 then
		local amp = math.sin(T.disp_n2_2 / 20 * math.pi) * 0.18
		shutdown_jitter2 = noise("shut2", passed) * amp * 0.7
			+ math.sin(T.tme * 18 + 1.7) * amp * 0.2
	end
	local disp_n2_2 = math.min(T.n2_max, interpolate(T.n2_scale, T.ang2 + T.n2_adv2 + surge2_osc))
	disp_n2_2 = disp_n2_2 + idle_n2_corr * temp_corr_weight(disp_n2_2)
	T.disp_n2_2 = disp_n2_2
	-- [v16] see engine 1 - the spike only on a cold start
	local is_starting2 = (flame2 > 0 or safe_get(Tdr.apd2, 0) > 0)
		and T.disp_n2_2 < 5
		and T.n2_jump_phase_2 < 3
	local in_jump2 = T.n2_jump_phase_2 > 0 and T.n2_jump_phase_2 < 3
	local n2_jump_disp_2 = T.disp_n2_2
	if is_starting2 or in_jump2 then
		n2_jump_disp_2, T.n2_jump_phase_2, T.n2_jump_val_2 =
			n2_with_jump(T.disp_n2_2, T.n2_jump_phase_2, T.n2_jump_val_2, true, passed)
	else
		if flame2 == 0 or T.disp_n2_2 >= 30 then
			T.n2_jump_phase_2 = 0
			T.n2_jump_val_2 = 0
		end
	end
	set(rpm_high_2, n2_jump_disp_2 + T.bias_n2_2 * bool2int(T.ang2 > 5) + idle_jitter2 + startup_flutter2 + shutdown_jitter2)

	T.N1need3 = target3
	if safe_get(Tdr.kpp3f, 0) > 0 then T.N1need3 = interpolate(T.kpp3_tbl, rpm_3) end
	if ((rpm_3 - T.rpm3_last) > 0 and T.N1need3 < 3.5) or T.N1need3 < 0.3 then
		T.ang3 = T.ang3 - T.ang3 * passed
	elseif (rpm_3 - T.rpm3_last) > 0 and T.N1need3 >= 3.5 and T.N1need3 < 5 then
		T.ang3 = T.ang3 + ((4*math.exp(-(T.N1need3-3.5)*5)*math.sin(10*(T.N1need3-3.5)) + T.N1need3) - T.ang3) * passed * 5
	else
		T.ang3 = T.ang3 + (T.N1need3 + (-0.145*math.pow(T.N1need3,2)+2.425*T.N1need3-8.313)*0.21*math.sin(19*T.tme)*bool2int(T.N1need3>5 and T.N1need3<12) - T.ang3) * passed * n2_spd(T.N1need3, rpm_3-T.rpm3_last) * hot3
	end
	local surge3_osc = T.surge_flutter3 * math.sin(T.tme * 27) * 0.5
	local idle_jitter3 = bool2int(flame3>0 and math.abs(rpm_3 - idle_rpm) < 3) * noise("idle3", passed) * 0.15
	-- [STARTER-FLUTTER] see engine 1
	local startup_flutter3 = 0
	if T.disp_n2_3 and T.disp_n2_3 > 0.5 and T.disp_n2_3 < 20 and (flame3 > 0 or safe_get(Tdr.apd3, 0) > 0) then
		local amp = math.sin(T.disp_n2_3 / 20 * math.pi) * 0.2
		startup_flutter3 = math.sin(T.tme * 36 + 2.4) * amp * 0.3
			+ math.sin(T.tme * 11 + 0.8) * amp * 0.2
			+ noise("flut3", passed) * amp * 0.3
	end
	-- [SHUTDOWN-JITTER] see engine 1
	local shutdown_jitter3 = 0
	if flame3 == 0 and T.disp_n2_3 and T.disp_n2_3 > 0.5 and T.disp_n2_3 < 20 then
		local amp = math.sin(T.disp_n2_3 / 20 * math.pi) * 0.18
		shutdown_jitter3 = noise("shut3", passed) * amp * 0.7
			+ math.sin(T.tme * 18 + 3.4) * amp * 0.2
	end
	local disp_n2_3 = math.min(T.n2_max, interpolate(T.n2_scale, T.ang3 + T.n2_adv3 + surge3_osc))
	disp_n2_3 = disp_n2_3 + idle_n2_corr * temp_corr_weight(disp_n2_3)
	T.disp_n2_3 = disp_n2_3
	-- [v16] see engine 1 - the spike only on a cold start
	local is_starting3 = (flame3 > 0 or safe_get(Tdr.apd3, 0) > 0)
		and T.disp_n2_3 < 5
		and T.n2_jump_phase_3 < 3
	local in_jump3 = T.n2_jump_phase_3 > 0 and T.n2_jump_phase_3 < 3
	local n2_jump_disp_3 = T.disp_n2_3
	if is_starting3 or in_jump3 then
		n2_jump_disp_3, T.n2_jump_phase_3, T.n2_jump_val_3 =
			n2_with_jump(T.disp_n2_3, T.n2_jump_phase_3, T.n2_jump_val_3, true, passed)
	else
		if flame3 == 0 or T.disp_n2_3 >= 30 then
			T.n2_jump_phase_3 = 0
			T.n2_jump_val_3 = 0
		end
	end
	set(rpm_high_3, n2_jump_disp_3 + T.bias_n2_3 * bool2int(T.ang3 > 5) + idle_jitter3 + startup_flutter3 + shutdown_jitter3)

	-- [NEW-4] N2 rate of change - the HP spool reacts faster than the LP
	-- Computed BEFORE rpm_last is updated, to get the correct delta
	local n2_rate_tau = 0.3
	local n2_delta1 = passed > 0 and (rpm_1 - T.rpm1_last) / passed or 0
	local n2_delta2 = passed > 0 and (rpm_2 - T.rpm2_last) / passed or 0
	local n2_delta3 = passed > 0 and (rpm_3 - T.rpm3_last) / passed or 0
	T.n2_rate1 = T.n2_rate1 + (n2_delta1 - T.n2_rate1) * passed / n2_rate_tau
	T.n2_rate2 = T.n2_rate2 + (n2_delta2 - T.n2_rate2) * passed / n2_rate_tau
	T.n2_rate3 = T.n2_rate3 + (n2_delta3 - T.n2_rate3) * passed / n2_rate_tau

	if passed ~= 0 then
		T.rpm1_last = rpm_1;  T.rpm2_last = rpm_2;  T.rpm3_last = rpm_3
	end
	-- [REMOVED] There used to be an "HP inertia" term here that divided M_rot by up to
	-- 0.6 whenever N2 was rising, i.e. it made the LP rotor up to 1.67x lighter exactly
	-- when the throttle was slammed - the opposite of what a rotor does, and one of the
	-- reasons acceleration read as instantaneous. T.n2_rate* is still computed above;
	-- it feeds the N2-leads-N1 lead term (n2_adv*), which is the real effect it modelled.

	-- [NEW-1] Acceleration: N2 leads N1 on a rapid throttle advance
	-- On a rapid N2 rise (>5%/s) N1 lags - the lead builds up and then decays
	local accel_thresh = 5.0  -- N2 acceleration threshold (%/s) at which the lead appears
	local adv_rise  = 0.4   -- build-up rate of the lead
	local adv_decay = 0.8   -- decay rate of the lead
	if T.n2_rate1 > accel_thresh then
		T.n2_adv1 = math.min(T.n2_adv1 + (T.n2_rate1 - accel_thresh) * adv_rise * passed, 4.0)
	else
		T.n2_adv1 = math.max(0, T.n2_adv1 - adv_decay * passed)
	end
	if T.n2_rate2 > accel_thresh then
		T.n2_adv2 = math.min(T.n2_adv2 + (T.n2_rate2 - accel_thresh) * adv_rise * passed, 4.0)
	else
		T.n2_adv2 = math.max(0, T.n2_adv2 - adv_decay * passed)
	end
	if T.n2_rate3 > accel_thresh then
		T.n2_adv3 = math.min(T.n2_adv3 + (T.n2_rate3 - accel_thresh) * adv_rise * passed, 4.0)
	else
		T.n2_adv3 = math.max(0, T.n2_adv3 - adv_decay * passed)
	end

	-- [NEW-6] N2 needle flutter when the anti-surge valves close (79% N2 threshold)
	-- D-30KU-154: the valves are closed by springs above N2 > 79% - a slight hydraulic shock
	local surge_thr = 79.0
	-- engine 1
	if not T.surge_crossed1 and rpm_1 > surge_thr and T.rpm1_last <= surge_thr and flame1 > 0 then
		T.surge_flutter1 = 1.8  -- initial flutter amplitude (%)
		T.surge_crossed1 = true
	elseif rpm_1 < surge_thr - 2 then
		T.surge_crossed1 = false  -- reset when it falls below the threshold
	end
	T.surge_flutter1 = T.surge_flutter1 * math.max(0, 1 - passed * 3.5)  -- decay ~0.3 s
	-- engine 2
	if not T.surge_crossed2 and rpm_2 > surge_thr and T.rpm2_last <= surge_thr and flame2 > 0 then
		T.surge_flutter2 = 1.8
		T.surge_crossed2 = true
	elseif rpm_2 < surge_thr - 2 then
		T.surge_crossed2 = false
	end
	T.surge_flutter2 = T.surge_flutter2 * math.max(0, 1 - passed * 3.5)
	-- engine 3
	if not T.surge_crossed3 and rpm_3 > surge_thr and T.rpm3_last <= surge_thr and flame3 > 0 then
		T.surge_flutter3 = 1.8
		T.surge_crossed3 = true
	elseif rpm_3 < surge_thr - 2 then
		T.surge_crossed3 = false
	end
	T.surge_flutter3 = T.surge_flutter3 * math.max(0, 1 - passed * 3.5)
	local c_q = T.c_q_base * interpolate(T.c_q_tbl, T.tas_LP)
	local li1 = n1_from_n2(idle_rpm, d_isa, alt_baro/1000, T.tas_LP) - T.rna1
	local li2 = n1_from_n2(idle_rpm, d_isa, alt_baro/1000, T.tas_LP) - T.rna2 - interpolate(T.e2n1_tbl, idle_rpm)
	local li3 = n1_from_n2(idle_rpm, d_isa, alt_baro/1000, T.tas_LP) - T.rna3
	T.cturb1 = T.c_aero*dens*math.pow(li1,2)/math.pow(idle_rpm,2) - c_q*T.q/math.pow(idle_rpm,2)
	T.cturb2 = T.c_aero*dens*math.pow(li2,2)/math.pow(idle_rpm,2) - c_q*T.q/math.pow(idle_rpm,2)
	T.cturb3 = T.c_aero*dens*math.pow(li3,2)/math.pow(idle_rpm,2) - c_q*T.q/math.pow(idle_rpm,2)

	local wa = math.min(get(Tdr.wdir) - get(Tdr.adir), 360 - get(Tdr.wdir) + get(Tdr.adir))
	if T.tas_LP > 80 then wa = 0 end
	local revL  = safe_get(Tdr.revL, 0)
	local revR  = safe_get(Tdr.revR, 0)
	local cov   = safe_get(Tdr.covers, 0)
	local coswa = math.cos(wa / 180 * 3.14) * (1 - cov)
	local q1 = T.q * coswa * (1 - 0.5*revL)
	local q2 = T.q * coswa
	local q3 = T.q * coswa * (1 - 0.5*revR)
	if math.abs(wa) > 90 then q1=q1/2*(1-revL); q3=q3/2*(1-revR) end

	-- [6] Altitude effect on N1 - correction factor above the tropopause (~11000 m)
	local alt_n1_corr = 1.0
	if alt_baro > 9000 then
		alt_n1_corr = 1.0 + (alt_baro - 9000) / 3000 * 0.04  -- +4% to N1 at 12000 m
	end

	-- N1 engine 1
	T.N2need1_old = n1_from_n2(T.ang1, d_isa, alt_baro/1000, T.tas_LP) - T.rna1
	T.N2need1_old = T.N2need1_old * interpolate(T.n1s_tbl, T.ang1) * alt_n1_corr
	if T.N2need1 > rna_thres and T.rna1 > 0 then
		T.rna1 = T.rna1 - T.rna1*passed*(1-0.8*math.max(math.max(T.rna1,4)-4,0)/2)/2
		if T.rna1<0 then T.rna1=0 end
	elseif T.N2need1 < rna_thres and T.rna1 < 6 then
		T.rna1 = T.rna1 + (6-T.rna1)*passed*(1-0.8*(1-math.min(math.min(T.rna1,2),2)/2))/2
		if T.rna1>6 then T.rna1=6 end
	end
	local aN1
	if T.N2need1 >= 0 then
		aN1 = T.cturb1*math.pow(T.ang1,2)*(0.2+0.8*flame1) - T.c_aero*dens*math.pow(T.N2need1,2) + c_q*q1 - T.c_f*math.min(T.N2need1/0.001,1)
	else
		aN1 = T.cturb1*math.pow(T.ang1,2)*(0.2+0.8*flame1) + T.c_aero*dens*math.pow(T.N2need1,2) + c_q*q1 - T.c_f*math.max(T.N2need1/0.001,-1)
	end
	if T.start_timer > 3 then T.N2need1 = T.N2need1 + aN1/T.M_rot*passed * temp_spd_coeff * hot1 end
	if math.abs(T.N2need1) < T.N2need1_old*flame1 then T.N2need1 = T.N2need1_old*flame1 end
	-- [4] N1 needle inertia during the decay + [8] hysteresis on a rapid throttle reduction
	T.ang1b_slow = T.ang1b_slow + (T.N2need1 - T.ang1b_slow) * passed * (T.N2need1 > T.ang1b_slow and 6 or 2)
	local n1_target1 = T.N2need1 < T.N2need1_prev and T.ang1b_slow or T.N2need1
	-- [8] lag on a rapid throttle reduction
	local drop1 = T.N2need1_prev - T.N2need1
	if drop1 > 5 then  -- a sharp drop > 5% per frame
		T.n1_lag1 = T.n1_lag1 + (T.N2need1 - T.n1_lag1) * passed * 1.5
		n1_target1 = T.n1_lag1
	else
		T.n1_lag1 = T.N2need1
	end
	if ((T.N2need1-T.N2need1_prev)>0 and T.N2need1<2) or T.N2need1<1 then
		T.ang1b = T.ang1b - T.ang1b*passed*2
	elseif (T.N2need1-T.N2need1_prev)>0 and T.N2need1>=2 and T.N2need1<3 then
		T.ang1b = T.ang1b + ((1*math.exp(-(T.N2need1-2)*5)*math.sin(10*(T.N2need1-2))+T.N2need1)-T.ang1b)*passed*5
		T.nmove1=1
	else
		T.ang1b = T.ang1b + (n1_target1+(-0.04167*math.pow(n1_target1,2)+0.5417*n1_target1-1.5)*0.57*math.sin(20*T.tme+2)*bool2int(n1_target1>3 and n1_target1<9)-T.ang1b)*passed*n1_spd(T.N2need1,T.N2need1-T.N2need1_prev)*T.nmove1
	end
	if T.N2need1>20 then T.nmove1=1 elseif T.ang1b<0.4 then T.nmove1=0 end
	local idle_jitter1b = bool2int(flame1>0 and math.abs(T.N2need1 - li1) < 2) * noise("idleb1", passed) * 0.12
	local disp_n1_1 = math.min(T.n1_max, interpolate(T.n1_scale, T.ang1b))
	-- [FIX] removed the artificial clamp disp_n1_1 = min(disp_n1_1, T.disp_n2_1 * 0.97)
	-- this clamp held the LP needle down against the HP needle at every setting,
	-- which is why at idle N1 showed 60% instead of the proper 30%.
	-- The N1/N2 ratio for the D-30KU-154 is variable: idle ~0.50, takeoff ~0.93.

	-- [STARTUP-SYNC v2] Synchronous rise N1=N2-30 up to idle.
	-- To avoid a discontinuity at the handover to the physics, the smoothed
	-- "tracking" via T.n1_track1: the target migrates smoothly from (N2-30) to the physics.
	-- Active while N2 < 60. Above 60 sync_weight decays smoothly over ~2 seconds.
	if flame1 > 0 and T.disp_n2_1 < 60 then
		disp_n1_1 = math.max(0, T.disp_n2_1 - 30)
		T.n1_sync_w1 = 1.0  -- hold the synchronisation weight at its maximum
	elseif flame1 > 0 and T.n1_sync_w1 > 0 then
		-- release the synchronisation smoothly once idle has been passed
		T.n1_sync_w1 = math.max(0, T.n1_sync_w1 - passed * 0.5)  -- ~2 s for the transition
		local sync_val = math.max(0, T.disp_n2_1 - 30)
		disp_n1_1 = sync_val * T.n1_sync_w1 + disp_n1_1 * (1 - T.n1_sync_w1)
	end

	-- [HARD-OVERRIDE v10] Smooth N1 rise without a jump (the jump moved to N2)
	-- The small needle rises smoothly behind the large one - this is the correct LP physics
	-- [CALIBRATED] Above idle this is anchored point by point on Flight Manual
	-- table 8.1.1 (ground, ISA), band midpoints, displayed N2 -> displayed N1:
	--   idle 60.5/30.0  0.42nom 82.25/59.0  0.6nom 86.75/68.5  0.7nom 88.75/72.5
	--   0.9nom 92.5/80.0  nominal 94.0/83.5  takeoff 95.25/86.75
	-- The previous curve over-read N1 by 11-15 points across that whole range
	-- (it reached 97.5 at the takeoff setting against the FM's 85.5-88.0).
	-- The 0-60 start band is unchanged - it is tuned to the start sequence.
	local function calc_n1_from_n2(n2)
		if     n2 <= 20 then return 0
		elseif n2 <= 35 then return (n2 - 20) / 15 * 2          -- 20→35: N1 0→2
		elseif n2 <= 45 then return 2  + (n2 - 35) / 10 * 6     -- 35→45: N1 2→8
		elseif n2 <= 55 then return 8  + (n2 - 45) / 10 * 14    -- 45→55: N1 8→22
		elseif n2 <= 59.5 then return 22 + (n2 - 55) / 4.5 * 8   -- 55->59.5: N1 22->30
		-- FM gives N1 30.0 flat across the whole 59.5-61.5 idle N2 band
		elseif n2 <= 61.5 then return 30                         -- idle plateau
		elseif n2 <= 82.25 then return 30   + (n2 - 61.5)  / 20.75 * 29    -- -> 0.42 nominal
		elseif n2 <= 86.75 then return 59   + (n2 - 82.25) / 4.5   * 9.5   -- -> 0.6 nominal
		elseif n2 <= 88.75 then return 68.5 + (n2 - 86.75) / 2     * 4     -- -> 0.7 nominal
		elseif n2 <= 92.5  then return 72.5 + (n2 - 88.75) / 3.75  * 7.5   -- -> 0.9 nominal
		elseif n2 <= 94    then return 80   + (n2 - 92.5)  / 1.5   * 3.5   -- -> nominal
		elseif n2 <= 95.25 then return 83.5 + (n2 - 94)    / 1.25  * 3.25  -- -> takeoff
		else                 return math.min(95, 86.75 + (n2 - 95.25) / 3.25 * 8.25) end
	end

	-- [LP-LAG] calc_n1_from_n2 is algebraic, so on its own the small needle tracked the
	-- large one with no lag at all - the LP rotor is the heavy one and must trail the HP.
	-- tau ~ 2 s spooling up, ~1.2 s down. Below 25% the start sequence owns the needle.
	local function n1_disp_lag(cur, target, dt)
		if target < 25 and cur < 25 then return target end
		local rate = target > cur and 0.5 or 0.85
		return cur + (target - cur) * math.min(1, dt * rate)
	end
	-- helper: implementation of the jump-rollback-rise for one engine
	-- n2 - the current N2, phase - the phase (state from T), val - the previous N1 value, flame - 0/1
	-- [TUNED v2] the spike is faster (6->25), an overshoot to 12% and a quicker rollback were added
	local function n1_with_jump(n2, phase, val, flame, dt)
		if flame == 0 then
			-- the engine has flamed out -> return to a smooth decay following N2 (no jump)
			return calc_n1_from_n2(n2), 0, 0
		end
		if n2 < 22 then
			-- the starter is still running, the LP spool is not moving
			return 0, 0, 0
		end
		-- phase 0 -> start the jump
		if phase == 0 and n2 >= 25 then phase = 1 end
		-- PHASE 1: a SHARP spike upwards with an overshoot to 12%
		if phase == 1 then
			-- [DT] lagCoef, not a bare dt*25: frame_time is clamped to 0.1 s, so
			-- the bare form reached a coefficient of 2.5 at <=10 fps and diverged --
			-- the spike shot to ~30% N1 instead of the intended 12%. n1_disp_lag
			-- above already clamped its own coefficient the same way.
			val = val + (12 - val) * lagCoef(dt, 25)  -- we head for 12 very quickly (fractions of a second)
			if val >= 10 then phase = 2 end   -- as soon as 10 is passed - move on to the rollback
			return val, phase, val
		end
		-- PHASE 2: a quick rollback down to 2%
		if phase == 2 then
			val = val + (2 - val) * dt * 4    -- the rollback is noticeably faster, ~1 s
			if val <= 2.5 then phase = 3 end
			return val, phase, val
		end
		-- PHASE 3: a smooth rise to idle following the table, from here N1 catches up with the "normal" curve
		if phase == 3 then
			-- target value from the table (as it used to be)
			local target
			if     n2 <= 45 then target = 2  + (n2 - 22) / 23 * 6     -- 22→45: 2→8
			elseif n2 <= 55 then target = 8  + (n2 - 45) / 10 * 14    -- 45→55: 8→22
			else                 target = 22 + (n2 - 55) / 5  * 8 end -- 55→60: 22→30
			val = val + (target - val) * dt * 2  -- head smoothly towards the target
			return val, phase, val
		end
		return calc_n1_from_n2(n2), phase, val
	end

	-- [v10] N1 now follows the table smoothly - the jump moved to N2 (the large needle)
	-- alt_n1_corr used to feed only the inert chain above; the FM gives a higher N1
	-- for the same N2 at altitude (table 8.1.2), so apply it to the displayed value
	local n1_calc_1 = math.min(T.n1_max, calc_n1_from_n2(T.disp_n2_1) * alt_n1_corr)
	T.n1_disp1 = n1_disp_lag(T.n1_disp1, n1_calc_1, passed)
	n1_calc_1 = T.n1_disp1
	-- During the runout (engine shutdown) - twitching in the 0-20% band
	if flame1 == 0 and n1_calc_1 > 0 and n1_calc_1 < 20 then
		local amp = math.sin(n1_calc_1 / 20 * math.pi) * 0.3
		n1_calc_1 = n1_calc_1 + noise("n1a1", passed) * amp
			+ math.sin(T.tme * 18) * amp * 0.3
	end
	-- During the start - a slight N1 twitch in the 5-25% band
	if flame1 > 0 and n1_calc_1 > 0.5 and n1_calc_1 < 25 then
		local amp = math.sin(n1_calc_1 / 25 * math.pi) * 0.25
		n1_calc_1 = n1_calc_1 + noise("n1b1", passed) * amp * 0.6
			+ math.sin(T.tme * 14) * amp * 0.4
	end
	set(rpm_low_1, math.max(0, n1_calc_1))

	-- N1 engine 2
	T.N2need2_old = n1_from_n2(T.ang2, d_isa, alt_baro/1000, T.tas_LP) - T.rna2 - interpolate(T.e2n1_tbl, T.ang2)
	T.N2need2_old = T.N2need2_old * interpolate(T.n1s_tbl, T.ang2) * alt_n1_corr
	if T.N2need2 > rna_thres+0.5 and T.rna2 > 0 then
		T.rna2 = T.rna2 - T.rna2*passed*(1-0.8*math.max(math.max(T.rna2,4)-4,0)/2)/2
		if T.rna2<0 then T.rna2=0 end
	elseif T.N2need2 < rna_thres+0.25 and T.rna2 < 6 then
		T.rna2 = T.rna2 + (6-T.rna2)*passed*(1-0.8*(1-math.min(math.min(T.rna2,2),2)/2))/2
		if T.rna2>6 then T.rna2=6 end
	end
	aN1 = T.cturb2*math.pow(T.ang2,2)*(0.2+0.8*flame2) - T.c_aero*dens*math.pow(T.N2need2,2) + c_q*q2 - T.c_f
	T.N2need2 = math.max(T.N2need2_old*flame2, T.N2need2 + aN1/T.M_rot*passed * temp_spd_coeff * hot2)
	T.ang2b_slow = T.ang2b_slow + (T.N2need2 - T.ang2b_slow) * passed * (T.N2need2 > T.ang2b_slow and 6 or 2)
	local n1_target2 = T.N2need2 < T.N2need2_prev and T.ang2b_slow or T.N2need2
	local drop2 = T.N2need2_prev - T.N2need2
	if drop2 > 5 then
		T.n1_lag2 = T.n1_lag2 + (T.N2need2 - T.n1_lag2) * passed * 1.5
		n1_target2 = T.n1_lag2
	else
		T.n1_lag2 = T.N2need2
	end
	if ((T.N2need2-T.N2need2_prev)>0 and T.N2need2<2) or T.N2need2<1 then
		T.ang2b = T.ang2b - T.ang2b*passed*2
	elseif (T.N2need2-T.N2need2_prev)>0 and T.N2need2>=2 and T.N2need2<3 then
		T.ang2b = T.ang2b + ((1*math.exp(-(T.N2need2-2)*5)*math.sin(10*(T.N2need2-2))+T.N2need2)-T.ang2b)*passed*5
		T.nmove2=1
	else
		T.ang2b = T.ang2b + (n1_target2+(-0.04167*math.pow(n1_target2,2)+0.5417*n1_target2-1.5)*0.66*math.sin(20*T.tme+3)*bool2int(n1_target2>3 and n1_target2<9)-T.ang2b)*passed*n1_spd(T.N2need2,T.N2need2-T.N2need2_prev)*T.nmove2
	end
	if T.N2need2>20 then T.nmove2=1 elseif T.ang2b<0.4 then T.nmove2=0 end
	local idle_jitter2b = bool2int(flame2>0 and math.abs(T.N2need2 - li2) < 2) * noise("idleb2", passed) * 0.12
	local disp_n1_2 = math.min(T.n1_max, interpolate(T.n1_scale, T.ang2b))
	-- [FIX] clamp removed -- see the comment above for engine 1
	-- [STARTUP-SYNC v2] synchronous needle rise up to idle -- see engine 1
	if flame2 > 0 and T.disp_n2_2 < 60 then
		disp_n1_2 = math.max(0, T.disp_n2_2 - 30)
		T.n1_sync_w2 = 1.0
	elseif flame2 > 0 and T.n1_sync_w2 > 0 then
		T.n1_sync_w2 = math.max(0, T.n1_sync_w2 - passed * 0.5)
		local sync_val = math.max(0, T.disp_n2_2 - 30)
		disp_n1_2 = sync_val * T.n1_sync_w2 + disp_n1_2 * (1 - T.n1_sync_w2)
	end
	-- [v10] N1 now follows the table smoothly - the jump moved to N2
	-- alt_n1_corr used to feed only the inert chain above; the FM gives a higher N1
	-- for the same N2 at altitude (table 8.1.2), so apply it to the displayed value
	local n1_calc_2 = math.min(T.n1_max, calc_n1_from_n2(T.disp_n2_2) * alt_n1_corr)
	T.n1_disp2 = n1_disp_lag(T.n1_disp2, n1_calc_2, passed)
	n1_calc_2 = T.n1_disp2
	if flame2 == 0 and n1_calc_2 > 0 and n1_calc_2 < 20 then
		local amp = math.sin(n1_calc_2 / 20 * math.pi) * 0.3
		n1_calc_2 = n1_calc_2 + noise("n1a2", passed) * amp
			+ math.sin(T.tme * 18 + 1.7) * amp * 0.3
	end
	if flame2 > 0 and n1_calc_2 > 0.5 and n1_calc_2 < 25 then
		local amp = math.sin(n1_calc_2 / 25 * math.pi) * 0.25
		n1_calc_2 = n1_calc_2 + noise("n1b2", passed) * amp * 0.6
			+ math.sin(T.tme * 14 + 1.5) * amp * 0.4
	end
	set(rpm_low_2, math.max(0, n1_calc_2))

	-- N1 engine 3
	T.N2need3_old = n1_from_n2(T.ang3, d_isa, alt_baro/1000, T.tas_LP) - T.rna3
	T.N2need3_old = T.N2need3_old * interpolate(T.n1s_tbl, T.ang3) * alt_n1_corr
	if T.N2need3 > rna_thres-0.5 and T.rna3 > 0 then
		T.rna3 = T.rna3 - T.rna3*passed*(1-0.8*math.max(math.max(T.rna3,4)-4,0)/2)/2
		if T.rna3<0 then T.rna3=0 end
	elseif T.N2need3 < rna_thres+0.5 and T.rna3 < 6 then
		T.rna3 = T.rna3 + (6-T.rna3)*passed*(1-0.8*(1-math.min(math.min(T.rna3,2),2)/2))/2
		if T.rna3>6 then T.rna3=6 end
	end
	if T.N2need3 >= 0 then
		aN1 = T.cturb3*math.pow(T.ang3,2)*(0.2+0.8*flame3) - T.c_aero*dens*math.pow(T.N2need3,2) + c_q*q3 - T.c_f*math.min(T.N2need3/0.001,1)
	else
		aN1 = T.cturb3*math.pow(T.ang3,2)*(0.2+0.8*flame3) + T.c_aero*dens*math.pow(T.N2need3,2) + c_q*q3 - T.c_f*math.max(T.N2need3/0.001,-1)
	end
	if T.start_timer > 3 then T.N2need3 = T.N2need3 + aN1/T.M_rot*passed * temp_spd_coeff * hot3 end
	if math.abs(T.N2need3) < T.N2need3_old*flame3 then T.N2need3 = T.N2need3_old*flame3 end
	T.ang3b_slow = T.ang3b_slow + (T.N2need3 - T.ang3b_slow) * passed * (T.N2need3 > T.ang3b_slow and 6 or 2)
	local n1_target3 = T.N2need3 < T.N2need3_prev and T.ang3b_slow or T.N2need3
	local drop3 = T.N2need3_prev - T.N2need3
	if drop3 > 5 then
		T.n1_lag3 = T.n1_lag3 + (T.N2need3 - T.n1_lag3) * passed * 1.5
		n1_target3 = T.n1_lag3
	else
		T.n1_lag3 = T.N2need3
	end
	if ((T.N2need3-T.N2need3_prev)>0 and T.N2need3<2) or T.N2need3<1.1 then
		T.ang3b = T.ang3b - T.ang3b*passed
	elseif (T.N2need3-T.N2need3_prev)>0 and T.N2need3>=2 and T.N2need3<3 then
		T.ang3b = T.ang3b + ((1*math.exp(-(T.N2need3-2)*5)*math.sin(10*(T.N2need3-2))+T.N2need3)-T.ang3b)*passed*5
		T.nmove3=1
	else
		T.ang3b = T.ang3b + (n1_target3+(-0.04167*math.pow(n1_target3,2)+0.5417*n1_target3-1.5)*0.45*math.sin(20*T.tme+1)*bool2int(n1_target3>3 and n1_target3<9)-T.ang3b)*passed*n1_spd(T.N2need3,T.N2need3-T.N2need3_prev)*T.nmove3
	end
	if T.N2need3>20 then T.nmove3=1 elseif T.ang3b<0.4 then T.nmove3=0 end
	local idle_jitter3b = bool2int(flame3>0 and math.abs(T.N2need3 - li3) < 2) * noise("idleb3", passed) * 0.12
	local disp_n1_3 = math.min(T.n1_max, interpolate(T.n1_scale, T.ang3b))
	-- [FIX] clamp removed -- see the comment above for engine 1
	-- [STARTUP-SYNC v2] synchronous needle rise up to idle -- see engine 1
	if flame3 > 0 and T.disp_n2_3 < 60 then
		disp_n1_3 = math.max(0, T.disp_n2_3 - 30)
		T.n1_sync_w3 = 1.0
	elseif flame3 > 0 and T.n1_sync_w3 > 0 then
		T.n1_sync_w3 = math.max(0, T.n1_sync_w3 - passed * 0.5)
		local sync_val = math.max(0, T.disp_n2_3 - 30)
		disp_n1_3 = sync_val * T.n1_sync_w3 + disp_n1_3 * (1 - T.n1_sync_w3)
	end
	-- [v10] N1 now follows the table smoothly - the jump moved to N2
	-- alt_n1_corr used to feed only the inert chain above; the FM gives a higher N1
	-- for the same N2 at altitude (table 8.1.2), so apply it to the displayed value
	local n1_calc_3 = math.min(T.n1_max, calc_n1_from_n2(T.disp_n2_3) * alt_n1_corr)
	T.n1_disp3 = n1_disp_lag(T.n1_disp3, n1_calc_3, passed)
	n1_calc_3 = T.n1_disp3
	if flame3 == 0 and n1_calc_3 > 0 and n1_calc_3 < 20 then
		local amp = math.sin(n1_calc_3 / 20 * math.pi) * 0.3
		n1_calc_3 = n1_calc_3 + noise("n1a3", passed) * amp
			+ math.sin(T.tme * 18 + 3.4) * amp * 0.3
	end
	if flame3 > 0 and n1_calc_3 > 0.5 and n1_calc_3 < 25 then
		local amp = math.sin(n1_calc_3 / 25 * math.pi) * 0.25
		n1_calc_3 = n1_calc_3 + noise("n1b3", passed) * amp * 0.6
			+ math.sin(T.tme * 14 + 2.8) * amp * 0.4
	end
	set(rpm_low_3, math.max(0, n1_calc_3))

	-- fan animation
	if T.N2need1 < 2 then T.fan1 = T.fan1 + T.N2need1/100*T.rpm_knd/60*360*passed end
	if T.fan1 >= 360 then T.fan1 = T.fan1 - 360 end
	if T.N2need3 < 2 then T.fan3 = T.fan3 + T.N2need3/100*T.rpm_knd/60*360*passed end
	if T.fan3 >= 360 then T.fan3 = T.fan3 - 360 end

	T.N2need1_prev = T.N2need1;  T.N2need2_prev = T.N2need2;  T.N2need3_prev = T.N2need3

	safe_set(Tdr.igv1, bool2int(T.rna1 > 5))
	safe_set(Tdr.igv2, bool2int(T.rna2 > 5))
	safe_set(Tdr.igv3, bool2int(T.rna3 > 5))
	safe_set(Tdr.rot1, T.fan1)
	safe_set(Tdr.rot3, T.fan3)
	safe_set(Tdr.knd1, T.N2need1)
	safe_set(Tdr.knd3, T.N2need3)

end

end


------------------------
-- fake gauges --
------------------------

local oil_qty_act_1 = 4
local oil_qty_act_2 = 4
local oil_qty_act_3 = 4


local function oil_qty_gau()
	
	local oil_now_1 = get(engn_oil_qty_1)
	local oil_now_2 = get(engn_oil_qty_2)
	local oil_now_3 = get(engn_oil_qty_3)
	
	
	local qty_1 = 4
	local qty_2 = 4
	local qty_3 = 4
	
	if power_36_L and power_36_R then
		qty_1 = oil_now_1 - T.rpm1_last * 0.05
		qty_2 = oil_now_2 - T.rpm2_last * 0.05
		qty_3 = oil_now_3 - T.rpm3_last * 0.05
	else
		qty_1 = 4
		qty_2 = 4
		qty_3 = 4
	end
	
	if get(gauges_on_1) == 0 then qty_1 = 4 end
	if get(gauges_on_2) == 0 then qty_2 = 4 end
	if get(gauges_on_3) == 0 then qty_3 = 4 end
	
	
	oil_qty_act_1 = oil_qty_act_1 + (qty_1 - oil_qty_act_1) * passed
	oil_qty_act_2 = oil_qty_act_2 + (qty_2 - oil_qty_act_2) * passed
	oil_qty_act_3 = oil_qty_act_3 + (qty_3 - oil_qty_act_3) * passed
	
	
	set(oil_qty_1, math.max(4, oil_qty_act_1))
	set(oil_qty_2, math.max(4, oil_qty_act_2))
	set(oil_qty_3, math.max(4, oil_qty_act_3))
	

end


local fuel_temp_act_1 = 0
local fuel_temp_act_2 = 0

local function fuel_temp_gau()

	local air_temp = get(thermo)
	
	if power_27_R then 
		fuel_temp_act_1 = fuel_temp_act_1 + (air_temp - fuel_temp_act_1) * passed
		fuel_temp_act_2 = fuel_temp_act_2 + (air_temp - fuel_temp_act_2) * passed
	else
		fuel_temp_act_1 = fuel_temp_act_1 + (0 - fuel_temp_act_1) * passed
		fuel_temp_act_2 = fuel_temp_act_2 + (0 - fuel_temp_act_2) * passed
	
	end

	if fuel_temp_act_1 > 65 then fuel_temp_act_1 = 65
	elseif fuel_temp_act_1 < -65 then fuel_temp_act_1 = -65 end
	
	if fuel_temp_act_2 > 65 then fuel_temp_act_2 = 65
	elseif fuel_temp_act_2 < -65 then fuel_temp_act_2 = -65 end

	set(fuel_temp_1, fuel_temp_act_1)
	set(fuel_temp_2, fuel_temp_act_2)


end


function update()
	passed = get(frame_time)
	
	MASTER = get(ismaster) ~= 1	
	
	
	power_27_L = get(bus27_volt_left) > 13
	power_27_R = get(bus27_volt_right) > 13
	power_115 = get(bus115_1_volt) > 110
	power_36_L = get(bus36_volt_left) > 30
	power_36_R = get(bus36_volt_right) > 30
	
	gau_1_on = get(gauges_on_1)
	gau_2_on = get(gauges_on_2) 
	gau_3_on = get(gauges_on_3)
	
	tachometers()
	egt_gauges()
	emi3()	
	fuel_flow()
	vibra_gau()
	oil_qty_gau()
	fuel_temp_gau()

end
