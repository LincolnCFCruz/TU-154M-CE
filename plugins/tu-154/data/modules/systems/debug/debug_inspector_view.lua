-- ---------------------------------------------------------------------------
-- Tu-154M System Viewer / Debug Inspector -- the frame: the tab bar and its
-- badges, the header, the DATAREFS overlay, the scrollbar, the clicks and the
-- per-frame update. What it draws lives beside it:
--
--   inspector_schema.lua   the tabs, and the datarefs each list tab shows
--   inspector_vocab.lua    palette, geometry, readv() and the value history,
--                          the node / wire / symbol helpers
--   inspector_lists.lua    the list tabs (every tab with `fields`)
--   inspector_<key>.lua    one per `diagram` tab, registered in DIAGRAMS
--
-- Decoupling contract: aircraft state is read ONLY by dataref name, through
-- readv(). Nothing here include()s a systems module, set()s a system dataref
-- or creates a dataref, so Hard Rule 4 does not apply.
-- ---------------------------------------------------------------------------
size = { 1180, 740 }

-- ---------------------------------------------------------------------------
-- The inspector's files, and how they share names
--
-- The other files are not include()d. include() runs a file with the
-- COMPONENT as its globals, so everything they share would become a component
-- field -- visible to the child clickables, which resolve names up the same
-- parent chain -- and a shared name that is ever nil would be handed to SASL's
-- component loader on every read ("can't load component X", CLAUDE.md 14).
-- Instead each is run exactly as include() runs a file (openFile, the
-- search-path push, setfenv) but in V: one table of the inspector's own. A
-- split file's top-level globals ARE the shared names, its `local`s stay
-- private, and a name V does not hold falls through to the component -- so
-- sasl, get and pluginDataDir still resolve -- and is cached, since those
-- never change.
--
-- This file keeps its own names local and imports the ones it reads from V
-- (below). The few shared names it ASSIGNS -- ref_list / ref_seen /
-- ref_capture (the DATAREFS capture), HITS, watch_hover, note_hook -- it
-- reads and writes as V.x, so the other files see the new value.
-- ---------------------------------------------------------------------------
local ENV = getfenv(1)
local V = setmetatable({}, { __index = function(t, k)
    local v = ENV[k]
    if v ~= nil then
        rawset(t, k, v)
    end
    return v
end })

local function loadPart(file)
    local f, subdir = openFile(file)
    if not f then
        logError("debug inspector: can't load " .. file)
        return
    end
    if subdir then
        addSearchPath(subdir)
    end
    setfenv(f, V)
    f()
    if subdir then
        popSearchPath(subdir)
    end
end

-- the schema first: the geometry sizes the tab bar from it
loadPart("inspector_schema.lua")
loadPart("inspector_vocab.lua")
loadPart("inspector_lists.lua")
for _, key in ipairs({ "elec", "air", "fuel", "watch", "hydro", "absu", "antiice", "fire",
                       "ctrl", "eng", "gear", "lamps" }) do
    loadPart("inspector_" .. key .. ".lua")
end

