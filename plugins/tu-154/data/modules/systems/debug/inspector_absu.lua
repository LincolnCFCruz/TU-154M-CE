--[[

  File: inspector_absu.lua
  -----
  Tu-154M System Viewer / Debug Inspector -- the RA-56 tab's diagram (DIAGRAMS.absu).

  Loaded by debug_inspector_view.lua into the inspector's shared namespace
  (see "The inspector's files" there): the vocabulary it draws with --
  listNode, wire, readv, the S_* states, colX, Y and the rest of
  inspector_vocab.lua -- is in scope without being imported, and its own
  top-level locals stay private to this file.

--]]

-- ---------------------------------------------------------------------------
-- RA-56 servo one-line diagram (the RA-56 tab)
--
-- This one is a NEW tab rather than a conversion, and that is deliberate. The
-- ABSU card tab carries 81 readings, most of them scalars and lamps that a grid
-- shows perfectly well; the servo layer adds about thirty more. Together they do
-- not fit one diagram without turning back into a grid, so the grid keeps the
-- scalars and this tab takes the part that has structure worth drawing.
--
-- The structure is a 3 x 3 matrix and the diagram is laid out as one: columns
-- are axes (pitch, roll, yaw), rows are the three RA-56 channels. Channel N is
-- driven by hydraulic system N -- `ra_gsN` is computed from `gs_press_N` and
-- feeds `d_raN` in ra56_*_logic.lua -- so a hydraulic failure walks across one
-- row of the matrix, and an ABSU channel failure walks down one column.
--
-- Each column reads as a parallel circuit, which is what it is: the command bus
-- runs down the left of the column into all three channels, and their outputs
-- collect on the bus down the right into the voted combined rod at the bottom.
--
-- Two things the row labels are careful about, because the names mislead:
--   * `tu-154/absu/d_raN_*` is the servo's commanded RATE, not a position --
--     ra56_*_logic integrates it (`raN_act = raN_act + d_raN * dt`).
--   * the POSITION was a module local until this diagram needed it. It matters
--     because the module's own bypass detector compares positions between
--     channels (a difference over 0.075 disconnects one), so without it you can
--     see that a channel dropped out but not that it drifted out of step first.
--     `tu-154/absu/pos_raN_*` is that value, published rather than inferred.
-- ---------------------------------------------------------------------------

local AB = {
    COL  = 370,  -- column pitch
    CW   = 340,  -- full-width node
    SW   = 236,  -- servo node, inset to leave a bus channel each side
    SX   = 52,   -- servo node inset from the column edge
    PWR  = 8,    -- power, health, autothrottle
    CMD  = 100,  -- per-axis mode and command
    S1   = 190,  -- RA-56 channel 1
    S2   = 292,  -- channel 2
    S3   = 394,  -- channel 3
    OUT  = 512,  -- voted output and director
}
-- The servo node is inset 40 rather than 30 and is 20 px narrower than the
-- column, which buys 25 px of bare wire on each side of it -- enough for a
-- head, so the command going IN and the rod position coming OUT are told
-- apart by more than which side of the box they are on.

local ABSU_AX = {
    { col = 1, t = "PITCH", ax = "p", sfx = "pitch", hyd = "elev", drives = "elevator",
      main = "tu-154/absu/pitch_main_mode", sub = "tu-154/absu/pitch_sub_mode",
      submap = { [0] = "OFF", [1] = "STAB", [2] = "V", [3] = "M", [4] = "H",
                 [5] = "GLIDESLOPE", [6] = "GO-AROUND" },
      cmd = "tu-154/absu/cmd_pitch", contr = "tu-154/absu/contr_pitch",
      dir = "tu-154/absu/absu_pitch_ind", flag = "tu-154/absu/absu_pitch_flag",
      inj = "tu-154/failures/absu_ra56_pitch_fail" },
    { col = 2, t = "ROLL", ax = "r", sfx = "roll", hyd = "ail", drives = "ailerons",
      main = "tu-154/absu/roll_main_mode", sub = "tu-154/absu/roll_sub_mode",
      submap = { [0] = "OFF", [1] = "STAB", [2] = "ZK", [3] = "NVU", [4] = "AZ 1",
                 [5] = "AZ 2", [6] = "APPROACH" },
      cmd = "tu-154/absu/cmd_roll", contr = "tu-154/absu/contr_roll",
      dir = "tu-154/absu/absu_roll_ind", flag = "tu-154/absu/absu_roll_flag",
      inj = "tu-154/failures/absu_ra56_roll_fail" },
    -- yaw is a damper only: no main or sub mode, and no flight director
    { col = 3, t = "YAW", ax = "y", sfx = "yaw", hyd = "rud", drives = "rudder",
      cmd = "tu-154/absu/cmd_yaw", contr = "tu-154/absu/contr_yaw",
      damp = "tu-154/absu/damp_yaw_lamp",
      inj = "tu-154/failures/absu_ra56_yaw_fail" },
}

