-- ---------------------------------------------------------------------------
-- Hydraulic one-line diagram (the Hydr tab)
--
-- Three independent systems drawn as three columns, each a closed loop read
-- top-down: reservoir -> two pumps -> accumulator and pressure -> consumers,
-- and back up the right-hand channel to the reservoir. That return leg is not
-- decoration: hydro_logic.lua really does credit the consumer flow back to
-- `hsN_qty` on the same frame it debits the accumulator, so fluid only ever
-- leaves a system through a leak.
--
-- Every system has exactly two pumps: HS1 two engine pumps (the second runs
-- off ENG 2's spool, not ENG 1's -- `eng_k2` in hydro_logic), HS2 and HS3 an
-- engine pump and an electric pump station each.
-- ---------------------------------------------------------------------------

local HG = {
    COL  = 370,  -- column pitch; nodes are CW wide and the rest is return channel
    CW   = 340,  -- full-width node
    PW   = 164,  -- half-width node, for the paired pumps
    RETX = 13,   -- the return channel, right of a column's nodes
    TANK = 8,    -- reservoirs
    RETY = 28,   -- where the return enters the reservoir, below TANK
    PJ   = 100,  -- tank -> pump junction
    PUMP = 134,  -- engine and electric pumps
    SJ   = 235,  -- pump -> system junction
    SYS  = 263,  -- accumulator and pressure
    XFD  = 41,   -- the HS 2 -> HS 1 cross-feed, below SYS
    CONS = 377,  -- boosters, consumers, emergency accumulator
    CHX  = 90,   -- the emergency accumulator's tap, right of HS 1's left edge
    RET  = 471,  -- the return leg back to the reservoir
    AUX  = 492,  -- cross-feed, gauges, warnings
}
-- every leg of the loop is long enough to carry a symbol or a flow head

-- hydro_logic initialises each system to this many litres, which is the only
-- "full" figure the code states, so the reservoir fill bars are drawn against it
local HYD = {
    { col = 1, n = 1, full = 58,
      feeds = "boosters, flaps, spoilers, brakes, gear",
      pumps = {
          { t = "ENG PUMP 1-1", eng = 1, flow = "tu-154/hydro/eng_pump_11",
            fail = "tu-154/failures/hydro_pump_fail_11" },
          { t = "ENG PUMP 1-2", eng = 2, flow = "tu-154/hydro/eng_pump_12",
            fail = "tu-154/failures/hydro_pump_fail_12" },
      } },
    { col = 2, n = 2, full = 58,
      feeds = "boosters, flaps, emergency gear",
      pumps = {
          { t = "ENG PUMP 2", eng = 2, flow = "tu-154/hydro/eng_pump_2",
            fail = "tu-154/failures/hydro_pump_fail_2" },
          { t = "ELEC PUMP 2", elec = 2, supply = "115 V/1 + 27 L",
            work = "tu-154/hydro/elec_pump_2_work", amp = "tu-154/hydro/gs_pump_2_cc",
            sw = "tu-154/switchers/hydro/pump_2", fail = "tu-154/failures/hydro_elec_fail_2" },
      } },
    { col = 3, n = 3, full = 45,
      feeds = "boosters, gear extension (3GS)",
      pumps = {
          { t = "ENG PUMP 3", eng = 3, flow = "tu-154/hydro/eng_pump_3",
            fail = "tu-154/failures/hydro_pump_fail_3" },
          { t = "ELEC PUMP 3", elec = 3, supply = "115 V/3 + 27 R",
            work = "tu-154/hydro/elec_pump_3_work", amp = "tu-154/hydro/gs_pump_3_cc",
            sw = "tu-154/switchers/hydro/pump_3", fail = "tu-154/failures/hydro_elec_fail_3" },
      } },
}

local HYD_LEGEND = {
    { S_LIVE,  "pressurised / delivering" },
    { S_STBY,  "available, not delivering" },
    { S_LOW,   "low pressure" },
    { S_DEAD,  "no pressure" },
    { S_FAULT, "failed or leaking" },
}

