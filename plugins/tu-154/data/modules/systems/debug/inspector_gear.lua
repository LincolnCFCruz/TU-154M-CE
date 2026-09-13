-- ---- Landing gear and brakes ------------------------------------------------
-- The top half of this diagram is one line of landing_gears.lua:
--
--   dirrection = lever * (gs1/200) * power_L * (1 - gs_3GS) * 2
--              + lever * (gs3/200) * power_R *      gs_3GS  * 1.3
--              + emerg_gear_ext * (gs2/200)                 * 1.3
--
-- Three paths to the same three actuators, SUMMED rather than selected, which
-- is why they are drawn as three columns dropping onto one bar. Each is
-- *proportional* to its system's pressure (`min(press / 200, 1)`) and not gated
-- by it, so a half-pressurised system still extends the gear, at half speed.
--
-- Below the bar the diagram stops being that line, because the sum is not what
-- moves the gear. Every leg integrates
--
--   pos = pos + SPEED * (drive * (not failed) + gravity - air load) * dt * gear_move
--
-- inside `if not lockN and retract then`, and those three extra terms are the
-- reason this tab is worth drawing:
--
--   * `gear_move` is a HARD gate -- 27 V left when 3GS is not selected, 27 V
--     right when it is. The emergency term needs no power to appear in the sum,
--     but the sum it lands in is multiplied by `gear_move` anyway, so with both
--     27 V buses dead the gear does not move at all: not on the emergency
--     system, and not under its own weight. That is what the contactors on the
--     three drops say.
--   * `retract` is named for retraction and gates BOTH directions: with weight
--     on the left main strut nothing moves unless the lock switch overrides it.
--   * gravity and air load are outside the failure term, so a leg whose
--     retraction has failed still free-falls -- and all three legs take both
--     terms from `pos1_last`, the NOSE gear's position, not their own.
--
-- The brake band is brake_system.lua, which saturates on `press / 120` where
-- the gear uses `press / 200`, and whose anti-skid releases a wheel that has
-- dropped below 80 % of ground speed.
-- ---------------------------------------------------------------------------

local LG = {
    C3   = 340,  -- three-column node
    TOP  = 8,    -- the three extension paths                (LN_H6 -> 107)
    BAR  = 135,  -- the summed drive
    LEGS = 187,  -- nose, left main, right main              (LN_H6 -> 286)
    BRK  = 326,  -- brakes                                   (LN_H6 -> 425)
    GATE = 465,  -- gates, struts, what the sim is told      (LN_H6 -> 564)
}

local LG_LEG = {
    { t = "NOSE GEAR", pos = "tu-154/anim/lg/front_pos", n = 1, suffix = "front",
      grav = "tu-154/gears/grav_front", load = "tu-154/gears/load_front" },
    { t = "LEFT MAIN", pos = "tu-154/anim/lg/main_pos_left", n = 2, suffix = "left",
      grav = "tu-154/gears/grav_main", load = "tu-154/gears/load_main" },
    { t = "RIGHT MAIN", pos = "tu-154/anim/lg/main_pos_right", n = 3, suffix = "right",
      grav = "tu-154/gears/grav_main", load = "tu-154/gears/load_main" },
}

-- a leg in transit is doing what it was told, so it is not amber
local LG_LEGEND = {
    { S_LIVE,  "down and locked" },
    { S_STBY,  "available, or moving" },
    { S_LOW,   "caution" },
    { S_DEAD,  "up, or no supply" },
    { S_FAULT, "failed or warning" },
}

