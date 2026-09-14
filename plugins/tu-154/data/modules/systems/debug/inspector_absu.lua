-- ---------------------------------------------------------------------------
-- RA-56 servo one-line diagram (the RA-56 tab)
--
-- The ABSU list tab keeps the scalars and lamps; this tab takes the servo
-- layer as the 3 x 3 matrix it is: columns are axes, rows the three RA-56
-- channels. Channel N runs on hydraulic system N (`ra_gsN` from `gs_press_N`
-- feeds `d_raN` in ra56_*_logic.lua), so a hydraulic failure crosses a row
-- and an ABSU channel failure runs down a column. Each column is a parallel
-- circuit: the command bus down the left into all three channels, their
-- outputs collected down the right into the voted rod.
--
-- `absu/d_raN_*` is the commanded RATE; `absu/pos_raN_*` is the position the
-- module's bypass detector compares between channels (over 0.075 apart
-- disconnects one).
-- ---------------------------------------------------------------------------

local AB = {
    CW   = 340,  -- column and full-width node
    SW   = 236,  -- servo node, inset to leave a bus channel each side
    SX   = 52,   -- servo node inset from the column edge
    BUSX = 15,   -- command bus, in from the column's left edge
    SUMX = 325,  -- output bus, in from the column's left edge
    MID  = 41,   -- the in / out wires, below a servo node's top
    PWR  = 8,    -- power, health, autothrottle
    CMD  = 100,  -- per-axis mode and command
    S1   = 190,  -- RA-56 channel 1
    S2   = 292,  -- channel 2
    S3   = 394,  -- channel 3
    OUT  = 512,  -- voted output and director
}
AB.SD = { AB.S1, AB.S2, AB.S3 }
-- the inset leaves 37 px of wire each side of a servo, enough for a flow head

local ABSU_AX = {
    { col = 1, t = "PITCH", ax = "p", sfx = "pitch", hyd = "elev", drives = "elevator",
      main = "tu-154/absu/pitch_main_mode", sub = "tu-154/absu/pitch_sub_mode",
      submap = ENUM_PITCH_SUB,
      cmd = "tu-154/absu/cmd_pitch", contr = "tu-154/absu/contr_pitch",
      dir = "tu-154/absu/absu_pitch_ind", flag = "tu-154/absu/absu_pitch_flag",
      inj = "tu-154/failures/absu_ra56_pitch_fail" },
    { col = 2, t = "ROLL", ax = "r", sfx = "roll", hyd = "ail", drives = "ailerons",
      main = "tu-154/absu/roll_main_mode", sub = "tu-154/absu/roll_sub_mode",
      submap = ENUM_ROLL_SUB,
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
    listNode(colX(1, 3, AB.CW), AB.PWR, AB.CW, LN_H4, "ABSU POWER",
        pwr27 and S_LIVE or S_DEAD, {
            { "27 V", pwr27 and "ON" or "OFF", pwr27 and S_LIVE or S_DEAD },
            { "ABSU load", fmt(readv("tu-154/absu_power_cc"), 1) .. " A" },
            { "autothrottle load", fmt(readv("tu-154/absu_at_power_cc"), 1) .. " A" },
            { "hydraulic circuit",
              readv("tu-154/switchers/eng/hydro_circuit_auto_man") > 0.5 and "MANUAL" or "AUTO" },
        })

    listNode(colX(2, 3, AB.CW), AB.PWR, AB.CW, LN_H4, "ABSU HEALTH",
        failsig and S_FAULT or (healthy and S_LIVE or S_DEAD), {
            { "healthy", healthy and "YES" or "NO", healthy and S_LIVE or S_DEAD },
            { "stabilisation", readv("tu-154/lights/stab_work") > 0.5 and "ON" or "OFF" },
            { "fail signal", failsig and "ON" or "OFF", failsig and S_FAULT or nil },
            -- cabin_sounds.lua sounds the siren on absu_fail_signal;
            -- alarm/speaker_absu is bound there and never written
            { "siren", "sounds on the fail signal", note = true },
        })

    local toga = readv("tu-154/absu/toga_comm") > 0.5
    listNode(colX(3, 3, AB.CW), AB.PWR, AB.CW, LN_H4, "AUTOTHROTTLE (STU)",
        toga and S_LIVE or (readv("tu-154/absu/stu_mode") > 0.5 and S_STBY or S_DEAD), {
            { "mode", enumTxt(ENUM_STU_MODE, readv("tu-154/absu/stu_mode")) },
            { "selector", enumTxt(ENUM_STU_SEL, readv("tu-154/switchers/console/absu_speed_mode")) },
            { "speed diff L / R", fmt(readv("tu-154/absu_at_dif_left"), 1) .. " / "
                .. fmt(readv("tu-154/absu_at_dif_right"), 1) },
            { "go-around", toga and "COMMANDED" or "-", toga and S_LIVE or nil },
        })

    -- ---- one column per axis ---------------------------------------------
    for i = 1, #ABSU_AX do
        local a = ABSU_AX[i]
        local x = colX(a.col, 3, AB.CW)
        local bus, sum = x + AB.BUSX, x + AB.SUMX
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
            local damp = readv(a.damp) > 0.5
            rows = {
                { "mode", "damper only", note = true },
                { "command", fmt(cmd, 3), cmdSt, hd = true },
                { "damper lamp", damp and "ON" or "OFF", damp and S_FAULT or nil },
                { "RA-56 failure injected", inj > 0.5 and ("CHANNEL " .. fmt(inj, 0)) or "none",
                  inj > 0.5 and S_FAULT or nil },
            }
        end
        listNode(x, AB.CMD, AB.CW, LN_H4, a.t .. " CHANNEL", cmdSt, rows)

        -- the three RA-56 channels, in parallel off the command bus
        local anyDriving = false
        for n = 1, 3 do
            local dy = AB.SD[n]
            local mid = dy + AB.MID
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
        wire(cmdSt, bus, Y(AB.CMD + LN_H4), bus, Y(AB.S3 + AB.MID))
        wire(anyDriving and S_LIVE or S_DEAD, sum, Y(AB.S1 + AB.MID), sum, Y(AB.OUT))
        arrow(bus, (Y(AB.CMD + LN_H4) + Y(AB.S1 + AB.MID)) / 2, 0, -1, cmdSt)
        arrow(sum, (Y(AB.S3 + AB.MID) + Y(AB.OUT)) / 2, 0, -1,
            anyDriving and S_LIVE or S_DEAD)

        -- ---- voted output --------------------------------------------------
        local flag = a.flag and readv(a.flag) > 0.5
        listNode(x, AB.OUT, AB.CW, LN_H4, a.t .. " OUTPUT",
            anyDriving and S_LIVE or (pwr27 and S_STBY or S_DEAD), {
                -- no headline: the output bus lands where it would sit
                { "combined rod", fmt(contr, 3), anyDriving and S_LIVE or nil },
                { "drives", a.drives, note = true },
                { "director", a.dir and fmt(readv(a.dir), 2) or "-" },
                { "director flag", a.flag and (flag and "SHOWN" or "clear") or "-",
                  flag and S_FAULT or nil },
            })
    end

    drawLegend(LEG_D, ABSU_LEGEND,
        "channel N runs on hydraulic system N: a hydraulic failure crosses a row, an ABSU one a column",
        "d_raN is the servo's commanded rate; pos_raN is the rod position the module's own bypass detector compares between channels.")
end
DIAGRAMS.absu = drawAbsuDiagram
