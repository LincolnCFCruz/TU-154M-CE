-- ---------------------------------------------------------------------------
-- Bleed air / conditioning / pressurisation one-line diagram (the Air tab)
--
-- Top-down along the air path: the four bleed sources, the centre section that
-- shares ENG 2 and the APU between both sides, the two manifolds, the hot
-- header and the two turbo-coolers, the hot and cold distribution manifolds,
-- the four conditioned zones, the cabin and the outflow valve.
--
-- The 50/50 centre section is the `* 0.5` on ENG 2 and the APU in
-- kskv_bleed.lua: it lets ENG 1 own the left manifold and ENG 3 the right one
-- without any line crossing another.
-- ---------------------------------------------------------------------------

local AG = {
    SRC    = 8,    -- engine and APU bleed sources
    TEE    = 104,  -- the ENG 1 / ENG 3 elbow into the side trunks
    CTR    = 112,  -- centre section (ENG 2 + APU)
    MAN    = 168,  -- left / right manifolds
    HELB   = 262,  -- manifold -> hot header elbow
    CND    = 274,  -- turbo-coolers
    HDR    = 280,  -- hot header (shorter, so centred in the same row)
    HOT    = 358,  -- hot air manifold
    COLD   = 378,  -- cold air manifold
    ZONE   = 398,  -- door heat / cockpit / cabin 1 / cabin 2
    CBAR   = 492,  -- cabin collector
    PRS    = 517,  -- outflow valve, cabin, panel, duct gauge
    OUTL   = 34,   -- the outflow valve -> cabin line, below PRS
    ZW     = 275,  -- zone / pressurisation column width
    SW     = 267,  -- source column width
}
-- every source and trunk drop is long enough to carry its valve

-- x: columns from colX / colC, and every offset a wire takes from a node
AG.C = {}
for i = 1, 4 do
    AG.C[i] = colC(i, 4, AG.SW)
end
AG.MIDX = CONTENT_L + CONTENT_W / 2 -- the centre section, the hot header
AG.MANW = 330                       -- manifold width
AG.TTHW = 300                       -- turbo-cooler width
AG.HDRW = 300                       -- hot and cold headers width
AG.CTRW = 380                       -- centre-section box width
AG.ML, AG.MR = CONTENT_L, CONTENT_L + CONTENT_W - AG.MANW
AG.TL, AG.TR = CONTENT_L, CONTENT_L + CONTENT_W - AG.TTHW
AG.HX = AG.MIDX - AG.HDRW / 2
AG.HLEG = 40  -- manifold -> hot header legs, in from each manifold's inner edge
AG.HIN  = 80  -- where those legs enter the header, in from its ends
AG.HTAP = 102 -- a zone's hot tap, from its column's left edge
AG.CTAP = 172 -- and its cold tap
AG.CIN  = 15  -- the cold ducts' drops, in from the turbo-coolers' outer edges
AG.HARR = 240 -- the hot manifold's flow heads, either side of the centre
AG.CARL, AG.CARR = 43, 40 -- the cold manifold's heads, in from the two drops

local AIR_VLV  = { [-1] = "CLOSE", [0] = "NEUTRAL", [1] = "OPEN" }
local AIR_MODE = { [0] = "NEUTRAL", [1] = "AUTO", [2] = "COLD", [3] = "HOT" }
local AIR_FAST = { [-1] = "COOL", [0] = "OFF", [1] = "HEAT" }
local AIR_TUE  = { [0] = "DOOR HEAT", [1] = "COCKPIT", [2] = "CABIN 1", [3] = "CABIN 2",
                   [4] = "COLD DUCT 1", [5] = "COLD DUCT 2" }

-- ENG 2 sits between ENG 1 and the APU because it feeds the centre section,
-- not because of where it is on the aeroplane
local AIR_ENG = {
    { n = 1, col = 1, cx = AG.C[1] },
    { n = 2, col = 2, cx = AG.C[2] },
    { n = 3, col = 4, cx = AG.C[4] },
}

