-- ---------------------------------------------------------------------------
-- Fuel one-line diagram (the Fuel tab)
--
-- Follows the fuel: the five supply tanks with their pumps, the transfer
-- manifold, the metering unit and the standby transfer, tank 1 (the service
-- tank everything is pumped into and drawn from), its four pumps, the ring
-- main, and the three fire shutoff valves into the engines.
--
-- Each supply tank shows the real contents (m_fuel[n]) beside the gauge:
-- fuel_panel.lua lags every gauge and each has its own failure flag, so a
-- disagreement between the two rows is the thing to look for. The balancer
-- stops the pumps on the heavier side (auto_tank_level_2/3), and that tank
-- gets a HELD chip.
-- ---------------------------------------------------------------------------

local FG = {
    TANK   = 8,    -- the five supply tanks
    COLL   = 130,  -- transfer manifold
    XFER   = 148,  -- automatics, metering, standby transfer, balancing
    T1     = 253,  -- totals, tank 1, APU tap
    APUL   = 34,   -- tank 1 -> APU FEED line, below T1
    PUMP   = 346,  -- warnings, tank 1 pumps, loads and meters
    RING   = 439,  -- ring main
    ENG    = 475,  -- the three engines
    TW     = 212,  -- supply tank column width
    XW     = 271,  -- transfer row column width
}
-- only the gaps that carry a symbol (pumps, valves) are 36 px; the rest stay tight

FG.XC = {}
for i = 1, 4 do
    FG.XC[i] = colC(i, 4, FG.XW)
end
FG.T1X = colX(2, 4, FG.XW)                  -- tank 1 and its pumps...
FG.T1W = colX(3, 4, FG.XW) + FG.XW - FG.T1X -- ...span transfer columns 2 and 3
FG.APUX = colX(4, 4, FG.XW)                 -- APU FEED, LOAD AND METERS
FG.EW = colW(3, 30)                         -- engine node width
FG.DROP = 194                               -- tank 1 -> pumps -> ring main, in from tank 1's left
FG.RARL, FG.RARR = 340, 790                 -- the ring main's two flow heads

-- These are the branches fuel_pumps.lua actually takes. The comment on
-- tu-154/fuel/auto_tanks_turn in dataref_creator_2.lua ("0, 1 - not working")
-- is stale: turn 1 runs the tank 2 pumps, 2 runs tanks 2 and 3 together,
-- 3 runs tanks 3, 4 runs tank 4. Only 0 means the automatics are idle.
local FUEL_TURN = { [0] = "OFF", [1] = "TANKS 2", [2] = "TANKS 2 + 3",
                    [3] = "TANKS 3", [4] = "TANK 4" }

-- `cap` is the ceiling fuel_tanks.lua clamps that tank to, so the node fill is
-- the real proportion rather than a guess
local FUEL_TANKS = {
    { col = 1, t = "TANK 2 LEFT",  qty = "sim/flightmodel/weight/m_fuel[3]", cap = 9550,
      gauge = "tu-154/gauges/fuel/fuel_meter_tank2_left",  gfail = "tu-154/failures/fuel_meter_2l_fail",
      work = "tu-154/fuel/pump_tank2_left_work",   n = 2, pfail = "tu-154/failures/fuel_pump_2l_fail",
      sw = "tu-154/switchers/fuel/pump_tank2_left",  bal = "tu-154/fuel/auto_tank_level_2", held = -1 },
    { col = 2, t = "TANK 3 LEFT",  qty = "sim/flightmodel/weight/m_fuel[5]", cap = 5425,
      gauge = "tu-154/gauges/fuel/fuel_meter_tank3_left",  gfail = "tu-154/failures/fuel_meter_3l_fail",
      work = "tu-154/fuel/pump_tank3_left_work",   n = 3, pfail = "tu-154/failures/fuel_pump_3l_fail",
      sw = "tu-154/switchers/fuel/pump_tank3_left",  bal = "tu-154/fuel/auto_tank_level_3", held = -1 },
    { col = 3, t = "TANK 4",       qty = "sim/flightmodel/weight/m_fuel[1]", cap = 6600,
      gauge = "tu-154/gauges/fuel/fuel_meter_tank4",       gfail = "tu-154/failures/fuel_meter_4_fail",
      work = "tu-154/fuel/pump_tank4_work",        n = 2, pfail = "tu-154/failures/fuel_pump_4_fail",
      sw = "tu-154/switchers/fuel/pump_tank4" },
    { col = 4, t = "TANK 3 RIGHT", qty = "sim/flightmodel/weight/m_fuel[4]", cap = 5425,
      gauge = "tu-154/gauges/fuel/fuel_meter_tank3_right", gfail = "tu-154/failures/fuel_meter_3r_fail",
      work = "tu-154/fuel/pump_tank3_right_work",  n = 3, pfail = "tu-154/failures/fuel_pump_3r_fail",
      sw = "tu-154/switchers/fuel/pump_tank3_right", bal = "tu-154/fuel/auto_tank_level_3", held = 1 },
    { col = 5, t = "TANK 2 RIGHT", qty = "sim/flightmodel/weight/m_fuel[2]", cap = 9550,
      gauge = "tu-154/gauges/fuel/fuel_meter_tank2_right", gfail = "tu-154/failures/fuel_meter_2r_fail",
      work = "tu-154/fuel/pump_tank2_right_work",  n = 2, pfail = "tu-154/failures/fuel_pump_2r_fail",
      sw = "tu-154/switchers/fuel/pump_tank2_right", bal = "tu-154/fuel/auto_tank_level_2", held = 1 },
}
for _, k in ipairs(FUEL_TANKS) do
    k.cx = colC(k.col, 5, FG.TW) -- each tank's pump drop into the manifold