local function drawGearDiagram()
    local v27l = readv("tu-154/elec/bus27_volt_left")
    local v27r = readv("tu-154/elec/bus27_volt_right")
    local p1 = readv("tu-154/hydro/gs_press_1")
    local p2 = readv("tu-154/hydro/gs_press_2")
    local p3 = readv("tu-154/hydro/gs_press_3")
    local g3 = readv("tu-154/switchers/gears_ext_3GS") > 0.5
    local emerg = readv("tu-154/controll/emerg_gear_ext") > 0.5
    -- rel_gear_act is X-Plane's own failure, so it is the 0/6 convention
    local actFail = readv("sim/operation/failures/rel_gear_act") >= 6
    local levRaw = math.floor(readv("tu-154/controll/gear_lever") + 0.5)
    local lever = actFail and 0 or levRaw
    local levTxt = enumTxt({ [-1] = "UP", [0] = "NEUTRAL", [1] = "DOWN" }, levRaw)

    -- the three terms of the sum, each written the way landing_gears.lua writes it
    local tNorm = lever * clamp(0, p1 / 200, 1) * (v27l > 13 and 1 or 0)
        * (g3 and 0 or 1) * 2
    local tAlt = lever * clamp(0, p3 / 200, 1) * (v27r > 13 and 1 or 0)
        * (g3 and 1 or 0) * 1.3
    local tEmg = (emerg and 1 or 0) * clamp(0, p2 / 200, 1) * 1.3
    -- the module's own sum, so a term written wrong here shows up as a mismatch
    local drive = readv("tu-154/gears/drive")

    listNode(colX(1, 3, LG.C3), LG.TOP, LG.C3, LN_H6, "NORMAL EXTENSION",
        tNorm ~= 0 and S_LIVE or ((not g3) and S_STBY or S_DEAD), {
            { "hydraulic system 1", fmt(p1, 0) .. " kg/cm2",
              p1 > 0 and S_LIVE or S_DEAD },
            { "27 V left (> 13)", fmt(v27l, 1) .. " V", v27l > 13 and S_LIVE or S_DEAD },
            { "gear lever", levTxt, levRaw ~= 0 and S_LIVE or nil },
            { "3GS selected", g3 and "YES -- this path is out" or "no",
              g3 and S_DEAD or nil },
            { "rate at full pressure", "2.0 (the fast path)", note = true },
            { "driving", fmt(tNorm, 2), tNorm ~= 0 and S_LIVE or nil, hd = true },
        }, clamp(0, p1 / 200, 1))

    listNode(colX(2, 3, LG.C3), LG.TOP, LG.C3, LN_H6, "ALTERNATE, FROM HS 3",
        tAlt ~= 0 and S_LIVE or (g3 and S_STBY or S_DEAD), {
            { "hydraulic system 3", fmt(p3, 0) .. " kg/cm2",
              p3 > 0 and S_LIVE or S_DEAD },
            { "27 V right (> 13)", fmt(v27r, 1) .. " V", v27r > 13 and S_LIVE or S_DEAD },
            { "gear lever", levTxt, levRaw ~= 0 and S_LIVE or nil },
            { "3GS selector", g3 and "SELECTED" or "off", g3 and S_LIVE or S_DEAD },
            { "rate at full pressure", "1.3", note = true },
            { "driving", fmt(tAlt, 2), tAlt ~= 0 and S_LIVE or nil, hd = true },
        }, clamp(0, p3 / 200, 1))

    listNode(colX(3, 3, LG.C3), LG.TOP, LG.C3, LN_H6, "EMERGENCY EXTENSION",
        tEmg ~= 0 and S_LIVE or (emerg and S_LOW or S_STBY), {
            { "hydraulic system 2", fmt(p2, 0) .. " kg/cm2",
              p2 > 0 and S_LIVE or S_DEAD },
            { "handle", emerg and "PULLED" or "stowed", emerg and S_LIVE or nil },
            { "gear lever", "not in this term", note = true },
            { "27 V", "not in this term -- but see the gate", note = true },
            { "rate at full pressure", "1.3", note = true },
            { "driving", fmt(tEmg, 2), tEmg ~= 0 and S_LIVE or nil, hd = true },
        }, clamp(0, p2 / 200, 1))

    -- ---- the three paths add, and the sum drives all three legs -------------
    local dSt = (drive ~= 0) and S_LIVE or S_DEAD
    local terms = { tNorm, tAlt, tEmg }
    for i = 1, 3 do
        local cx = colC(i, 3, LG.C3)
        local tSt = (terms[i] ~= 0) and S_LIVE or S_DEAD
        wire(tSt, cx, Y(LG.TOP + LN_H6), cx, Y(LG.BAR))
        -- which way this path is pushing: the emergency term is always positive,
        -- the other two carry the sign of the lever
        if terms[i] ~= 0 then
            arrow(cx, Y(121), 0, (terms[i] < 0) and 1 or -1, tSt)
        end
        junction(cx, Y(LG.BAR), dSt)
    end
    wire(dSt, colC(1, 3, LG.C3), Y(LG.BAR), colC(3, 3, LG.C3), Y(LG.BAR))

    -- Nothing below the bar moves without gear_move AND retract, and that
    -- includes the emergency path and the free-fall terms -- so the gate is a
    -- contactor in series with every leg rather than a row in a box.
    local powerGate = readv("tu-154/gears/power_gate") > 0.5
    local retrGate = readv("tu-154/gears/retract_gate") > 0.5
    local gateOk = powerGate and retrGate
    local gSt = gateOk and (drive ~= 0 and S_LIVE or S_STBY) or S_DEAD
    for i = 1, 3 do
        local cx = colC(i, 3, LG.C3)
        wire(gateOk and dSt or S_DEAD, cx, Y(LG.BAR), cx, Y(LG.LEGS))
        contactor(cx, Y(161), gateOk, gSt)
    end
    sasl.gl.drawText(font, colX(1, 3, LG.C3) + 2, Y(176),
        "DRIVE " .. fmt(drive, 2) .. "  "
        .. ((drive > 0) and "EXTENDING" or ((drive < 0) and "RETRACTING" or "IDLE")),
        11, false, false, TEXT_ALIGN_LEFT, COL_DIM)
    sasl.gl.drawText(font, colC(3, 3, LG.C3) - 40, Y(176),
        gateOk and "GATE OPEN" or "GATE SHUT", 11, false, false,
        TEXT_ALIGN_RIGHT, COL_DIM)

    -- ---- the legs -----------------------------------------------------------
    for i = 1, 3 do
        local g = LG_LEG[i]
        local pos = readv(g.pos)
        local green = readv("tu-154/lights/gears_green_" .. g.suffix) > 0.05
        local red = readv("tu-154/lights/gears_red_" .. g.suffix) > 0.05
        local locked = readv("tu-154/gears/lock_" .. g.suffix) > 0.5
        local retF = readv("sim/operation/failures/rel_lagear" .. g.n) >= 6
        local colF = readv("sim/operation/failures/rel_collapse" .. g.n) >= 6
        local grav = readv(g.grav)
        local load = readv(g.load)
        local st
        if retF or colF then
            st = S_FAULT
        elseif green then
            st = S_LIVE
        elseif pos > 0.99 then
            st = S_STBY
        elseif pos > 0.01 then
            st = S_STBY
        else
            st = S_DEAD
        end
        listNode(colX(i, 3, LG.C3), LG.LEGS, LG.C3, LN_H6, g.t, st, {
            { "position", fmt(pos * 100, 0) .. " %", st, hd = true },
            { "lock", locked and "AT AN END STOP" or "free to move",
              locked and S_STBY or nil },
            { "green / red lamp", (green and "LIT" or "dark") .. " / "
              .. (red and "LIT" or "dark"),
              red and S_LOW or (green and S_LIVE or nil) },
            { (i == 1) and "gravity, helping down"
              or "gravity (uses the NOSE position)", "+" .. fmt(grav, 3),
              grav > 0.001 and S_LIVE or nil },
            { "air load, holding it up", "-" .. fmt(load, 3) },
            { "retract / collapse failure", (retF and "FAILED" or "ok") .. " / "
              .. (colF and "COLLAPSED" or "ok"), (retF or colF) and S_FAULT or nil },
        }, clamp(0, pos, 1))
    end

    band(LG.BRK - 5, "BRAKES")
    -- ---- brakes -------------------------------------------------------------
    for _, b in ipairs({ { 1, "LEFT BRAKE", "L", "left", 1 },
                         { 3, "RIGHT BRAKE", "R", "right", 2 } }) do
        local col, ttl, sfx, side, wheel = b[1], b[2], b[3], b[4], b[5]
        local applied = readv("tu-154/brakes/int_brakes_" .. sfx)
        local temp = readv("tu-154/failures/brake_heat_" .. side)
        local skid = readv("tu-154/brakes/antiskid_" .. sfx) < 0.5
        -- a release only matters while the brake is being applied; unbraked,
        -- the coefficient says nothing and was an amber row on every cold start
        local releasing = skid and applied > 0.02
        local life = readv("tu-154/failures/brake_runtime_" .. side)
        local failed = readv("sim/operation/failures/rel_" .. string.lower(sfx)
            .. "brakes") >= 6
        local st
        if failed then
            st = S_FAULT
        elseif releasing then
            st = S_LOW
        elseif applied > 0.02 then
            st = S_LIVE
        else
            st = S_STBY
        end
        listNode(colX(col, 3, LG.C3), LG.BRK, LG.C3, LN_H6, ttl, st, {
            { "applied", fmt(applied * 100, 0) .. " %",
              applied > 0.02 and S_LIVE or nil, hd = true },
            { "line pressure",
              fmt(readv("tu-154/gauges/console/gear_brake_press_" .. sfx), 0)
              .. " kg/cm2" },
            { "anti-skid", skid and "RELEASED" or "holding", releasing and S_LOW or nil },
            { "wheel speed", fmt(readv("sim/flightmodel/parts/tire_speed_now["
              .. wheel .. "]"), 1) .. " m/s" },
            { "temperature (300 C)", fmt(temp, 0) .. " C",
              temp > 300 and S_FAULT or nil },
            { "life left / failed", fmt(life, 2) .. " / "
              .. (failed and "FAILED" or "ok"), failed and S_FAULT or nil },
        }, clamp(0, applied, 1))
    end

    local park = readv("tu-154/controll/parking_brake") > 0.5
    local emgBrk = readv("tu-154/controlls/brake_emerg")
    local chocks = readv("tu-154/anim/gear_blocks") > 0.5
    local p4 = readv("tu-154/hydro/gs_press_4")
    listNode(colX(2, 3, LG.C3), LG.BRK, LG.C3, LN_H6, "EMERGENCY AND PARKING",
        (park or emgBrk > 0.02) and S_LIVE or S_STBY, {
            { "parking brake", park and "SET" or "off", park and S_LIVE or nil },
            { "emergency lever", fmt(emgBrk * 100, 0) .. " %",
              emgBrk > 0.02 and S_LIVE or nil },
            { "emergency left / right",
              fmt(readv("tu-154/controlls/brake_emerg_L") * 100, 0) .. " / "
              .. fmt(readv("tu-154/controlls/brake_emerg_R") * 100, 0) .. " %" },
            { "accumulator, HS 4 (Hydr tab)", fmt(p4, 0) .. " kg/cm2",
              p4 > 50 and S_LIVE or S_DEAD, link = "Hydr" },
            { "wheel chocks", chocks and "IN PLACE" or "removed",
              chocks and S_LOW or nil },
            { "brakes saturate at", "120 kg/cm2, the gear at 200", note = true },
        }, clamp(0, p4 / 210, 1))

    band(LG.GATE - 5, "GATES, STRUTS AND OUTPUTS")
    -- ---- gates, struts, and what the sim was told ---------------------------
    local retrLock = readv("tu-154/switchers/gears_retr_lock") > 0.5
    local notExt = readv("tu-154/lights/gears_not_ext") > 0.05
    local warn = readv("tu-154/alarm/main_gear_flaps") > 0.5
    listNode(colX(1, 3, LG.C3), LG.GATE, LG.C3, LN_H6, "WHAT LETS THE LEGS MOVE",
        actFail and S_FAULT
        or ((not powerGate) and S_DEAD or (retrGate and S_LIVE or S_STBY)), {
            { "27 V gate", powerGate
              and ("OPEN via 27 V " .. (g3 and "RIGHT" or "LEFT"))
              or "SHUT -- nothing moves at all",
              powerGate and S_LIVE or S_DEAD },
            { "movement interlock", retrGate and "released"
              or "HELD -- left main is loaded", retrGate and S_LIVE or nil },
            { "retraction lock switch", retrLock and "OVERRIDDEN" or "armed",
              retrLock and S_LOW or nil },
            { "actuator failure", actFail and "FAILED -- lever ignored" or "ok",
              actFail and S_FAULT or nil },
            { "GEARS NOT EXTENDED lamp", notExt and "LIT" or "dark",
              notExt and S_FAULT or nil },
            { "gear / flap warning", warn and "SOUNDING" or "quiet",
              warn and S_FAULT or nil },
        })

    readout(colX(2, 3, LG.C3), LG.GATE, LG.C3, LN_H6, "STRUTS, STEERING, BOGIES",
        S_DEAD, {
            { "nose steering", fmt(readv("tu-154/anim/lg/front_turn"), 1) .. " deg" },
            -- nosewheel.lua writes the limit: 10 or 63 deg by the selector, times
            -- HS 2 pressure (controlls/nosewheel_lever is the 0..1 tiller handle)
            { "steering limit",
              fmt(readv("sim/aircraft/gear/acf_nw_steerdeg1"), 0) .. " deg" },
            { "nose strut compression",
              fmt(readv("tu-154/anim/lg/front_defl"), 2) },
            { "main strut deflection L / R",
              fmt(readv("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"), 3)
              .. " / "
              .. fmt(readv("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"), 3)
              .. " m" },
            { "bogie rotation L / R",
              fmt(readv("tu-154/anim/lg/main_rot_left"), 2) .. " / "
              .. fmt(readv("tu-154/anim/lg/main_rot_right"), 2) },
            -- the switch: nothing computes lights/gear_nacelle_light itself,
            -- light_panel only reads this for its click sound
            { "nacelle light switch",
              readv("tu-154/lights/gear_nacelle_light_set") > 0.5 and "ON" or "off" },
        })

    readout(colX(3, 3, LG.C3), LG.GATE, LG.C3, LN_H6, "WHAT THE SIM IS TOLD",
        S_DEAD, {
            { "gear deploy 1 / 2 / 3",
              fmt(readv("sim/aircraft/parts/acf_gear_deploy[0]"), 2) .. " / "
              .. fmt(readv("sim/aircraft/parts/acf_gear_deploy[1]"), 2) .. " / "
              .. fmt(readv("sim/aircraft/parts/acf_gear_deploy[2]"), 2) },
            { "handle status / down",
              fmt(readv("sim/cockpit/switches/gear_handle_status"), 0) .. " / "
              .. fmt(readv("sim/cockpit2/controls/gear_handle_down"), 0) },
            { "park brake",
              fmt(readv("sim/flightmodel/controls/parkbrake") * 100, 0) .. " %" },
            { "brake add L / R",
              fmt(readv("sim/flightmodel/controls/l_brake_add") * 100, 0) .. " / "
              .. fmt(readv("sim/flightmodel/controls/r_brake_add") * 100, 0) .. " %" },
            { "airspeed / normal g",
              fmt(readv("sim/flightmodel/position/indicated_airspeed"), 0) .. " kt / "
              .. fmt(readv("sim/flightmodel2/misc/gforce_normal"), 2) },
            { "height above ground",
              fmt(readv("sim/flightmodel/position/y_agl"), 0) .. " m" },
        })

    drawLegend(LEG_D, LG_LEGEND,
        "pressure scales the rate, it does not gate it: half pressure is half speed",
        "The contactors are gear_move AND retract: with both 27 V buses dead the gear moves neither on the emergency system nor under its own weight. A failed leg still free-falls.")
end
DIAGRAMS.gear = drawGearDiagram
