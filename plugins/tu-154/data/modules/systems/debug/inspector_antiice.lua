-- ---------------------------------------------------------------------------
-- Anti-ice one-line diagram (the Ice tab)
--
-- Two separate heat media, one band each:
--   HOT AIR  -- wing, stabiliser and the three engine inlets. `wing_heat` is
--               gated on ANY HP spool over 50 %, `inlet_heat_N` on engine N's
--               own: losing two engines leaves the wing heated and two inlets
--               cold. The collector bar is there to show that.
--   ELECTRIC -- slats, the three heated windows, the pitot/AOA probes. Each
--               names its own pair of buses in its rows.
-- The bottom band is an unwired result read-out.
--
-- What a schematic drawn from the manual would get wrong: the wing switch
-- also drives the stabiliser duct (`stab_heat_t` integrates towards
-- `wing_heat * 300`), and a pitot switch at -1 is CHECK (see ENUM_PPD).
-- ---------------------------------------------------------------------------

local AI = {
    C3   = 340,  -- three-column node
    C4   = 275,  -- four-column node
    TOP  = 8,    -- detector, conditions, electrical load    (LN_H6 -> 107)
    AIRB = 143,  -- hot-air collector bar
    AIR  = 183,  -- wing + stabiliser, three engine inlets   (LN_H6 -> 282)
    ELB  = 318,  -- 115 V / 27 V supply bar
    ELEC = 358,  -- slats, three heated windows              (LN_H6 -> 457)
    OUT  = 493,  -- probes, ice accreted, what the sim gets  (LN_H6 -> 592)
}
-- the supply gaps are 80 px (a bar, junctions and a symbol per drop); the gap
-- above the result band carries nothing, so it stays at 40

-- engine 1 hangs off 27 V LEFT, engines 2 and 3 off 27 V RIGHT; note that
-- engine 1's inlet failure is the only one of the three without a digit
local AI_ENG = {
    { bus = "left",  vd = "tu-154/elec/bus27_volt_left",
      fail = "sim/operation/failures/rel_ice_inlet_heat" },
    { bus = "right", vd = "tu-154/elec/bus27_volt_right",
      fail = "sim/operation/failures/rel_ice_inlet_heat2" },
    { bus = "right", vd = "tu-154/elec/bus27_volt_right",
      fail = "sim/operation/failures/rel_ice_inlet_heat3" },
}

-- window 1 is the captain's and runs off 115 V/1 + 27 L; windows 2 and 3 share
-- 115 V/3 + 27 R, which is why one 115 V bus takes two windows' worth of load
local AI_WIN = {
    { dcn = "27 V left",  dc = "tu-154/elec/bus27_volt_left",
      acn = "115 V bus 1", ac = "tu-154/elec/bus115_1_volt" },
    { dcn = "27 V right", dc = "tu-154/elec/bus27_volt_right",
      acn = "115 V bus 3", ac = "tu-154/elec/bus115_3_volt" },
    { dcn = "27 V right", dc = "tu-154/elec/bus27_volt_right",
      acn = "115 V bus 3", ac = "tu-154/elec/bus115_3_volt" },
}

local AI_LEGEND = {
    { S_LIVE,  "heating" },
    { S_STBY,  "selected, not heating" },
    { S_LOW,   "ice present" },
    { S_DEAD,  "off or unpowered" },
    { S_FAULT, "failed" },
}

