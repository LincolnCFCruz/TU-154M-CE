-- ---------------------------------------------------------------------------
-- Electrical one-line diagram (the Elec tab)
--
-- Top-down: the five AC sources on the 115 V rail, the three main and two
-- emergency 115 V buses, the converters (TR 1/2 -> 36 V, VU 1/2/reserve ->
-- 27 V), the 27 V and 36 V buses with their tie, the PTS-250 inverters with
-- their output buses, and the four batteries.
--
-- Wiring the systems code fixes (bus115_logic, bus36_logic, bus27_logic) is
-- fixed geometry, only coloured. Wiring it switches is drawn from the
-- datarefs that publish the selection (bus115_src_*, bus27_source_*,
-- bus36_src_*, vu_res_to_*, bat_is_source_*), never inferred.
-- ---------------------------------------------------------------------------

-- Five equal columns carry sources, converters, DC buses (columns 1, 2, 4, 5)
-- and inverters, so every feeder is a straight drop. The 115 V bus row has its
-- own widths: the emergency buses are narrower.
local EG = {
    W      = 208,  -- the five-column width
    BW     = 250,  -- main and emergency 115 V bus widths
    BEM    = 170,  -- emergency 115 V bus width
    SRC    = 8,    -- generators, APU generator, ground power
    RAIL   = 104,  -- 115 V busbar
    BUS    = 124,  -- 115 V buses
    STUB   = 202,  -- bus 1 / bus 3 distribution stubs
    VUR    = 224,  -- the stub tie that feeds the reserve VU
    CNV    = 244,  -- TR and VU converters
    ALTH   = 374,  -- 36 V left -> PTS-2 bus alternate feed, upper leg
    MID    = 386,  -- mid-height of the DC bus row (side taps, tie)
    TRA    = 318,  -- the 36 V LEFT bus's feed when it comes from TR 2
    ELB    = 331,  -- reserve-VU output elbow
    TRB    = 344,  -- the 36 V RIGHT bus's feed when it comes from TR 1
    DC     = 358,  -- 27 V and 36 V buses
    LOW    = 466,  -- PTS-250 inverters and batteries
    PTS    = 500,  -- mid-height of that row
    OUT    = 565,  -- PTS-250 output buses
    OUTH   = 24,   -- height of those output bars
    ALT    = 577,  -- alternate feed, lower leg
}
-- MID / PTS are the middles of the DC and inverter rows and ALTH / ALT the
-- alternate feed's legs: move them with DC / LOW / OUT.

-- x: the five columns from colX / colC, and every offset a wire takes from a
-- node, so moving a column moves every wire that meets it
EG.X, EG.C = {}, {}
for i = 1, 5 do
    EG.X[i], EG.C[i] = colX(i, 5, EG.W), colC(i, 5, EG.W)
end
EG.MIDX = EG.C[3] -- the centre line: VU RESERVE, the stub tie, the bus tie
EG.VURO = 16      -- the stub tie's ends, outboard of the VU RESERVE node
EG.VUO  = 22      -- VU 1 / VU 2 output drops, outboard of their centres
EG.VRO  = 23      -- the reserve VU's drops into the 27 V buses, inboard of theirs
EG.VRE  = 20      -- the reserve VU's two output legs, either side of its centre
EG.TIE  = 13      -- half-width of the bus-tie contactor (contactor() draws +-13)
EG.TAPL = 8       -- 27 V LEFT -> PTS-250 2 tap, right of the PTS-250 2 node
EG.ALTX = 20      -- 36 V LEFT -> 36 V PTS-2 alternate feed, right of that node
EG.TAPR = 16      -- 27 V RIGHT -> PTS-250 1 tap, right of the 27 V RIGHT node
EG.BATW = 100     -- battery node width

