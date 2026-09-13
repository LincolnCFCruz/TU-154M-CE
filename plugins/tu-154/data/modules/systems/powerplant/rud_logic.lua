-- Throttle (RUD) logic: lever-to-thrust tables, the lever lag filter
-- (virtual_rud_*_act) and the three idle stops (ground, flight idle MG,
-- configuration stop PMG).

-- controls
defineProperty("tro_comm_1", globalPropertyf("tu-154/SC/engine/ENGN_thro_0")) 
defineProperty("tro_comm_2", globalPropertyf("tu-154/SC/engine/ENGN_thro_1")) 
defineProperty("tro_comm_3", globalPropertyf("tu-154/SC/engine/ENGN_thro_2"))

defineProperty("sim_rud_1", globalProperty("sim/flightmodel/engine/ENGN_thro_use[0]"))
defineProperty("sim_rud_2", globalProperty("sim/flightmodel/engine/ENGN_thro_use[1]"))
defineProperty("sim_rud_3", globalProperty("sim/flightmodel/engine/ENGN_thro_use[2]"))


defineProperty("eng_modL", globalProperty("sim/flightmodel/engine/ENGN_propmode[0]")) 
defineProperty("eng_modR", globalProperty("sim/flightmodel/engine/ENGN_propmode[2]")) 

defineProperty("anim_rud1", globalPropertyf("tu-154/controlls/throttle_1")) 
defineProperty("anim_rud2", globalPropertyf("tu-154/controlls/throttle_2")) 
defineProperty("anim_rud3", globalPropertyf("tu-154/controlls/throttle_3")) 

defineProperty("anim_rud1_ENG", globalPropertyf("tu-154/controlls/throttle_1_ENG")) 
defineProperty("anim_rud2_ENG", globalPropertyf("tu-154/controlls/throttle_2_ENG")) 
defineProperty("anim_rud3_ENG", globalPropertyf("tu-154/controlls/throttle_3_ENG")) 

defineProperty("revers_L", globalPropertyf("tu-154/controlls/revers_L")) 
defineProperty("revers_R", globalPropertyf("tu-154/controlls/revers_R")) 

defineProperty("throttle_lock", globalPropertyf("tu-154/controlls/throttle_lock")) 

defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  

defineProperty("baro_press_pas", globalPropertyf("sim/weather/region/sealevel_pressure_pas"))  

defineProperty("rud_1_spd", globalPropertyf("tu-154/absu/rud_1_spd")) 
defineProperty("rud_2_spd", globalPropertyf("tu-154/absu/rud_2_spd")) 
defineProperty("rud_3_spd", globalPropertyf("tu-154/absu/rud_3_spd")) 

-- failures
defineProperty("comsta0", globalPropertyi("sim/operation/failures/rel_comsta0")) 
defineProperty("comsta1", globalPropertyi("sim/operation/failures/rel_comsta1"))
defineProperty("comsta2", globalPropertyi("sim/operation/failures/rel_comsta2"))