local ABSU_LEGEND = {
    { S_LIVE,  "driving" },
    { S_STBY,  "powered, not driving" },
    { S_LOW,   "degraded" },
    { S_DEAD,  "off" },
    { S_FAULT, "bypassed or failed" },
}

local function drawAbsuDiagram()
    local pwr27 = readv("tu-154/absu_power_27") > 0.5
    local healthy = readv("tu-154/lights/absu_work") > 0.5
    local failsig = readv("tu-154/absu/absu_fail_signal") > 0.5

    -- ---- power, health, autothrottle -------------------------------------
    listNode(colX(1, 3, AB.COL), AB.PWR, AB.CW, LN_H4, "ABSU POWER",
        pwr27 and S_LIVE or S_DEAD, {
            { "27 V", pwr27 and "ON" or "OFF", pwr27 and S_LIVE or S_DEAD },
            { "ABSU load", fmt(readv("tu-154/absu_power_cc"), 1) .. " A" },
            { "autothrottle load", fmt(readv("tu-154/absu_at_power_cc"), 1) .. " A" },
            { "hydraulic circuit",
              readv("tu-154/switchers/eng/hydro_circuit_auto_man") > 0.5 and "MANUAL" or "AUTO" },
        })

    listNode(colX(2, 3, AB.COL), AB.PWR, AB.CW, LN_H4, "ABSU HEALTH",
        failsig and S_FAULT or (healthy and S_LIVE or S_DEAD), {
            { "healthy", healthy and "YES" or "NO", healthy and S_LIVE or S_DEAD },
            { "stabilisation", readv("tu-154/lights/stab_work") > 0.5 and "ON" or "OFF" },
            { "fail signal", failsig and "ON" or "OFF", failsig and S_FAULT or nil },
            -- cabin_sounds.lua sounds the siren on absu_fail_signal (with power,
            -- the buzzer switch and a working speaker); alarm/speaker_absu, which
            -- this row used to read, is bound there and never written
            { "siren", "sounds on the fail signal", note = true },
        })

    local toga = readv("tu-154/absu/toga_comm") > 0.5
    listNode(colX(3, 3, AB.COL), AB.PWR, AB.CW, LN_H4, "AUTOTHROTTLE (STU)",
        toga and S_LIVE or (readv("tu-154/absu/stu_mode") > 0.5 and S_STBY or S_DEAD), {
            { "mode", enumTxt({ [0] = "OFF", [1] = "ON", [2] = "ARMED", [3] = "STAB",
                                [4] = "GO-AROUND" }, readv("tu-154/absu/stu_mode")) },
            { "selector", enumTxt({ [0] = "OFF", [1] = "NVU", [2] = "AZ 1", [3] = "AZ 2",
                                    [4] = "LANDING" },
                readv("tu-154/switchers/console/absu_speed_mode")) },
            { "speed diff L / R", fmt(readv("tu-154/absu_at_dif_left"), 1) .. " / "
                .. fmt(readv("tu-154/absu_at_dif_right"), 1) },
            { "go-around", toga and "COMMANDED" or "-", toga and S_LIVE or nil },
        })

    -- ---- one column per axis ---------------------------------------------
    for i = 1, #ABSU_AX do
        local a = ABSU_AX[i]
        local x = colX(a.col, 3, AB.COL)
        local bus, sum = x + 15, x + 325
        local cmd = readv(a.cmd)
        local contr = readv(a.contr)
        local inj = readv(a.inj)
        local cmdSt = (not pwr27) and S_DEAD
            or ((math.abs(cmd) > 0.0005) and S_LIVE or S_STBY)

        local rows
        if a.main then
            rows = {
                { "main mode", enumTxt(ENUM_AXIS_MAIN, readv(a.main)) },
                { "sub mode", enumTxt(a.submap, readv(a.sub)) },
                { "command", fmt(cmd, 3), cmdSt, hd = true },
                { "RA-56 failure injected", inj > 0.5 and ("CHANNEL " .. fmt(inj, 0)) or "none",
                  inj > 0.5 and S_FAULT or nil },
            }
        else
            rows = {
                { "mode", "damper only", note = true },
                { "command", fmt(cmd, 3), cmdSt, hd = true },
                { "damper lamp", readv(a.damp) > 0.5 and "ON" or "OFF",
                  readv(a.damp) > 0.5 and S_FAULT or nil },
                { "RA-56 failure injected", inj > 0.5 and ("CHANNEL " .. fmt(inj, 0)) or "none",
                  inj > 0.5 and S_FAULT or nil },
            }
        end
        listNode(x, AB.CMD, AB.CW, LN_H4, a.t .. " CHANNEL", cmdSt, rows)

        -- the three RA-56 channels, in parallel off the command bus
        local depths = { AB.S1, AB.S2, AB.S3 }
        local anyDriving = false
        for n = 1, 3 do
            local dy = depths[n]
            local mid = dy + 41
            local supply = readv("tu-154/switchers/eng/hydro_ra56_" .. a.hyd .. "_" .. n) > 0.5
            local press = readv("tu-154/hydro/gs_press_" .. n)
            local bypass = readv("tu-154/failures/absu_ra" .. n .. "_" .. a.sfx .. "_fail") > 0.5
            local pos = readv("tu-154/absu/pos_ra" .. n .. "_" .. a.ax)
            local rate = readv("tu-154/absu/d_ra" .. n .. "_" .. a.ax)
            local st
            if bypass then
                st = S_FAULT
            elseif math.abs(rate) > 0.001 then
                st = S_LIVE
                anyDriving = true
            elseif supply and press >= 150 then
                st = S_STBY
            else
                st = S_DEAD
            end
            listNode(x + AB.SX, dy, AB.SW, LN_H5, "RA-56 " .. n, st, {
                { "supply switch", supply and "OPEN" or "SHUT", supply and S_LIVE or S_DEAD },
                { "HS " .. n .. " pressure", fmt(press, 0) .. " kg/cm2",
                  press >= 150 and S_LIVE or S_DEAD },
                { "channel", bypass and "BYPASSED" or "ENGAGED", bypass and S_FAULT or nil },
                { "rod position", fmt(pos, 3), hd = true },
                { "rod rate", fmt(rate, 3), st },
            })
            -- command in on the left, output out on the right
            wire(cmdSt, bus, Y(mid), x + AB.SX, Y(mid))
            wire(st, x + AB.SX + AB.SW, Y(mid), sum, Y(mid))
            junction(bus, Y(mid), cmdSt)
            junction(sum, Y(mid), st)
            arrow((bus + x + AB.SX) / 2, Y(mid), 1, 0, cmdSt)
            arrow((x + AB.SX + AB.SW + sum) / 2, Y(mid), 1, 0, st)
        end
        wire(cmdSt, bus, Y(AB.CMD + LN_H4), bus, Y(AB.S3 + 41))
        wire(anyDriving and S_LIVE or S_DEAD, sum, Y(AB.S1 + 41), sum, Y(AB.OUT))
        arrow(bus, (Y(AB.CMD + LN_H4) + Y(AB.S1 + 41)) / 2, 0, -1, cmdSt)
        arrow(sum, (Y(AB.S3 + 41) + Y(AB.OUT)) / 2, 0, -1,
            anyDriving and S_LIVE or S_DEAD)

        -- ---- voted output --------------------------------------------------
        listNode(x, AB.OUT, AB.CW, LN_H4, a.t .. " OUTPUT",
            anyDriving and S_LIVE or (pwr27 and S_STBY or S_DEAD), {
                -- no headline here: the voted-output bus lands on this node's
                -- top edge right where a headline would sit
                { "combined rod", fmt(contr, 3), anyDriving and S_LIVE or nil },
                { "drives", a.drives, note = true },
                { "director", a.dir and fmt(readv(a.dir), 2) or "-" },
                { "director flag", a.flag and (readv(a.flag) > 0.5 and "SHOWN" or "clear") or "-",
                  (a.flag and readv(a.flag) > 0.5) and S_FAULT or nil },
            })
    end

    drawLegend(LEG_D, ABSU_LEGEND,
        "channel N runs on hydraulic system N: a hydraulic failure crosses a row, an ABSU one a column",
        "d_raN is the servo's commanded rate; pos_raN is the rod position the module's own bypass detector compares between channels.")
end
DIAGRAMS.absu = drawAbsuDiagram
