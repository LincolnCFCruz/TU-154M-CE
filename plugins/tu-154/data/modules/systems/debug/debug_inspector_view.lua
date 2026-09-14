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
-- Aircraft state is read only by dataref name, through readv(). Nothing here
-- include()s a systems module, set()s a system dataref or creates a dataref.
-- ---------------------------------------------------------------------------
size = { 1180, 740 }

-- ---------------------------------------------------------------------------
-- The parts are not include()d: include() would make every shared name a
-- component field, visible to the child clickables, and a nil one would reach
-- SASL's component loader (CLAUDE.md 14). Each runs as include() runs a file
-- (openFile, search-path push, setfenv) but in V; a part's top-level globals
-- are the shared names, and a name V lacks falls through to the component
-- (sasl, get, pluginDataDir) and is cached.
--
-- This file imports what it reads from V into locals once. The shared names it
-- assigns (ref_list / ref_seen / ref_capture, HITS, watch_hover, note_hook) it
-- uses as V.x, so the parts see the new value.
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
local inRect = V.inRect

local current_tab = 1
local scroll_row = 0
local max_scroll = 0

local refs_on = false -- the DATAREFS overlay is showing
-- hits: the rects drawRefs last used, for the click handler; filter: REF_FILTERS index
local REF = { hits = {}, filter = 1 }
-- the DATAREFS toggle in the header
local REFS_BTN = { x = W - 412, y = CONTENT_T + 4, w = 100, h = 20 }
local watch_acc = 0   -- the Watch sampler's sim-time accumulator

-- Tab-bar order, by system group with a divider between groups. A list of
-- `short` names rather than a reordering of `schema`, so nothing keyed on the
-- schema (current_tab, diagcheck's tab list, the snapshot) moves. A tab no
-- group names is appended at the end. idx maps `short` to schema index.
local TABS = { order = {}, gstart = {}, idx = {} }
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
    local idx, used = TABS.idx, {}
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
-- Tab-bar badges (BADGE is in inspector_vocab.lua). The drawing calls a badge
-- pass swaps for no-ops; measureText is kept, because layouts measure strings.
-- ---------------------------------------------------------------------------
BADGE.gl = { "drawText", "drawRectangle", "drawFrame", "drawLine", "drawWideLine",
             "drawCircle", "drawArc", "drawTriangle" }

-- diagrams that carry no badge
local NO_BADGE = { watch = true, lamps = true }

-- A list tab: any failure flag or fault lamp set is red; a gauge over its
-- warn_hi is amber. warn_lo is not counted: those are voltages and pressures
-- that sit at 0 on a cold aircraft.
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
    if not fn or NO_BADGE[tab.diagram] then
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
    -- Watch sampling on a fixed sim-time cadence (CLAUDE.md 7a): frame_time is
    -- 0 while paused, so a paused sim takes no samples
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
    -- a list tab scrolls by whole columns, and only if it outgrows LS.NCOL
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
    -- which columns of a scrolling list tab are on screen
    local tab = schema[current_tab]
    if not tab.diagram and max_scroll > 0 then
        sasl.gl.drawText(font, REFS_BTN.x - 10, y + 10, "columns " .. (scroll_row + 1) .. "-"
            .. (scroll_row + LS.NCOL) .. " of " .. (max_scroll + LS.NCOL), 12, false, false,
            TEXT_ALIGN_RIGHT, COL_DIM)
    end
    -- Power lamps, by NOM_27 / NOM_115. A dead bus is red, not grey: here it is
    -- the alarm. 115 V is the best of the three buses ("is there AC at all").
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
    local b = REFS_BTN
    sasl.gl.drawRectangle(b.x, b.y, b.w, b.h, refs_on and COL_SEL or COL_TAB)
    sasl.gl.drawFrame(b.x, b.y, b.w, b.h, COL_FRAME)
    sasl.gl.drawText(font, b.x + b.w / 2, b.y + 6, "DATAREFS", 12, false, false, TEXT_ALIGN_CENTER,
        refs_on and COL_TEXT or COL_DIM)
    sasl.gl.drawLine(PAD, y + 2, W - PAD, y + 2, COL_FRAME)
end

-- The DATAREFS overlay: every name the current tab read this frame, sorted and
-- grouped by namespace (up to the second slash, shown once per group), with
-- its live value. A value at exactly 0 is dim -- on a diagram tab that is
-- usually a dataref nothing writes. Clicks are hit-tested against REF.hits,
-- the rects this draw used.
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

-- each name's value, and the count behind each filter chip
local function refValues()
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
    return vals, counts
end

-- the rows the filter lets through, each namespace headed once
local function refItems(vals)
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
    return items
end

local function drawRefs()
    -- opaque: any translucency lets the diagram's text run into the names
    sasl.gl.drawRectangle(CONTENT_L, CONTENT_B, CONTENT_W, CONTENT_H, { 0.08, 0.09, 0.11, 1 })
    sasl.gl.drawFrame(CONTENT_L, CONTENT_B, CONTENT_W, CONTENT_H, COL_DIM)
    table.sort(V.ref_list)
    REF.hits = {}

    local vals, counts = refValues()

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

    local items = refItems(vals)

    -- Balanced columns, 13 px pitch. A group header is never a column's last
    -- line, and a group carried over a break is headed again "(cont.)".
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
        if BADGE.live and not NO_BADGE[tab.diagram] then
            BADGE.tab[current_tab] = BADGE.worst
        end
    else
        drawList(current_tab, scroll_row)
    end
    sasl.gl.resetClipArea()
    V.ref_capture = false
    -- after capture is off: a list tab is judged on every field, not only the
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

comps[#comps + 1] = clickable {
    position = { REFS_BTN.x, REFS_BTN.y, REFS_BTN.w, REFS_BTN.h },
    onMouseDown = function()
        refs_on = not refs_on
        return true
    end
}

-- The content area. x/y arrive in this clickable's own space and are turned
-- back into window coordinates, which is what every hit rect is recorded in.
comps[#comps + 1] = clickable {
    position = { CONTENT_L, CONTENT_B, CONTENT_W, CONTENT_H },
    onMouseDown = function(_, x, y)
        local cx, cy = CONTENT_L + x, CONTENT_B + y
        if not refs_on then
            -- a row that links to another tab (listNode `link`)
            for _, h in ipairs(V.HITS) do
                local i = inRect(h, cx, cy) and TABS.idx[h.tab]
                if i then
                    current_tab, scroll_row = i, 0
                    return true
                end
            end
            if schema[current_tab].diagram == "lamps" then
                return LP.click(cx, cy)
            end
            return false
        end
        -- the overlay: a filter chip, a name to pin or unpin, or the gap to close
        for _, h in ipairs(REF.hits) do
            if inRect(h, cx, cy) then
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

-- scroll arrows
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
