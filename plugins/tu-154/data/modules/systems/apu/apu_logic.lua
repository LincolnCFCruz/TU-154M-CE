-- apu_logic.lua - the TA-6A APU for the Tu-154M
-- Full implementation per the Tu-154M Flight Manual subsection 8.2
-- ============================================================
-- Flight Manual 8.2.1 - TA-6A operating limits:
--   Time to reach idle (ground): normal 32-37 s, max 40 s
--   Time to reach idle (in flight): max 60 s
--   Idle rpm:                             normal 98%, max 100%
--   Rpm overshoot at start:                up to 103%, falling to 99+/-1 in 3 s
--   EGT at start:                          max 680 C (auto shutdown), no more than 700 C
--   EGT under load:                        max 550 C
--   Rpm under load (ground):               normal 97-101%, max 103%
--   Rpm under load (>3000 m):              max 103.5%
--   "REACHING RATED MODE" annunciator:     lights at 90%
--   Bleed air permitted at:                RPM >= 92%
--   Cold cranking:                         19-23%, up to 32 s
--   Runout 30%->10%:                       14 s
--   Start altitude:                        up to 3000 m
--   Operating altitude:                    up to 9000 m
--   Speed with the APU running:            up to 575 km/h
--   Speed band for an in-flight start:     400-575 km/h
--   Start with an oil temperature below -25 C: PROHIBITED
--   Oil temperature in the oil tank:       max 115 C
--   Warm-up before load:                   1 min at idle
-- ============================================================
-- Flight Manual 8.2.1(2) - Start attempts:
--   From a ground source: max 7 attempts
--     interval between attempts 1-5: min 1 min
--     interval after the 5th attempt:  min 15 min
--     interval after the 6th attempt:  min 1 min
--     after the 7th: starter cooling of at least 2 hours
--   From the batteries: max 3 attempts, 3 min interval
-- ============================================================

-- controls
defineProperty("apu_main_switch", globalPropertyi("tu-154/switchers/eng/apu_main_switch"))
defineProperty("apu_start_mode",  globalPropertyi("tu-154/switchers/eng/apu_start_mode"))
defineProperty("apu_air_bleed",   globalPropertyi("tu-154/switchers/eng/apu_air_bleed"))
defineProperty("apu_start",       globalPropertyi("tu-154/buttons/eng/apu_start"))
defineProperty("apu_stop",        globalPropertyi("tu-154/buttons/eng/apu_stop"))

-- internal DataRefs
defineProperty("apu_n1",     globalPropertyf("tu-154/eng/apu_n1"))
defineProperty("apu_oil_t",  globalPropertyf("tu-154/eng/apu_oil_t"))
defineProperty("apu_oil_q",  globalPropertyf("tu-154/eng/apu_oil_q"))
defineProperty("apu_oil_p",  globalPropertyf("tu-154/eng/apu_oil_p"))
defineProperty("apu_egt",    globalPropertyf("tu-154/eng/apu_egt"))

defineProperty("bus27_volt_left",  globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))
defineProperty("gen4_amp_bus",     globalPropertyf("tu-154/elec/gen4_amp"))

defineProperty("apu_system_on",  globalPropertyi("tu-154/eng/apu_system_on"))
defineProperty("apu_fuel_last",  globalPropertyf("tu-154/eng/apu_fuel_last"))
defineProperty("tank1_w",        globalProperty("sim/flightmodel/weight/m_fuel[0]"))

-- results
defineProperty("apu_air_press",    globalPropertyf("tu-154/eng/apu_air_press"))
defineProperty("apu_air_doors",    globalPropertyf("tu-154/eng/apu_air_doors"))
defineProperty("apu_fuel_p",       globalPropertyf("tu-154/eng/apu_fuel_p"))
defineProperty("apu_start_bus",    globalPropertyf("tu-154/elec/apu_start_bus"))
defineProperty("apu_start_cc",     globalPropertyf("tu-154/elec/apu_start_cc"))
defineProperty("apu_start_seq",    globalPropertyi("tu-154/elec/apu_start_seq"))
defineProperty("fuel_pumps_27_cc", globalPropertyf("tu-154/elec/fuel_pumps_27_cc"))
defineProperty("apu_doors",        globalPropertyf("tu-154/anim/apu_doors"))
defineProperty("apu_burn_fuel",    globalPropertyf("tu-154/elec/apu_burning_fuel"))
-- warm-up: ready-for-load flag (1 = warmed up)
defineProperty("apu_ready",        globalPropertyi("tu-154/eng/apu_ready"))
-- start phase for the indication (0=none, 1=starter, 2=combustion, 3=overshoot, 4=running)
defineProperty("apu_start_phase",  globalPropertyi("tu-154/eng/apu_start_phase"))
-- interval timer (for display to the crew)
defineProperty("apu_cooldown",     globalPropertyf("tu-154/eng/apu_cooldown"))