-- what this file reads from the shared namespace
local BADGE, COL_ACCENT, COL_AMBER, COL_BG, COL_DIM, COL_FRAME = V.BADGE, V.COL_ACCENT, V.COL_AMBER, V.COL_BG, V.COL_DIM, V.COL_FRAME
local COL_OFF, COL_RED, COL_SEL, COL_TAB, COL_TABON, COL_TER = V.COL_OFF, V.COL_RED, V.COL_SEL, V.COL_TAB, V.COL_TABON, V.COL_TER
local COL_TEXT, CONTENT_B, CONTENT_H, CONTENT_L, CONTENT_T, CONTENT_W = V.COL_TEXT, V.CONTENT_B, V.CONTENT_H, V.CONTENT_L, V.CONTENT_T, V.CONTENT_W
local DIAGRAMS, Hh, LP, LS, NOM_115, NOM_27 = V.DIAGRAMS, V.Hh, V.LP, V.LS, V.NOM_115, V.NOM_27
local N_TABS, PAD, S_DEAD, S_FAULT, S_LOW, TAB_H = V.N_TABS, V.PAD, V.S_DEAD, V.S_FAULT, V.S_LOW, V.TAB_H
local TAB_PER_ROW, TAB_W, W, WATCH_DT, chip, clamp = V.TAB_PER_ROW, V.TAB_W, V.W, V.WATCH_DT, V.chip, V.clamp
local drawList, fmt, font, listLayout, readv, schema = V.drawList, V.fmt, V.font, V.listLayout, V.readv, V.schema
local stateCol, voltState, watch, watchFind, watchSample, watchToggle = V.stateCol, V.voltState, V.watch, V.watchFind, V.watchSample, V.watchToggle

-- shared UI state (upvalues; read/written by clickables, update(), draw())
local current_tab = 1
local scroll_row = 0
local max_scroll = 0

-- the DATAREFS overlay is showing
local refs_on = false
-- where drawRefs last put each name and filter chip, for the click handler;
-- and which filter is showing (REF_FILTERS, by index)
local REF = { hits = {}, filter = 1 }
-- the Watch sampler's sim-time accumulator (update())
local watch_acc = 0

