-- ---------------------------------------------------------------------------
-- Fire protection one-line diagram (the Fire tab)
--
-- The three bottles are a SHARED BANK, not one per engine: any bottle can go
-- to any compartment, the compartment is chosen by its own valve, and the
-- bottles are used in order -- hence one bar with a valve on each drop.
--
-- From fire_logic.lua:
--   * a discharge clears the fire with probability 0.98 / valves_open;
--   * the APU compartment is wired but not implemented (the APU branch is
--     empty, the engine_fire_state_4 writes are commented out);
--   * fire is X-Plane's own code, `rel_engfirN == 6`.
--
-- The hot-start band produces engine_fire_state_N = 1 (overheat). RLE Book 2
-- 8.1.2 allows 550 C for 4 s during a start; fire_logic trips after 15 s
-- (HOT_ALLOW), because X-Plane's light-off runs hotter and longer.
-- ---------------------------------------------------------------------------

local FR = {
    C3   = 340,  -- three-column node
    C4   = 275,  -- four-column node (the compartments)
    C2   = 570,  -- two-column node
    TOP  = 8,    -- system, detection, bottle bank      (LN_H6 -> 107)
    BAR  = 148,  -- the extinguisher manifold
    ENG  = 193,  -- three engine compartments + the APU (LN_H6 -> 292)
    HOT  = 333,  -- hot-start protection                (LN_H6 -> 432)
    ZONE = 473,  -- smoke zones and what the sim is told (LN_H6 -> 572)
}

-- Compartment 4 is the APU. It has a valve and a lamp and nothing behind them.
local FIRE_CMP = {
    { n = 1, t = "ENGINE 1", eng = true },
    { n = 2, t = "ENGINE 2", eng = true },
    { n = 3, t = "ENGINE 3", eng = true },
    { n = 4, t = "APU", eng = false },
}

-- armed is cyan (S_STBY), as everywhere else; green is something happening --
-- a compartment valve open, a start under watch
local FIRE_LEGEND = {
    { S_LIVE,  "valve open / start watched" },
    { S_STBY,  "armed" },
    { S_LOW,   "overheat" },
    { S_DEAD,  "unpowered or spent" },
    { S_FAULT, "fire" },
}

-- a tu-154/lights/fire/ lamp is lit
local function lit(n)
    return readv("tu-154/lights/fire/" .. n) > 0.05
end

local function litTxt(n)
    return lit(n) and "LIT" or "dark"
end