-- sim APU datarefs - for maintaining the bleed air pressure
-- XP12 maintains the pressure itself when bleed_air_mode=4 and the APU is running
defineProperty("APU_starter_switch",globalPropertyi("sim/cockpit2/electrical/APU_starter_switch"))
defineProperty("APU_N1_percent",    globalPropertyf("sim/cockpit2/electrical/APU_N1_percent"))
defineProperty("APU_running",       globalPropertyi("sim/cockpit2/electrical/APU_running"))
-- sim/aircraft/overflow/acf_has_APU_switch does not exist in XP12. The "aircraft has
-- an APU" flag now lives in tu154.acf (acf/_has_APU_switch 1), so there is nothing
-- to write here and the binding only produced a findDataRef warning.
defineProperty("rel_APU_press",     globalPropertyi("sim/operation/failures/rel_APU_press"))
defineProperty("bleed_air_mode",    globalPropertyi("sim/cockpit2/pressurization/actuators/bleed_air_mode"))
defineProperty("rpm_high_2",     globalPropertyf("tu-154/gauges/engine/rpm_high_2"))
defineProperty("eng_airvalve_2", globalPropertyf("tu-154/bleed/eng_airvalve_2"))

-- time / sim
defineProperty("frame_time",       globalPropertyf("tu-154/time/frame_time"))
defineProperty("outside_air_temp", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc"))
defineProperty("msl_alt",          globalPropertyf("sim/flightmodel/position/elevation"))
defineProperty("baro_press",       globalPropertyf("sim/weather/region/sealevel_pressure_pas"))
defineProperty("indicated_airspeed", globalPropertyf("sim/flightmodel/position/indicated_airspeed")) -- knots indicated air speed
defineProperty("on_ground",        globalPropertyi("sim/flightmodel/failures/onground_any"))

-- the ground heater (apu_heater.lua) owns the oil temperature while it is
-- running; this module must not pull the oil back towards ambient underneath it
defineProperty("heater_active",    globalPropertyi("tu-154/apu_heater/active"))

-- Smart Copilot
defineProperty("ismaster",     globalPropertyf("scp/api/ismaster"))
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1"))

-- failures
defineProperty("apu_start_fail",     globalPropertyi("tu-154/failures/apu_start_fail"))
defineProperty("apu_gen_fail",       globalPropertyi("tu-154/failures/apu_gen_fail"))
defineProperty("apu_runtime",        globalPropertyf("tu-154/failures/apu_runtime"))
defineProperty("apu_fail_oilt",      globalPropertyi("tu-154/failures/apu_fail_oilt"))
defineProperty("apu_fail_egt",       globalPropertyi("tu-154/failures/apu_fail_egt"))
defineProperty("apu_fail_fuel_left", globalPropertyi("tu-154/failures/apu_fail_fuel_left"))
defineProperty("apu_fail",           globalPropertyi("tu-154/failures/apu_fail"))
defineProperty("apu_press_fail",     globalPropertyi("tu-154/failures/apu_press_fail"))
defineProperty("failures_enabled",   globalPropertyi("tu-154/failures/failures_enabled"))
defineProperty("apu_apd_working",    globalPropertyi("tu-154/elec/apu_apd_working"))
defineProperty("apd_working_1",      globalPropertyf("tu-154/start/apd_working_1"))
defineProperty("apd_working_2",      globalPropertyf("tu-154/start/apd_working_2"))
defineProperty("apd_working_3",      globalPropertyf("tu-154/start/apd_working_3"))
defineProperty("eng4_ext",           globalPropertyi("tu-154/fire/apu_ext_used"))

set(apu_runtime, math.random(280, 320) * 3600)

-- oil dataref initialisation when the script loads
-- without this oil_q = 0 at simulator start -> pressure = 0 -> the lamp lights
if get(apu_oil_q) <= 0 then
    set(apu_oil_q, 1.0)
end

-- ============================================================
-- CONSTANTS per Flight Manual 8.2.1
-- ============================================================
local RPM_COLD_MAX   = 23    -- cold cranking maximum, %
local RPM_IGNITE     = 18    -- minimum RPM for ignition
local RPM_MODE_LAMP  = 90    -- REACHING RATED MODE annunciator
local RPM_BLEED      = 92    -- bleed air permission
local RPM_IDLE_NOM   = 98    -- nominal idle rpm
local RPM_IDLE_MAX   = 100   -- idle maximum
local RPM_LOAD_MAX   = 103   -- maximum under load
local EGT_START_MAX  = 680   -- auto shutdown during the start
local EGT_LOAD_MAX   = 550   -- max under load
local EGT_LOAD_STOP  = 570   -- auto shutdown under load
local TIME_START_GND = 40    -- max start time, on the ground
local TIME_START_AIR = 60    -- max start time, in the air
local TIME_WARMUP    = 60    -- warm-up before load (s)
local OIL_T_MIN      = -25   -- minimum oil temperature for a start
local OIL_T_MAX      = 115   -- maximum oil temperature
local ALT_MAX        = 3000  -- maximum start altitude, m
local ALT_MAX_OPER   = 9000  -- maximum operating altitude, m
local IAS_MAX_OPER   = 575   -- maximum speed with the APU running, km/h
local IAS_START_MIN  = 400   -- minimum speed for an in-flight start, km/h
local IAS_START_MAX  = 575   -- maximum speed for an in-flight start, km/h

-- ============================================================
-- STATE
-- ============================================================
local RPM             = 0
local oil_q           = 1
local apu_doors_pos   = get(apu_doors)
local bleed_doors_pos = get(apu_air_doors)
local burning         = 0
local starter_on      = 0
local fuel_last       = get(apu_fuel_last)
local egt             = get(outside_air_temp)
local apu_temp        = get(outside_air_temp)
local oil_temp        = get(outside_air_temp)
local eng2_corr       = 0
local oil_overheat_t  = 0
local minus_timer     = 0
local false_bleed     = 0
local emerg_off       = 0

-- ============================================================
-- START STATE MACHINE
-- ============================================================
-- Phases:
--  0 = the APU is not active
--  1 = COLD CRANKING (mode_sw=2): starter without fuel, 19-23%
--  2 = STARTER: spool-up 0->18% (up to ignition)
--  3 = IGNITION: rise 18->90%
--  4 = OVERSHOOT: 90->103% and settling
--  5 = WARM-UP: RPM ~98%, wait 60 s before load (Flight Manual)
--  6 = RUNNING: the APU is ready for load
local phase          = 0
local start_timer    = 0    -- time in the current phase
local total_timer    = 0    -- total time since START was pressed
local overshoot_rpm  = 101  -- target rpm overshoot
local warmup_timer   = 0    -- warm-up timer (60 s)
local apu_is_ready   = 0    -- 1 = warmed up, ready for load

-- ============================================================
-- ATTEMPT COUNTER (Flight Manual 8.2.1(2))
-- ============================================================
local attempt_count    = 0
local cooldown_timer   = 0
local cooldown_req     = 0
local start_blocked    = false
local starter_hot_lock = false

-- ============================================================
-- PHYSICS TABLES
-- ============================================================

-- braking / runout (runout 30%->10% = 14 s per the Flight Manual)
local off_tbl = {
    { -500,  30   },
    {    0,   0   },
    {    3,  -2   },
    {    5,  -0.1 },
    {   10,  -0.15},
    {   20,  -0.8 },
    {   30,  -2.0 },
    {   40,  -3.5 },
    {   55,  -5.0 },
    {   60, -15.0 },
    {  100, -15.0 },
    { 1000,-100.0 },
}

-- starter: spools up 0->21% in 8-10 s
local starter_tbl = {
    { -500, 20   },
    {    0, 10   },
    {    3,  8   },
    {   15,  4   },
    {   20,  5   },
    {   23,  2.5 },
    {   30,  0   },
    { 1000,  0   },
}

-- fuel burn: calibrated for a 32-37 s time to reach the running mode
local fuel_tbl = {
    { -500,  0   },
    {    0,  0   },
    {   18,  0   },
    {   20,  1.5 },
    {   25,  4.0 },
    {   30,  6.0 },
    {   35,  8.0 },
    {   45, 12.0 },
    {   60, 20.0 },
    {   75, 24.0 },
    {   85, 26.0 },
    {   90, 30.0 },
    {   94, 20.0 },  -- deceleration after the overshoot
    {   96, 16.0 },
    {   98, 15.5 },  -- equilibrium: +15.5 -15.0 = +0.5 -> stabilisation at 98-100%
    {  100, 14.5 },  -- a slight excess -> it does not fall below 98%
    {  101, 10.0 },
    {  103, -8.0 },  -- settling of the overshoot
    {  106,-20.0 },
    { 1000,-20.0 },
}

-- coefficient from the oil temperature
local oil_tbl = {
    { -500,  10  },
    {  -30,   1.2},
    {    0,   1.1},
    {   30,   1.0},
    {  150,   0.9},
    { 1000,   0.7},
}

-- ============================================================
-- HELPER FUNCTION: start the interval timer
-- ============================================================
-- count_attempt=false books only the interval between starter runs, without
-- charging a failed start attempt: a cold crank that ran to its normal 32 s
-- loads the starter but is not a start that failed.
local function start_cooldown(ground, count_attempt)
    if count_attempt ~= false then
        attempt_count = attempt_count + 1
    end
    if ground then
        if attempt_count >= 7 then
            starter_hot_lock = true
            cooldown_req     = 7200   -- 2 hours of starter cooling
        elseif attempt_count == 5 then
            cooldown_req = 900        -- 15 min after the 5th
        elseif attempt_count == 6 then
            cooldown_req = 60         -- 1 min after the 6th
        else
            cooldown_req = 60         -- 1 min between attempts 1-5
        end
    else
        if attempt_count >= 3 then
            starter_hot_lock = true
            cooldown_req     = 7200
        else
            cooldown_req = 180        -- 3 min from the batteries
        end
    end
    cooldown_timer = cooldown_req
    start_blocked  = (cooldown_req > 0)
end

-- ============================================================
-- UPDATE FUNCTION
-- ============================================================
function update()
    local passed = get(frame_time)
    if passed <= 0 or passed > 0.5 then return end

    RPM            = get(apu_n1)
    oil_q          = math.max(0.01, get(apu_oil_q))  -- protection against an uninitialised dataref
    oil_temp       = get(apu_oil_t)
    apu_doors_pos  = get(apu_doors)
    bleed_doors_pos= get(apu_air_doors)
    burning        = get(apu_burn_fuel)
    egt            = get(apu_egt)

    local MASTER = get(ismaster) ~= 1
    if not MASTER then return end

    local fail_fuel  = get(apu_fail_fuel_left)
    local fail_egt   = get(apu_fail_egt)
    local fail_oilt  = get(apu_fail_oilt)
    local fail_gen   = get(apu_fail)
    local fail_start = get(apu_start_fail)

    local mode_sw    = get(apu_start_mode)
    local main_sw    = get(apu_main_switch)
    local power      = get(apu_start_bus)
    local bus_L      = get(bus27_volt_left)
    local bus_R      = get(bus27_volt_right)
    local out_temp   = get(outside_air_temp)

    local system_on  = (bus_R > 13 and main_sw == 1) and 1 or 0
    local has_fuel   = get(tank1_w) > 150 and 1 or 0
    local ground_pwr = bus_L > 25 or bus_R > 25

    -- altitude and speed, for the start gate and the operating limits below.
    -- real_alt is pressure altitude: the physical MSL height corrected for the
    -- deviation of the regional QNH from the standard 29.92 inHg.
    -- The QNH is sanity-checked first: sealevel_pressure_pas reads 0 before the
    -- weather is initialised, and 0 Pa turns the correction into +9120 m, which
    -- would block every start and trip the operating ceiling on the ground.
    local baro_pa = get(baro_press)
    if baro_pa < 80000 or baro_pa > 120000 then baro_pa = 101325 end
    local baro_inhg  = baro_pa / 3386.389
    local real_alt   = get(msl_alt) + (29.92 - baro_inhg) * 304.8
    local ias_kmh    = get(indicated_airspeed) * 1.852
    local on_grnd    = get(on_ground) == 1
    -- an in-flight start is permitted only inside the 400-575 km/h band
    local speed_ok_to_start = on_grnd
        or (ias_kmh >= IAS_START_MIN and ias_kmh <= IAS_START_MAX)

    -- -------------------------------------------------------
    -- INTERVAL TIMER BETWEEN STARTS
    -- -------------------------------------------------------
    if cooldown_timer > 0 then
        cooldown_timer = cooldown_timer - passed
        if cooldown_timer <= 0 then
            cooldown_timer = 0
            if not starter_hot_lock then
                start_blocked = false
            end
        end
    end

    -- unlocking the hot starter after cooling.
    -- The cooldown timer must have run out as well as the body having cooled:
    -- repeated dry cranking never warms the APU body, so a thermal test on its
    -- own would release the 2 h starter lock in exactly the case it exists for.
    if starter_hot_lock and cooldown_timer <= 0
        and math.abs(apu_temp - out_temp) < 15 and RPM < 1 then
        starter_hot_lock = false
        start_blocked    = false
        cooldown_timer   = 0
        attempt_count    = 0
    end

    -- -------------------------------------------------------
    -- APU DOORS (external)
    -- -------------------------------------------------------
    apu_doors_pos = apu_doors_pos + bus_L * (system_on * 2 - 1) * passed / 81
    apu_doors_pos = math.max(0, math.min(1, apu_doors_pos))

    -- -------------------------------------------------------
    -- BLEED AIR DOORS
    -- per the Flight Manual: bleed air is permitted at RPM >= 92%
    -- toggle: +1=open, 0=neutral, -1=close (as in the original script)
    if bus_R > 13 and RPM >= RPM_BLEED and get(apu_press_fail) == 0 then
        bleed_doors_pos = bleed_doors_pos + get(apu_air_bleed) * passed * 0.2
    elseif bus_R > 13 then
        -- RPM < 92% - force it closed
        bleed_doors_pos = bleed_doors_pos - passed * 0.2
    end
    bleed_doors_pos = math.max(0, math.min(1, bleed_doors_pos))

    -- AIR PRESSURE for the engine start
    -- builds while the doors are open and the APU is at its running mode
    local air_press = get(apu_air_press)
    if bleed_doors_pos > 0.5 and RPM >= RPM_BLEED then
        air_press = math.min(3.8, air_press + passed * 1.5)
    else
        air_press = math.max(0, air_press - passed * 2.0)
    end
    set(apu_air_press, air_press)

    -- -------------------------------------------------------
    -- FUEL PRESSURE
    -- -------------------------------------------------------
    local fuel_press  = get(apu_fuel_p)
    local fuel_current= 0
    -- fuel is supplied when the START selector = 1 or a start is active
    if (mode_sw == 1 or phase >= 2) and system_on == 1 and power > 13 and has_fuel == 1 then
        fuel_press   = math.min(1, fuel_press + passed * 2)
        fuel_current = 15
    else
        fuel_press   = math.max(0, fuel_press - passed * 2)
        fuel_current = 0
    end

    -- -------------------------------------------------------
    -- STATE MACHINE
    -- -------------------------------------------------------

    -- *** PHASE 0: the APU is not active ***
    if phase == 0 then
        starter_on = 0
        burning    = 0

        -- START BUTTON (the selector in the START position = mode_sw=1)
        -- emerg_off latches an automatic shutdown: the crew must press STOP to
        -- acknowledge it before another start is accepted, so a start attempt
        -- cannot silently crank with the fuel still suppressed.
        if power > 13 and system_on == 1 and get(apu_start) == 1
            and apu_doors_pos > 0.9 and oil_temp >= OIL_T_MIN
            and not start_blocked and not starter_hot_lock
            and emerg_off == 0
            and real_alt <= ALT_MAX and speed_ok_to_start
            and mode_sw == 1 then
            phase         = 2
            start_timer   = 0
            total_timer   = 0
            overshoot_rpm = 99 + math.random() * 4
            emerg_off     = 0
            apu_is_ready  = 0
            warmup_timer  = 0
        end

        -- COLD CRANKING (the selector at COLD CRANK = mode_sw=2)
        -- per Flight Manual 8.2.1(5): rpm 19-23%, time up to 32 s, without fuel
        if power > 13 and system_on == 1 and get(apu_start) == 1
            and apu_doors_pos > 0.9 and mode_sw == 2
            and not start_blocked and not starter_hot_lock then
            phase       = 1
            start_timer = 0
        end

    -- *** PHASE 1: COLD CRANKING ***
    elseif phase == 1 then
        starter_on = 1
        burning    = 0

        start_timer = start_timer + passed

        -- rpm limit (Flight Manual: 19-23%)
        -- off_tbl at 23% gives braking - the starter holds it in range

        -- shutdown on time (max 32 s per the Flight Manual) or the STOP button
        if start_timer >= 32 or get(apu_stop) == 1 or power < 5 then
            phase      = 0
            starter_on = 0
            -- a cold crank is not a start attempt: it takes the interval
            -- between starter runs but does not count towards the 7-attempt limit
            start_cooldown(ground_pwr, false)
        end

    -- *** PHASE 2: STARTER SPOOL-UP (0->18%) ***
    elseif phase == 2 then
        starter_on = (fail_start == 0 and fail_gen == 0) and 1 or 0
        burning    = 0

        start_timer  = start_timer  + passed
        total_timer  = total_timer  + passed

        -- transition to ignition above RPM > 18%
        if RPM >= RPM_IGNITE and fuel_press > 0.3
            and fail_fuel == 0 and fail_egt == 0 then
            phase       = 3
            start_timer = 0
            burning     = 1
        end

        -- emergency shutdown: no ignition within 32 s (the starter has finished)
        if start_timer >= 32 then
            phase      = 0
            starter_on = 0
            burning    = 0
            start_cooldown(ground_pwr)
        end

    -- *** PHASE 3: COMBUSTION + SPOOL-UP (18->90%) ***
    elseif phase == 3 then
        -- the starter runs while RPM < 45% or less than 32 s have passed since the start began
        starter_on = (total_timer < 32 and RPM < 45
                      and fail_start == 0 and fail_gen == 0) and 1 or 0
        burning    = (fail_fuel == 0 and fail_egt == 0 and fail_gen == 0) and 1 or 0

        start_timer = start_timer + passed
        total_timer = total_timer + passed

        -- transition to the overshoot at RPM >= 90%
        if RPM >= RPM_MODE_LAMP then
            phase       = 4
            start_timer = 0
        end

        -- time check: the running mode was not reached within TIME_START_GND/AIR seconds
        local time_limit = get(msl_alt) > 100 and TIME_START_AIR or TIME_START_GND
        if total_timer > time_limit then
            -- per Flight Manual 8.2.3(I): press STOP if the running mode is not reached
            phase      = 0
            starter_on = 0
            burning    = 0
            start_cooldown(ground_pwr)
        end

    -- *** PHASE 4: RPM OVERSHOOT (90->103% and settling to 98%) ***
    elseif phase == 4 then
        starter_on = 0
        burning    = (fail_fuel == 0 and fail_egt == 0 and fail_gen == 0) and 1 or 0

        start_timer = start_timer + passed

        -- the overshoot reached its target - move on to the warm-up
        -- or if the overshoot has not been reached within 10 s - move on anyway
        if RPM >= overshoot_rpm or start_timer > 10 then
            phase       = 5
            start_timer = 0
            warmup_timer= 0
        end

    -- *** PHASE 5: WARM-UP (1 min at idle per the Flight Manual) ***
    elseif phase == 5 then
        starter_on   = 0
        burning      = (fail_fuel == 0 and fail_egt == 0 and fail_gen == 0) and 1 or 0
        warmup_timer = warmup_timer + passed

        -- the warm-up is complete -> the APU is ready for load
        if warmup_timer >= TIME_WARMUP then
            phase        = 6
            apu_is_ready = 1
        end

        -- FLIGHT MANUAL NOTE: in a difficult or emergency situation
        -- the load may be applied as soon as the REACHING RATED MODE annunciator lights
        -- (implemented via apu_panel.lua - the crew can override it)

    -- *** PHASE 6: RUNNING - THE APU IS READY FOR LOAD ***
    elseif phase == 6 then
        starter_on   = 0
        burning      = (fail_fuel == 0 and fail_egt == 0 and fail_gen == 0) and 1 or 0
        apu_is_ready = 1
    end

    -- -------------------------------------------------------
    -- FUEL STARVATION
    -- -------------------------------------------------------
    -- Once alight, the phases below set burning purely from the failure flags,
    -- so without this the APU would keep running on an empty tank 1 for ever.
    -- fuel_press is the faithful proxy: it is held up only while has_fuel is
    -- true, and decays at 2/s once tank 1 falls below the 150 kg usable mark.
    if phase >= 3 and fuel_press <= 0.3 then
        burning      = 0
        starter_on   = 0
        phase        = 0
        apu_is_ready = 0
    end

    -- -------------------------------------------------------
    -- EMERGENCY SHUTDOWN (Flight Manual 8.2.3)
    -- -------------------------------------------------------
    -- EGT during the start > 680 C
    if (phase >= 2 and phase <= 4) and egt > EGT_START_MAX then
        emerg_off = 1
    end
    -- EGT in operation > 570 C
    if (phase == 5 or phase == 6) and egt > EGT_LOAD_STOP then
        emerg_off = 1
    end
    -- rpm > 105%
    if RPM > 105 then emerg_off = 1 end

    if emerg_off == 1 then
        burning    = 0
        starter_on = 0
        if phase >= 2 then
            start_cooldown(ground_pwr)
        end
        phase        = 0
        apu_is_ready = 0
    end

    -- -------------------------------------------------------
    -- STOP BUTTON
    -- -------------------------------------------------------
    local eng_starting = get(apd_working_1) + get(apd_working_2) + get(apd_working_3) > 0
    if (get(apu_stop) == 1 and not eng_starting)
        or power < 5
        or get(eng4_ext) == 1 then
        burning    = 0
        starter_on = 0
        if phase >= 2 and phase <= 4 then
            -- a failed attempt - count it
            start_cooldown(ground_pwr)
        end
        phase        = 0
        apu_is_ready = 0
        emerg_off    = 0
    end

    -- reset of the emergency flag when the system is switched off
    if system_on == 0 then emerg_off = 0 end

    -- -------------------------------------------------------
    -- RPM PHYSICS
    -- -------------------------------------------------------
    local t_coef = interpolate(oil_tbl, oil_temp)
    local m_stop = (1 - fail_egt) * (1 - fail_oilt * 0.5)
    local m_fuel = (1 - fail_fuel) * (1 - fail_egt) * (1 - fail_gen)

    RPM = RPM + interpolate(off_tbl,     RPM) * t_coef * m_stop * passed * 0.8
    RPM = RPM + interpolate(starter_tbl, RPM) * starter_on       * passed * 0.8
    RPM = RPM + interpolate(fuel_tbl,    RPM) * burning * m_fuel * (1 - emerg_off) * passed * 0.8

    -- cold cranking limit (Flight Manual: 19-23%)
    if phase == 1 and RPM > RPM_COLD_MAX then
        RPM = RPM_COLD_MAX
    end

    -- flutter from the interaction with engine No.2
    local bleed_flutter = get(eng_airvalve_2) * get(rpm_high_2)
                          * bleed_doors_pos * (math.random(0, 100) - 51) * 0.00004
    false_bleed = false_bleed + (bleed_flutter - false_bleed) * passed * 0.5
    RPM = RPM * (false_bleed + 1)

    if RPM < 0 then RPM = 0 end

    -- starter current
    local start_cc = starter_on * 600 / (1 + math.max(RPM - 10, 0) / 5)

    -- -------------------------------------------------------
    -- EGT
    -- -------------------------------------------------------
    local egt_heat = (1000 - egt) * 0.1 * burning
        * (bleed_doors_pos * 0.25 + 1)
        * (get(gen4_amp_bus) * 0.0012 + 1)
    egt_heat = egt_heat - false_bleed * 2000

    local egt_cool = (egt - apu_temp) * (0.5 + ((RPM * 0.01) ^ 1.05) * 1.5) * 0.09

    -- per the Flight Manual: an EGT overshoot above 570 C during the start is permitted
    -- a delay of up to 10 s before the REACHING RATED MODE annunciator lights
    -- (implemented via phase - phase 3 continues up to 90%)

    if RPM > 5 then
        egt = egt + (egt_heat - egt_cool) * passed
    else
        egt = egt + (out_temp - egt) * passed * 0.001
    end

    -- -------------------------------------------------------
    -- APU CASING TEMPERATURE
    -- -------------------------------------------------------
    local body_heat = (egt * 0.5 - apu_temp) * 0.005 * (2 - math.abs(RPM) * 0.01)
    local body_cool = (apu_temp - out_temp) * (0.05 + 1.95 * (math.abs(RPM) * 0.01) ^ 0.5) * 0.001
    if RPM > 5 then
        apu_temp = apu_temp + (body_heat - body_cool) * passed / 10
    else
        apu_temp = apu_temp + (out_temp - apu_temp) * passed * 0.0005
    end

    -- correction from engine No.2.
    -- The rate constants are 60x their former values because eng2_corr used to
    -- be added to oil_temp once per FRAME rather than per second (see below),
    -- which made the warm-up time inversely proportional to the frame rate.
    -- These figures reproduce the previous behaviour at 60 fps, at any frame rate.
    if get(rpm_high_2) > 40 and oil_temp < 46 then
        eng2_corr = eng2_corr + 0.012 * math.abs(oil_temp) * passed
    elseif eng2_corr > 0 then
        eng2_corr = eng2_corr - 0.03 * passed
    end

    -- -------------------------------------------------------
    -- OIL TEMPERATURE (max 115 C per the Flight Manual)
    -- -------------------------------------------------------
    -- Skipped entirely while the ground heater is running: apu_heater.lua owns
    -- the oil temperature then. Without this the relaxation towards ambient
    -- (gain ~1.15/s) overwhelms the heater's 3 C/s and pins the oil to within
    -- ~2.6 C of OAT, so the heater could never clear the -25 C start gate.
    if get(heater_active) ~= 1 then
        local oil_heat = (apu_temp - oil_temp) * 0.55 * (1.2 - oil_q * 0.2) ^ 3
        local oil_cool = (oil_temp - out_temp) * 0.6
        oil_temp = oil_temp + (oil_heat - oil_cool) * passed + eng2_corr * passed
    end

    if oil_temp > OIL_T_MAX then
        oil_q = oil_q - passed * 0.0002
        oil_overheat_t = oil_overheat_t + passed
        if oil_overheat_t > 10 then
            if math.random(math.max(1, 255 - math.floor(oil_temp))) < 5 then
                set(apu_fail_oilt, 1)
            end
            oil_overheat_t = 0
        end
    end

    -- -------------------------------------------------------
    -- RESIDUAL FUEL IN THE CHAMBER
    -- -------------------------------------------------------
    if burning == 1 then fuel_last = 1.2 end
    fuel_last = fuel_last - (math.abs(RPM * 0.01) ^ 0.7) * 0.12 * passed
                          - burning * 0.1 * passed
    if fuel_last < 0 then fuel_last = 0 end

    -- Operating limits (Flight Manual 8.2.1). These apply to a *running* APU
    -- and are distinct from the 3000 m / 400-575 km/h gate on starting one,
    -- which is enforced in phase 0 above.
    if burning == 1 and (real_alt > ALT_MAX_OPER or ias_kmh > IAS_MAX_OPER) then
        burning   = 0
        fuel_last = fuel_last + 0.5
        if phase >= 2 then phase = 0; apu_is_ready = 0 end
    end
    set(apu_fuel_last, fuel_last)

    -- -------------------------------------------------------
    -- OPERATING TIME AND FAILURES
    -- -------------------------------------------------------
    if get(failures_enabled) > 0 then
        minus_timer = minus_timer + passed * RPM * 0.01
        if minus_timer >= 1 then
            minus_timer = 0
            set(apu_runtime, math.max(0, get(apu_runtime) - 1))
        end
    else
        -- apu_runtime is NOT reset here: it is persisted by core/save_state.lua,
        -- which restores it 2 s after load, and writing it every frame destroyed
        -- the restored value. The seed for a first-ever load is set at load time.
        set(apu_fail_fuel_left, 0)
        set(apu_fail_egt,       0)
        set(apu_fail_oilt,      0)
        set(apu_start_fail,     0)
    end

    -- -------------------------------------------------------
    -- SYNCHRONISATION WITH THE SIMULATOR APU
    -- XP12 maintains the bleed air pressure itself when:
    --   bleed_air_mode = 4 (APU) and APU_running = 1
    -- So our APU state is synchronised with the simulator
    -- -------------------------------------------------------
    set(rel_APU_press,      0)          -- APU pressure failure = none
    set(bleed_air_mode,     4)          -- bleed mode = APU
    -- APU_generator_on is NOT written here. systems/electrical/generators_logic.lua
    -- models generator 4 and is its sole owner; forcing it to 1 every frame from
    -- here (and from apu_panel) made that module's set(sim_gen4_on, 0) dead code,
    -- so the sim's APU generator could never read as off.

    -- synchronisation of the rpm and the start state
    set(APU_N1_percent, math.floor(RPM))
    if phase >= 5 and RPM >= 90 then
        -- the APU is running - the simulator sees it as started
        set(APU_running,        1)
        set(APU_starter_switch, 1)
    elseif phase >= 2 then
        -- start in progress
        set(APU_running,        0)
        set(APU_starter_switch, 2)  -- start mode
    else
        -- the APU is stopped
        set(APU_running,        0)
        set(APU_starter_switch, 0)
    end
    local system_out = (phase > 0 or RPM > 1) and 1 or system_on
    set(apu_system_on,    system_out)
    set(apu_n1,           RPM)
    set(apu_air_doors,    bleed_doors_pos)
    set(apu_doors,        apu_doors_pos)
    set(apu_oil_t,        oil_temp)
    set(apu_oil_q,        oil_q)
    -- oil pressure per Flight Manual 8.2.1(3): normally 3.8 kgf/cm2 at +15 C,
    -- min 3.4 at +50 C; builds above RPM > 15% (the oil pump)
    local oil_press = oil_q * 3.8 * math.min(1, math.max(0, (RPM - 15) / 30))
    set(apu_oil_p,        oil_press)
    set(apu_egt,          egt)
    set(apu_fuel_p,       fuel_press)
    set(apu_start_cc,     start_cc)
    set(fuel_pumps_27_cc, fuel_current)
    set(apu_burn_fuel,    burning)
    set(apu_ready,        apu_is_ready)
    set(apu_start_phase,  phase)
    set(apu_cooldown,     cooldown_timer)

    -- starter annunciation
    set(apu_start_seq, starter_on)

    -- annunciation for starting the engines from the APU
    set(apu_apd_working, (phase >= 5 and RPM > 90) and 1 or 0)
end
