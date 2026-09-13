-- ---- Annunciators and lights (the Lamps tab) -------------------------------
-- Every tu-154/lights/ dataref the registry creates, as a grid of lamps, with
-- a LIT view that shows only what is lit right now -- the quickest way to find
-- the one lamp that should not be on. The other chips show one group each, so
-- no view ever holds more than a screen and the tab never scrolls.
--
-- The list is not typed out here. LP.load reads it from
-- core/dataref_creator_*.lua the first time the tab is drawn, so a lamp added
-- to the registry appears without anyone touching this file -- the same reason
-- the DATAREFS probe derives its list from the reads. Reading a file as text is
-- not include(): nothing here runs systems code.
--
-- Left out: the controls that share the namespace -- anything with `_set` in
-- its name (dimmers, integral lighting, the landing-light extension and mode
-- switches), switch covers (`_cap`) and landing_light_off. They are switch
-- positions, not lamps.
--
-- DEAD is the one list that is typed out: the lamps nothing in the aircraft
-- drives, per _tools/writers.py. They are drawn hollow and never read, because
-- a lamp nothing drives reads 0, which looks exactly like a working lamp that
-- is off. diagcheck keeps it honest both ways: its dead rule fails this tab if
-- it reads a lamp nothing writes, and fails a DEAD entry that something writes.
-- ---------------------------------------------------------------------------

-- shared: the frame code's click handler and diagcheck reach it
LP = {
    CHIP_D = 4,    -- depth of the mode chips
    CHIP_W = 150,
    TOP    = 30,   -- depth of the first lamp row
    PITCH  = 13,
    COLS   = 5,
    LIT    = 0.05, -- lamp values are brightness, so a dimmed lamp is still lit
    MODES  = {
        { t = "LIT" },
        { g = "main",    t = "MAIN" },
        { g = "small",   t = "SMALL" },
        { g = "engines", t = "ENGINES" },
        { g = "button",  t = "BUTTONS" },
        { g = "fire",    t = "FIRE" },
        { g = "apu",     t = "APU" },
    },
    DEAD   = {
        ["tu-154/lights/button/dejur_contr"] = true,
        ["tu-154/lights/button/sound_off"] = true,
        ["tu-154/lights/cargo_light_1"] = true,
        ["tu-154/lights/cargo_light_2"] = true,
        ["tu-154/lights/engines/egt_nk8_1"] = true,
        ["tu-154/lights/engines/egt_nk8_2"] = true,
        ["tu-154/lights/engines/egt_nk8_3"] = true,
        ["tu-154/lights/engines/eng1_t_high"] = true,
        ["tu-154/lights/engines/eng2_t_high"] = true,
        ["tu-154/lights/engines/eng3_t_high"] = true,
        ["tu-154/lights/gear_nacelle_light"] = true,
        ["tu-154/lights/left_spotlight_flood"] = true,
        ["tu-154/lights/nvu_no_reserve"] = true,
        ["tu-154/lights/oil_qty_work_1"] = true,
        ["tu-154/lights/oil_qty_work_2"] = true,
        ["tu-154/lights/oil_qty_work_3"] = true,
        ["tu-154/lights/small/close_toilet"] = true,
        ["tu-154/lights/small/leftside_yellow"] = true,
        ["tu-154/lights/small/pnp_rsbn_left"] = true,
        ["tu-154/lights/small/pnp_rsbn_right"] = true,
        ["tu-154/lights/small/sp50_c1"] = true,
        ["tu-154/lights/small/sp50_c2"] = true,
        ["tu-154/lights/small/sp50_g1"] = true,
        ["tu-154/lights/small/sp50_g2"] = true,
        ["tu-154/lights/small/transponder1_fail"] = true,
        ["tu-154/lights/small/transponder1_kd"] = true,
        ["tu-154/lights/small/transponder1_kp"] = true,
        ["tu-154/lights/small/turn_on_aux"] = true,
        ["tu-154/lights/tail_light"] = true,
        ["tu-154/lights/tcas_ident"] = true,
        ["tu-154/lights/tech_light"] = true,
        ["tu-154/lights/wing_light_left"] = true,
        ["tu-154/lights/wing_light_right"] = true,
    },
    mode   = 1,
    list   = nil, -- { name, g, label, full, o }, by group then label
    hits   = {},  -- where the last draw put each chip and lamp, for LP.click
}