local function drawFireDiagram()
    local v27l = readv("tu-154/elec/bus27_volt_left")
    local v27r = readv("tu-154/elec/bus27_volt_right")
    local mainSw = readv("tu-154/switchers/eng/fire_main_switch") > 0.5
    -- the module gates its annunciation on 27 V LEFT and the main switch
    local live = mainSw and v27l > 13
    local sysSt = live and S_LIVE or S_DEAD

    listNode(colX(1, 3, FR.C3), FR.TOP, FR.C3, LN_H6, "SPZ FIRE SYSTEM", sysSt, {
        { "main switch", mainSw and "ON" or "OFF", mainSw and S_LIVE or S_DEAD },
        { "27 V left (gates the panel)", fmt(v27l, 1) .. " V",
          v27l > 13 and S_LIVE or S_DEAD },
        { "27 V right", fmt(v27r, 1) .. " V", v27r > 13 and S_LIVE or S_DEAD },
        { "sensor group selector",
          fmt(readv("tu-154/switchers/eng/fire_sensor_sel"), 0) },
        { "compartment selector",
          fmt(readv("tu-154/switchers/eng/fire_place_sel"), 0) },
        { "system load", fmt(readv("tu-154/fire/fire_sys_cc"), 1) .. " A" },
    })

    local det = readv("tu-154/fire/fire_detected") > 0.5
    local siren = readv("tu-154/fire/fire_siren") > 0.5
    local fireLamp = readv("tu-154/lights/fire") > 0.05
    listNode(colX(2, 3, FR.C3), FR.TOP, FR.C3, LN_H6, "DETECTION",
        det and S_FAULT or (live and S_STBY or S_DEAD), {
            { "fire detected", det and "YES" or "no", det and S_FAULT or nil },
            { "FIRE lamp", fireLamp and "LIT" or "dark", fireLamp and S_FAULT or nil },
            { "TURN ON SPZ lamp", litTxt("turn_on_spz"), lit("turn_on_spz") and S_LOW or nil },
            { "check overheat lamp", litTxt("check_overheat"),
              lit("check_overheat") and S_LOW or nil },
            { "siren / buzzer switch", (siren and "SOUNDING" or "quiet") .. " / "
              .. (readv("tu-154/switchers/eng/fire_buzzer") > 0.5 and "ON" or "OFF"),
              siren and S_FAULT or nil },
            { "smoke test / ext test",
              (readv("tu-154/buttons/eng/smoke_test") > 0.5 and "ON" or "-") .. " / "
              .. (readv("tu-154/buttons/eng/ext_test") > 0.5 and "ON" or "-") },
        })

    -- ---- the shared bottle bank -------------------------------------------
    local used = { readv("tu-154/fire/ext_used_1") > 0.5,
                   readv("tu-154/fire/ext_used_2") > 0.5,
                   readv("tu-154/fire/ext_used_3") > 0.5 }
    local left = 0
    for i = 1, 3 do
        if not used[i] then
            left = left + 1
        end
    end
    local vlv = {}
    local open = 0
    for i = 1, 4 do
        vlv[i] = readv("tu-154/fire/valve_open_" .. i) > 0.5
        if vlv[i] then
            open = open + 1
        end
    end
    local ng = readv("tu-154/fire/ng_used") > 0.5
    local bankSt = (left == 0) and S_DEAD or (open > 0 and S_LIVE or S_STBY)

    listNode(colX(3, 3, FR.C3), FR.TOP, FR.C3, LN_H6, "EXTINGUISHER BANK", bankSt, {
        { "bottle 1", used[1] and "SPENT" or "ready", used[1] and S_DEAD or S_STBY },
        { "bottle 2", used[2] and "SPENT" or "ready", used[2] and S_DEAD or S_STBY },
        { "bottle 3", used[3] and "SPENT" or "ready", used[3] and S_DEAD or S_STBY },
        { "shots remaining", fmt(left, 0) .. " of 3", (left == 0) and S_DEAD or nil, hd = true },
        { "neutral gas", ng and "DISCHARGED" or "ready", ng and S_DEAD or S_STBY },
        { "valves open / odds per shot", fmt(open, 0) .. " / "
          .. ((open > 0) and (fmt(98 / open, 0) .. " %") or "-"),
          (open > 1) and S_LOW or nil },
    }, left / 3)

    -- the bank feeds one manifold and the compartment valves tap off it
    local bankCx = colC(3, 3, FR.C3)
    -- an armed manifold, not a flowing one: it only carries agent on a discharge
    local barSt = (left > 0 and live) and S_STBY or S_DEAD
    wire(barSt, bankCx, Y(FR.TOP + LN_H6), bankCx, Y(FR.BAR))
    wire(barSt, colC(1, 4, FR.C4), Y(FR.BAR), colC(4, 4, FR.C4), Y(FR.BAR))
    junction(bankCx, Y(FR.BAR), barSt)
    for i = 1, 2 do
        arrow((colC(i, 4, FR.C4) + colC(i + 1, 4, FR.C4)) / 2, Y(FR.BAR), -1, 0, barSt)
    end
    band(FR.BAR - 11, "EXTINGUISHING")
    -- ends left of the bank's drop, which would spear a caption run to the
    -- margin; 11 above the bar to clear its chevrons
    sasl.gl.drawText(font, bankCx - 14, Y(FR.BAR - 11),
        "ONE BANK, ANY COMPARTMENT: THE VALVE CHOOSES, THE BOTTLES ARE SHARED",
        11, false, false, TEXT_ALIGN_RIGHT, COL_DIM)

    -- ---- the compartments --------------------------------------------------
    for i = 1, #FIRE_CMP do
        local c = FIRE_CMP[i]
        local cx = colC(c.n, 4, FR.C4)
        local st = readv("tu-154/fire/engine_fire_state_" .. c.n)
        local fire = st > 1.5
        local hot = st > 0.5 and st < 1.5
        local nodeSt = fire and S_FAULT or (hot and S_LOW or (vlv[c.n] and S_LIVE or
            (live and S_STBY or S_DEAD)))
        local rows
        if c.eng then
            rows = {
                { "state", enumTxt(ENUM_FIRE_STATE, st), fire and S_FAULT
                  or (hot and S_LOW or nil), hd = true },
                { "fire lamp", litTxt("fire_eng_" .. c.n), fire and S_FAULT or nil },
                { "overheat lamp", litTxt("overheat_eng_" .. c.n), hot and S_LOW or nil },
                { "extinguishing valve", vlv[c.n] and "OPEN" or "shut",
                  vlv[c.n] and S_LIVE or nil },
                { "halon to the sim",
                  readv("sim/cockpit2/engine/actuators/fire_extinguisher_on["
                  .. (c.n - 1) .. "]") > 0.5 and "ON" or "off" },
                { "fuel shutoff",
                  -- shut is not a fault: it is shut on every engine that is not running
                  fmt(readv("tu-154/fuel/fire_vlv_open_" .. c.n) * 100, 0) .. " % open" },
            }
        else
            rows = {
                { "state", "not modelled", note = true },
                { "fire lamp", litTxt("fire_apu") },
                { "overheat lamp", "-", note = true },
                { "extinguishing valve", vlv[4] and "OPEN" or "shut",
                  vlv[4] and S_LIVE or nil },
                { "halon to the sim", "-", note = true },
                { "fuel shutoff", "-", note = true },
            }
        end
        wire(barSt, cx, Y(FR.BAR), cx, Y(FR.ENG))
        junction(cx, Y(FR.BAR), barSt)
        valveSym(cx, (Y(FR.BAR) + Y(FR.ENG)) / 2, vlv[c.n],
            vlv[c.n] and (barSt ~= S_DEAD and S_LIVE or S_STBY) or S_DEAD, true)
        listNode(colX(c.n, 4, FR.C4), FR.ENG, FR.C4, LN_H6, c.t, nodeSt, rows)
    end

    band(FR.HOT - 5, "HOT-START PROTECTION")
    -- ---- hot-start protection ----------------------------------------------
    for i = 1, 3 do
        local egt = readv("sim/cockpit2/engine/indicators/EGT_deg_cel[" .. (i - 1) .. "]")
        local clk = readv("tu-154/fire/hotstart_timer_" .. i)
        local sev = readv("tu-154/engine/hotstart_" .. i)
        local n2 = readv("tu-154/gauges/engine/rpm_high_" .. i)
        local apd = readv("tu-154/start/apd_working_" .. i) > 0.5
        local fstate = readv("tu-154/fire/engine_fire_state_" .. i)
        local tripped = fstate > 0.5 and fstate < 1.5
        local st
        if tripped then
            st = S_LOW
        elseif clk > 0 then
            st = S_FAULT
        else
            st = apd and S_LIVE or S_DEAD
        end
        listNode(colX(i, 3, FR.C3), FR.HOT, FR.C3, LN_H6, "HOT START " .. i, st, {
            { "gas temp behind turbine", fmt(egt, 0) .. " C",
              egt > 550 and S_FAULT or nil, hd = true },
            { "documented ceiling", "550 C for 4 s", note = true },
            -- fire_logic trips at HOT_ALLOW = 15 s, not the manual's 4 s
            { "over the ceiling for", fmt(clk, 1) .. " / 15 s",
              clk > 0 and (clk > 15 and S_LOW or S_FAULT) or nil },
            { "overheat latched", tripped and "YES" or "no", tripped and S_LOW or nil },
            { "severity to the spool", fmt(sev, 2), sev > 0 and S_LOW or nil },
            { "HP spool / start panel", fmt(n2, 0) .. " % / "
              .. (apd and "DRIVING" or "-") },
        }, clamp(0, clk / 19, 1))
    end

    band(FR.ZONE - 5, "SMOKE AND OUTPUTS")
    -- ---- smoke zones and outputs -------------------------------------------
    local function pair(a, b)
        return litTxt(a) .. " / " .. litTxt(b)
    end
    local anySmoke = lit("smoke_1") or lit("smoke_2") or lit("smoke_zone2_left")
        or lit("smoke_zone2_right") or lit("smoke_zone3") or lit("smoke_zone4")
        or lit("smoke_zone5_left") or lit("smoke_zone5_right") or lit("smoke_zone6")
    listNode(colX(1, 2, FR.C2), FR.ZONE, FR.C2, LN_H6, "SMOKE DETECTORS (SSD)",
        anySmoke and S_FAULT or (live and S_STBY or S_DEAD), {
            { "detector 1 / 2", pair("smoke_1", "smoke_2") },
            { "zone 2 left / right", pair("smoke_zone2_left", "smoke_zone2_right") },
            { "zone 3", litTxt("smoke_zone3") },
            { "zone 4", litTxt("smoke_zone4") },
            { "zone 5 left / right", pair("smoke_zone5_left", "smoke_zone5_right") },
            { "zone 6", litTxt("smoke_zone6") },
        })

    readout(colX(2, 2, FR.C2), FR.ZONE, FR.C2, LN_H6, "WHAT THE SIM IS TOLD",
        S_DEAD, {
            { "engine fire 1 / 2 / 3 (6 = fire now)",
              fmt(readv("sim/operation/failures/rel_engfir0"), 0) .. " / "
              .. fmt(readv("sim/operation/failures/rel_engfir1"), 0) .. " / "
              .. fmt(readv("sim/operation/failures/rel_engfir2"), 0) },
            { "extinguisher on 1 / 2 / 3",
              onoff(readv("sim/cockpit2/engine/actuators/fire_extinguisher_on[0]") > 0.5)
              .. " / " ..
              onoff(readv("sim/cockpit2/engine/actuators/fire_extinguisher_on[1]") > 0.5)
              .. " / " ..
              onoff(readv("sim/cockpit2/engine/actuators/fire_extinguisher_on[2]") > 0.5) },
            -- the lamp fire_panel drives from fire_vlv_open_N < 0.5; the
            -- fire/engine_fuel_cut_N it also binds is never read or written
            { "FUEL OFF lamp 1 / 2 / 3",
              onoff(readv("tu-154/lights/fire/fuel_off_eng_1") > 0.05) .. " / "
              .. onoff(readv("tu-154/lights/fire/fuel_off_eng_2") > 0.05) .. " / "
              .. onoff(readv("tu-154/lights/fire/fuel_off_eng_3") > 0.05) },
            { "fire shutoff valves, % open",
              fmt(readv("tu-154/fuel/fire_vlv_open_1") * 100, 0) .. " / "
              .. fmt(readv("tu-154/fuel/fire_vlv_open_2") * 100, 0) .. " / "
              .. fmt(readv("tu-154/fuel/fire_vlv_open_3") * 100, 0) },
            { "spool severity 1 / 2 / 3",
              fmt(readv("tu-154/engine/hotstart_1"), 2) .. " / "
              .. fmt(readv("tu-154/engine/hotstart_2"), 2) .. " / "
              .. fmt(readv("tu-154/engine/hotstart_3"), 2) },
            { "the same valves are drawn on the Fuel tab", "fuel/fire_vlv_open_1..3", note = true,
              link = "Fuel" },
        })

    drawLegend(LEG_D, FIRE_LEGEND,
        "fire/engine_fire_state_4 is created but nothing writes it: the APU branch is empty",
        "A discharge clears the fire with probability 0.98 divided by the number of valves open, so a second open compartment halves the odds on the one that is burning.")
end
DIAGRAMS.fire = drawFireDiagram