local AIR_ZONES = {
    { col = 2, t = "COCKPIT", tue = 1,
      duct = "tu-154/bleed/cockpit_tube_t", air = "tu-154/bleed/cockpit_temp",
      set = "tu-154/switchers/airbleed/cockpit_temp_set",
      mode = "tu-154/switchers/airbleed/cockpit_mode_set",
      reg = "tu-154/bleed/reg_cockpit", regmax = 0.5 },
    { col = 3, t = "CABIN 1", tue = 2,
      duct = "tu-154/bleed/cabin1_tube_t", air = "tu-154/bleed/cabin_1_temp",
      set = "tu-154/switchers/airbleed/cabin1_temp_set",
      mode = "tu-154/switchers/airbleed/cabin1_mode_set",
      reg = "tu-154/bleed/reg_cabin1", regmax = 0.5 },
    { col = 4, t = "CABIN 2", tue = 3,
      duct = "tu-154/bleed/cabin2_tube_t", air = "tu-154/bleed/cabin_2_temp",
      set = "tu-154/switchers/airbleed/cabin2_temp_set",
      mode = "tu-154/switchers/airbleed/cabin2_mode_set",
      reg = "tu-154/bleed/reg_cabin2", regmax = 0.5 },
}
for _, z in ipairs(AIR_ZONES) do
    z.cx = colC(z.col, 4, AG.ZW) -- where each zone drops into the cabin collector
end

local AIR_LEGEND = {
    { S_LIVE,  "flowing / on setpoint" },
    { S_STBY,  "available, valve shut" },
    { S_LOW,   "off setpoint" },
    { S_DEAD,  "no flow" },
    { S_FAULT, "failed" },
}

-- the flow at which kskv_bleed's PSVP regulation is doing something (it holds
-- 590..620), used only to decide whether a duct is carrying air
local function airState(f)
    if f > 50 then
        return S_LIVE
    end
    if f > 5 then
        return S_LOW
    end
    return S_DEAD
end

local function ductState(fail, flowing, regulating, temp, target, band)
    if fail then
        return S_FAULT
    end
    if not flowing then
        return S_DEAD
    end
    if regulating and math.abs(temp - target) > band then
        return S_LOW
    end
    return S_LIVE
end

-- a mixer position as a percentage of hot air, for the zone and duct nodes
local function mixTxt(v, maxv)
    return fmt(v / maxv * 100, 0) .. " % hot"
end