-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time")) 
defineProperty("outside_air_temp", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")) 
defineProperty("onground", globalPropertyi("sim/flightmodel/failures/onground_any"))
-- landing-configuration gate for the PMG (approach idle) stop - see below
defineProperty("flap_ratio", globalPropertyf("sim/flightmodel2/controls/flap1_deploy_ratio"))

-- idle regime references, published for engine_gauges.lua and the debug inspector
defineProperty("flight_idle",     globalPropertyf("tu-154/engines/flight_idle"))     -- sim-N2 idle reference
defineProperty("flight_idle_rpm", globalPropertyf("tu-154/engines/flight_idle_rpm")) -- gauge-scale idle N2, %
defineProperty("idle_stop",       globalPropertyf("tu-154/engines/idle_stop"))       -- throttle floor applied this frame
defineProperty("idle_stop_mode",  globalPropertyi("tu-154/engines/idle_stop_mode"))  -- 0 ground, 1 MG, 2 PMG
-- test switches, set from DataRefTool (see core/dataref_creator_2.lua)
defineProperty("tune_idle_11k",   globalPropertyf("tu-154/tune/idle_11k"))
defineProperty("tune_offset",     globalPropertyf("tu-154/tune/thro_alt_offset"))
defineProperty("tune_pmg_gate",   globalPropertyi("tu-154/tune/pmg_gate"))

defineProperty("rev_fail", globalPropertyi("sim/operation/failures/rel_revloc1")) 
defineProperty("rev_fail_2", globalPropertyi("sim/operation/failures/rel_revers1")) 
defineProperty("override", globalPropertyi("sim/operation/override/override_throttles"))

-- engine result power
defineProperty("acf_tmax", globalPropertyf("sim/aircraft/engine/acf_tmax")) 
defineProperty("throttle_ratio_all", globalPropertyf("sim/cockpit2/engine/actuators/throttle_ratio_all")) 

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 

set(override, 1) 

-- the initial value corresponds to idle (0.42 nominal)
set(sim_rud_1, 0.38)
set(sim_rud_2, 0.38)
set(sim_rud_3, 0.38)

-- reference tables
-- forward_table: throttle position (0-1) -> thrust (0-1)
-- Per Flight Manual Table 8.1.1 (ground settings, ISA):
--   Idle:                 HP 59.5-61.5%  -> joy=0.0  -> 0.38 (0.42 nominal)
--   0.6 of nominal:       HP 85.5-88.0%  -> joy=0.5  -> 0.55
--   0.7 of nominal:       HP 87.5-90.0%  -> joy=0.6  -> 0.65
--   Nominal:              HP 93.0-95.0%  -> joy=0.7  -> 0.805
--   Takeoff:              HP 94.5-96.0%  -> joy=1.0  -> 0.975
local forward_table = {
    { -10000, 0.00  },
    -- Ground idle (Malyy gaz). CALIBRATED from the sweep - see GROUND_IDLE_OUT
    -- below, which MUST carry the same number: the idle floor is math.max() of
    -- the two, so changing one alone silently does nothing.
    --
    -- (The comment that used to sit here read "idle: 0.42 nominal (HP 59.5-
    -- 61.5%)", welding two regimes together. This point is GROUND idle, HP
    -- 59.5...61.5 %, N1 30 %. 0.42 nominal is PMG at HP 81.0...83.5 %, which is
    -- FLIGHT_IDLE_OUT's job, not this row's.)
    {   0.0,  0.16  },  -- ground idle: 903 kgf, under the documented 940 limit
    {   0.5,  0.55  },  -- 0.6 nominal
    {   0.6,  0.637 },  -- between 0.6 and 0.7 nominal
    {   0.65, 0.72  },  -- 0.7 nominal
    {   0.7,  0.805 },  -- nominal
    {   0.8,  0.886 },
    -- Takeoff detent. joy is clamped to 1.0, so this is the highest row that can
    -- ever be reached. CALIBRATED: 0.975 delivered 10 148 kgf against the
    -- documented 10 500, and left raw N2 at 98.2 when the documented takeoff
    -- band wants the gauge at 94.5...96.0 %. Raising it to 0.995 fixes both at
    -- once - 10 493 kgf and raw N2 99.0 - because thrust and N2 are both
    -- functions of throttle, so one lever corrects them together.
    -- Preferred over inflating acf_tmax further: X-Plane's delivered thrust is
    -- strongly sub-linear in commanded thrust (eta fell 0.894 -> 0.867 when
    -- acf_tmax went up 6.5 %), so chasing thrust through acf_tmax alone has
    -- sharply diminishing returns and does nothing for N2.
    {   1.0,  0.995 },  -- takeoff: 10 493 kgf, the documented 10 500 +/-1 %
    -- The three rows below are DEAD. joy_rud_pos is clamped with
    -- math.max(0, math.min(1, ...)) before this table is interpolated, so no
    -- lever position can index past 1.0. Left in place only because deleting
    -- them changes nothing; do not treat 1.3 as the model's maximum output.
    {   1.1,  1.0   },
    {   1.2,  1.2   },
    { 100000, 1.3   }
}
-- reverse_table: lever position -> reverse output ratio. The two flat steps are
-- correct in shape - they model the real stepped "Malyy revers / Maksimalnyy
-- revers" lever - but the ratios have never been checked against a kgf figure.
--
-- DECIDED: this aircraft models the 3400 kgf variant, per the Tu-154M RLE note
-- on stepped-reverse aircraft. (The engine RE 072.00.00 sect.5.9.2 lists
-- 3400 kgf +/-3 % for "straight" buckets and 2920 kgf +/-3 % for flow-deflecting
-- ones; the RLE note gives 3400 kgf for stepped-reverse aircraft. The two do not
-- obviously agree and the scan is poor there - see the sources README.)
--
-- MEASURED at UUEE (density ratio 0.984), before the thrust correction above:
--     min detent, throttle 0.196 ->  5 845 N =  596 kgf   (target <= 500)
--     max detent, throttle 0.804 -> 31 511 N = 3213 kgf   (target 3400 +/-3 %)
-- Those two points give reverse thrust ~ throttle^1.195, i.e. the X-Plane
-- reverse model is markedly non-linear and delivers only about a quarter of
-- what a linear reading of these ratios would suggest. An earlier estimate that
-- assumed linearity concluded max reverse was 2.5x too strong; it is not, it
-- was 5.5 % too weak. Retuning from arithmetic here is how that mistake is made.
--
-- Raising acf_tmax to the corrected rating multiplies both detents by 1.065:
--     max detent -> 3479 kgf ISA SL, inside the 3298...3502 band, so unchanged
--     min detent -> 645 kgf, still over, so trimmed 0.18 -> 0.141 below
-- (Max sits near the top of the band rather than on the 3400 nominal; 0.784
-- would centre it, but 0.8 is in tolerance and fewer moving parts is better.)
local reverse_table = {{ -10000, 0.04 }, { 0.0, 0.141 }, { 0.5, 0.141 }, { 0.6, 0.8}, { 1.0, 0.8 }, { 100000, 0.8 }}
-- rud_T_tbl is a RATE schedule in 1/s against OAT: 10 at -60 C, 1.0 at 0 C, 0.4 at +40 C.
-- Cold engine responds faster, hot one slower - the same sense as temp_spd_coeff in
-- engine_gauges.lua. At ISA (+15 C) the rate is ~0.775, so tau ~ 1.3 s.
local rud_T_tbl = {{ -10000, 10 }, { -60, 10 }, { 0, 1}, { 40, 0.4}, { 60, 0.3}, { 100000, 0.1 }}

