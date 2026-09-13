--[[

  File: inspector_ctrl.lua
  -----
  Tu-154M System Viewer / Debug Inspector -- the Ctrl tab's diagram (DIAGRAMS.ctrl).

  Loaded by debug_inspector_view.lua into the inspector's shared namespace
  (see "The inspector's files" there): the vocabulary it draws with --
  listNode, wire, readv, the S_* states, colX, Y and the rest of
  inspector_vocab.lua -- is in scope without being imported, and its own
  top-level locals stay private to this file.

--]]

-- ---------------------------------------------------------------------------
-- Flight controls one-line diagram (the Ctrl tab)
--
-- This one is the mechanical counterpart of the hydraulic diagram, and the
-- structure worth drawing is the same shape as the RA-56 matrix: the three
-- boosters are NOT one per axis. hydro_logic.lua multiplies the whole control
-- demand by each booster in turn --
--
--   system 1: (ailerons + elevator + rudder + elevons) * buster_1 + spoilers + flaps
--   system 2: (ailerons + elevator + rudder + elevons) * buster_2 + flaps
--   system 3: (ailerons + elevator + rudder + elevons) * buster_3
--
-- so booster N draws from hydraulic system N, all three drive all three axes in
-- parallel, and only system 1 also carries the spoilers while 1 and 2 carry the
-- flaps. That is why the bar runs across all three axes rather than each
-- booster dropping into one of them.
--
-- Two things the rows are careful about:
--   * a booster is LATCHED. hydro_logic only copies the switch into its
--     internal state while the relevant bus is powered -- 27 V LEFT for
--     boosters 1 and 2, 27 V RIGHT for booster 3 -- so losing that bus freezes
--     the booster wherever it was rather than dropping it out. The asymmetry is
--     real and is why the rows name the bus.
--   * being engaged is not the same as working. `booster_N` is the latched
--     switch and nothing else; the hydraulic pressure beside it is a separate
--     reading, and the module never gates one on the other.
-- ---------------------------------------------------------------------------

local FC = {
    C3   = 340,  -- three-column node
    TOP  = 8,    -- the three boosters                       (LN_H6 -> 107)
    BAR  = 147,  -- the boosted control linkage
    AX   = 187,  -- pitch / roll / yaw                       (LN_H6 -> 286)
    HL   = 326,  -- flaps / slats / spoilers                 (LN_H6 -> 425)
    TRIM = 465,  -- stabiliser / loads / failures            (LN_H6 -> 564)
}

-- booster N runs on hydraulic system N, and latches on the bus named here
local FC_BOOST = {
    { n = 1, bus = "27 V left", volt = "tu-154/elec/bus27_volt_left",
      also = "spoilers, flaps, brakes, gear" },
    { n = 2, bus = "27 V left", volt = "tu-154/elec/bus27_volt_left",
      also = "flaps, emergency gear" },
    { n = 3, bus = "27 V right", volt = "tu-154/elec/bus27_volt_right",
      also = "gear extension only" },
}

local FC_AX = {
    { t = "PITCH", inp = "tu-154/controlls/yoke_pitch",
      sw = "tu-154/controll/elev_trimm_switcher", trim = "tu-154/trimmers/int_pitch_trim",
      swmap = { [-1] = "NOSE DN", [0] = "NEUTRAL", [1] = "NOSE UP" },
      feel = "tu-154/controls/control_force_pos",
      gauge = "tu-154/gauges/misc/elevator_pos_ind",
      pl = "tu-154/controlls/elev_L_phys", pr = "tu-154/controlls/elev_R_phys",
      fl = "tu-154/failures/elev_fail_left", fr = "tu-154/failures/elev_fail_right",
      drives = "elevator" },
    { t = "ROLL", inp = "tu-154/controlls/yoke_roll",
      sw = "tu-154/controll/ail_trimm_sw", trim = "tu-154/trimmers/int_roll_trim",
      swmap = ENUM_TRIM_SW,
      gauge = "tu-154/gauges/misc/aileron_pos_ind",
      -- flight_controls writes the ailerons straight to X-Plane, in degrees with
      -- the failure applied; tu-154/controlls/ail_*_phys is created and never
      -- written. Only the master writes these under SmartCopilot.
      pl = "sim/flightmodel/controls/wing3l_ail1def",
      pr = "sim/flightmodel/controls/wing3r_ail1def",
      fl = "tu-154/failures/ail_fail_left", fr = "tu-154/failures/ail_fail_right",
      drives = "ailerons + elevons" },
    { t = "YAW", inp = "tu-154/controlls/pedals",
      sw = "tu-154/controll/rudd_trimm_sw", trim = "tu-154/trimmers/int_yaw_trim",
      swmap = ENUM_TRIM_SW,
      feel = "tu-154/controls/control_force_pos_rud",
      gauge = "tu-154/gauges/misc/rudder_pos_ind",
      pl = "tu-154/gauges/misc/rudder_pos_ind", pr = nil, single = true,
      fl = "tu-154/failures/rudder_fail", fr = nil,
      drives = "rudder" },
}

