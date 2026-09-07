-- apu_heater.lua - the TA-6A APU ground heater for the Tu-154M
-- ============================================================
-- Simulation of an MP-85 type ground heater unit.
-- Warming the APU oil before the start at low temperatures
-- of the outside air (below -25 C per Flight Manual 8.2.1).
--
-- Operating conditions:
--   - the aircraft is on the ground
--   - the APU is off (RPM < 5%)
--   - Target temperature: -10 to +60 C (with +/-2 C hysteresis)
--
-- Control through datarefs:
--   tu-154/apu_heater/on        - int, 0/1 (on/off)
--   tu-154/apu_heater/target_t  - float, target temperature, C
--   tu-154/apu_heater/active    - int, 1 = actually heating right now
--
-- To switch it on/off, change the tu-154/apu_heater/on dataref.
-- The simplest way is through DataRefEditor (you already have the plugin)
-- or bind it to a hotkey through a FlyWithLua script.
--
-- Heating rate - accelerated (~3 C/s) for gameplay.
-- In reality an MP-85 warms the APU up in 15-25 minutes.
-- ============================================================

-- ============================================================
-- DATAREFS
-- ============================================================

-- APU state
defineProperty("apu_n1",     globalPropertyf("tu-154/eng/apu_n1"))
defineProperty("apu_oil_t",  globalPropertyf("tu-154/eng/apu_oil_t"))

-- frame time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- the "on the ground" state
defineProperty("on_ground", globalPropertyi("sim/flightmodel/failures/onground_any"))

-- ============================================================
-- THE HEATER'S DATAREFS (writable)
-- ============================================================
-- Declared in core/dataref_creator_2.lua, per CLAUDE.md section 14, and only
-- bound here. They used to be created in this module, which meant they did not
-- exist until after apu_logic.lua had loaded - and apu_logic now reads
-- apu_heater/active to know when to leave the oil temperature alone.
local heater_on_p     = globalPropertyi("tu-154/apu_heater/on")
local heater_target_p = globalPropertyf("tu-154/apu_heater/target_t")
local heater_active_p = globalPropertyi("tu-154/apu_heater/active")

defineProperty("heater_on",     heater_on_p)
defineProperty("heater_target", heater_target_p)
defineProperty("heater_active", heater_active_p)

-- ============================================================
-- CONSTANTS
-- ============================================================
local HEAT_RATE       = 3.0   -- oil heating rate, C/s (accelerated mode)
local TARGET_MIN      = -10   -- min target temperature, C
local TARGET_MAX      = 60    -- max target temperature, C (Flight Manual - no higher)
local HYSTERESIS      = 2.0   -- controller hysteresis, C
local APU_OFF_RPM     = 5.0   -- the RPM below which the APU counts as off

-- ============================================================
-- UPDATE LOGIC
-- ============================================================
local heating_now = false  -- internal flag for the hysteresis

function update()
    local passed = get(frame_time)
    if passed <= 0 or passed > 0.5 then return end

    local rpm        = get(apu_n1)
    local oil_temp   = get(apu_oil_t)
    local target_t   = get(heater_target_p)
    local switch_on  = get(heater_on_p) == 1
    local on_grnd    = get(on_ground) == 1

    -- Target temperature limiting
    if target_t > TARGET_MAX then
        set(heater_target_p, TARGET_MAX)
        target_t = TARGET_MAX
    elseif target_t < TARGET_MIN then
        set(heater_target_p, TARGET_MIN)
        target_t = TARGET_MIN
    end

    -- Automatic shutdown
    if switch_on then
        if rpm >= APU_OFF_RPM then
            set(heater_on_p, 0)
            switch_on = false
            heating_now = false
        elseif not on_grnd then
            set(heater_on_p, 0)
            switch_on = false
            heating_now = false
        end
    end

    -- A controller with hysteresis
    if switch_on then
        if heating_now then
            if oil_temp >= target_t then
                heating_now = false
            end
        else
            if oil_temp <= (target_t - HYSTERESIS) then
                heating_now = true
            end
        end

        if heating_now then
            oil_temp = oil_temp + HEAT_RATE * passed
            if oil_temp > target_t then oil_temp = target_t end
            set(apu_oil_t, oil_temp)
            set(heater_active_p, 1)
        else
            set(heater_active_p, 0)
        end
    else
        heating_now = false
        set(heater_active_p, 0)
    end
end