local function drawAntiIceDiagram()
    -- antiice_logic.lua's own bus tests, written out rather than NOM_*: that
    -- module is what decides whether the heaters run
    local v27l = readv("tu-154/elec/bus27_volt_left")
    local v27r = readv("tu-154/elec/bus27_volt_right")
    local dcL, dcR = v27l > 13, v27r > 13
    local dcAny = dcL or dcR
    local ac1 = readv("tu-154/elec/bus115_1_volt")
    local ac2 = readv("tu-154/elec/bus115_2_volt")
    local ac3 = readv("tu-154/elec/bus115_3_volt")

    local oat = readv("sim/weather/aircraft/temperature_ambient_deg_c")
    local rate = readv("tu-154/antiice/ice_speed")
    -- the slat interlock tests each main-gear strut separately, not the sum
    local onGround = not (readv("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]") < 0.1
        and readv("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]") < 0.1)

    -- ---- SOI-21 ice detector ---------------------------------------------
    local soiOn = readv("tu-154/switchers/eng/soi21_on") > 0.5
    local rio = readv("tu-154/failures/rio_fail") > 0.5
    local iceDet = readv("tu-154/antiice/ice_detected") > 0.5
    local soiOk = readv("tu-154/antiice/ice_detect_ok") > 0.5
    local iceClk = readv("tu-154/antiice/soi_ice_timer")
    local soiSt
    if rio then
        soiSt = S_FAULT
    elseif not (soiOn and dcL and dcR) then
        soiSt = S_DEAD
    else
        soiSt = iceDet and S_LIVE or S_STBY
    end

    listNode(colX(1, 3, AI.C3), AI.TOP, AI.C3, LN_H6, "SOI-21 ICE DETECTOR", soiSt, {
        { "switch", soiOn and "ON" or "OFF", soiOn and S_LIVE or S_DEAD },
        { "needs 27 V left AND right", fmt(v27l, 1) .. " / " .. fmt(v27r, 1) .. " V",
          (dcL and dcR) and S_LIVE or S_DEAD },
        { "ice detected", iceDet and "YES" or "no", iceDet and S_LIVE or nil },
        { "detection holds", iceClk < 8 and (fmt(8 - iceClk, 1) .. " s more") or "-",
          (iceDet and iceClk < 8) and S_LIVE or nil },
        { "test clock (answers 30-55 s)",
          fmt(readv("tu-154/antiice/soi_test_timer"), 0) .. " s",
          soiOk and S_LIVE or nil },
        { "RIO-3 failure", rio and "FAILED" or "ok", rio and S_FAULT or nil },
    })

    -- ---- what the airframe is flying through -------------------------------
    local master = readv("scp/api/ismaster") ~= 1
    readout(colX(2, 3, AI.C3), AI.TOP, AI.C3, LN_H6, "ICING CONDITIONS",
        rate > 0 and S_LOW or S_DEAD, {
            { "outside air", fmt(oat, 1) .. " C", oat < 5 and S_LOW or nil, hd = true },
            { "indicated airspeed", fmt(readv("sim/flightmodel/position/indicated_airspeed"), 0)
              .. " kt" },
            { "icing rate", fmt(rate, 4) .. " /s", rate > 0 and S_LOW or nil },
            { "windshield ice input",
              fmt(readv("sim/flightmodel/failures/window_ice"), 2) .. " (re-centred to 0.5)" },
            { "on the ground", onGround and "YES" or "no" },
            -- NOT `master and nil or S_STBY`: that is always S_STBY (CLAUDE.md 14)
            { "SmartCopilot", master and "computing" or "slave, values synced",
              (not master) and S_STBY or nil },
        })

    -- ---- what all of it costs ----------------------------------------------
    local l27l = readv("tu-154/antiice/ai_27_L_cc")
    local l27r = readv("tu-154/antiice/ai_27_R_cc")
    local l1 = readv("tu-154/antiice/ai_115_1_cc")
    local l2 = readv("tu-154/antiice/ai_115_2_cc")
    local l3 = readv("tu-154/antiice/ai_115_3_cc")
    local total = l27l + l27r + l1 + l2 + l3
    readout(colX(3, 3, AI.C3), AI.TOP, AI.C3, LN_H6, "ANTI-ICE ELECTRICAL LOAD",
        total > 0 and S_LIVE or S_DEAD, {
            { "27 V left (pitot 1, AOA)", fmt(l27l, 1) .. " A", l27l > 0 and S_LIVE or nil },
            { "27 V right (pitot 2, 3)", fmt(l27r, 1) .. " A", l27r > 0 and S_LIVE or nil },
            { "115 V bus 1 (window 1)", fmt(l1, 1) .. " A", l1 > 0 and S_LIVE or nil },
            { "115 V bus 2 (slats)", fmt(l2, 1) .. " A", l2 > 0 and S_LIVE or nil },
            { "115 V bus 3 (windows 2, 3)", fmt(l3, 1) .. " A", l3 > 0 and S_LIVE or nil },
            { "total", fmt(total, 1) .. " A", total > 0 and S_LIVE or nil, hd = true },
        })

    -- ---- hot air: the wing runs on any spool, an inlet only on its own ------
    local rpm = { readv("tu-154/gauges/engine/rpm_high_1"),
                  readv("tu-154/gauges/engine/rpm_high_2"),
                  readv("tu-154/gauges/engine/rpm_high_3") }
    local anySpool = rpm[1] > 50 or rpm[2] > 50 or rpm[3] > 50
    local hotSt = anySpool and S_LIVE or S_DEAD
    local wingCx = colC(1, 4, AI.C4)

    local wingSw = readv("tu-154/switchers/eng/antiice_wing") > 0.5
    local surfFail = readv("sim/operation/failures/rel_ice_surf_heat") >= 6
    local wingOn = readv("tu-154/antiice/wing_heating") > 0.5
    local wingT = readv("tu-154/antiice/wing_heat_t")
    local wingSt
    if surfFail then
        wingSt = S_FAULT
    elseif wingOn then
        wingSt = S_LIVE
    else
        wingSt = wingSw and S_STBY or S_DEAD
    end

    wire(hotSt, wingCx, Y(AI.AIRB), colC(4, 4, AI.C4), Y(AI.AIRB))
    wire(hotSt, wingCx, Y(AI.AIRB), wingCx, Y(AI.AIR))
    junction(wingCx, Y(AI.AIRB), hotSt)
    -- the bar collects towards the wing, so the heads point that way
    for i = 1, 3 do
        arrow((colC(i, 4, AI.C4) + colC(i + 1, 4, AI.C4)) / 2, Y(AI.AIRB), -1, 0, hotSt)
    end
    arrow(wingCx, (Y(AI.AIRB) + Y(AI.AIR)) / 2, 0, -1, wingSt)
    band(AI.AIRB - 11, "HOT AIR")
    -- 11 above the bar, not 9: at 9 the chevron tips reach the descenders
    sasl.gl.drawText(font, W - PAD, Y(AI.AIRB - 11),
        "ANY SPOOL FEEDS THE WING, EACH INLET ONLY ITS OWN", 11, false, false,
        TEXT_ALIGN_RIGHT, COL_DIM)

    listNode(colX(1, 4, AI.C4), AI.AIR, AI.C4, LN_H6, "WING + STABILISER", wingSt, {
        { "one switch, both ducts", wingSw and "ON" or "OFF", wingSw and S_LIVE or S_DEAD },
        { "hot air", anySpool and "AVAILABLE" or "no spool", hotSt },
        { "27 V, either bus", fmt(math.max(v27l, v27r), 1) .. " V",
          dcAny and S_LIVE or S_DEAD },
        { "heater failure", surfFail and "FAILED" or "ok", surfFail and S_FAULT or nil },
        { "wing duct / gauge", fmt(wingT, 0) .. " / "
          .. fmt(readv("tu-154/gauges/eng/wing_temp"), 0) .. " C" },
        { "stab duct / gauge", fmt(readv("tu-154/antiice/stab_heat_t"), 0) .. " / "
          .. fmt(readv("tu-154/gauges/eng/stab_temp"), 0) .. " C" },
    }, clamp(0, wingT / 300, 1))

    local inletHeat = {}
    for i = 1, 3 do
        local e = AI_ENG[i]
        local cx = colC(i + 1, 4, AI.C4)
        local spool = rpm[i] > 50
        local sw = readv("tu-154/switchers/eng/antiice_eng_" .. i) > 0.5
        local dc = readv(e.vd) > 13
        local fail = readv(e.fail) >= 6
        local flap = readv("tu-154/antiice/eng_heat_open_" .. i) > 0.5
        local heat = readv("sim/cockpit2/ice/ice_inlet_heat_on_per_engine[" .. (i - 1) .. "]") > 0.5
        inletHeat[i] = heat
        local st
        if fail then
            st = S_FAULT
        elseif heat then
            st = S_LIVE
        else
            st = (sw and dc) and S_STBY or S_DEAD
        end
        wire(spool and S_LIVE or S_DEAD, cx, Y(AI.AIRB), cx, Y(AI.AIR))
        junction(cx, Y(AI.AIRB), spool and S_LIVE or S_DEAD)
        valveSym(cx, (Y(AI.AIRB) + Y(AI.AIR)) / 2, flap, st, true)
        listNode(colX(i + 1, 4, AI.C4), AI.AIR, AI.C4, LN_H6, "ENGINE " .. i .. " INLET", st, {
            { "switch", sw and "ON" or "OFF", sw and S_LIVE or S_DEAD },
            { "27 V " .. e.bus, fmt(readv(e.vd), 1) .. " V", dc and S_LIVE or S_DEAD },
            { "own HP spool, needs 50", fmt(rpm[i], 0) .. " %", spool and S_LIVE or S_DEAD },
            { "heat flap", flap and "OPEN" or "shut", flap and S_LIVE or nil },
            { "inlet heat to sim", heat and "ON" or "off", heat and S_LIVE or nil, hd = true },
            { "heater failure", fail and "FAILED" or "ok", fail and S_FAULT or nil },
        })
    end

    -- ---- electric heat -----------------------------------------------------
    local elSt = (dcAny and (ac1 > 110 or ac2 > 110 or ac3 > 110)) and S_LIVE or S_DEAD
    wire(elSt, wingCx, Y(AI.ELB), colC(4, 4, AI.C4), Y(AI.ELB))
    band(AI.ELB - 9, "ELECTRIC, 115 V AND 27 V")
    sasl.gl.drawText(font, W - PAD, Y(AI.ELB - 9),
        "EACH CONSUMER HAS ITS OWN PAIR OF BUSES", 11, false, false,
        TEXT_ALIGN_RIGHT, COL_DIM)

    local slatSw = readv("tu-154/switchers/eng/antiice_slats") > 0.5
    local slatOn = readv("tu-154/antiice/slat_heating") > 0.5
    local slatFail = readv("sim/operation/failures/rel_ice_surf_heat2") >= 6
    local slatSt
    if slatFail then
        slatSt = S_FAULT
    elseif slatOn then
        slatSt = S_LIVE
    else
        slatSt = slatSw and S_STBY or S_DEAD
    end
    wire(slatSt, wingCx, Y(AI.ELB), wingCx, Y(AI.ELEC))
    junction(wingCx, Y(AI.ELB), slatSt)
    heaterSym(wingCx, (Y(AI.ELB) + Y(AI.ELEC)) / 2, slatSt)
    listNode(colX(1, 4, AI.C4), AI.ELEC, AI.C4, LN_H6, "SLAT HEAT", slatSt, {
        { "switch", slatSw and "ON" or "OFF", slatSw and S_LIVE or S_DEAD },
        { "115 V bus 2", fmt(ac2, 0) .. " V", ac2 > 110 and S_LIVE or S_DEAD },
        { "27 V, either bus", fmt(math.max(v27l, v27r), 1) .. " V",
          dcAny and S_LIVE or S_DEAD },
        { "ground interlock", onGround and "ON GROUND" or "airborne",
          onGround and S_DEAD or nil },
        { "heater failure", slatFail and "FAILED" or "ok", slatFail and S_FAULT or nil },
        { "heating", slatOn and "ON" or "off", slatOn and S_LIVE or nil, hd = true },
    })

    local glassIce = {}
    for i = 1, 3 do
        local w = AI_WIN[i]
        local cx = colC(i + 1, 4, AI.C4)
        local sw = readv("tu-154/switchers/ovhd/window_heat_" .. i)
        local acv = readv(w.ac)
        local dcv = readv(w.dc)
        local fail = readv("tu-154/failures/window_heat_fail_" .. i) > 0.5
        local heat = readv("tu-154/antiice/window_heat_rate_" .. i)
        local ice = readv("tu-154/anim/window_ice_" .. i)
        glassIce[i] = ice
        local st
        if fail then
            st = S_FAULT
        elseif heat > 0 then
            st = S_LIVE
        else
            st = (math.abs(sw) > 0.5) and S_STBY or S_DEAD
        end
        wire(st, cx, Y(AI.ELB), cx, Y(AI.ELEC))
        junction(cx, Y(AI.ELB), st)
        heaterSym(cx, (Y(AI.ELB) + Y(AI.ELEC)) / 2, st)
        listNode(colX(i + 1, 4, AI.C4), AI.ELEC, AI.C4, LN_H6, "WINDOW " .. i .. " HEAT", st, {
            { "switch", enumTxt(ENUM_WIN_HEAT, sw), math.abs(sw) > 0.5 and S_LIVE or S_DEAD },
            { w.dcn, fmt(dcv, 1) .. " V", dcv > 13 and S_LIVE or S_DEAD },
            { w.acn, fmt(acv, 0) .. " V", acv > 110 and S_LIVE or S_DEAD },
            { "element failure", fail and "FAILED" or "ok", fail and S_FAULT or nil },
            { "heat delivered", fmt(heat, 3) .. " /s", heat > 0 and S_LIVE or nil, hd = true },
            { "ice on the glass", fmt(ice, 2), ice > 0.1 and S_LOW or nil },
        })
    end

    band(AI.OUT - 5, "PROBES AND RESULTS")
    -- ---- probes ------------------------------------------------------------
    local p1 = readv("tu-154/switchers/ovhd/pitot_heat_1")
    local p2 = readv("tu-154/switchers/ovhd/pitot_heat_2")
    local p3 = readv("tu-154/switchers/ovhd/pitot_heat_3")
    local pf1 = readv("sim/operation/failures/rel_ice_pitot_heat1") >= 6
    local pf2 = readv("sim/operation/failures/rel_ice_pitot_heat2") >= 6
    local pf3 = readv("tu-154/antiice/ppd_3_heat_fail") > 0.5
    local lamps = ""
    for i = 1, 3 do
        if readv("tu-154/lights/small/heat_ok_" .. i) > 0.05 then
            lamps = lamps .. (lamps == "" and "" or " ") .. i
        end
    end
    local anyPitot = p1 > 0.5 or p2 > 0.5 or p3 > 0.5
    local aoaOn = readv("sim/cockpit2/ice/ice_AOA_heat_on") > 0.5
    listNode(colX(1, 3, AI.C3), AI.OUT, AI.C3, LN_H6, "PITOT AND AOA HEAT (PPD)",
        (pf1 or pf2 or pf3) and S_FAULT or (anyPitot and S_LIVE or S_DEAD), {
            { "PPD-1 left, 27 V left", enumTxt(ENUM_PPD, p1),
              pf1 and S_FAULT or (p1 > 0.5 and S_LIVE or nil) },
            { "PPD-2 right, 27 V right", enumTxt(ENUM_PPD, p2),
              pf2 and S_FAULT or (p2 > 0.5 and S_LIVE or nil) },
            { "PPD-3 ABSU, 27 V right", enumTxt(ENUM_PPD, p3),
              pf3 and S_FAULT or (p3 > 0.5 and S_LIVE or nil) },
            { "AOA vanes follow PPD-1", onoff(aoaOn), aoaOn and S_LIVE or nil },
            { "HEAT OK lamps lit", lamps == "" and "none" or lamps,
              lamps ~= "" and S_LIVE or nil },
            { "load 27 V left / right", fmt(l27l, 1) .. " / " .. fmt(l27r, 1) .. " A" },
        })

    -- ---- what actually stuck ----------------------------------------------
    local iwL = readv("tu-154/antiice/ice_wing_L")
    local iwR = readv("tu-154/antiice/ice_wing_R")
    local isL = readv("tu-154/antiice/ice_slat_L")
    local isR = readv("tu-154/antiice/ice_slat_R")
    local w4 = readv("tu-154/anim/window_ice_4")
    local frmL = readv("sim/flightmodel/failures/frm_ice")
    local frmR = readv("sim/flightmodel/failures/frm_ice2")
    local frm = math.max(frmL, frmR)
    readout(colX(2, 3, AI.C3), AI.OUT, AI.C3, LN_H6, "ICE ACCRETED",
        frm > 0.05 and S_LOW or S_DEAD, {
            { "wing L / R, bleed heated", fmt(iwL, 3) .. " / " .. fmt(iwR, 3),
              math.max(iwL, iwR) > 0.05 and S_LOW or nil },
            { "slat L / R, capped at 0.20", fmt(isL, 3) .. " / " .. fmt(isR, 3),
              math.max(isL, isR) > 0.05 and S_LOW or nil },
            { "to flight model L / R", fmt(frmL, 3) .. " / " .. fmt(frmR, 3),
              frm > 0.05 and S_LOW or nil },
            { "glass 1 / 2 / 3", fmt(glassIce[1], 2) .. " / " .. fmt(glassIce[2], 2) .. " / "
              .. fmt(glassIce[3], 2) },
            { "glass 4, no heater at all", fmt(w4, 2), w4 > 0.1 and S_LOW or nil },
            { "warm air can melt it", oat > 0 and "yes" or "no, below zero",
              oat > 0 and S_LIVE or nil },
        }, clamp(0, frm, 1))

    -- ---- and what the sim was told -----------------------------------------
    local si1, si2, si3 = inletHeat[1], inletHeat[2], inletHeat[3]
    local surf = readv("sim/cockpit2/ice/ice_surfce_heat_on") > 0.5
    readout(colX(3, 3, AI.C3), AI.OUT, AI.C3, LN_H6, "WHAT THE SIM IS TOLD",
        (surf or si1 or si2 or si3) and S_LIVE or S_DEAD, {
            { "ice_surfce_heat_on (wing)", onoff(surf), surf and S_LIVE or nil },
            { "inlet heat 1 / 2 / 3",
              onoff(si1) .. " / " .. onoff(si2) .. " / " .. onoff(si3),
              (si1 or si2 or si3) and S_LIVE or nil },
            { "pitot heat pilot / copilot",
              onoff(readv("sim/cockpit2/ice/ice_pitot_heat_on_pilot") > 0.5) .. " / "
              .. onoff(readv("sim/cockpit2/ice/ice_pitot_heat_on_copilot") > 0.5) },
            { "AOA heat pilot / copilot",
              onoff(aoaOn) .. " / "
              .. onoff(readv("sim/cockpit2/ice/ice_AOA_heat_on_copilot") > 0.5) },
            { "ice_window_heat_on", "held at 0", note = true },
            { "the glass is modelled here", "anim/window_ice_1..4", note = true },
        })

    drawLegend(LEG_D, AI_LEGEND,
        "antiice/stab_heat_open is created but nothing writes it",
        "27 V is tested at >13 and 115 V at >110 here, the thresholds antiice_logic.lua itself uses. A pitot switch at CHECK lights the HEAT OK lamp without powering the element.")
end
DIAGRAMS.antiice = drawAntiIceDiagram