local function drawAirDiagram()
    local flowL = readv("tu-154/bleed/air_usage_L")
    local flowR = readv("tu-154/bleed/air_usage_R")
    local flowT = flowL + flowR
    local stL, stR, stT = airState(flowL), airState(flowR), airState(flowT)
    local tue = math.floor(readv("tu-154/switchers/airbleed/sys_temp_select") + 0.5)

    -- ---- bleed sources ---------------------------------------------------
    local engSt, engVlv = {}, {}
    for i = 1, #AIR_ENG do
        local e = AIR_ENG[i]
        local rpm = readv("tu-154/gauges/engine/rpm_high_" .. e.n)
        local vlv = readv("tu-154/bleed/eng_airvalve_" .. e.n)
        local cmd = readv("tu-154/switchers/airbleed/eng_valve_" .. e.n) > 0.5
        local bad = readv("tu-154/failures/airbleed_" .. e.n) > 0.5
        local st
        if bad then
            st = S_FAULT
        elseif rpm > 10 and vlv > 0.05 then
            st = S_LIVE
        elseif rpm > 10 then
            st = S_STBY
        else
            st = S_DEAD
        end
        engSt[e.n] = st
        engVlv[e.n] = vlv
        listNode(colX(e.col, 4, AG.SW), AG.SRC, AG.SW, LN_H3, "ENG " .. e.n, st, {
            { "HP rpm", fmt(rpm, 0) .. " %" },
            { "bleed valve", fmt(vlv * 100, 0) .. " %", st, hd = true },
            { "command", bad and "FAILED" or (cmd and "OPEN" or "SHUT") },
        }, vlv)
    end

    local apuRpm = readv("tu-154/eng/apu_n1")
    local apuDoor = readv("tu-154/eng/apu_air_doors")
    local apuSt = S_DEAD
    if apuRpm > 10 then
        apuSt = (apuDoor > 0.05) and S_LIVE or S_STBY
    end
    listNode(colX(3, 4, AG.SW), AG.SRC, AG.SW, LN_H3, "APU", apuSt, {
        { "rpm", fmt(apuRpm, 0) .. " %" },
        { "air door", fmt(apuDoor * 100, 0) .. " %", apuSt, hd = true },
        { "bleed", apuDoor > 0.05 and "OPEN" or "SHUT" },
    }, apuDoor)

    -- ---- centre section and the two trunks -------------------------------
    local startSys = readv("tu-154/start/start_sys_work") > 0.5
    local ctrSt
    if startSys then
        -- the main valves are driven shut for a start: procedure, not caution
        ctrSt = S_STBY
    else
        ctrSt = (engSt[2] == S_LIVE or apuSt == S_LIVE) and S_LIVE or S_DEAD
    end
    local ctrTxt = startSys and "ENGINE START -- main valves driven shut"
        or "ENG 2 + APU -- 50 / 50 to left and right"
    local cyb = Y(AG.CTR + 24)
    local cbx = AG.MIDX - AG.CTRW / 2
    sasl.gl.drawRectangle(cbx, cyb, AG.CTRW, 24, COL_CARD)
    sasl.gl.drawRectangle(cbx, cyb, 4, 24, stateCol(ctrSt))
    sasl.gl.drawFrame(cbx, cyb, AG.CTRW, 24, COL_FRAME)
    sasl.gl.drawText(font, AG.MIDX, cyb + 8, ctrTxt, 11, false, false, TEXT_ALIGN_CENTER,
        stateCol(ctrSt))

    local e1, e2, e3 = AIR_ENG[1].cx, AIR_ENG[2].cx, AIR_ENG[3].cx
    local apuX = AG.C[3]
    -- where each trunk meets its manifold: the manifold's centre
    local mLc = AG.ML + math.floor(AG.MANW / 2)
    local mRc = AG.MR + math.floor(AG.MANW / 2)
    wire(engSt[1], e1, Y(AG.SRC + LN_H3), e1, Y(AG.TEE), mLc, Y(AG.TEE))
    wire(engSt[3], e3, Y(AG.SRC + LN_H3), e3, Y(AG.TEE), mRc, Y(AG.TEE))
    wire(engSt[2], e2, Y(AG.SRC + LN_H3), e2, Y(AG.CTR))
    wire(apuSt, apuX, Y(AG.SRC + LN_H3), apuX, Y(AG.CTR))
    local srcMid = (Y(AG.SRC + LN_H3) + Y(AG.TEE)) / 2
    local ctrMid = (Y(AG.SRC + LN_H3) + Y(AG.CTR)) / 2
    valveSym(e1, srcMid, engVlv[1] > 0.05, engSt[1], true)
    valveSym(e3, srcMid, engVlv[3] > 0.05, engSt[3], true)
    valveSym(e2, ctrMid, engVlv[2] > 0.05, engSt[2], true)
    valveSym(apuX, ctrMid, apuDoor > 0.05, apuSt, true)
    wire(ctrSt, cbx, Y(AG.CTR + 12), mLc, Y(AG.CTR + 12))
    wire(ctrSt, cbx + AG.CTRW, Y(AG.CTR + 12), mRc, Y(AG.CTR + 12))
    wire(stL, mLc, Y(AG.TEE), mLc, Y(AG.MAN))
    wire(stR, mRc, Y(AG.TEE), mRc, Y(AG.MAN))
    -- two thirds down, not the midpoint: the top of this run is the trunk
    -- elbow, with its junction dot and the engine-start banner across it
    local manMid = Y(AG.TEE) + (Y(AG.MAN) - Y(AG.TEE)) * 0.66
    junction(mLc, Y(AG.CTR + 12), stL)
    junction(mRc, Y(AG.CTR + 12), stR)

    -- ---- manifolds -------------------------------------------------------
    local psvpLF = readv("tu-154/failures/psvp_fail_left") > 0.5
    local psvpRF = readv("tu-154/failures/psvp_fail_right") > 0.5
    local mvL = readv("tu-154/bleed/main_valve_L")
    local mvR = readv("tu-154/bleed/main_valve_R")
    valveSym(mLc, manMid, mvL > 0.05, stL, true)
    valveSym(mRc, manMid, mvR > 0.05, stR, true)
    local pvL = readv("tu-154/bleed/psvp_L")
    local pvR = readv("tu-154/bleed/psvp_R")
    local smooth = readv("tu-154/bleed/smooth_valve")
    listNode(AG.ML, AG.MAN, AG.MANW, LN_H5, "LEFT MANIFOLD", psvpLF and S_FAULT or stL, {
        { "flow", fmt(flowL, 0), stL, hd = true },
        { "main valve", fmt(mvL * 100, 0) .. " %", mvL > 0.5 and S_LIVE or S_DEAD },
        { "commanded", enumTxt(AIR_VLV, readv("tu-154/switchers/airbleed/air_valve_left")) },
        { "PSVP travel", fmt(pvL * 100, 0) .. " %", pvL > 0.5 and S_LIVE or S_DEAD },
        { "PSVP switch", psvpLF and "FAILED"
            or (readv("tu-154/switchers/airbleed/psvp_left_on") > 0.5 and "ON" or "OFF"),
            psvpLF and S_FAULT or nil },
    }, math.min(mvL, pvL))
    listNode(AG.MR, AG.MAN, AG.MANW, LN_H5, "RIGHT MANIFOLD", psvpRF and S_FAULT or stR, {
        { "flow", fmt(flowR, 0), stR, hd = true },
        { "main valve", fmt(mvR * 100, 0) .. " %", mvR > 0.5 and S_LIVE or S_DEAD },
        { "commanded", enumTxt(AIR_VLV, readv("tu-154/switchers/airbleed/air_valve_right")) },
        { "PSVP travel", fmt(pvR * 100, 0) .. " %", pvR > 0.5 and S_LIVE or S_DEAD },
        { "ground smoothing", fmt(smooth * 100, 0) .. " %", smooth > 0.01 and S_LIVE or nil },
    }, math.min(mvR + smooth, pvR + smooth, 1))

    -- each manifold into its turbo-cooler's centre, and across to the header
    local tLc, tRc = AG.TL + AG.TTHW / 2, AG.TR + AG.TTHW / 2
    local hl, hr = AG.ML + AG.MANW - AG.HLEG, AG.MR + AG.HLEG
    wire(stL, tLc, Y(AG.MAN + LN_H5), tLc, Y(AG.CND))
    wire(stR, tRc, Y(AG.MAN + LN_H5), tRc, Y(AG.CND))
    wire(stL, hl, Y(AG.MAN + LN_H5), hl, Y(AG.HELB), AG.HX + AG.HIN, Y(AG.HELB),
        AG.HX + AG.HIN, Y(AG.HDR))
    wire(stR, hr, Y(AG.MAN + LN_H5), hr, Y(AG.HELB), AG.HX + AG.HDRW - AG.HIN, Y(AG.HELB),
        AG.HX + AG.HDRW - AG.HIN, Y(AG.HDR))

    -- ---- turbo-coolers and the headers -----------------------------------
    local coldL = readv("tu-154/bleed/cold_tube1_t")
    local coldR = readv("tu-154/bleed/cold_tube2_t")
    local modeL = readv("tu-154/switchers/airbleed/left_sys_mode_set")
    local modeR = readv("tu-154/switchers/airbleed/right_sys_mode_set")
    local setL = readv("tu-154/switchers/airbleed/left_sys_temp_set")
    local setR = readv("tu-154/switchers/airbleed/right_sys_temp_set")
    local regL = readv("tu-154/bleed/reg_cold_L")
    local regR = readv("tu-154/bleed/reg_cold_R")
    local stTthL = ductState(readv("tu-154/failures/tth_left_fail") > 0.5, stL == S_LIVE,
        math.floor(modeL + 0.5) == 1, coldL, setL, 5)
    local stTthR = ductState(readv("tu-154/failures/tth_right_fail") > 0.5, stR == S_LIVE,
        math.floor(modeR + 0.5) == 1, coldR, setR, 5)

    local yb = listNode(AG.TL, AG.CND, AG.TTHW, LN_H4, "TTH L / COLD DUCT 1", stTthL, {
        { "duct temp", fmt(coldL, 1) .. " C", stTthL, hd = true },
        { "mode", enumTxt(AIR_MODE, modeL) },
        { "set", fmt(setL, 0) .. " C" },
        { "hot bypass", mixTxt(regL, 0.6) },
    }, regL / 0.6)
    if tue == 4 then
        chip(afterTitle(AG.TL, "TTH L / COLD DUCT 1"), yb + LN_H4 - 13, 34, "TUE", true, 12)
    end
    yb = listNode(AG.TR, AG.CND, AG.TTHW, LN_H4, "TTH R / COLD DUCT 2", stTthR, {
        { "duct temp", fmt(coldR, 1) .. " C", stTthR, hd = true },
        { "mode", enumTxt(AIR_MODE, modeR) },
        { "set", fmt(setR, 0) .. " C" },
        { "hot bypass", mixTxt(regR, 0.6) },
    }, regR / 0.6)
    if tue == 5 then
        chip(afterTitle(AG.TR, "TTH R / COLD DUCT 2"), yb + LN_H4 - 13, 34, "TUE", true, 12)
    end

    listNode(AG.HX, AG.HDR, AG.HDRW, LN_H3, "HOT AND COLD HEADERS", stT, {
        { "hot air", fmt(readv("tu-154/bleed/hot_tube_t"), 1) .. " C", stT, hd = true },
        { "cold air", fmt(readv("tu-154/bleed/cold_air_t"), 1) .. " C", stT },
        { "source", "engine compressors", note = true },
    })

    -- ---- hot and cold distribution manifolds -----------------------------
    local hotTaps, coldTaps = {}, {}
    for i = 1, 4 do
        hotTaps[i] = colX(i, 4, AG.ZW) + AG.HTAP
        coldTaps[i] = colX(i, 4, AG.ZW) + AG.CTAP
    end
    local cL, cR = AG.TL + AG.CIN, AG.TR + AG.TTHW - AG.CIN -- the cold ducts' drops
    wire(stT, AG.MIDX, Y(AG.HDR + LN_H3), AG.MIDX, Y(AG.HOT))
    wire(stT, hotTaps[1], Y(AG.HOT), hotTaps[4], Y(AG.HOT))
    arrow(AG.MIDX - AG.HARR, Y(AG.HOT), -1, 0, stT)
    arrow(AG.MIDX + AG.HARR, Y(AG.HOT), 1, 0, stT)
    wire(stTthL, cL, Y(AG.CND + LN_H4), cL, Y(AG.COLD))
    wire(stTthR, cR, Y(AG.CND + LN_H4), cR, Y(AG.COLD))
    barWithJumps(AG.COLD, cL, cR, stT, hotTaps)
    arrow(cL + AG.CARL, Y(AG.COLD), 1, 0, stT)
    arrow(cR - AG.CARR, Y(AG.COLD), -1, 0, stT)
    for i = 1, 4 do
        wire(stT, hotTaps[i], Y(AG.HOT), hotTaps[i], Y(AG.ZONE))
        wire(stT, coldTaps[i], Y(AG.COLD), coldTaps[i], Y(AG.ZONE))
        junction(hotTaps[i], Y(AG.HOT), stT)
        junction(coldTaps[i], Y(AG.COLD), stT)
    end

    -- ---- conditioned zones -----------------------------------------------
    local dhT = readv("tu-154/bleed/door_heat_tube_t")
    local dhOn = readv("tu-154/switchers/eng/door_heat") > 0.5
    local dhReg = readv("tu-154/bleed/reg_door_heat")
    local stDH = ductState(false, dhOn and flowT > 50, true, dhT, 80, 10)
    yb = listNode(colX(1, 4, AG.ZW), AG.ZONE, AG.ZW, LN_H5, "DOOR HEAT", stDH, {
        { "duct temp", fmt(dhT, 1) .. " C", stDH, hd = true },
        { "switch", dhOn and "ON" or "OFF" },
        { "regulates to", "80 C", note = true },
        { "mixer", mixTxt(dhReg, 1) },
        { "TUE source", tue == 0 and "YES" or "-" },
    }, dhReg)
    if tue == 0 then
        chip(afterTitle(colX(1, 4, AG.ZW), "DOOR HEAT"), yb + LN_H5 - 13, 34, "TUE", true, 12)
    end

    for i = 1, #AIR_ZONES do
        local z = AIR_ZONES[i]
        local x = colX(z.col, 4, AG.ZW)
        local duct = readv(z.duct)
        local air = readv(z.air)
        local set = readv(z.set)
        local mode = math.floor(readv(z.mode) + 0.5)
        local reg = readv(z.reg)
        local st = ductState(false, flowT > 50, mode == 1, air, set, 2)
        local zyb = listNode(x, AG.ZONE, AG.ZW, LN_H5, z.t, st, {
            { "duct temp", fmt(duct, 1) .. " C" },
            { "cabin temp", fmt(air, 1) .. " C", st, hd = true },
            { "set", fmt(set, 0) .. " C" },
            { "mode", enumTxt(AIR_MODE, mode) },
            { "mixer", mixTxt(reg, z.regmax) },
        }, reg / z.regmax)
        if tue == z.tue then
            chip(afterTitle(x, z.t), zyb + LN_H5 - 13, 34, "TUE", true, 12)
        end
        wire(st, z.cx, Y(AG.ZONE + LN_H5), z.cx, Y(AG.CBAR))
    end

    local z1, z2, z3 = AIR_ZONES[1].cx, AIR_ZONES[2].cx, AIR_ZONES[3].cx
    wire(stT, z1, Y(AG.CBAR), z3, Y(AG.CBAR))
    wire(stT, z1, Y(AG.CBAR), z1, Y(AG.PRS))
    junction(z2, Y(AG.CBAR), stT)
    junction(z3, Y(AG.CBAR), stT)

    -- ---- cabin, outflow valve and the panel leftovers ---------------------
    local dumping = readv("sim/cockpit2/pressurization/actuators/dump_all_on") > 0.5
    local emerg = readv("tu-154/switchers/airbleed/emerg_decompress") > 0.5
    local sardF = readv("tu-154/failures/sard_valve_fail") > 0.5
    local stOut = sardF and S_FAULT or (dumping and S_LIVE or S_STBY)
    listNode(colX(1, 4, AG.ZW), AG.PRS, AG.ZW, LN_H4, "OUTFLOW VALVE", stOut, {
        { "state", sardF and "FAILED" or (dumping and "DUMPING" or "CLOSED"), stOut, hd = true },
        { "emerg dump", emerg and "ON" or "OFF", emerg and S_LOW or nil },
        { "dump inhibit", readv("tu-154/switchers/eng/sard_disable") > 0.5 and "ON" or "OFF" },
        { "discharges", "overboard", note = true },
    })

    local alarm = readv("tu-154/alarm/main_pressure") > 0.5
    listNode(colX(2, 4, AG.ZW), AG.PRS, AG.ZW, LN_H4, "CABIN", alarm and S_FAULT or stT, {
        { "altitude", fmt(readv("tu-154/gauges/airbleed/cabin_alt"), 2) .. " km", hd = true },
        { "differential", fmt(readv("tu-154/gauges/airbleed/cabin_diff"), 2) .. " kg/cm2" },
        { "alarm", alarm and "PRESSURE" or "OK", alarm and S_FAULT or nil },
        { "fed by", "3 zones above", note = true },
    })
    wire(stOut, colX(2, 4, AG.ZW), Y(AG.PRS + AG.OUTL), colX(1, 4, AG.ZW) + AG.ZW, Y(AG.PRS + AG.OUTL))

    local gcond = readv("tu-154/switchers/airbleed/ground_cond_on") > 0.5
    local hclose = readv("tu-154/switchers/airbleed/heat_close") > 0.5
    local dubler = readv("tu-154/switchers/airbleed/dubler_on") > 0.5
    readout(colX(3, 4, AG.ZW), AG.PRS, AG.ZW, LN_H4, "PANEL (state only)",
        (gcond or hclose or dubler) and S_STBY or S_DEAD, {
            { "ground cond", gcond and "ON" or "OFF" },
            { "heating stop", hclose and "ON" or "OFF" },
            { "dubler", dubler and "ON" or "OFF" },
            { "read by", "no module", note = true },
        })

    local sysT = readv("tu-154/gauges/airbleed/system_temp")
    local stGau = sysT > -70 and S_LIVE or S_DEAD
    readout(colX(4, 4, AG.ZW), AG.PRS, AG.ZW, LN_H4, "TUE DUCT GAUGE", stGau, {
        { "reads", fmt(sysT, 1) .. " C", stGau, hd = true },
        { "source", AIR_TUE[tue] or "?" },
        { "fast heat/cool", enumTxt(AIR_FAST, readv("tu-154/switchers/airbleed/skv_faster_work")) },
        { "range", "-75 .. 155 C", note = true },
    })

    drawLegend(LEG_D, AIR_LEGEND,
        "angles not values: air_flow_1|2, cabin_vvi, cockpit/cabin temp gauges",
        "no writer: gauges/airbleed cabin_alt_new + cabin_diff_new, kskv/ard_temp, thermo/cockpit|cabin1|cabin2_temp")
end
DIAGRAMS.air = drawAirDiagram
