-- ---------------------------------------------------------------------------
-- Engines one-line diagram (the Eng tab)
--
-- Three engine columns through four stages, the way the hydraulic diagram runs
-- three systems through four. The columns are the engines; the bands are start,
-- running, and health.
--
-- The structure worth drawing is the START system, because it is the only part
-- of this tab that branches. start_logic.lua ACCUMULATES starting air:
--
--   starter_press = starter_press + (apu_contribution + eng_1 + eng_2 + eng_3) * dt
--
-- where each engine's term is `burning * bleed_valve * f(rpm)`. So an engine
-- that is already running feeds the air for the next one, which is why the
-- source node counts all four contributors and why the bar is fed from it
-- rather than from the APU alone. The APU's own term needs `apu_n1 > 50` and
-- is scaled by the air-door travel.
--
-- Three more gates the rows name because they are easy to be caught by:
--   * the start system needs BOTH 27 V buses (`starter_switch == 1 and
--     power27L and power27R`), not either one;
--   * a start needs the fuel system ready -- `auto_tanks_turn > 0` and all
--     FOUR tank 1 pumps running -- which is a Fuel-tab condition appearing as
--     an engine-start precondition;
--   * moving the engine selector counts as pressing STOP (`stop_button` is
--     `starter_stop == 1 or eng_select ~= select_last`).
--
-- Engine 2 has no thrust reverser; its column says so rather than showing a
-- bar that can only read 0.
-- ---------------------------------------------------------------------------

local EN = {
    C3    = 340,  -- three-column node
    TOP   = 8,    -- start system, start air, fuel readiness  (LN_H6 -> 107)
    BAR   = 147,  -- start air to the selected engine
    START = 187,  -- the three engines' start chains          (LN_H6 -> 286)
    RUN   = 326,  -- the three engines running                (LN_H6 -> 425)
    OIL   = 465,  -- oil, vibration, reverse                  (LN_H6 -> 564)
}

-- RLE Table 8.1.3 (p.8.1.5): maximum EGT on the takeoff regime by outside air
-- temperature, read on the UT-7A gauge - the indication this tab shows. It is
-- the highest limit of any forward-thrust regime, so it is the one that turns a
-- reading into a redline. The table stops at -60 and +50 C; the OAT is clamped
-- to that range rather than extrapolated.
local EGT_TAKEOFF_MAX = {
    { -60, 574 }, { -50, 583 }, { -40, 591 }, { -30, 600 }, { -20, 608 }, { -10, 617 },
    {   0, 625 }, {  10, 634 }, {  20, 642 }, {  30, 650 }, {  40, 658 }, {  50, 666 },
}

-- a dry crank is a procedure, not a caution
local EN_LEGEND = {
    { S_LIVE,  "running" },
    { S_STBY,  "starting or cranking" },
    { S_LOW,   "caution" },
    { S_DEAD,  "shut down" },
    { S_FAULT, "failed or over a redline" },
}