-- a deflected surface is not a caution; a demand with nothing to boost it is
local FC_LEGEND = {
    { S_LIVE,  "boosted and driving, or deployed" },
    { S_STBY,  "engaged, no demand" },
    { S_LOW,   "demand or engaged, no pressure" },
    { S_DEAD,  "off or unpressurised" },
    { S_FAULT, "failed" },
}

local function drawCtrlDiagram()
    -- ---- the three boosters ------------------------------------------------
    local anyBoost = false
    for i = 1, 3 do
        local b = FC_BOOST[i]
        local on = readv("tu-154/hydro/booster_" .. b.n) > 0.5
        local sw = readv("tu-154/switchers/console/buster_on_" .. b.n) > 0.5
        local press = readv("tu-154/hydro/gs_press_" .. b.n)
        local volt = readv(b.volt)
        local latched = volt <= 13 and on ~= sw
        local st
        if on and press >= 150 then
            st = S_LIVE
            anyBoost = true
        elseif on then
            -- engaged with nothing to drive it: abnormal, but nothing has failed
            st = S_LOW
        else
            st = sw and S_STBY or S_DEAD
        end
        listNode(colX(b.n, 3, FC.C3), FC.TOP, FC.C3, LN_H6, "BOOSTER " .. b.n, st, {
            { "switch", sw and "ON" or "OFF", sw and S_LIVE or S_DEAD },
            { "guard", readv("tu-154/switchers/console/busters_cap") > 0.5
              and "CLOSED" or "open" },
            { "latches on " .. b.bus, fmt(volt, 1) .. " V",
              volt > 13 and S_LIVE or S_DEAD },
            { "engaged", (on and "YES" or "no") .. (latched and " (HELD)" or ""),
              on and S_LIVE or S_DEAD },
            { "hydraulic system " .. b.n, fmt(press, 0) .. " kg/cm2",
              press >= 150 and S_LIVE or S_DEAD, hd = true },
            { "system " .. b.n .. " also feeds", b.also, note = true },
        }, clamp(0, press / 210, 1))
    end

    -- ---- the linkage all three of them drive -------------------------------
    local barSt = anyBoost and S_LIVE or S_DEAD
    for i = 1, 3 do
        local cx = colC(i, 3, FC.C3)
        wire(barSt, cx, Y(FC.TOP + LN_H6), cx, Y(FC.BAR))
        junction(cx, Y(FC.BAR), barSt)
        arrow(cx, (Y(FC.TOP + LN_H6) + Y(FC.BAR)) / 2, 0, -1, barSt)
        wire(barSt, cx, Y(FC.BAR), cx, Y(FC.AX))
        arrow(cx, (Y(FC.BAR) + Y(FC.AX)) / 2, 0, -1, barSt)
    end
    wire(barSt, colC(1, 3, FC.C3), Y(FC.BAR), colC(3, 3, FC.C3), Y(FC.BAR))
    band(FC.BAR - 9, "BOOSTED LINKAGE")
    sasl.gl.drawText(font, colC(3, 3, FC.C3) - 14, Y(FC.BAR - 9),
        "EVERY BOOSTER DRIVES EVERY AXIS, ONE PER HYDRAULIC SYSTEM",
        11, false, false, TEXT_ALIGN_RIGHT, COL_DIM)

    -- ---- the three axes ----------------------------------------------------
    for i = 1, 3 do
        local a = FC_AX[i]
        local inp = readv(a.inp)
        local pl = readv(a.pl)
        local pr = a.pr and readv(a.pr) or nil
        local bad = readv(a.fl) > 0.5 or (a.fr and readv(a.fr) > 0.5)
        local st
        if bad then
            st = S_FAULT
        elseif math.abs(inp) > 0.02 then
            st = anyBoost and S_LIVE or S_LOW
        else
            st = anyBoost and S_STBY or S_DEAD
        end
        listNode(colX(i, 3, FC.C3), FC.AX, FC.C3, LN_H6, a.t .. " -- " .. a.drives, st, {
            { "column / pedal input", fmt(inp, 3), hd = true },
            { "trim switch", enumTxt(a.swmap, readv(a.sw)) },
            { "trim applied", fmt(readv(a.trim), 3) },
            { "feel unit", a.feel and (fmt(readv(a.feel) * 100, 0) .. " %") or "-" },
            { "gauge", fmt(readv(a.gauge), 2) },
            -- the rudder is one surface and has no _phys dataref of its own,
            -- so it repeats its gauge rather than inventing a reading
            { a.single and "surface (gauge)" or "surface L / R",
              a.pr and (fmt(pl, 2) .. " / " .. fmt(pr, 2)) or fmt(pl, 2),
              bad and S_FAULT or nil },
        })
    end

    band(FC.HL - 5, "HIGH LIFT AND AIRBRAKES")
    -- ---- high lift and the airbrakes ---------------------------------------
    local flapL = readv("tu-154/gauges/misc/flap_left_ind")
    local flapR = readv("tu-154/gauges/misc/flap_right_ind")
    local flapBad = readv("tu-154/lights/flaps_unsync") > 0.5
        or readv("tu-154/failures/flap_fail_left") > 0.5
        or readv("tu-154/failures/flap_fail_right") > 0.5
    listNode(colX(1, 3, FC.C3), FC.HL, FC.C3, LN_H6, "FLAPS",
        flapBad and S_FAULT or (flapL > 1 and S_LIVE or S_STBY), {
            { "lever", fmt(readv("tu-154/controll/flaps_lever"), 0) .. " deg" },
            { "left / right", fmt(flapL, 1) .. " / " .. fmt(flapR, 1) .. " deg", hd = true },
            { "asymmetry lamp", readv("tu-154/lights/flaps_unsync") > 0.5 and "LIT" or "dark",
              readv("tu-154/lights/flaps_unsync") > 0.5 and S_FAULT or nil },
            { "PK valve 1 / 2",
              (readv("tu-154/lights/flaps_1_valve") > 0.5 and "OPEN" or "shut") .. " / "
              .. (readv("tu-154/lights/flaps_2_valve") > 0.5 and "OPEN" or "shut") },
            { "driven by", "hydraulic systems 1 and 2", note = true },
            { "failure L / R",
              (readv("tu-154/failures/flap_fail_left") > 0.5 and "FAILED" or "ok") .. " / "
              .. (readv("tu-154/failures/flap_fail_right") > 0.5 and "FAILED" or "ok"),
              flapBad and S_FAULT or nil },
        }, clamp(0, flapL / 36, 1))

    local slatBad = readv("tu-154/failures/slats_fail") > 0.5
        or readv("tu-154/lights/slats_unsync") > 0.5
    listNode(colX(2, 3, FC.C3), FC.HL, FC.C3, LN_H6, "SLATS",
        slatBad and S_FAULT or (readv("tu-154/lights/slats_extended") > 0.5
        and S_LIVE or S_STBY), {
            { "extended lamp",
              readv("tu-154/lights/slats_extended") > 0.5 and "LIT" or "dark" },
            { "asymmetry lamp",
              readv("tu-154/lights/slats_unsync") > 0.5 and "LIT" or "dark",
              readv("tu-154/lights/slats_unsync") > 0.5 and S_FAULT or nil },
            { "manual switch", enumTxt({ [-1] = "RETRACT", [0] = "OFF", [1] = "EXTEND" },
              readv("tu-154/switchers/slat_man")) },
            { "electric heat", "115 V bus 2 -- see the Ice tab", note = true, link = "Ice" },
            { "ground interlock", "extension inhibited on wheels", note = true },
            { "failure", slatBad and "FAILED" or "ok", slatBad and S_FAULT or nil },
        })

    local spl = readv("tu-154/controlls/spoilers_lever")
    listNode(colX(3, 3, FC.C3), FC.HL, FC.C3, LN_H6, "SPOILERS", spl > 0.02
        and S_LIVE or S_STBY, {
            { "lever", fmt(spl * 100, 0) .. " %", hd = true },
            -- flight_controls writes both pairs straight to X-Plane in degrees;
            -- tu-154/controlls/spoil_*_phys is created and never written
            { "middle (speed brake) L / R",
              fmt(readv("sim/flightmodel/controls/wing2l_spo2def"), 1) .. " / "
              .. fmt(readv("sim/flightmodel/controls/wing2r_spo2def"), 1) .. " deg" },
            { "inner (ground) L / R",
              fmt(readv("sim/flightmodel/controls/wing1l_spo1def"), 1) .. " / "
              .. fmt(readv("sim/flightmodel/controls/wing1r_spo1def"), 1) .. " deg" },
            -- spoilers_cmd = bool2int(auto_deploy): on the ground, with idle
            -- thrust above 54 km/h or both reversers out. The lever is not in it.
            { "inner deploy", "automatic only -- never the lever", note = true },
            { "driven by", "HS 1 only, commanded on 27 V LEFT", note = true },
            { "no booster in the path", "they are not part of the boosted demand", note = true },
        }, clamp(0, spl, 1))

    band(FC.TRIM - 5, "TRIM, FEEL AND FAILURES")
    -- ---- stabiliser, loads, and what the surfaces are scaled by ------------
    local stab = readv("tu-154/gauges/misc/stab_ind")
    listNode(colX(1, 3, FC.C3), FC.TRIM, FC.C3, LN_H6, "STABILISER", S_STBY, {
        { "position", fmt(stab, 2) .. " deg", hd = true },
        { "gauge", fmt(readv("tu-154/gauges/misc/stab_ind"), 2) },
        { "CG setting", enumTxt({ [0] = "AFT", [1] = "MID", [2] = "FWD" },
          readv("tu-154/controll/stab_setting")) },
        { "manual switch", enumTxt({ [-1] = "NOSE DN", [0] = "NEUTRAL", [1] = "NOSE UP" },
          readv("tu-154/controll/stab_manual")) },
        { "elevator indication", fmt(readv("tu-154/gauges/misc/elevator_ind"), 2) },
        { "anti-ice duct", "follows the wing switch -- see the Ice tab", note = true, link = "Ice" },
    })

    local l27l = readv("tu-154/control/ctr_27_L_cc")
    local l27r = readv("tu-154/control/ctr_27_R_cc")
    readout(colX(2, 3, FC.C3), FC.TRIM, FC.C3, LN_H6, "FEEL UNITS AND LOAD",
        (l27l + l27r) > 0 and S_LIVE or S_DEAD, {
            { "feel selector", enumTxt({ [-1] = "FLIGHT", [0] = "AUTO", [1] = "T/O-LDG" },
              readv("tu-154/controll/contr_force_set")) },
            { "elevator feel",
              fmt(readv("tu-154/controls/control_force_pos") * 100, 0) .. " %" },
            { "rudder feel",
              fmt(readv("tu-154/controls/control_force_pos_rud") * 100, 0) .. " %" },
            { "27 V left / right load", fmt(l27l, 1) .. " / " .. fmt(l27r, 1) .. " A",
              (l27l + l27r) > 0 and S_LIVE or nil },
            { "elevator coefficient", fmt(readv("tu-154/controlls/elev_coeff"), 3) },
            { "rudder coefficient (Mach, reversers)",
              fmt(readv("tu-154/controlls/rudder_coeff"), 3) },
        })

    local fails = {}
    for _, f in ipairs({ { "elev L", "elev_fail_left" }, { "elev R", "elev_fail_right" },
                         { "ail L", "ail_fail_left" }, { "ail R", "ail_fail_right" },
                         { "rudder", "rudder_fail" }, { "flap L", "flap_fail_left" },
                         { "flap R", "flap_fail_right" }, { "slats", "slats_fail" } }) do
        if readv("tu-154/failures/" .. f[2]) > 0.5 then
            fails[#fails + 1] = f[1]
        end
    end
    readout(colX(3, 3, FC.C3), FC.TRIM, FC.C3, LN_H6, "SURFACE FAILURES",
        (#fails > 0) and S_FAULT or S_DEAD, {
            { "elevator L / R",
              (readv("tu-154/failures/elev_fail_left") > 0.5 and "FAILED" or "ok") .. " / "
              .. (readv("tu-154/failures/elev_fail_right") > 0.5 and "FAILED" or "ok") },
            { "aileron L / R",
              (readv("tu-154/failures/ail_fail_left") > 0.5 and "FAILED" or "ok") .. " / "
              .. (readv("tu-154/failures/ail_fail_right") > 0.5 and "FAILED" or "ok") },
            { "rudder", readv("tu-154/failures/rudder_fail") > 0.5 and "FAILED" or "ok" },
            { "flap L / R",
              (readv("tu-154/failures/flap_fail_left") > 0.5 and "FAILED" or "ok") .. " / "
              .. (readv("tu-154/failures/flap_fail_right") > 0.5 and "FAILED" or "ok") },
            { "slats", readv("tu-154/failures/slats_fail") > 0.5 and "FAILED" or "ok" },
            { "failed now", (#fails > 0) and table.concat(fails, ", ") or "none",
              (#fails > 0) and S_FAULT or nil },
        })

    drawLegend(LEG_D, FC_LEGEND,
        "boosters latch: hydro_logic only reads the switch while the bus is live",
        "hydro_logic multiplies the whole control demand by each booster in turn, so booster N draws from hydraulic system N and all three drive all three axes. Only system 1 also carries the spoilers.")
end
DIAGRAMS.ctrl = drawCtrlDiagram