-- 210 kg/cm2 is acc * 50 at the accumulator's ceiling; the low-pressure lamps
-- and the old card tab both treat 150 as the bottom of the green band
local function pressState(p, leak)
    if leak then
        return S_FAULT
    end
    if p >= 150 then
        return S_LIVE
    end
    if p > 20 then
        return S_LOW
    end
    return S_DEAD
end

local function drawHydroDiagram()
    for i = 1, #HYD do
        local s = HYD[i]
        local x = colX(s.col, 3, HG.COL)
        local cx = x + HG.CW / 2
        local p1, p2 = x + HG.PW / 2, x + HG.CW - HG.PW / 2
        local ret = x + HG.CW + HG.RETX

        local press = readv("tu-154/hydro/gs_press_" .. s.n)
        local leak = readv("tu-154/failures/hydro_leak_" .. s.n) > 0.5
        local qty = readv("tu-154/hydro/gs_qty_" .. s.n)
        local tank = readv("tu-154/hydro/gs_bak_qty_" .. s.n)
        local st = pressState(press, leak)

        -- ---- reservoir ---------------------------------------------------
        listNode(x, HG.TANK, HG.CW, LN_H3, "RESERVOIR " .. s.n,
            leak and S_FAULT or (tank > 1 and S_LIVE or S_DEAD), {
                { "in tank", fmt(tank, 1) .. " l", hd = true },
                { "system total", fmt(qty, 1) .. " l", leak and S_FAULT or nil },
                { "leak", leak and "LEAKING" or "OK", leak and S_FAULT or nil },
            }, qty / s.full)

        -- ---- pumps -------------------------------------------------------
        -- plumbing first, symbols second: a pump drawn before the line it sits
        -- on gets painted over by it
        wire(st, cx, Y(HG.TANK + LN_H3), cx, Y(HG.PJ))
        arrow(cx, (Y(HG.TANK + LN_H3) + Y(HG.PJ)) / 2, 0, -1, st)
        wire(st, p1, Y(HG.PJ), p2, Y(HG.PJ))
        wire(st, p1, Y(HG.PJ), p1, Y(HG.PUMP))
        wire(st, p2, Y(HG.PJ), p2, Y(HG.PUMP))
        junction(cx, Y(HG.PJ), st)
        wire(st, p1, Y(HG.SJ), p2, Y(HG.SJ))
        wire(st, cx, Y(HG.SJ), cx, Y(HG.SYS))
        junction(cx, Y(HG.SJ), st)
        arrow(cx, (Y(HG.SJ) + Y(HG.SYS)) / 2, 0, -1, st)

        for k = 1, 2 do
            local pm = s.pumps[k]
            local px = (k == 1) and x or (x + HG.CW - HG.PW)
            local bad = readv(pm.fail) > 0.5
            local pst, rows
            if pm.eng then
                local rpm = readv("tu-154/gauges/engine/rpm_high_" .. pm.eng)
                local flow = readv(pm.flow)
                if bad then
                    pst = S_FAULT
                elseif flow > 0.01 then
                    pst = S_LIVE
                elseif rpm > 10 then
                    pst = S_STBY
                else
                    pst = S_DEAD
                end
                rows = {
                    { "driven by", "ENG " .. pm.eng, note = true },
                    { "HP rpm", fmt(rpm, 0) .. " %" },
                    { "delivery", fmt(flow, 2) .. " l/s", pst, hd = true },
                    { "state", bad and "FAILED"
                        or (pst == S_LIVE and "DELIVERING" or (pst == S_STBY and "IDLE" or "STOPPED")) },
                }
            else
                local run = readv(pm.work) > 0.5
                local swOn = readv(pm.sw) > 0.5
                if bad then
                    pst = S_FAULT
                elseif run then
                    pst = S_LIVE
                elseif swOn then
                    pst = S_STBY
                else
                    pst = S_DEAD
                end
                rows = {
                    { "supply", pm.supply, note = true },
                    { "current", fmt(readv(pm.amp), 1) .. " A", hd = true },
                    { "switch", swOn and "ON" or "OFF" },
                    { "state", bad and "FAILED"
                        or (run and "RUNNING" or (swOn and "NO SUPPLY" or "OFF")), pst },
                }
            end
            listNode(px, HG.PUMP, HG.PW, LN_H4, pm.t, pst, rows)
            local pcx = (k == 1) and p1 or p2
            wire(pst, pcx, Y(HG.PUMP + LN_H4), pcx, Y(HG.SJ))
            pumpSym(pcx, (Y(HG.PJ) + Y(HG.PUMP)) / 2, pst == S_LIVE, pst)
            arrow(pcx, (Y(HG.PUMP + LN_H4) + Y(HG.SJ)) / 2, 0, -1, pst)
        end

        -- ---- accumulator and pressure ------------------------------------
        local lowLamp = readv("tu-154/lights/small/front_hydr_fail_" .. s.n) > 0.5
        listNode(x, HG.SYS, HG.CW, LN_H5, "HYDRAULIC SYSTEM " .. s.n, st, {
            { "pressure", fmt(press, 0) .. " kg/cm2", st, hd = true },
            { "gauge", fmt(readv("tu-154/gauges/hydro/pressure_ind_" .. s.n), 1) },
            { "accumulator", fmt(press / 50, 2) .. " l" },
            { "low press lamp", lowLamp and "ON" or "OFF", lowLamp and S_FAULT or nil },
            { "nominal", "210 kg/cm2", note = true },
        }, press / 210)

        -- ---- consumers ---------------------------------------------------
        local bst = readv("tu-154/hydro/booster_" .. s.n) > 0.5
        local bsw = readv("tu-154/switchers/console/buster_on_" .. s.n) > 0.5
        listNode(x, HG.CONS, HG.CW, LN_H5, "CONSUMERS " .. s.n,
            (bst and st == S_LIVE) and S_LIVE or (bst and S_LOW or S_DEAD), {
                { "booster " .. s.n, bst and "ENGAGED" or "OFF", bst and S_LIVE or nil, hd = true },
                { "switch", bsw and "ON" or "OFF", (bst ~= bsw) and S_LOW or nil },
                { "feeds", s.feeds, note = true },
                { "returns to", "reservoir " .. s.n, note = true },
                { "fed at", fmt(press, 0) .. " kg/cm2", st },
            })
        wire(st, cx, Y(HG.SYS + LN_H5), cx, Y(HG.CONS))
        arrow(cx, (Y(HG.SYS + LN_H5) + Y(HG.CONS)) / 2, 0, -1, st)

        -- ---- return leg, up the channel to the right of the column -------
        wire(st, cx, Y(HG.CONS + LN_H5), cx, Y(HG.RET), ret, Y(HG.RET))
        wire(st, ret, Y(HG.RET), ret, Y(HG.TANK + HG.RETY), x + HG.CW, Y(HG.TANK + HG.RETY))
        arrow(ret, (Y(HG.RET) + Y(HG.TANK + HG.RETY)) / 2, 0, 1, st)
    end

    -- ---- the HS2 -> HS1 cross-feed, drawn between the two systems ---------
    local x1 = colX(1, 3, HG.COL)
    local xsw = readv("tu-154/switchers/hydro/connect2to1") > 0.5
    local xflow = readv("tu-154/hydro/connect_2to1") > 0.5
    local xst = xflow and S_LIVE or (xsw and S_STBY or S_DEAD)
    -- it passes behind system 1's return channel on the way across
    barWithJumps(HG.SYS + HG.XFD, x1 + HG.CW, colX(2, 3, HG.COL), xst, { x1 + HG.CW + HG.RETX })
    valveSym((x1 + HG.CW + colX(2, 3, HG.COL)) / 2 + 4, Y(HG.SYS + HG.XFD), xst == S_LIVE, xst)
    -- clear of the valve's shut crossbar, which reaches SYS + 31
    sasl.gl.drawText(font, (x1 + HG.CW + colX(2, 3, HG.COL)) / 2 + 4, Y(HG.SYS + 24),
        "2 -> 1", 11, false, false, TEXT_ALIGN_CENTER, stateCol(xst))

    -- ---- the emergency brake accumulator ---------------------------------
    -- Charged out of HS 1, so tapped off the HS 1 consumer node: the same
    -- pressure, and the one route down that crosses no node. Offset from the
    -- centre so it does not run down the return leg.
    local p4 = readv("tu-154/hydro/gs_press_4")
    local leak4 = readv("tu-154/failures/hydro_leak_4") > 0.5
    local charging = readv("tu-154/hydro/accum_charge") > 0.5
    local lowLamp4 = readv("tu-154/lights/small/front_hydr_fail_4") > 0.5
    local chx = x1 + HG.CHX
    local chSt = charging and S_LIVE or (p4 > 50 and S_STBY or S_DEAD)
    wire(chSt, chx, Y(HG.CONS + LN_H5), chx, Y(HG.AUX))
    arrow(chx, (Y(HG.CONS + LN_H5) + Y(HG.AUX)) / 2, 0, -1, chSt)
    listNode(x1, HG.AUX, HG.CW, LN_H6, "EMERG BRAKE ACCUMULATOR", pressState(p4, leak4), {
        { "charged from", "HS 1 accumulator", note = true },
        { "pressure", fmt(p4, 0) .. " kg/cm2", pressState(p4, leak4), hd = true },
        { "gauge", fmt(readv("tu-154/gauges/hydro/pressure_ind_emerg"), 1) },
        { "low press lamp", lowLamp4 and "ON" or "OFF", lowLamp4 and S_FAULT or nil },
        { "leak", leak4 and "LEAKING" or "OK", leak4 and S_FAULT or nil },
        { "charging", charging and "YES" or "NO", charging and S_LIVE or nil },
    }, p4 / 210)

    local v27l = readv("tu-154/elec/bus27_volt_left")
    listNode(colX(2, 3, HG.COL), HG.AUX, HG.CW, LN_H6, "CROSS-FEED HS 2 -> HS 1", xst, {
        { "switch", xsw and "ON" or "OFF" },
        { "passing fluid", xflow and "YES" or "NO", xflow and S_LIVE or nil },
        { "needs", "27 V LEFT", note = true },
        { "27 V left", fmt(v27l, 1) .. " V", v27l > 13 and S_LIVE or S_DEAD },
        { "HS 1 pressure", fmt(readv("tu-154/hydro/gs_press_1"), 0) .. " kg/cm2" },
        { "HS 2 pressure", fmt(readv("tu-154/hydro/gs_press_2"), 0) .. " kg/cm2" },
    })

    local noG = readv("tu-154/lights/no_reserve_g") > 0.5
    local nwsPower = readv("tu-154/hydro/nosewheel_turn_power") > 0.5
    readout(colX(3, 3, HG.COL), HG.AUX, HG.CW, LN_H6, "TANK GAUGES AND WARNINGS",
        noG and S_FAULT or S_DEAD, {
            { "tanks 1+2 fluid", fmt(readv("tu-154/hydro/gs_qty_12_show"), 1) .. " l" },
            { "tanks 1+2 gauge", fmt(readv("tu-154/gauges/hydro/qty_12"), 1) },
            { "tank 3 fluid", fmt(readv("tu-154/hydro/gs_qty_3_show"), 1) .. " l" },
            { "tank 3 gauge", fmt(readv("tu-154/gauges/hydro/qty_3"), 1) },
            { "no standby G", noG and "ON" or "OFF", noG and S_FAULT or nil },
            -- nosewheel.lua: either 27 V bus, the steering switch, and HS 2 --
            -- not HS 1 -- above 20 % of its 200 kg/cm2
            { "nosewheel steering, HS 2", nwsPower and "POWERED" or "off",
              nwsPower and S_LIVE or nil },
        })

    drawLegend(LEG_D, HYD_LEGEND,
        "booster rows latch: they hold their last state when 27 V is lost",
        "Reservoir fill is against the 58 / 58 / 45 l hydro_logic fills each system to at load -- the only ceiling in the module rather than a limit it tests; system fill is pressure against 210 kg/cm2.")
end
DIAGRAMS.hydro = drawHydroDiagram