-- The order the tab bar shows the tabs in, by system group, with a divider
-- between groups. It is a list of `short` names rather than a reordering of
-- `schema`, so nothing keyed on the schema -- current_tab, diagcheck's tab
-- list, the snapshot -- moves. A tab no group names still appears, at the end.
local TABS = { order = {}, gstart = {} }
do
    local groups = {
        { "Elec", "Bat/VU" },                                      -- power
        { "Fuel", "Hydr" },                                        -- fluids
        { "Air", "Ice" },                                          -- air and ice
        { "Eng", "APU", "Fire" },                                  -- propulsion
        { "Ctrl", "Gear", "RA-56", "ABSU", "Flt", "Nav", "Radio" }, -- flight
        { "Warn", "Lamps" },                                       -- alerting
        { "Load", "Fail", "Watch" },                               -- the rest
    }
    local idx, used = {}, {}
    for i = 1, N_TABS do
        idx[schema[i].short] = i
    end
    local function add(i, first)
        TABS.order[#TABS.order + 1] = i
        used[i] = true
        if first then
            TABS.gstart[#TABS.order] = true
        end
    end
    for _, g in ipairs(groups) do
        local first = true
        for _, short in ipairs(g) do
            local i = idx[short]
            if i and not used[i] then
                add(i, first)
                first = false
            end
        end
    end
    local first = true
    for i = 1, N_TABS do
        if not used[i] then
            add(i, first)
            first = false
        end
    end
end

-- ---------------------------------------------------------------------------
-- Tab-bar badges (BADGE is in inspector_vocab.lua). The drawing calls a badge pass swaps
-- for no-ops -- measureText is left alone, because layouts measure strings.
-- ---------------------------------------------------------------------------
BADGE.gl = { "drawText", "drawRectangle", "drawFrame", "drawLine", "drawWideLine",
             "drawCircle", "drawArc", "drawTriangle" }

-- a card tab: any failure flag or fault lamp set is red; a gauge over its
-- warn_hi is amber. warn_lo is not counted: every one of them is a voltage or
-- a pressure that sits at 0 on a cold aircraft, which is not a caution.
function BADGE.card(fields)
    local w
    for k = 1, #fields do
        local f = fields[k]
        if f.dref and not f.dead then
            local v = readv(f.dref)
            if (f.kind == "fail" and math.abs(v) > 0.5) or (f.fault and v > 0.5) then
                return S_FAULT
            end
            if f.warn_hi and v > f.warn_hi then
                w = S_LOW
            end
        end
    end
    return w
end

-- Judge tab i without drawing it. The swap and the draw are inside one pcall
-- so a diagram that errors cannot leave sasl.gl pointing at the no-ops, and
-- note_hook is parked so diagcheck does not credit this tab's notes to the
-- one it is checking.
function BADGE.pass(i)
    local tab = schema[i]
    if tab.fields then
        BADGE.tab[i] = BADGE.card(tab.fields)
        return
    end
    local fn = DIAGRAMS[tab.diagram]
    if not fn or tab.diagram == "watch" or tab.diagram == "lamps" then
        return
    end
    local gl, saved = sasl.gl, {}
    local hook = V.note_hook
    local ok = pcall(function()
        for _, n in ipairs(BADGE.gl) do
            saved[n] = gl[n]
            gl[n] = function() end
        end
        V.note_hook = false
        BADGE.on, BADGE.worst, BADGE.dry = true, nil, true
        fn()
    end)
    BADGE.on, BADGE.dry = false, false
    V.note_hook = hook
    pcall(function()
        for n, f in pairs(saved) do
            gl[n] = f
        end
    end)
    if ok then
        BADGE.tab[i] = BADGE.worst
    end
end

-- ---------------------------------------------------------------------------
-- Frame
-- ---------------------------------------------------------------------------
function update()
    -- Value history, on a fixed sim-time cadence. frame_time is read here at
    -- the top of update() (section 7a rule 4) and is 0 while the sim is paused,
    -- so a paused sim accumulates nothing and takes no samples. This is the
    -- only integration this tool does, and the only reason it reads the clock.
    if #watch > 0 then
        watch_acc = watch_acc + readv("tu-154/time/frame_time")
        local guard = 0
        while watch_acc >= WATCH_DT and guard < 4 do
            watch_acc = watch_acc - WATCH_DT
            watchSample()
            guard = guard + 1
        end
        if watch_acc > WATCH_DT then
            watch_acc = 0 -- came back from a long stall: resync, do not burst
        end
    end

    local tab = schema[current_tab]
    if tab.diagram then
        -- a diagram tab is drawn to fit; there is nothing to scroll
        scroll_row = 0
        max_scroll = 0
        return
    end
    -- a card tab scrolls by whole columns, and only if it outgrows LS.NCOL
    max_scroll = math.max(0, listLayout(current_tab).cols - LS.NCOL)
    scroll_row = clamp(0, scroll_row, max_scroll)
end

-- Tab p's rect in whole pixels: TAB_W (1180 / 11) is not an integer, and a
-- tab edge or group divider on a fraction is smeared over two pixel columns.
local function tabRect(p)
    local j = p - 1
    local k = j % TAB_PER_ROW
    local x0 = math.floor(k * TAB_W)
    local y0 = Hh - (math.floor(j / TAB_PER_ROW) + 1) * TAB_H
    return x0, y0, math.floor((k + 1) * TAB_W) - x0
end

local function drawTabBar()
    for p = 1, N_TABS do
        local i = TABS.order[p]
        local x0, y0, tw = tabRect(p)
        local on = (i == current_tab)
        sasl.gl.drawRectangle(x0, y0, tw, TAB_H, on and COL_TABON or COL_TAB)
        sasl.gl.drawText(font, x0 + tw / 2, y0 + 10, schema[i].short, 13, false, false, TEXT_ALIGN_CENTER,
            on and COL_TEXT or COL_DIM)
        if on then
            sasl.gl.drawRectangle(x0, y0, tw, 3, COL_TEXT)
        end
        sasl.gl.drawLine(x0, y0, x0, y0 + TAB_H, COL_BG)
        -- a system group starts here, unless it also starts the row
        if TABS.gstart[p] and (p - 1) % TAB_PER_ROW ~= 0 then
            sasl.gl.drawRectangle(x0 - 1, y0 + 7, 2, TAB_H - 14, COL_DIM)
        end
        local b = BADGE.tab[i]
        if b then
            sasl.gl.drawCircle(x0 + tw - 14, y0 + TAB_H / 2, 4, true, stateCol(b))
        end
    end
end

local function drawHeader()
    local y = CONTENT_T
    sasl.gl.drawText(font, PAD, y + 7, schema[current_tab].name, 17, false, false, TEXT_ALIGN_LEFT, COL_TEXT)
    -- where a scrolling card tab is: which cards are on screen, of how many.
    -- The scrollbar's thumb says roughly where; this says which.
    local tab = schema[current_tab]
    if not tab.diagram and max_scroll > 0 then
        sasl.gl.drawText(font, W - 422, y + 10, "columns " .. (scroll_row + 1) .. "-"
            .. (scroll_row + LS.NCOL) .. " of " .. (max_scroll + LS.NCOL), 12, false, false,
            TEXT_ALIGN_RIGHT, COL_DIM)
    end
    -- Always-on power readout, coloured by the diagrams' NOM_27 / NOM_115. A
    -- dead bus stays red rather than grey: here it is the alarm. 115 V is the
    -- best of the three buses -- the lamp answers "is there AC at all".
    local dcl = readv("tu-154/elec/bus27_volt_left")
    local dcr = readv("tu-154/elec/bus27_volt_right")
    local ac = math.max(readv("tu-154/elec/bus115_1_volt"),
        readv("tu-154/elec/bus115_2_volt"), readv("tu-154/elec/bus115_3_volt"))
    local lamps = {
        { W - 290, "27L " .. fmt(dcl, 1) .. "V", voltState(dcl, NOM_27) },
        { W - 185, "27R " .. fmt(dcr, 1) .. "V", voltState(dcr, NOM_27) },
        { W - 80, "115 " .. fmt(ac, 0) .. "V", voltState(ac, NOM_115) },
    }
    for _, l in ipairs(lamps) do
        sasl.gl.drawCircle(l[1], y + 14, 6, true, l[3] == S_DEAD and COL_RED or stateCol(l[3]))
        sasl.gl.drawText(font, l[1] + 12, y + 7, l[2], 14, false, false, TEXT_ALIGN_LEFT, COL_DIM)
    end
    -- the dataref probe toggle, between the title and the power readout
    sasl.gl.drawRectangle(W - 412, y + 4, 100, 20, refs_on and COL_SEL or COL_TAB)
    sasl.gl.drawFrame(W - 412, y + 4, 100, 20, COL_FRAME)
    sasl.gl.drawText(font, W - 362, y + 10, "DATAREFS", 12, false, false, TEXT_ALIGN_CENTER,
        refs_on and COL_TEXT or COL_DIM)
    sasl.gl.drawLine(PAD, y + 2, W - PAD, y + 2, COL_FRAME)
end

-- The probe overlay: every name the current tab read this frame, sorted, with
-- its live value. A name sitting at exactly 0 is drawn dim -- on the diagram
-- tabs that is the quickest way to spot a dataref nothing writes.
--
-- The names are grouped by namespace -- the part up to the second slash,
-- "tu-154/elec/" -- which heads its group once, and each row shows only the
-- rest: the same prefix used to be repeated on every one of up to 140 rows,
-- and it was most of what the eye had to read past. The chips filter the list
-- (NONZERO and ZERO are the two halves the dim/bright rendering already
-- suggested; PINNED is what is on Watch), each with its count. Clicks are
-- hit-tested against REF.hits, the rects this draw put things at, rather than
-- recomputed from the layout arithmetic, which the group headers broke.
local REF_COLS = 3
local REF_FILTERS = { "ALL", "NONZERO", "ZERO", "PINNED" }

local function refShown(name, v, f)
    if f == 2 then
        return v ~= 0
    elseif f == 3 then
        return v == 0
    elseif f == 4 then
        return watchFind(name) ~= nil
    end
    return true
end

local function drawRefs()
    -- opaque: at 97 % the diagram's brightest text showed through and ran
    -- into the names laid over it
    sasl.gl.drawRectangle(CONTENT_L, CONTENT_B, CONTENT_W, CONTENT_H, { 0.08, 0.09, 0.11, 1 })
    sasl.gl.drawFrame(CONTENT_L, CONTENT_B, CONTENT_W, CONTENT_H, COL_DIM)
    table.sort(V.ref_list)
    REF.hits = {}

    local vals, counts = {}, { #V.ref_list, 0, 0, 0 }
    for i, name in ipairs(V.ref_list) do
        local v = readv(name)
        vals[i] = v
        if v ~= 0 then
            counts[2] = counts[2] + 1
        else
            counts[3] = counts[3] + 1
        end
        if watchFind(name) then
            counts[4] = counts[4] + 1
        end
    end

    sasl.gl.drawText(font, CONTENT_L + 8, CONTENT_T - 17,
        schema[current_tab].short .. " reads " .. #V.ref_list ..
        " datarefs this frame -- click one to plot it on Watch", 12, false, false,
        TEXT_ALIGN_LEFT, COL_TEXT)
    local cw = 96
    for k = 1, #REF_FILTERS do
        local x = CONTENT_L + CONTENT_W - 8 - (#REF_FILTERS - k + 1) * (cw + 6) + 6
        local y = CONTENT_T - 22
        chip(x, y, cw, REF_FILTERS[k] .. "  " .. counts[k], k == REF.filter)
        REF.hits[#REF.hits + 1] = { x, y, x + cw, y + 15, filter = k }
    end

    -- the rows the filter lets through, each namespace headed once
    local items, group = {}, nil
    for i, name in ipairs(V.ref_list) do
        if refShown(name, vals[i], REF.filter) then
            local g, rest = name:match("^([^/]+/[^/]+)/(.+)$")
            if not g then
                g, rest = "", name
            end
            if g ~= group then
                items[#items + 1] = { head = (g ~= "") and (g .. "/") or "(other)" }
                group = g
            end
            items[#items + 1] = { name = name, rest = rest, v = vals[i] }
        end
    end

    -- Three columns filled top to bottom and balanced, 13 px pitch; a group
    -- header is never left as the last line of a column, and a group carried
    -- over a column break is headed again, "(cont.)", as the list tabs do --
    -- one row of slack per column pays for those.
    local top = CONTENT_T - 40
    local maxRows = math.floor((top - CONTENT_B - 6) / 13) + 1
    local rows = math.max(1, math.min(maxRows, math.ceil((#items + REF_COLS - 1) / REF_COLS)))
    local colw = CONTENT_W / REF_COLS
    local col, r, drawn, total, cur = 0, 0, 0, 0, nil
    for _, it in ipairs(items) do
        if not it.head then
            total = total + 1
        end
        if (it.head and r == rows - 1) or r >= rows then
            col, r = col + 1, 0
            if not it.head and cur and col < REF_COLS then
                sasl.gl.drawText(font, CONTENT_L + 8 + col * colw, top, cur .. " (cont.)", 11,
                    false, false, TEXT_ALIGN_LEFT, COL_DIM)
                r = 1
            end
        end
        if it.head then
            cur = it.head
        end
        if col < REF_COLS then
            local x = CONTENT_L + 8 + col * colw
            local y = top - r * 13
            if it.head then
                sasl.gl.drawText(font, x, y, it.head, 11, false, false, TEXT_ALIGN_LEFT, COL_DIM)
            else
                local pinned = watchFind(it.name) ~= nil
                local dead = (it.v == 0)
                sasl.gl.drawText(font, x + 10, y, it.rest, 11, false, false, TEXT_ALIGN_LEFT,
                    pinned and COL_ACCENT or (dead and COL_TER or COL_TEXT))
                sasl.gl.drawText(font, x + colw - 18, y,
                    (it.v == math.floor(it.v)) and fmt(it.v, 0) or fmt(it.v, 2), 11, false, false,
                    TEXT_ALIGN_RIGHT, dead and COL_TER or COL_TEXT)
                REF.hits[#REF.hits + 1] = { x, y - 3, x + colw - 8, y + 10, name = it.name }
                drawn = drawn + 1
            end
            r = r + 1
        end
    end
    if total > drawn then
        sasl.gl.drawText(font, W - PAD - 8, CONTENT_B + 4, "+" .. (total - drawn) .. " not shown",
            11, false, false, TEXT_ALIGN_RIGHT, COL_AMBER)
    elseif total == 0 then
        sasl.gl.drawText(font, CONTENT_L + 8, top, "Nothing in this filter.", 12, false, false,
            TEXT_ALIGN_LEFT, COL_DIM)
    end
end

local function drawScrollbar()
    if max_scroll <= 0 then
        return
    end
    local total_rows = LS.NCOL + max_scroll
    local trackX, trackW = W - 8, 5
    sasl.gl.drawRectangle(trackX, CONTENT_B, trackW, CONTENT_H, COL_OFF)
    local thumbH = CONTENT_H * (LS.NCOL / total_rows)
    local thumbY = CONTENT_T - thumbH - (CONTENT_H - thumbH) * (scroll_row / max_scroll)
    sasl.gl.drawRectangle(trackX, thumbY, trackW, thumbH, COL_DIM)
    -- arrow glyphs (clickable areas are separate components)
    local ax = W - 11
    sasl.gl.drawTriangle(ax, CONTENT_T - 4, ax + 8, CONTENT_T - 4, ax + 4, CONTENT_T - 14, COL_DIM)  -- up
    sasl.gl.drawTriangle(ax, CONTENT_B + 14, ax + 8, CONTENT_B + 14, ax + 4, CONTENT_B + 4, COL_DIM) -- down
end

function draw()
    -- the tab-bar dots: BADGE.per other tabs re-judged per frame, round robin
    for _ = 1, BADGE.per do
        BADGE.pass(BADGE.nxt)
        BADGE.nxt = BADGE.nxt % N_TABS + 1
    end
    -- glyphs on the pixel grid: without this a label whose x lands on a half
    -- pixel is rendered soft. Turned off again at the end.
    sasl.gl.setRenderTextPixelAligned(true)
    sasl.gl.drawRectangle(0, 0, W, Hh, COL_BG)
    drawTabBar()
    drawHeader()

    -- Capture only spans the tab's own content, so drawHeader's three power
    -- reads above do not turn up on every tab's list.
    if refs_on then
        V.ref_list = {}
        V.ref_seen = {}
        V.ref_capture = true
    end

    local tab = schema[current_tab]
    sasl.gl.setClipArea(CONTENT_L, CONTENT_B, CONTENT_W, CONTENT_H)
    -- every tab, not only diagrams: a list tab must not keep the link rects
    -- the diagram before it drew
    V.HITS = {}
    if tab.diagram then
        -- the tab on screen judges itself from the draw it is doing anyway
        BADGE.on, BADGE.worst = true, nil
        DIAGRAMS[tab.diagram]()
        BADGE.on = false
        if BADGE.live and tab.diagram ~= "watch" and tab.diagram ~= "lamps" then
            BADGE.tab[current_tab] = BADGE.worst
        end
    else
        drawList(current_tab, scroll_row)
    end
    sasl.gl.resetClipArea()
    V.ref_capture = false
    -- after capture is off: a card tab is judged on every field, not only the
    -- rows in view, and those reads must not land in the DATAREFS list
    if BADGE.live and not tab.diagram then
        BADGE.tab[current_tab] = BADGE.card(tab.fields)
    end

    drawScrollbar()

    if refs_on then
        sasl.gl.setClipArea(CONTENT_L, CONTENT_B, CONTENT_W, CONTENT_H)
        drawRefs()
        sasl.gl.resetClipArea()
    end
    sasl.gl.setRenderTextPixelAligned(false)
end

-- ---------------------------------------------------------------------------
-- Interactivity -- child clickables (handlers are rawget-dispatched, so they
-- must be constructor props on real clickable components, not file globals)
-- ---------------------------------------------------------------------------
local function scrollBy(d)
    scroll_row = clamp(0, scroll_row + d, max_scroll)
end

local comps = {}

-- tab buttons across the top (multi-row grid; matches drawTabBar)
do
    for p = 1, N_TABS do
        local i = TABS.order[p]
        local x0, y0, tw = tabRect(p)
        comps[#comps + 1] = clickable {
            position = { x0, y0, tw, TAB_H },
            onMouseDown = function()
                current_tab = i
                scroll_row = 0
                return true
            end
        }
    end
end

-- the dataref probe toggle in the header (matches the button in drawHeader)
comps[#comps + 1] = clickable {
    position = { W - 412, CONTENT_T + 4, 100, 20 },
    onMouseDown = function()
        refs_on = not refs_on
        return true
    end
}

-- mouse-wheel scrolling over the content area; a click here dismisses the
-- probe overlay, which covers this same rect while it is up
comps[#comps + 1] = clickable {
    position = { CONTENT_L, CONTENT_B, CONTENT_W, CONTENT_H },
    -- While the probe overlay is up, a click on one of its rows pins or unpins
    -- that dataref; a click anywhere else closes the overlay. x/y arrive in
    -- this clickable's own space, and the rect is the content area, so depth
    -- below CONTENT_T is CONTENT_H - y -- the coordinate drawRefs lays out in.
    onMouseDown = function(_, x, y)
        local cx, cy = CONTENT_L + x, CONTENT_B + y
        local function hit(h)
            return cx >= h[1] and cx < h[3] and cy >= h[2] and cy < h[4]
        end
        if not refs_on then
            -- a row that links to another tab (listNode `link`)
            for _, h in ipairs(V.HITS) do
                if hit(h) then
                    for i = 1, N_TABS do
                        if schema[i].short == h.tab then
                            current_tab, scroll_row = i, 0
                            return true
                        end
                    end
                end
            end
            -- the Lamps tab takes clicks on its mode chips and on its lamps
            if schema[current_tab].diagram == "lamps" then
                return LP.click(cx, cy)
            end
            return false
        end
        -- the overlay: a filter chip, a name to pin or unpin, or the gap to close
        for _, h in ipairs(REF.hits) do
            if hit(h) then
                if h.filter then
                    REF.filter = h.filter
                else
                    watchToggle(h.name)
                end
                return true
            end
        end
        refs_on = false
        return true
    end,
    -- the Watch tab's time cursor follows the mouse; nothing is consumed
    onMouseMove = function(_, x, y)
        if schema[current_tab].diagram == "watch" then
            V.watch_hover = { CONTENT_L + x, CONTENT_B + y }
        end
        return false
    end,
    onMouseLeave = function()
        V.watch_hover = false
    end,
    onMouseWheel = function(_, _, _, _, _, _, clicks)
        scrollBy(-(clicks or 0))
        return true
    end
}

-- scroll arrows (right gutter)
comps[#comps + 1] = clickable {
    position = { W - 20, CONTENT_T - 16, 16, 16 },
    onMouseDown = function()
        scrollBy(-1)
        return true
    end,
    onMouseHold = holdToRepeat(function()
        scrollBy(-1)
    end)
}
comps[#comps + 1] = clickable {
    position = { W - 20, CONTENT_B, 16, 16 },
    onMouseDown = function()
        scrollBy(1)
        return true
    end,
    onMouseHold = holdToRepeat(function()
        scrollBy(1)
    end)
}

components = comps