-- 0 = none; matches tu-154/elec/bus115_src_1..3 written by bus115_logic.lua
local ENUM_115_SRC = { [0] = "NONE", [1] = "GEN 1", [2] = "GEN 2", [3] = "GEN 3",
                       [4] = "APU GEN", [5] = "RAP" }

-- `id` is both the column and the bus115_src_N value that selects the source
local ELEC_SRC = {
    { id = 1, t = "GEN 1 (ENG 1)", volt = "tu-154/elec/gen1_volt", amp = "tu-154/elec/gen1_amp",
      work = "tu-154/elec/gen1_work", ovl = "tu-154/elec/gen1_overload" },
    { id = 2, t = "GEN 2 (ENG 2)", volt = "tu-154/elec/gen2_volt", amp = "tu-154/elec/gen2_amp",
      work = "tu-154/elec/gen2_work", ovl = "tu-154/elec/gen2_overload" },
    { id = 3, t = "GEN 3 (ENG 3)", volt = "tu-154/elec/gen3_volt", amp = "tu-154/elec/gen3_amp",
      work = "tu-154/elec/gen3_work", ovl = "tu-154/elec/gen3_overload" },
    { id = 4, t = "APU GEN",       volt = "tu-154/elec/gen4_volt", amp = "tu-154/elec/gen4_amp",
      work = "tu-154/elec/gen4_work", ovl = "tu-154/elec/gen4_overload",
      fail = "tu-154/failures/apu_gen_fail" },
    { id = 5, t = "RAP (ground)",  volt = "tu-154/elec/gpu_volt",  amp = "tu-154/elec/gpu_amp",
      work = "tu-154/elec/gpu_work",  ovl = "tu-154/elec/gpu_overload" },
}