end

-- the ring main drops into each engine at its column centre
local FUEL_ENG = {}
for i = 1, 3 do
    FUEL_ENG[i] = { col = i, cx = colC(i, 3, FG.EW), n = i }
end

local FUEL_LEGEND = {
    { S_LIVE,  "fuel moving" },
    { S_STBY,  "armed, not flowing" },
    { S_LOW,   "degraded" },
    { S_DEAD,  "off" },
    { S_FAULT, "failed" },
}

-- auto_tank_level_2/3 is which side the balancer has stopped, not which side
-- is being fed: -1 stops the left pumps, +1 the right ones (fuel_pumps.lua)
local function heldTxt(v)
    if v < 0 then
        return "L HELD"
    end
    if v > 0 then
        return "R HELD"
    end
    return "LEVEL"
end

local function drawFuelDiagram()
    -- ---- supply tanks and the transfer manifold --------------------------
    local anyPump = false
    for i = 1, #FUEL_TANKS do
        local k = FUEL_TANKS[i]
        local x = colX(k.col, 5, FG.TW)
        local qty = readv(k.qty)
        local run = readv(k.work)
        local failed = readv(k.pfail)
        local swOn = readv(k.sw) > 0.5
        local gbad = readv(k.gfail) > 0.5
        if run > 0 then
            anyPump = true
        end
        local st
        if failed >= k.n then
            st = S_FAULT
        elseif run > 0 then
            st = (failed > 0) and S_LOW or S_LIVE
        elseif swOn then
            st = S_STBY
        else
            st = S_DEAD
        end
        local yb = listNode(x, FG.TANK, FG.TW, LN_H5, k.t, st, {
            { "contents", fmt(qty, 0) .. " kg", hd = true },
            { "gauge", gbad and "FAILED" or (fmt(readv(k.gauge), 0) .. " kg"),
              gbad and S_FAULT or nil },
            { "capacity", fmt(k.cap, 0) .. " kg", note = true },
            { "pumps", fmt(run, 0) .. " / " .. k.n, st },
            { "switch", swOn and "ON" or "OFF" },
        }, qty / k.cap)
        if k.bal and math.floor(readv(k.bal) + 0.5) == k.held then
            chip(afterTitle(x, k.t), yb + LN_H5 - 13, 36, "HELD", true, 12)
        end
        wire(st, k.cx, Y(FG.TANK + LN_H5), k.cx, Y(FG.COLL))
        junction(k.cx, Y(FG.COLL), st)
        pumpSym(k.cx, (Y(FG.TANK + LN_H5) + Y(FG.COLL)) / 2, run > 0.5, st)
    end

    local manifold = anyPump and S_LIVE or S_DEAD
    wire(manifold, FUEL_TANKS[1].cx, Y(FG.COLL), FUEL_TANKS[5].cx, Y(FG.COLL))
    sasl.gl.drawText(font, W - PAD, Y(FG.COLL + 4), "MANIFOLD", 11, false, false,
        TEXT_ALIGN_RIGHT, COL_DIM)
    -- down into the metering unit and the standby transfer
    local porcX, transX = FG.XC[2], FG.XC[3]
    wire(manifold, porcX, Y(FG.COLL), porcX, Y(FG.XFER))
    wire(manifold, transX, Y(FG.COLL), transX, Y(FG.XFER))
    junction(porcX, Y(FG.COLL), manifold)
    junction(transX, Y(FG.COLL), manifold)

    -- ---- automatics, metering, standby transfer, balancing ---------------
    local autoFail = readv("tu-154/failures/fuel_auto_fail") > 0.5
    local turn = math.floor(readv("tu-154/fuel/auto_tanks_turn") + 0.5)
    listNode(colX(1, 4, FG.XW), FG.XFER, FG.XW, LN_H4, "USAGE AUTOMATICS",
        autoFail and S_FAULT or (turn > 0 and S_LIVE or S_DEAD), {
            { "order", FUEL_TURN[turn] or fmt(turn, 0), autoFail and S_FAULT or nil, hd = true },
            { "controller", readv("tu-154/switchers/fuel/fuel_flow_on") > 0.5 and "ON" or "OFF" },
            { "mode", readv("tu-154/switchers/fuel/fuel_flow_mode") > 0.5 and "AUTO" or "MANUAL" },
            { "failure", autoFail and "FAILED" or "OK", autoFail and S_FAULT or nil },
        })

    local porcFail = readv("tu-154/failures/fuel_porc_fail") > 0.5
    local porcOpen = readv("tu-154/fuel/porc_open") > 0.5
    listNode(colX(2, 4, FG.XW), FG.XFER, FG.XW, LN_H4, "PORC (metering)",
        porcFail and S_FAULT or (porcOpen and manifold or S_STBY), {
            { "valve", porcFail and "FAILED" or (porcOpen and "OPEN" or "SHUT"),
              porcFail and S_FAULT or (porcOpen and S_LIVE or S_DEAD), hd = true },
            { "switch", readv("tu-154/switchers/fuel/fuel_porc") > 0.5 and "FORCED" or "AUTO" },
            { "opens below", "3150 kg", note = true },
            { "closes at", "3300 kg", note = true },
        })

    local transSw = readv("tu-154/switchers/fuel/fuel_trans") > 0.5
    local transOpen = readv("tu-154/fuel/reserv_trans") > 0.5
    local transPos = readv("tu-154/fuel/trans_pos")
    -- fuel_tanks gates this valve on 27 V right > 13: a shut valve with a dead
    -- bus is a different fault from one with a live bus
    local v27R = readv("tu-154/elec/bus27_volt_right")
    listNode(colX(3, 4, FG.XW), FG.XFER, FG.XW, LN_H4, "STANDBY TRANSFER",
        transOpen and S_LIVE or (transSw and S_STBY or S_DEAD), {
            { "valve", transOpen and "OPEN" or "SHUT", transOpen and S_LIVE or nil, hd = true },
            { "travel", fmt(transPos * 100, 0) .. " %", transPos > 0.01 and S_LIVE or nil },
            { "switch", transSw and "ON" or "OFF" },
            { "27 V right", fmt(v27R, 1) .. " V", v27R > 13 and S_LIVE or S_DEAD },
        }, transPos)

    local balFail = readv("tu-154/failures/fuel_level_fail") > 0.5
    local balSw = readv("tu-154/switchers/fuel/fuel_level") > 0.5
    local bal2 = math.floor(readv("tu-154/fuel/auto_tank_level_2") + 0.5)
    local bal3 = math.floor(readv("tu-154/fuel/auto_tank_level_3") + 0.5)
    local balSt = S_DEAD
    if balFail then
        balSt = S_FAULT
    elseif bal2 ~= 0 or bal3 ~= 0 then
        balSt = S_LIVE
    elseif balSw then
        balSt = S_STBY
    end
    listNode(colX(4, 4, FG.XW), FG.XFER, FG.XW, LN_H4, "BALANCING", balSt, {
        { "switch", balSw and "ON" or "OFF" },
        { "tanks 2", heldTxt(bal2), bal2 ~= 0 and S_LIVE or nil },
        { "tanks 3", heldTxt(bal3), bal3 ~= 0 and S_LIVE or nil },
        { "failure", balFail and "FAILED" or "OK", balFail and S_FAULT or nil },
    })

    -- ---- totals, tank 1 and the APU tap ----------------------------------
    local porcSt = porcFail and S_FAULT or (porcOpen and manifold or S_DEAD)
    local transSt = transOpen and manifold or S_DEAD
    wire(porcSt, porcX, Y(FG.XFER + LN_H4), porcX, Y(FG.T1))
    wire(transSt, transX, Y(FG.XFER + LN_H4), transX, Y(FG.T1))
    valveSym(porcX, (Y(FG.XFER + LN_H4) + Y(FG.T1)) / 2, porcOpen, porcSt, true)
    valveSym(transX, (Y(FG.XFER + LN_H4) + Y(FG.T1)) / 2, transOpen, transSt, true)

    local summFail = readv("tu-154/failures/fuel_meter_summ") > 0.5
    readout(colX(1, 4, FG.XW), FG.T1, FG.XW, LN_H4, "FUEL TOTALS", summFail and S_FAULT or S_DEAD, {
        { "total gauge", summFail and "FAILED"
            or (fmt(readv("tu-154/gauges/fuel/fuel_meter_summ"), 0) .. " kg"),
          summFail and S_FAULT or nil, hd = true },
        { "front panel", fmt(readv("tu-154/gauges/misc/fuel_front_ind"), 0) .. " kg" },
        { "flowmeter", fmt(readv("tu-154/gauges/fuel/fuel_meter_mech"), 0) .. " kg" },
        { "temp L / R", fmt(readv("tu-154/gauges/eng/fuel_temp_1"), 1) .. " / "
            .. fmt(readv("tu-154/gauges/eng/fuel_temp_2"), 1) .. " C" },
    })

    local t1qty = readv("sim/flightmodel/weight/m_fuel[0]")
    local t1Gbad = readv("tu-154/failures/fuel_meter_1_fail") > 0.5
    local low2500 = readv("tu-154/lights/fuel_less_2500") > 0.5
    local t1St = t1qty > 150 and S_LIVE or S_DEAD
    listNode(FG.T1X, FG.T1, FG.T1W, LN_H4, "TANK 1 (service tank)", low2500 and S_LOW or t1St, {
        { "contents", fmt(t1qty, 0) .. " kg", t1St, hd = true },
        { "gauge", t1Gbad and "FAILED"
            or (fmt(readv("tu-154/gauges/fuel/fuel_meter_tank1"), 0) .. " kg"),
          t1Gbad and S_FAULT or nil },
        { "capacity", "3350 kg, full at 3300", note = true },
        { "2500 kg lamp", low2500 and "ON" or "OFF", low2500 and S_LOW or nil },
    }, t1qty / 3350)

    local apuBurn = readv("tu-154/elec/apu_burning_fuel") > 0.5
    listNode(FG.APUX, FG.T1, FG.XW, LN_H4, "APU FEED", apuBurn and S_LIVE or S_DEAD, {
        { "burning", apuBurn and "YES" or "NO", apuBurn and S_LIVE or nil },
        { "draw", "0.056 kg/s", note = true },
        { "source", "TANK 1", note = true },
        { "27 V load", fmt(readv("tu-154/elec/fuel_pumps_27_cc"), 1) .. " A" },
    })
    wire(apuBurn and S_LIVE or S_DEAD, FG.T1X + FG.T1W, Y(FG.T1 + FG.APUL), FG.APUX, Y(FG.T1 + FG.APUL))

    -- ---- warnings, tank 1 pumps, loads -----------------------------------
    local dropX = FG.T1X + FG.DROP
    wire(t1St, dropX, Y(FG.T1 + LN_H4), dropX, Y(FG.PUMP))

    local siren = readv("tu-154/alarm/speaker_fuel") > 0.5
    readout(colX(1, 4, FG.XW), FG.PUMP, FG.XW, LN_H4, "WARNINGS",
        (siren or autoFail or balFail or porcFail) and S_FAULT or S_DEAD, {
            { "fuel siren", siren and "ON" or "OFF", siren and S_FAULT or nil },
            { "automatics", autoFail and "FAILED" or "OK", autoFail and S_FAULT or nil },
            { "balancing", balFail and "FAILED" or "OK", balFail and S_FAULT or nil },
            { "metering", porcFail and "FAILED" or "OK", porcFail and S_FAULT or nil },
        })

    -- fuel_pump_1_fail is a COUNT: pump n is out when the count reaches n
    local t1Failed = readv("tu-154/failures/fuel_pump_1_fail")
    local t1Rows = {}
    local t1Run = 0
    for i = 1, 4 do
        local run = readv("tu-154/fuel/pump_tank1_" .. i .. "_work") > 0.5
        local sw = readv("tu-154/switchers/fuel/pump_tank1_" .. i) > 0.5
        local bad = t1Failed >= i
        if run then
            t1Run = t1Run + 1
        end
        local rs = S_DEAD
        if bad then
            rs = S_FAULT
        elseif run then
            rs = S_LIVE
        elseif sw then
            rs = S_STBY
        end
        t1Rows[i] = { "pump " .. i,
            bad and "FAILED" or (run and "RUN" or (sw and "ARMED" or "OFF")), rs }
    end
    listNode(FG.T1X, FG.PUMP, FG.T1W, LN_H4, "TANK 1 PUMPS",
        (t1Failed >= 4) and S_FAULT or (t1Run > 0 and S_LIVE or S_DEAD), t1Rows, t1Run / 4)

    readout(FG.APUX, FG.PUMP, FG.XW, LN_H4, "LOAD AND METERS", S_DEAD, {
        { "115 V bus 1", fmt(readv("tu-154/elec/fuel_pumps_115_1_cc"), 1) .. " A" },
        { "115 V bus 3", fmt(readv("tu-154/elec/fuel_pumps_115_3_cc"), 1) .. " A" },
        { "gauges", readv("tu-154/switchers/fuel/fuel_meter_on") > 0.5 and "ON" or "OFF" },
        { "flowmeter", readv("tu-154/switchers/fuel/fuel_meter_mech_on") > 0.5 and "ON" or "OFF" },
    })

    -- ---- ring main and the engines ---------------------------------------
    local ring = t1Run > 0 and S_LIVE or S_DEAD
    wire(ring, dropX, Y(FG.PUMP + LN_H4), dropX, Y(FG.RING))
    wire(ring, FUEL_ENG[1].cx, Y(FG.RING), FUEL_ENG[3].cx, Y(FG.RING))
    arrow(FG.RARL, Y(FG.RING), -1, 0, ring)
    arrow(FG.RARR, Y(FG.RING), 1, 0, ring)
    sasl.gl.drawText(font, W - PAD, Y(FG.RING + 4), "RING MAIN", 11, false, false,
        TEXT_ALIGN_RIGHT, COL_DIM)

    local ew = FG.EW
    for i = 1, #FUEL_ENG do
        local e = FUEL_ENG[i]
        local vlv = readv("tu-154/fuel/fire_vlv_open_" .. e.n)
        local cut = readv("tu-154/controlls/fuel_cutoff_" .. e.n)
        local press = readv("tu-154/fuel/eng_fuel_press_" .. e.n) > 0.5
        local feed = readv("tu-154/start/fuel_in_" .. e.n) > 0.5
        local bad = readv("tu-154/failures/eng_fuel_pmp_fail_" .. e.n) > 0.5
        local ff = readv("sim/cockpit2/engine/indicators/fuel_flow_kg_sec[" .. (e.n - 1) .. "]")
        local st
        if bad then
            st = S_FAULT
        elseif press and vlv > 0.5 and cut > 0.6 and feed then
            st = S_LIVE
        elseif press then
            st = S_STBY
        else
            st = S_DEAD
        end
        listNode(colX(e.col, 3, ew), FG.ENG, ew, LN_H6, "ENGINE " .. e.n, st, {
            { "fire valve", fmt(vlv * 100, 0) .. " %", vlv > 0.5 and S_LIVE or S_DEAD },
            { "cutoff lever", cut > 0.6 and "OPEN" or "SHUT", cut > 0.6 and S_LIVE or S_DEAD },
            { "feed pressure", press and "YES" or "NO", press and S_LIVE or S_DEAD },
            { "start feed", feed and "OPEN" or "SHUT" },
            { "gauge", fmt(readv("tu-154/gauges/eng/fuel_press_" .. e.n), 2), st },
            { "burning", fmt(ff * 3600, 0) .. " kg/h", ff > 0.001 and S_LIVE or S_DEAD, hd = true },
        }, vlv)
        wire(ring, e.cx, Y(FG.RING), e.cx, Y(FG.ENG))
        junction(e.cx, Y(FG.RING), ring)
        valveSym(e.cx, (Y(FG.RING) + Y(FG.ENG)) / 2, vlv > 0.5,
            vlv > 0.5 and ring or S_DEAD, true)
    end

    drawLegend(LEG_D, FUEL_LEGEND,
        "usage order 1 = tanks 2, 2 = tanks 2 + 3 (creator comment is stale)",
        "Bar fill is contents against the ceiling fuel_tanks.lua clamps each tank to. Per-pump pressure ramps are still module locals.")
end
DIAGRAMS.fuel = drawFuelDiagram