local function drawEngDiagram()
    local v27l = readv("tu-154/elec/bus27_volt_left")
    local v27r = readv("tu-154/elec/bus27_volt_right")
    -- start_logic tests both buses at > 13, the same threshold as everything else
    local sysLive = readv("tu-154/switchers/eng/starter_switch") > 0.5
        and v27l > 13 and v27r > 13
    local sel = math.floor(readv("tu-154/switchers/eng/starter_eng_select") + 0.5)
    local mode = math.floor(readv("tu-154/switchers/eng/starter_mode") + 0.5)
    local press = readv("tu-154/start/starter_pressure")

    listNode(colX(1, 3, EN.C3), EN.TOP, EN.C3, LN_H6, "START SYSTEM (APD)",
        sysLive and S_LIVE or S_DEAD, {
            { "master switch", readv("tu-154/switchers/eng/starter_switch") > 0.5
              and "ON" or "OFF" },
            { "needs 27 V left AND right", fmt(v27l, 1) .. " / " .. fmt(v27r, 1) .. " V",
              (v27l > 13 and v27r > 13) and S_LIVE or S_DEAD },
            { "guard", readv("tu-154/switchers/eng/starter_cap") > 0.5
              and "CLOSED" or "open" },
            { "engine selector", (sel >= 1 and sel <= 3) and ("ENGINE " .. sel) or "none",
              (sel >= 1 and sel <= 3) and S_LIVE or nil },
            { "mode", (mode > 0) and "START (fuel admitted)" or "CRANK (dry)",
              (mode > 0) and S_LIVE or nil },
            { "start / stop button",
              (readv("tu-154/buttons/eng/starter_start") > 0.5 and "START" or "-")
              .. " / " .. (readv("tu-154/buttons/eng/starter_stop") > 0.5 and "STOP" or "-") },
        })

    local apuN1 = readv("tu-154/eng/apu_n1")
    local apuDoor = readv("tu-154/eng/apu_air_doors")
    local apuTerm = (apuN1 > 50) and (apuDoor * apuN1 * 0.01) or 0
    local engFeed = 0
    for i = 1, 3 do
        if readv("sim/flightmodel2/engines/engine_is_burning_fuel[" .. (i - 1) .. "]") > 0.5 then
            engFeed = engFeed + readv("tu-154/bleed/eng_airvalve_" .. i)
        end
    end
    local airSt = (press > 3) and S_LIVE or (press > 0 and S_STBY or S_DEAD)
    listNode(colX(2, 3, EN.C3), EN.TOP, EN.C3, LN_H6, "START AIR", airSt, {
        { "accumulated pressure", fmt(press, 2) .. " (needs 3)", airSt, hd = true },
        { "APU rpm / air door", fmt(apuN1, 0) .. " % / " .. fmt(apuDoor * 100, 0) .. " %",
          apuN1 > 50 and S_LIVE or S_DEAD },
        { "APU contribution", fmt(apuTerm, 2), apuTerm > 0 and S_LIVE or nil },
        { "running engines feeding", fmt(engFeed, 2),
          engFeed > 0 and S_LIVE or nil },
        { "a running engine starts the next", "its bleed is a source too", note = true },
        { "system live", sysLive and "YES" or "no", sysLive and S_LIVE or S_DEAD },
    }, clamp(0, press / 6, 1))

    local turn = readv("tu-154/fuel/auto_tanks_turn")
    local pumps = 0
    for i = 1, 4 do
        if readv("tu-154/fuel/pump_tank1_" .. i .. "_work") > 0.5 then
            pumps = pumps + 1
        end
    end
    local fuelReady = turn > 0 and pumps == 4
    listNode(colX(3, 3, EN.C3), EN.TOP, EN.C3, LN_H6, "FUEL READINESS",
        fuelReady and S_LIVE or S_DEAD, {
            { "tank 1 pumps running", fmt(pumps, 0) .. " of 4",
              (pumps == 4) and S_LIVE or S_DEAD },
            { "usage automatics", (turn > 0) and ("order " .. fmt(turn, 0)) or "NOT SET",
              (turn > 0) and S_LIVE or S_DEAD },
            { "ready to start", fuelReady and "YES" or "NO",
              fuelReady and S_LIVE or S_DEAD },
            { "flow mode",
              fmt(readv("tu-154/switchers/fuel/fuel_flow_mode"), 0) },
            { "intake covers", readv("tu-154/anim/engine_caps") > 0.5
              and "FITTED" or "removed",
              readv("tu-154/anim/engine_caps") > 0.5 and S_LOW or nil },
            { "the same pumps are on the Fuel tab", "fuel/pump_tank1_1..4_work", note = true,
              link = "Fuel" },
        })

    -- ---- start air out to whichever engine is selected ---------------------
    local barSt = (sysLive and press > 3 and fuelReady) and S_LIVE or S_DEAD
    wire(barSt, colC(2, 3, EN.C3), Y(EN.TOP + LN_H6), colC(2, 3, EN.C3), Y(EN.BAR))
    wire(barSt, colC(1, 3, EN.C3), Y(EN.BAR), colC(3, 3, EN.C3), Y(EN.BAR))
    junction(colC(2, 3, EN.C3), Y(EN.BAR), barSt)
    band(EN.BAR - 9, "START AIR")
    sasl.gl.drawText(font, colC(3, 3, EN.C3) - 14, Y(EN.BAR - 9),
        "ONLY THE SELECTED ENGINE IS CRANKED",
        11, false, false, TEXT_ALIGN_RIGHT, COL_DIM)

    -- ---- the start chain, one column per engine ----------------------------
    for i = 1, 3 do
        local cx = colC(i, 3, EN.C3)
        local apd = readv("tu-154/start/apd_working_" .. i) > 0.5
        local torque = readv("sim/flightmodel2/engines/starter_making_torque["
            .. (i - 1) .. "]") > 0.5
        local fuelIn = readv("tu-154/start/fuel_in_" .. i)
        local ign = readv("sim/cockpit2/engine/actuators/igniter_on[" .. (i - 1) .. "]") > 0.5
        local burn = readv("sim/flightmodel2/engines/engine_is_burning_fuel["
            .. (i - 1) .. "]") > 0.5
        local n2 = readv("tu-154/gauges/engine/rpm_high_" .. i)
        local st
        if burn then
            st = S_LIVE
        elseif apd or torque then
            st = S_STBY
        else
            st = S_DEAD
        end
        local drop = (sel == i) and barSt or S_DEAD
        wire(drop, cx, Y(EN.BAR), cx, Y(EN.START))
        junction(cx, Y(EN.BAR), drop)
        arrow(cx, (Y(EN.BAR) + Y(EN.START)) / 2, 0, -1, drop)

        listNode(colX(i, 3, EN.C3), EN.START, EN.C3, LN_H6,
            "ENGINE " .. i .. " -- START", st, {
                { "selected", (sel == i) and "YES" or "no",
                  (sel == i) and S_LIVE or nil },
                { "APD driving", apd and "YES" or "no", apd and S_STBY or nil },
                { "starter torque", torque and "YES" or "no", torque and S_STBY or nil },
                { "fuel admitted", (fuelIn > 0) and "YES" or "no",
                  (fuelIn > 0) and S_LIVE or nil },
                { "igniter", ign and "ON" or "off", ign and S_LIVE or nil },
                { "burning / N2", (burn and "BURNING" or "no flame") .. " / "
                  .. fmt(n2, 0) .. " %", burn and S_LIVE or nil },
            })
    end

    band(EN.RUN - 5, "RUNNING")
    local egtMax = interpolate(EGT_TAKEOFF_MAX,
        clamp(-60, readv("sim/cockpit2/temperature/outside_air_temp_degc"), 50))
    -- ---- running --------------------------------------------------------
    for i = 1, 3 do
        local n1 = readv("tu-154/gauges/engine/rpm_low_" .. i)
        local n2 = readv("tu-154/gauges/engine/rpm_high_" .. i)
        local egt = readv("tu-154/gauges/eng/egt_" .. i)
        local burn = readv("sim/flightmodel2/engines/engine_is_burning_fuel["
            .. (i - 1) .. "]") > 0.5
        -- the RLE 8.1.1 redlines: N1 95 %, N2 98.5 %, and EGT by OAT from
        -- Table 8.1.3 (egtMax above)
        local over = n1 > 95 or n2 > 98.5 or egt > egtMax
        listNode(colX(i, 3, EN.C3), EN.RUN, EN.C3, LN_H6, "ENGINE " .. i, over and S_FAULT
            or (burn and S_LIVE or S_DEAD), {
                { "N1 low spool (95 % max)", fmt(n1, 1) .. " %", n1 > 95 and S_FAULT or nil, hd = true },
                { "N2 high spool (98.5 max)", fmt(n2, 1) .. " %",
                  n2 > 98.5 and S_FAULT or nil },
                { "EGT (" .. fmt(egtMax, 0) .. " C max)", fmt(egt, 0) .. " C",
                  egt > egtMax and S_FAULT or nil },
                { "thrust", fmt(readv("sim/cockpit2/engine/indicators/thrust_n["
                  .. (i - 1) .. "]") / 1000, 1) .. " kN" },
                { "fuel flow", fmt(readv("tu-154/gauges/eng/fuel_flow_" .. i), 0)
                  .. " kg/h" },
                { "throttle / stop cock",
                  fmt(readv("tu-154/controlls/throttle_" .. i) * 100, 0) .. " % / "
                  .. (readv("tu-154/controlls/fuel_cutoff_" .. i) > 0.5 and "OPEN" or "SHUT") },
            }, clamp(0, n2 / 100, 1))
    end

    band(EN.OIL - 5, "HEALTH")
    -- ---- oil, vibration and reverse ---------------------------------------
    for i = 1, 3 do
        local oilT = readv("tu-154/gauges/eng/oil_temp_" .. i)
        local leak = readv("tu-154/failures/engn_oil_leak_" .. i) > 0.5
        local pmp = readv("tu-154/failures/eng_fuel_pmp_fail_" .. i) > 0.5
        local vib = readv("tu-154/gauges/eng/vibra_" .. i)
        -- an explicit if: `(i == 2) and nil or readv(...)` is always the readv
        -- (CLAUDE.md 14), and engine 2 has no reverser
        local rev
        if i ~= 2 then
            rev = readv("sim/flightmodel2/engines/thrust_reverser_deploy_ratio["
                        .. (i - 1) .. "]")
        end
        listNode(colX(i, 3, EN.C3), EN.OIL, EN.C3, LN_H6, "ENGINE " .. i .. " -- HEALTH",
            (leak or pmp or oilT > 110) and S_FAULT
            or (readv("sim/flightmodel2/engines/engine_is_burning_fuel[" .. (i - 1) .. "]") > 0.5
                and S_LIVE or S_DEAD), {
                { "oil pressure", fmt(readv("tu-154/gauges/eng/oil_press_" .. i), 2) },
                { "oil temp (110 C max)", fmt(oilT, 0) .. " C",
                  oilT > 110 and S_FAULT or nil },
                { "oil quantity / leak", fmt(readv("tu-154/gauges/eng/oil_qty_" .. i), 1)
                  .. " l / " .. (leak and "LEAKING" or "ok"), leak and S_FAULT or nil },
                { "vibration", fmt(vib, 0) .. " %", vib > 60 and S_FAULT or nil },
                { "reverser", rev and (fmt(rev * 100, 0) .. " % deployed")
                  or "none fitted", (rev and rev > 0.05) and S_LIVE or nil },
                { "fuel pump / lamp", (pmp and "FAILED" or "ok") .. " / "
                  .. (readv("tu-154/lights/engines/eng" .. i .. "_fuel_p") > 0.05
                      and "LIT" or "dark"), pmp and S_FAULT or nil },
            })
    end

    drawLegend(LEG_D, EN_LEGEND,
        "moving the engine selector counts as pressing STOP",
        "A start needs both 27 V buses, more than 3 units of accumulated air, and the fuel system ready -- auto_tanks_turn set with all four tank 1 pumps running. Engine 2 has no reverser.")
end
DIAGRAMS.eng = drawEngDiagram