function LP.load()
    local list, seen, order = {}, {}, {}
    for i = 2, #LP.MODES do
        order[LP.MODES[i].g] = i
    end
    for k = 1, 3 do
        local f = io.open(pluginDataDir .. "/modules/core/dataref_creator_" .. k .. ".lua", "r")
        if f then
            for line in f:lines() do
                local name = (not line:match("^%s*%-%-"))
                    and line:match('createGlobalProperty%a*%(%s*"(tu%-154/lights/[^"]+)"')
                if name and not seen[name] and not name:find("_set", 1, true)
                    and not name:match("_cap$") and name ~= "tu-154/lights/landing_light_off" then
                    seen[name] = true
                    local sub, rest = name:match("^tu%-154/lights/([%w_]+)/(.+)$")
                    local label = rest or name:match("^tu%-154/lights/(.+)$")
                    local g = sub or "main"
                    list[#list + 1] = { name = name, g = g, label = label,
                        full = sub and (sub .. "/" .. rest) or label,
                        o = order[g] or (#LP.MODES + 1) }
                end
            end
            f:close()
        end
    end
    table.sort(list, function(a, b)
        if a.o ~= b.o then
            return a.o < b.o
        end
        return a.label < b.label
    end)
    LP.list = list
end

local function drawLampsDiagram()
    if not LP.list then
        LP.load()
    end
    local hits = {}
    LP.hits = hits

    -- Every live lamp is read on every frame, whatever the mode: the chips
    -- count what is lit in each group, and LIT needs all of them anyway.
    local lit, nLit, total = {}, {}, {}
    for i = 1, #LP.list do
        local e = LP.list[i]
        total[e.g] = (total[e.g] or 0) + 1
        if not LP.DEAD[e.name] then
            e.v = readv(e.name)
            if e.v > LP.LIT then
                lit[#lit + 1] = e
                nLit[e.g] = (nLit[e.g] or 0) + 1
            end
        end
    end

    -- ---- the mode chips -----------------------------------------------------
    for k = 1, #LP.MODES do
        local m = LP.MODES[k]
        local x = colX(k, #LP.MODES, LP.CHIP_W)
        local txt = m.g and (m.t .. "  " .. (nLit[m.g] or 0) .. " / " .. (total[m.g] or 0))
            or (m.t .. "  " .. #lit)
        chip(x, Y(LP.CHIP_D + 15), LP.CHIP_W, txt, k == LP.mode)
        hits[#hits + 1] = { x, Y(LP.CHIP_D + 15), x + LP.CHIP_W, Y(LP.CHIP_D), mode = k }
    end

    -- ---- the grid -----------------------------------------------------------
    local mode = LP.MODES[LP.mode]
    local show = lit
    if mode.g then
        show = {}
        for i = 1, #LP.list do
            if LP.list[i].g == mode.g then
                show[#show + 1] = LP.list[i]
            end
        end
    end
    local rows = math.floor((LEG_D - 10 - LP.TOP) / LP.PITCH)
    local cap = rows * LP.COLS
    local cellW = math.floor(CONTENT_W / LP.COLS)
    local n = #show
    if n == 0 then
        sasl.gl.drawText(font, CONTENT_L + 4, Y(LP.TOP + 14),
            mode.g and "Nothing in this group." or "No lamp is lit.", 14, false, false,
            TEXT_ALIGN_LEFT, COL_TEXT)
    end
    -- lamp test lights everything, which is more than one screen holds
    local over = n > cap
    local shown = over and (cap - 1) or n
    local perCol = over and rows or math.max(1, math.ceil(shown / LP.COLS))
    for i = 1, shown do
        local e = show[i]
        local x = CONTENT_L + math.floor((i - 1) / perCol) * cellW
        local top = LP.TOP + ((i - 1) % perCol) * LP.PITCH
        local label = mode.g and e.label or e.full
        if LP.DEAD[e.name] then
            sasl.gl.drawCircle(math.floor(x + 7), math.floor(Y(top + 6)), 3, false, COL_OFF)
            sasl.gl.drawText(font, x + 16, Y(top + 10), label, 11, false, false,
                TEXT_ALIGN_LEFT, COL_TER)
        else
            local on = e.v > LP.LIT
            local dot = COL_OFF
            if on then
                -- brighter for a brighter lamp, but never so dim it reads as off
                local k = clamp(0.45, e.v, 1)
                dot = { COL_BG[1] + (COL_AMBER[1] - COL_BG[1]) * k,
                        COL_BG[2] + (COL_AMBER[2] - COL_BG[2]) * k,
                        COL_BG[3] + (COL_AMBER[3] - COL_BG[3]) * k, 1 }
            end
            sasl.gl.drawCircle(math.floor(x + 7), math.floor(Y(top + 6)), 3, true, dot)
            sasl.gl.drawText(font, x + 16, Y(top + 10), label, 11, false, false,
                TEXT_ALIGN_LEFT,
                watchFind(e.name) and COL_ACCENT or (on and COL_TEXT or COL_DIM))
            hits[#hits + 1] = { x, Y(top + LP.PITCH), x + cellW, Y(top), name = e.name }
        end
    end
    if over then
        sasl.gl.drawText(font, CONTENT_L + (LP.COLS - 1) * cellW + 16,
            Y(LP.TOP + (rows - 1) * LP.PITCH + 10), "+" .. (n - shown) .. " more lit",
            11, false, false, TEXT_ALIGN_LEFT, COL_AMBER)
    end

    local nDead = 0
    for _ in pairs(LP.DEAD) do
        nDead = nDead + 1
    end
    drawLegend(LEG_D, { { S_LOW, "lit" }, { S_DEAD, "dark" } },
        "click a lamp to pin it to Watch",
        "Every tu-154/lights/ dataref in the registry except the controls (anything with _set"
        .. " in its name, switch covers). Hollow: nothing in the aircraft drives it -- "
        .. nDead .. " of " .. #LP.list .. ", per _tools/writers.py.")
end
DIAGRAMS.lamps = drawLampsDiagram

-- a click on the Lamps tab: a chip changes the view, a lamp pins it to Watch
function LP.click(x, y)
    for i = 1, #LP.hits do
        local h = LP.hits[i]
        if x >= h[1] and x < h[3] and y >= h[2] and y < h[4] then
            if h.mode then
                LP.mode = h.mode
            else
                watchToggle(h.name)
            end
            return true
        end
    end
    return false
end