-- The emergency buses are strapped to buses 1 and 3: no `src` of their own,
-- and no `amp` -- bus115_logic reads bus115_em_1/2_amp and nothing writes them.
local ELEC_AC = {
    { w = EG.BEM, t = "115 V EMERG 1", strap = "BUS 1",
      volt = "tu-154/elec/bus115_em_1_volt" },
    { w = EG.BW,  t = "115 V BUS 1",   src = "tu-154/elec/bus115_src_1",
      volt = "tu-154/elec/bus115_1_volt",    amp = "tu-154/elec/bus115_1_amp" },
    { w = EG.BW,  t = "115 V BUS 2",   src = "tu-154/elec/bus115_src_2",
      volt = "tu-154/elec/bus115_2_volt",    amp = "tu-154/elec/bus115_2_amp" },
    { w = EG.BW,  t = "115 V BUS 3",   src = "tu-154/elec/bus115_src_3",
      volt = "tu-154/elec/bus115_3_volt",    amp = "tu-154/elec/bus115_3_amp" },
    { w = EG.BEM, t = "115 V EMERG 2", strap = "BUS 3",
      volt = "tu-154/elec/bus115_em_2_volt" },
}
-- spread edge to edge like colX: the gap is fractional, the positions are not
do
    local used = 0
    for _, b in ipairs(ELEC_AC) do
        used = used + b.w
    end
    local gap = (CONTENT_W - used) / (#ELEC_AC - 1)
    local x = CONTENT_L
    for _, b in ipairs(ELEC_AC) do
        b.x = math.floor(x)
        b.cx = b.x + math.floor(b.w / 2)
        x = x + b.w + gap
    end
end

-- batteries 1 and 3 feed the left 27 V bus, 2 and 4 the right one; each pair
-- sits flush with the ends of its bus
local ELEC_BAT = {
    { x = EG.X[2],                  n = 1 },
    { x = EG.X[2] + EG.W - EG.BATW, n = 3 },
    { x = EG.X[4],                  n = 2 },
    { x = EG.X[4] + EG.W - EG.BATW, n = 4 },
}
for _, b in ipairs(ELEC_BAT) do
    b.tap = b.x + EG.BATW / 2
end

local ELEC_LEGEND = {
    { S_LIVE,  "carrying" },
    { S_STBY,  "available" },
    { S_LOW,   "low volts" },
    { S_DEAD,  "de-energised" },
    { S_FAULT, "failed / overload" },
}

-- ENUM_BUS27_SRC spells out the left bus batteries; the right bus has 2 and 4
local function src27Txt(v, isLeft)
    if v == 3 then
        return isLeft and "BAT 1+3" or "BAT 2+4"
    end
    return ENUM_BUS27_SRC[v] or fmt(v, 0)
end

-- The lines a cross-diagram 36 V feed jumps. The reserve VU's elbow (EG.ELB)
-- sits between the two lanes: its legs exist only above it, its drops into the
-- 27 V buses only below it.
local EG_XJ_HI = { EG.C[2] - EG.VUO, EG.MIDX - EG.VRE, EG.MIDX + EG.VRE, EG.C[4] + EG.VUO }
local EG_XJ_LO = { EG.C[2] - EG.VUO, EG.C[2] + EG.VRO, EG.C[4] - EG.VRO, EG.C[4] + EG.VUO }

-- One 36 V bus's feed, drawn from the TR actually supplying it: bus36_logic
-- picks each bus's TR independently, so one TR can carry both. Only the live
-- path is drawn -- a 950 px line for an unselected feed would dominate the
-- diagram -- which is the one exception to "fixed geometry, only coloured".
local function busFeed(fromX, toX, ch, jumps, s)
    if fromX == toX then
        wire(s, fromX, Y(EG.CNV + LN_H3), fromX, Y(EG.DC))
        arrow(fromX, (Y(EG.CNV + LN_H3) + Y(EG.DC)) / 2, 0, -1, s)
    else
        wire(s, fromX, Y(EG.CNV + LN_H3), fromX, Y(ch))
        barWithJumps(ch, math.min(fromX, toX), math.max(fromX, toX), s, jumps)
        wire(s, toX, Y(ch), toX, Y(EG.DC))
        junction(fromX, Y(ch), s)
        arrow((fromX + toX) / 2, Y(ch), (toX > fromX) and 1 or -1, 0, s)
    end
end

local function drawElecDiagram()
    local v115 = { readv("tu-154/elec/bus115_1_volt"), readv("tu-154/elec/bus115_2_volt"),
                   readv("tu-154/elec/bus115_3_volt") }
    local s1 = voltState(v115[1], NOM_115)
    local s3 = voltState(v115[3], NOM_115)
    local srcX = {}

    -- ---- AC sources ------------------------------------------------------
    for i = 1, #ELEC_SRC do
        local s = ELEC_SRC[i]
        local x, cx = EG.X[s.id], EG.C[s.id]
        srcX[s.id] = cx
        local v, a = readv(s.volt), readv(s.amp)
        local st
        if readv(s.ovl) > 0.5 or (s.fail and readv(s.fail) > 0.5) then
            st = S_FAULT
        elseif readv(s.work) > 0.5 then
            st = (a > 1) and S_LIVE or S_STBY
        else
            st = (v > 5) and S_LOW or S_DEAD
        end
        listNode(x, EG.SRC, EG.W, LN_H3, s.t, st, {
            { "voltage", fmt(v, 1) .. " V", st, hd = true },
            { "load", fmt(a, 0) .. " A" },
            { "state", (st == S_FAULT and "OVERLOAD")
                or (st == S_LIVE and "ON LINE") or (st == S_STBY and "ON LINE, IDLE") or "OFF" },
        }, a / 145) -- 145 A is where generators_logic starts the overload timer
        wire(st, cx, Y(EG.SRC + LN_H3), cx, Y(EG.RAIL))
        roundSym(cx, (Y(EG.SRC + LN_H3) + Y(EG.RAIL)) / 2,
            (s.id <= 3) and "G" or (s.id == 4 and "A" or "R"), st)
    end

    -- ---- the 115 V busbar and the feeds it is actually carrying ----------
    -- the bar is drawn dead; each bus's selected path (bus115_src_N) goes on top
    wire(S_DEAD, srcX[1], Y(EG.RAIL), srcX[5], Y(EG.RAIL))
    for i = 1, #ELEC_AC do
        local b = ELEC_AC[i]
        if b.src then
            local sel = math.floor(readv(b.src) + 0.5)
            local st = voltState(readv(b.volt), NOM_115)
            if sel > 0 and srcX[sel] then
                wire(st, srcX[sel], Y(EG.RAIL), b.cx, Y(EG.RAIL))
                wire(st, srcX[sel], Y(EG.RAIL), srcX[sel], Y(EG.RAIL) + 7)
                junction(srcX[sel], Y(EG.RAIL), st)
                junction(b.cx, Y(EG.RAIL), st)
            end
            wire(st, b.cx, Y(EG.RAIL), b.cx, Y(EG.BUS))
        end
    end

    -- ---- 115 V buses -----------------------------------------------------
    for i = 1, #ELEC_AC do
        local b = ELEC_AC[i]
        local v = readv(b.volt)
        local a = b.amp and readv(b.amp)
        local st = voltState(v, NOM_115)
        local from = b.strap
        if b.src then
            from = ENUM_115_SRC[math.floor(readv(b.src) + 0.5)] or "?"
        end
        listNode(b.x, EG.BUS, b.w, LN_H3, b.t, st, {
            { "voltage", fmt(v, 1) .. " V", st, hd = true },
            { "load", a and (fmt(a, 0) .. " A") or "not computed" },
            { "fed from", from, st == S_LIVE and S_LIVE or nil },
        }, a and a / 200)
    end

    -- the emergency buses are strapped to buses 1 and 3
    local e1, b1, b3, e2 = ELEC_AC[1], ELEC_AC[2], ELEC_AC[4], ELEC_AC[5]
    wire(voltState(readv("tu-154/elec/bus115_em_1_volt"), NOM_115), e1.x + e1.w, Y(EG.BUS + 28),
        b1.x, Y(EG.BUS + 28))
    wire(voltState(readv("tu-154/elec/bus115_em_2_volt"), NOM_115), b3.x + b3.w, Y(EG.BUS + 28),
        e2.x, Y(EG.BUS + 28))

    -- ---- distribution stubs ----------------------------------------------
    local vurL, vurR = EG.X[3] - EG.VURO, EG.X[3] + EG.W + EG.VURO
    wire(s1, b1.cx, Y(EG.BUS + LN_H3), b1.cx, Y(EG.STUB))
    wire(s1, EG.C[1], Y(EG.STUB), vurL, Y(EG.STUB))
    junction(b1.cx, Y(EG.STUB), s1)
    wire(s3, b3.cx, Y(EG.BUS + LN_H3), b3.cx, Y(EG.STUB))
    wire(s3, vurR, Y(EG.STUB), EG.C[5], Y(EG.STUB))
    junction(b3.cx, Y(EG.STUB), s3)

    local acR = (v115[1] >= 115 or v115[3] >= 115) and S_LIVE
        or ((v115[1] > 1 or v115[3] > 1) and S_LOW or S_DEAD)
    wire(s1, vurL, Y(EG.STUB), vurL, Y(EG.VUR))
    wire(s3, vurR, Y(EG.STUB), vurR, Y(EG.VUR))
    wire(acR, vurL, Y(EG.VUR), vurR, Y(EG.VUR))
    wire(acR, EG.MIDX, Y(EG.VUR), EG.MIDX, Y(EG.CNV))
    wire(s1, EG.C[1], Y(EG.STUB), EG.C[1], Y(EG.CNV))
    wire(s1, EG.C[2], Y(EG.STUB), EG.C[2], Y(EG.CNV))
    wire(s3, EG.C[4], Y(EG.STUB), EG.C[4], Y(EG.CNV))
    wire(s3, EG.C[5], Y(EG.STUB), EG.C[5], Y(EG.CNV))

    -- ---- converters ------------------------------------------------------
    local src36L = math.floor(readv("tu-154/elec/bus36_src_L") + 0.5) -- 0 = TR 1, 1 = TR 2
    local src36R = math.floor(readv("tu-154/elec/bus36_src_R") + 0.5) -- 0 = TR 2, 1 = TR 1
    local src27L = math.floor(readv("tu-154/elec/bus27_source_left") + 0.5)
    local src27R = math.floor(readv("tu-154/elec/bus27_source_right") + 0.5)

    local tr1F = readv("tu-154/failures/tr1_fail") > 0.5
    local tr2F = readv("tu-154/failures/tr2_fail") > 0.5
    local tr1W = readv("tu-154/elec/bus36_tr1_work") > 0.5 and not tr1F
    local tr2W = readv("tu-154/elec/bus36_tr2_work") > 0.5 and not tr2F
    -- read per BUS, because each takes its TR independently and one TR can be
    -- carrying both: bus36_src_L is 0 = TR 1, bus36_src_R is 0 = TR 2
    local lFrom = (src36L == 0) and EG.C[1] or EG.C[5]
    local rFrom = (src36R == 0) and EG.C[5] or EG.C[1]
    local lSt = ((src36L == 0) and tr1W or tr2W) and S_LIVE or S_DEAD
    local rSt = ((src36R == 0) and tr2W or tr1W) and S_LIVE or S_DEAD
    local tr1Out = feedState(tr1W, src36L == 0 or src36R == 1)
    local tr2Out = feedState(tr2W, src36R == 0 or src36L == 1)
    listNode(EG.X[1], EG.CNV, EG.W, LN_H3, "TR 1", tr1F and S_FAULT or tr1Out, {
            { "state", tr1F and "FAILED" or (tr1W and "RUN" or "OFF"), tr1F and S_FAULT or nil, hd = true },
            { "converts", "115 -> 36 V", note = true },
            { "feeding", (src36L == 0 and tr1W) and "36 V LEFT"
                or ((src36R == 1 and tr1W) and "36 V RIGHT" or "-") },
        })
    listNode(EG.X[5], EG.CNV, EG.W, LN_H3, "TR 2", tr2F and S_FAULT or tr2Out, {
            { "state", tr2F and "FAILED" or (tr2W and "RUN" or "OFF"), tr2F and S_FAULT or nil, hd = true },
            { "converts", "115 -> 36 V", note = true },
            { "feeding", (src36R == 0 and tr2W) and "36 V RIGHT"
                or ((src36L == 1 and tr2W) and "36 V LEFT" or "-") },
        })

    local vu1V, vu1A = readv("tu-154/elec/vu1_volt"), readv("tu-154/elec/vu1_amp")
    local vu2V, vu2A = readv("tu-154/elec/vu2_volt"), readv("tu-154/elec/vu2_amp")
    local vu3V, vu3A = readv("tu-154/elec/vu_res_volt"), readv("tu-154/elec/vu_res_amp")
    local vu1F = readv("tu-154/failures/vu1_fail") > 0.5
    local vu2F = readv("tu-154/failures/vu2_fail") > 0.5
    local vu3F = readv("tu-154/failures/vu3_fail") > 0.5
    local toL = readv("tu-154/elec/vu_res_to_L") > 0.5
    local toR = readv("tu-154/elec/vu_res_to_R") > 0.5
    local vu1Out = feedState(vu1V > NOM_27, src27L == 1)
    local vu2Out = feedState(vu2V > NOM_27, src27R == 1)

    listNode(EG.X[2], EG.CNV, EG.W, LN_H3, "VU 1", vu1F and S_FAULT or vu1Out, {
        { "voltage", vu1F and "FAILED" or (fmt(vu1V, 1) .. " V"), vu1F and S_FAULT or nil, hd = true },
        { "load", fmt(vu1A, 0) .. " A" },
        { "feeding", src27L == 1 and "27 V LEFT" or "-" },
    }, vu1A / 450) -- bus27_logic trips a VU on overload above 450 A
    listNode(EG.X[3], EG.CNV, EG.W, LN_H3, "VU RESERVE",
        vu3F and S_FAULT or feedState(vu3V > NOM_27, toL or toR), {
            { "voltage", vu3F and "FAILED" or (fmt(vu3V, 1) .. " V"), vu3F and S_FAULT or nil, hd = true },
            { "load", fmt(vu3A, 0) .. " A" },
            { "feeding", (toL and toR) and "BOTH 27 V"
                or (toL and "27 V LEFT" or (toR and "27 V RIGHT" or "-")) },
        }, vu3A / 450)
    listNode(EG.X[4], EG.CNV, EG.W, LN_H3, "VU 2", vu2F and S_FAULT or vu2Out, {
        { "voltage", vu2F and "FAILED" or (fmt(vu2V, 1) .. " V"), vu2F and S_FAULT or nil, hd = true },
        { "load", fmt(vu2A, 0) .. " A" },
        { "feeding", src27R == 1 and "27 V RIGHT" or "-" },
    }, vu2A / 450)

    busFeed(lFrom, EG.C[1], EG.TRA, EG_XJ_HI, lSt)
    busFeed(rFrom, EG.C[5], EG.TRB, EG_XJ_LO, rSt)
    local vu1X, vu2X = EG.C[2] - EG.VUO, EG.C[4] + EG.VUO
    wire(vu1Out, vu1X, Y(EG.CNV + LN_H3), vu1X, Y(EG.DC))
    wire(vu2Out, vu2X, Y(EG.CNV + LN_H3), vu2X, Y(EG.DC))
    local cnvMid = (Y(EG.CNV + LN_H3) + Y(EG.DC)) / 2
    arrow(vu1X, cnvMid, 0, -1, vu1Out)
    arrow(vu2X, cnvMid, 0, -1, vu2Out)
    local rl, rr = EG.MIDX - EG.VRE, EG.MIDX + EG.VRE
    wire(feedState(vu3V > NOM_27, toL), rl, Y(EG.CNV + LN_H3), rl, Y(EG.ELB),
        EG.C[2] + EG.VRO, Y(EG.ELB), EG.C[2] + EG.VRO, Y(EG.DC))
    wire(feedState(vu3V > NOM_27, toR), rr, Y(EG.CNV + LN_H3), rr, Y(EG.ELB),
        EG.C[4] - EG.VRO, Y(EG.ELB), EG.C[4] - EG.VRO, Y(EG.DC))

    -- ---- 27 V and 36 V buses ---------------------------------------------
    local v36L = readv("tu-154/elec/bus36_volt_left")
    local v36R = readv("tu-154/elec/bus36_volt_right")
    local v27L = readv("tu-154/elec/bus27_volt_left")
    local v27R = readv("tu-154/elec/bus27_volt_right")
    local st36L, st36R = voltState(v36L, NOM_36), voltState(v36R, NOM_36)
    local st27L, st27R = voltState(v27L, NOM_27), voltState(v27R, NOM_27)
    local a36L = readv("tu-154/elec/bus36_amp_left")
    local a36R = readv("tu-154/elec/bus36_amp_right")
    local a27L = readv("tu-154/elec/bus27_amp_left")
    local a27R = readv("tu-154/elec/bus27_amp_right")

    listNode(EG.X[1], EG.DC, EG.W, LN_H3, "36 V LEFT", st36L, {
        { "voltage", fmt(v36L, 1) .. " V", st36L, hd = true },
        { "load", fmt(a36L, 0) .. " A" },
        { "fed from", src36L == 0 and "TR 1" or "TR 2", st36L == S_LIVE and S_LIVE or nil },
    }, a36L / 100)
    listNode(EG.X[2], EG.DC, EG.W, LN_H3, "27 V LEFT", st27L, {
        { "voltage", fmt(v27L, 1) .. " V", st27L, hd = true },
        { "load", fmt(a27L, 0) .. " A" },
        { "fed from", src27Txt(src27L, true), st27L == S_LIVE and S_LIVE or nil },
    }, a27L / 600)
    listNode(EG.X[4], EG.DC, EG.W, LN_H3, "27 V RIGHT", st27R, {
        { "voltage", fmt(v27R, 1) .. " V", st27R, hd = true },
        { "load", fmt(a27R, 0) .. " A" },
        { "fed from", src27Txt(src27R, false), st27R == S_LIVE and S_LIVE or nil },
    }, a27R / 600)
    listNode(EG.X[5], EG.DC, EG.W, LN_H3, "36 V RIGHT", st36R, {
        { "voltage", fmt(v36R, 1) .. " V", st36R, hd = true },
        { "load", fmt(a36R, 0) .. " A" },
        { "fed from", src36R == 0 and "TR 2" or "TR 1", st36R == S_LIVE and S_LIVE or nil },
    }, a36R / 100)

    local tied = readv("tu-154/elec/bus_connected") > 0.5
    local tieS = tied and ((st27L == S_LIVE or st27R == S_LIVE) and S_LIVE or S_DEAD) or S_DEAD
    wire(tieS, EG.X[2] + EG.W, Y(EG.MID), EG.MIDX - EG.TIE, Y(EG.MID))
    wire(tieS, EG.MIDX + EG.TIE, Y(EG.MID), EG.X[4], Y(EG.MID))
    contactor(EG.MIDX, Y(EG.MID), tied, tieS)
    sasl.gl.drawText(font, EG.MIDX, Y(EG.MID) - 26, "27 V BUS TIE", 11, false, false,
        TEXT_ALIGN_CENTER, COL_DIM)

    -- ---- PTS-250 inverters and batteries ---------------------------------
    local pts1F = readv("tu-154/failures/pts250_1_fail") > 0.5
    local pts2F = readv("tu-154/failures/pts250_2_fail") > 0.5
    local pts1W = readv("tu-154/elec/bus36_pts1_work") > 0.5
    local pts2W = readv("tu-154/elec/bus36_pts2_work") > 0.5

    listNode(EG.X[1], EG.LOW, EG.W, LN_H4, "PTS-250 2",
        pts2F and S_FAULT or (pts2W and S_LIVE or S_DEAD), {
            { "state", pts2F and "FAILED" or (pts2W and "RUN" or "OFF"), pts2F and S_FAULT or nil, hd = true },
            { "converts", "27 -> 36 V", note = true },
            { "fed from", "27 V LEFT", note = true },
            { "standby for", "36 V LEFT", note = true },
        })
    listNode(EG.X[5], EG.LOW, EG.W, LN_H4, "PTS-250 1",
        pts1F and S_FAULT or (pts1W and S_LIVE or S_DEAD), {
            { "state", pts1F and "FAILED" or (pts1W and "RUN" or "OFF"), pts1F and S_FAULT or nil, hd = true },
            { "converts", "27 -> 36 V", note = true },
            { "fed from", "27 V RIGHT", note = true },
            { "standby for", "36 V RIGHT", note = true },
        })

    -- the tap out of the 27 V left bus passes behind the 36 V left alternate
    -- feed on its way to PTS-250 2, so it breaks around it
    local pts2R = EG.X[1] + EG.W  -- the PTS-250 2 node's right edge
    local tapL = pts2R + EG.TAPL
    barWithJumps(EG.MID, tapL, EG.X[2], feedState(st27L == S_LIVE, pts2W), { pts2R + EG.ALTX })
    wire(feedState(st27L == S_LIVE, pts2W), tapL, Y(EG.MID), tapL, Y(EG.PTS), pts2R, Y(EG.PTS))
    local dcR = EG.X[4] + EG.W    -- the 27 V RIGHT node's right edge
    wire(feedState(st27R == S_LIVE, pts1W), dcR, Y(EG.MID), dcR + EG.TAPR, Y(EG.MID),
        dcR + EG.TAPR, Y(EG.PTS), EG.X[5], Y(EG.PTS))

    for i = 1, #ELEC_BAT do
        local b = ELEC_BAT[i]
        local v = readv("tu-154/elec/bat_volt_" .. b.n)
        local a = readv("tu-154/elec/bat_amp_" .. b.n)
        local temp = readv("tu-154/elec/bat_therm_" .. b.n)
        local bad = readv("tu-154/failures/bat_" .. b.n .. "_fail") > 0.5
            or readv("tu-154/failures/bat_" .. b.n .. "_kz") > 0.5
        local isSrc = readv("tu-154/elec/bat_is_source_" .. b.n) > 0.5
        local st = bad and S_FAULT or feedState(v > 1, isSrc)
        listNode(b.x, EG.LOW, EG.BATW, LN_H4, "BAT " .. b.n, st, {
            { "volts", bad and "FAIL" or (fmt(v, 1) .. " V"), bad and S_FAULT or nil, hd = true },
            { "amps", fmt(a, 0) },
            { "temp", fmt(temp, 0) .. " C", temp > 55 and S_LOW or nil },
            { "state", isSrc and "SOURCE" or (v > 1 and "READY" or "FLAT"), st },
        }, v / 26)
        wire(st, b.tap, Y(EG.LOW), b.tap, Y(EG.DC + LN_H3))
        battSym(b.tap, Y(EG.DC + LN_H3) - 14, st)
        if v > 1 then
            arrow(b.tap, Y(EG.LOW) + 15, 0, isSrc and 1 or -1, st)
        end
    end

    -- ---- PTS-250 output buses --------------------------------------------
    local vp1, vp2 = readv("tu-154/elec/bus36_volt_pts250_1"), readv("tu-154/elec/bus36_volt_pts250_2")
    local ap1, ap2 = readv("tu-154/elec/bus36_amp_pts250_1"), readv("tu-154/elec/bus36_amp_pts250_2")
    slimNode(EG.X[1], EG.OUT, EG.W, EG.OUTH, "36 V PTS-2", voltState(vp2, NOM_36),
        fmt(vp2, 1) .. " V  " .. fmt(ap2, 0) .. " A")
    slimNode(EG.X[5], EG.OUT, EG.W, EG.OUTH, "36 V PTS-1", voltState(vp1, NOM_36),
        fmt(vp1, 1) .. " V  " .. fmt(ap1, 0) .. " A")

    -- bus36_logic feeds the PTS-2 bus off the 36 V left bus whenever that is
    -- alive, and from PTS-250 2 only when it is not
    local fromL = v36L > 30
    local altS = feedState(fromL, vp2 > 30)
    wire(altS, pts2R, Y(EG.ALTH), pts2R + EG.ALTX, Y(EG.ALTH), pts2R + EG.ALTX, Y(EG.ALT),
        pts2R, Y(EG.ALT))
    wire(feedState(pts2W, not fromL and vp2 > 30), EG.C[1], Y(EG.LOW + LN_H4), EG.C[1], Y(EG.OUT))
    wire(feedState(pts1W, vp1 > 30), EG.C[5], Y(EG.LOW + LN_H4), EG.C[5], Y(EG.OUT))

    drawLegend(LEG_D, ELEC_LEGEND,
        "no writer: avto_L/R_volt, avto_L/R_amp, bus115_freq, gen_dist_fail",
        "Bar fill is load against the limit the systems code tests: 145 A per generator, 450 A per VU, 600 A per 27 V bus.")
end
DIAGRAMS.elec = drawElecDiagram