-- Spool-down is faster than spool-up (FM: accel idle->takeoff <= 12 s, decel ~5-6 s)
local DECEL_RATE_FACTOR = 1.6
-- rud_T_tbl runs away at its cold end (rate 10 at -60 C = no lag at all), so clamp it.
-- 0.5..1.1 gives tau 2.0 s hot / 0.91 s cold, ~1.3 s at ISA - the same order of
-- temperature spread that temp_spd_coeff in engine_gauges.lua allows itself.
local RUD_RATE_MIN, RUD_RATE_MAX = 0.5, 1.1

local function rud_lag(act, target, rate, dt)
	if target < act then rate = rate * DECEL_RATE_FACTOR end
	-- min(1, ...) keeps the filter stable at low frame rates
	return act + (target - act) * math.min(1, dt * rate)
end

-- Idle stops. There are three since 2026-09-10; before that one airborne stop
-- was applied from liftoff to touchdown, and the aircraft could not decelerate.
--   GROUND_IDLE_OUT    on the ground. CALIBRATED - see the sweep below. It is
--                      forward_table's joy=0 row and MUST carry the same number:
--                      the floor is math.max() of the two, so changing one alone
--                      silently does nothing.
--   flight idle (MG)   airborne, clean. Scheduled with altitude from
--                      FLIGHT_IDLE_OUT_SL to tu-154/tune/idle_11k (default
--                      0.45). PROVISIONAL - see "Flight idle calibration" below.
--   APPROACH_IDLE_OUT  airborne with the flaps past PMG_FLAP_RATIO, and ONLY
--                      when tu-154/tune/pmg_gate is 1 - it is 0 by default.
--                      Its value is the single airborne stop this code used
--                      before the split. Neither manual describes such a stop:
--                      the lever has one idle position, МАЛЫЙ ГАЗ, whose N2
--                      rises with altitude (RLE 8.1.4.2, 8.1.16.1 note 2), and
--                      0.42 nominal - "посадочный малый газ" in the RLE,
--                      "полетный малый газ" in the engine manual's tables - is
--                      a regime the crew sets with the lever. Descent is flown
--                      at МАЛЫЙ ГАЗ (RLE 4.5.1) and idle is selected at 6-4 m
--                      (4.7.1). Kept behind the switch for comparison only;
--                      see R-14 in _extras/docs/patch-2026-09-10/decisions_EN.txt.
-- tu-154/engines/idle_stop and idle_stop_mode publish which stop applies.
--
-- GROUND_IDLE_OUT is CALIBRATED, not chosen. From the throttle sweep at UUEE:
--     r = 0.15 -> 862 kgf     r = 0.17 -> 944 kgf
--     r = 0.16 -> 903 kgf     r = 0.18 -> 986 kgf   (SL-equivalent thrust)
-- Documented ground idle is thrust <= 940 kgf with N2 59.5...61.5 % and N1 30 %
-- (RLE 8.1.1). 0.16 sits under the thrust ceiling with margin and puts the
-- gauge mid-band. The old 0.38 produced ~1871 kgf - twice the documented idle -
-- which is what made the aircraft float, refuse to slow down and descend flat.
--
-- Flight idle calibration. MG rises with altitude - real FCU behaviour, and the
-- ONLY row of Tables 8.1.1 / 8.1.2 that changes with height:
--     ground (Table 8.1.1) .... N1 30.0 / N2 59.5...61.5
--     H=11 km (Table 8.1.2) ... N1 63.0 / N2 78.0 / EGT 365 C
-- Every regime ABOVE idle carries the same N2 at both altitudes (nominal
-- 93.0...95.0, 0.7 nominal 87.5...90.0, 0.42 nominal 81.0...83.5), which is
-- why the lever-to-regime mapping should not shift with height - see
-- thro_high further down, and test card T4.
-- To calibrate: climb to 11 km, M 0.8, throttles to the stop, and trim
-- tu-154/tune/idle_11k until the gauge reads N2 78.0 % (test card T3). Whatever
-- value does that IS flight idle, by definition. FLIGHT_IDLE_OUT_SL has no
-- documented anchor; it only has to sit just above ground idle.
local GROUND_IDLE_OUT, APPROACH_IDLE_OUT = 0.16, 0.42
local FLIGHT_IDLE_OUT_SL = 0.20   -- MG near sea level, PROVISIONAL
-- Flaps beyond the takeoff settings (15/28 deg) stand in for the landing
-- configuration: 0.7 of the 45 deg maximum is 31.5 deg, so the gate selects the
-- 36 and 45 deg settings. Only read when tu-154/tune/pmg_gate is 1.
local PMG_FLAP_RATIO = 0.7
-- SUSPECT: APPROACH_IDLE_OUT = 0.42 looks like a units confusion rather than a
-- calibration. The regime it models is named "0.42 nominal" - 0.42 of NOMINAL
-- THRUST, i.e. 4000 kgf - but this constant is a throttle fraction, and 0.42 of
-- throttle is not 0.42 of thrust. The sweep puts throttle 0.4316 at about
-- 2350 kgf and raw N2 ~74, where 0.42 nominal should be 4000 kgf and N2
-- 81.0...83.5 %. By the same thrust anchoring used for the ground stop it
-- wants r ~= 0.595. Left alone: it changes approach handling and needs an
-- airborne check (question Q2 of the readiness plan).
--
-- Idle references for tu-154/engines/flight_idle*.
-- THE TWO KINDS ARE NOT A MAPPED PAIR, despite looking like one:
--   *_N2_SIM  feeds tu-154/engines/flight_idle, read by engine_gauges.lua as
--             idle_rpm and compared against RAW sim N2. It sets the idle N1
--             reference (li1..li3 -> cturb1..3) and the needle-jitter band, so
--             it is a physics tuning value that cannot be set from the desk.
--             Both airborne values are still the single 72 used before the
--             stop was split: T3 records the raw sim N2 at each stop to
--             replace them.
--   *_N2_DISP feeds tu-154/engines/flight_idle_rpm, which nothing consumes but
--             the debug inspector. It is a documented-value readout: 60.5 on
--             the ground (the FM 59.5...61.5 midpoint), MG from 60.5 at sea
--             level to 78.0 at 11 km, and 82.0 for 0.42 nominal (81.0...83.5).
local GROUND_IDLE_N2_SIM = 68
local MG_IDLE_N2_SIM, PMG_IDLE_N2_SIM = 72, 72   -- PLACEHOLDERS until test card T3
local GROUND_IDLE_N2_DISP, PMG_IDLE_N2_DISP = 60.5, 82.0
local MG_IDLE_N2_DISP_SL, MG_IDLE_N2_DISP_11K = 60.5, 78.0
local IDLE_BLEND_RATE = 0.2  -- ~5 s to move between the regimes

local thro_1_pos, thro_2_pos, thro_3_pos = 0, 0, 0
local thro_1_pos_ENG, thro_3_pos_ENG = 0, 0
local rev_L_pos, rev_R_pos = 0, 0

local joy_pos_last_1 = get(tro_comm_1)
local joy_pos_last_2 = get(tro_comm_2)
local joy_pos_last_3 = get(tro_comm_3)

local idle_blend = get(onground) == 1 and 0 or 1

local virtual_rud_1, virtual_rud_2, virtual_rud_3 = 0.02, 0.02, 0.02
local virtual_rud_1_act, virtual_rud_2_act, virtual_rud_3_act = 0.02, 0.02, 0.02

local joy_rud_pos_1 = get(tro_comm_1)
local joy_rud_pos_2 = get(tro_comm_2)
local joy_rud_pos_3 = get(tro_comm_3)

rev_comm = findCommand("sim/engines/thrust_reverse_toggle")
function rev_comm_hnd(phase)
	if 0 == phase then set(throttle_ratio_all, 0) end
	return 0
end
registerCommandHandler(rev_comm, 0, rev_comm_hnd)

function update()
	local passed = get(frame_time)
	local stop_lever = get(throttle_lock) 

	-- Barometric altitude. MOVED UP 2026-09-10: the idle-stop schedule below
	-- needs alt_blend, and it used to be computed further down - which left
	-- alt_blend nil at that point and threw on every frame.
	-- CHANGED for XP12: the pressure now arrives in Pascals, converted to inHg
	-- 1 inHg = 3386.389 Pa
	local baro_inhg = get(baro_press_pas) / 3386.389
	-- barometric altitude in metres (msl_alt is already in metres in XP12)
	local alt_baro = get(msl_alt) + (29.92 - baro_inhg) * 304.8
	-- line() extrapolates without limit, so clamp the blend argument to the
	-- 0..11000 m band the two schedules below are actually defined over
	local alt_blend = math.max(0, math.min(11000, alt_baro))
	
	-- Idle stop selection. Airborne the stop rises to flight idle (MG),
	-- scheduled with altitude. Only when tu-154/tune/pmg_gate is 1 and the
	-- flaps are past PMG_FLAP_RATIO does it rise further, to the configuration
	-- stop (PMG). Before 2026-09-10 the PMG value applied for
	-- the whole flight, which left about 7400 kgf of residual thrust at 6 km and
	-- made it impossible to decelerate below roughly 460 km/h indicated.
	-- NB: the local must NOT be called flight_idle - that is the property
	-- defined above, and a local of the same name would shadow it.
	local idle_11k = math.max(GROUND_IDLE_OUT, math.min(1, get(tune_idle_11k)))
	local flight_idle_stop = line(alt_blend, 0, FLIGHT_IDLE_OUT_SL, 11000, idle_11k)
	-- the flap-gated stop is off unless tu-154/tune/pmg_gate is 1 (see the
	-- idle-stop block above: the manuals describe no such stop)
	local pmg_config = get(tune_pmg_gate) == 1 and get(flap_ratio) > PMG_FLAP_RATIO
	local airborne_stop = flight_idle_stop
	if pmg_config then airborne_stop = APPROACH_IDLE_OUT end
	
	local idle_target = get(onground) == 1 and 0 or 1
	idle_blend = idle_blend + (idle_target - idle_blend) * math.min(1, passed * IDLE_BLEND_RATE)
	local idle_out = GROUND_IDLE_OUT + (airborne_stop - GROUND_IDLE_OUT) * idle_blend
	
	local rev_L = get(eng_modL) == 3
	local rev_R = get(eng_modR) == 3
	
	local joy_rud_MAX_1, joy_rud_MIN_1 = 1, 0.02
	local joy_rud_MAX_2, joy_rud_MIN_2 = 1, 0.02
	local joy_rud_MAX_3, joy_rud_MIN_3 = 1, 0.02

	-- Thrust-with-altitude coefficient for the D-30KU-154, used only to scale
	-- acf_tmax. Flight Manual Table 8.1.2 (H=11 km M=0.8): takeoff setting,
	-- HP 95.5-97.5%. X-Plane models the ~35-40% thrust lapse to 11 km itself,
	-- so only a small cruise correction is left.
	local height_coef = line(alt_blend, 0, 1, 11000, 1.05)

	if get(comsta0) == 6 then joy_rud_MAX_1, joy_rud_MIN_1 = 0.05, 0 end
	if get(comsta1) == 6 then joy_rud_MAX_2, joy_rud_MIN_2 = 0.05, 0 end
	if get(comsta2) == 6 then joy_rud_MAX_3, joy_rud_MIN_3 = 0.05, 0 end

	local rud_spd_1, rud_spd_2, rud_spd_3 = get(rud_1_spd), get(rud_2_spd), get(rud_3_spd)
	local joy_pos_1, joy_pos_2, joy_pos_3 = get(tro_comm_1), get(tro_comm_2), get(tro_comm_3)
	
	-- Take controls of RUDs
	if rud_spd_1 ~= 0 then joy_rud_pos_1 = joy_rud_pos_1 + rud_spd_1 * passed
	elseif math.abs(joy_pos_1 - joy_pos_last_1) > 0.001 then joy_rud_pos_1 = joy_pos_1 end
	
	if rud_spd_2 ~= 0 then joy_rud_pos_2 = joy_rud_pos_2 + rud_spd_2 * passed
	elseif math.abs(joy_pos_2 - joy_pos_last_2) > 0.001 then joy_rud_pos_2 = joy_pos_2 end
	
	if rud_spd_3 ~= 0 then joy_rud_pos_3 = joy_rud_pos_3 + rud_spd_3 * passed
	elseif math.abs(joy_pos_3 - joy_pos_last_3) > 0.001 then joy_rud_pos_3 = joy_pos_3 end
	
	if math.abs(joy_pos_last_1 - joy_pos_1) > 0.001 then joy_pos_last_1 = joy_pos_1 end
	if math.abs(joy_pos_last_2 - joy_pos_2) > 0.001 then joy_pos_last_2 = joy_pos_2 end
	if math.abs(joy_pos_last_3 - joy_pos_3) > 0.001 then joy_pos_last_3 = joy_pos_3 end

	joy_rud_pos_1 = math.max(0, math.min(1, joy_rud_pos_1))
	joy_rud_pos_2 = math.max(0, math.min(1, joy_rud_pos_2))
	joy_rud_pos_3 = math.max(0, math.min(1, joy_rud_pos_3))
	
	if stop_lever < 0.2 then
		-- Engine 1 logic
		if rev_L then
			thro_1_pos = 0
			thro_1_pos_ENG = -interpolate(reverse_table, joy_rud_pos_1) * 0.4
			rev_L_pos = -thro_1_pos_ENG * 2.5
			virtual_rud_1 = joy_rud_MIN_1 + (joy_rud_MAX_1 - joy_rud_MIN_1) * interpolate(reverse_table, joy_rud_pos_1)
		else
			thro_1_pos, thro_1_pos_ENG, rev_L_pos = joy_rud_pos_1, joy_rud_pos_1, 0
			virtual_rud_1 = joy_rud_MIN_1 + (joy_rud_MAX_1 - joy_rud_MIN_1) * math.max(idle_out, interpolate(forward_table, joy_rud_pos_1))
		end

		-- Engine 2 logic
		-- Per the Tu-154M Flight Manual: engine No.2 (the tail, centre engine) HAS NO REVERSER
		-- When the reversers of engines No.1 and No.3 are deployed, engine No.2 goes to idle
		if rev_L or rev_R then
			thro_2_pos = 0
			-- idle for engine No.2 while the others are in reverse.
			-- (was interpolate(forward_table, joy_rud_MIN_2) - joy_rud_MIN is a scale
			--  offset, not a lever position, and only landed near idle by coincidence)
			virtual_rud_2 = joy_rud_MIN_2 + (joy_rud_MAX_2 - joy_rud_MIN_2) * idle_out
		else
			thro_2_pos = joy_rud_pos_2
			virtual_rud_2 = joy_rud_MIN_2 + (joy_rud_MAX_2 - joy_rud_MIN_2) * math.max(idle_out, interpolate(forward_table, joy_rud_pos_2))
		end

		-- Engine 3 logic
		if rev_R then
			thro_3_pos = 0
			thro_3_pos_ENG = -interpolate(reverse_table, joy_rud_pos_3) * 0.4
			rev_R_pos = -thro_3_pos_ENG * 2.5
			virtual_rud_3 = joy_rud_MIN_3 + (joy_rud_MAX_3 - joy_rud_MIN_3) * interpolate(reverse_table, joy_rud_pos_3)
		else
			thro_3_pos, thro_3_pos_ENG, rev_R_pos = joy_rud_pos_3, joy_rud_pos_3, 0
			virtual_rud_3 = joy_rud_MIN_3 + (joy_rud_MAX_3 - joy_rud_MIN_3) * math.max(idle_out, interpolate(forward_table, joy_rud_pos_3))
		end
	end
	
	---------------------------------------------------------
	-- Lever / fuel-control lag. This stage is the one the "No Delay" edit
	-- removed; X-Plane's own acf_spooltime_jet filter cannot stand in for it,
	-- because override_throttles bypasses that filter entirely.
	---------------------------------------------------------
	local rud_rate = math.max(RUD_RATE_MIN, math.min(RUD_RATE_MAX,
	                          interpolate(rud_T_tbl, get(outside_air_temp))))
	virtual_rud_1_act = rud_lag(virtual_rud_1_act, virtual_rud_1, rud_rate, passed)
	virtual_rud_2_act = rud_lag(virtual_rud_2_act, virtual_rud_2, rud_rate, passed)
	virtual_rud_3_act = rud_lag(virtual_rud_3_act, virtual_rud_3, rud_rate, passed)
	---------------------------------------------------------
	
	-- The zero-point offset was removed for XP12 on 2026-09-10. Tables 8.1.1 and
	-- 8.1.2 give the SAME N2 for every regime above idle at sea level and at
	-- 11 km, so lever-to-regime must not shift with height. The old offset of
	-- 0.35 pushed the WHOLE range up: with the throttles fully back it sent 0.554
	-- to X-Plane at 6 km and 0.665 at 11 km - over half travel, at the idle stop.
	-- That is why idle thrust barely lapsed with altitude. The 1.1 slope is kept:
	-- takeoff N2 does rise slightly with height (94.5...96.0 -> 95.5...97.5).
	-- The offset moves EVERY lever position at altitude, not only idle: at
	-- 11 km the nominal detent sent 0.954 with 0.35 and sends 0.886 with 0.
	-- It is read from tu-154/tune/thro_alt_offset so test card T4 can fly both
	-- against Table 8.1.2 (nominal N2 93.0...95.0 %).
	local thro_offset = get(tune_offset)
	local thro_high_1 = line(virtual_rud_1_act, 0, thro_offset, 1, 1.1)
	local thro_high_2 = line(virtual_rud_2_act, 0, thro_offset, 1, 1.1)
	local thro_high_3 = line(virtual_rud_3_act, 0, thro_offset, 1, 1.1)
	
	local thro_1 = line(alt_blend, 0, virtual_rud_1_act, 11000, thro_high_1)
	local thro_2 = line(alt_blend, 0, virtual_rud_2_act, 11000, thro_high_2)
	local thro_3 = line(alt_blend, 0, virtual_rud_3_act, 11000, thro_high_3)
	
	local MASTER = get(ismaster) ~= 1	

	if MASTER then	
		set(anim_rud1, thro_1_pos)
		set(anim_rud2, thro_2_pos)
		set(anim_rud3, thro_3_pos)

		set(anim_rud1_ENG, thro_1_pos_ENG)
		set(anim_rud2_ENG, thro_2_pos)
		set(anim_rud3_ENG, thro_3_pos_ENG)
		
		set(throttle_lock, stop_lever)
		set(revers_L, rev_L_pos)
		set(revers_R, rev_R_pos)
		
		set(sim_rud_1, thro_1)
		set(sim_rud_2, thro_2)
		set(sim_rud_3, thro_3)
	end
	
	-- idle references for the gauges - derived from onground, the flap gate and
	-- altitude only, so both SmartCopilot sides compute the same value and it
	-- needs no sync entry. Airborne they follow the stop in use.
	local air_n2_sim = pmg_config and PMG_IDLE_N2_SIM or MG_IDLE_N2_SIM
	local air_n2_disp = pmg_config and PMG_IDLE_N2_DISP
		or line(alt_blend, 0, MG_IDLE_N2_DISP_SL, 11000, MG_IDLE_N2_DISP_11K)
	set(flight_idle,     GROUND_IDLE_N2_SIM  + (air_n2_sim  - GROUND_IDLE_N2_SIM)  * idle_blend)
	set(flight_idle_rpm, GROUND_IDLE_N2_DISP + (air_n2_disp - GROUND_IDLE_N2_DISP) * idle_blend)

	-- which stop applies, for the inspector's ABSU tab and the test cards
	local stop_mode = 1
	if get(onground) == 1 then stop_mode = 0 elseif pmg_config then stop_mode = 2 end
	set(idle_stop, idle_out)
	set(idle_stop_mode, stop_mode)

	set(rev_fail, 6) 
	set(rev_fail_2, 6)
	-- Rated takeoff thrust: 10 500 kgf = 102 970 N per engine, ISA SL, static,
	-- quoted +/-1 % (engine RE 59-00-800RE, 072.00.00 sect.5.9.1.1, p.17).
	--
	-- XP12 does not deliver what it is commanded. MEASURED at UUEE, field 628 ft,
	-- OAT 13 C, QNH 1013 (density ratio 0.984): acf_tmax of 108 159 N at the
	-- takeoff detent produced 95 180 N of thrust, so the model returns
	--     delivered / (commanded x density) = 0.894
	-- The 1.118 below is 1/0.894 and exists only to cancel that loss.
	--
	-- It is measured, not derived, and the direction matters: the previous
	-- "10800 kgf + 2 %" left the aircraft 7.6 % DOWN on its rating. Comparing
	-- the constants alone suggested the opposite (that 10 800 overstated 10 500),
	-- which is why this has to be set from a static thrust reading and never
	-- from arithmetic on the rating.
	--
	-- To re-derive after an engine-model or XP version change:
	--   K = commanded_N x density_ratio / delivered_N
	-- Read commanded/delivered on the debug inspector Eng tab, brakes set,
	-- bleeds and anti-ice OFF, at the takeoff detent.
	set(acf_tmax, 102970 * 1.118 * height_coef)  -- ~115 140 N at ISA SL
end

function onModuleDone()
	set(override, 0)
	print("throttles released")
end
