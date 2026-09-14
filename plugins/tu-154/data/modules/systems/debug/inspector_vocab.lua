-- ---------------------------------------------------------------------------
-- The shared vocabulary: palette and font, readv() and the DATAREFS capture,
-- the Watch history, canvas geometry, the S_* states, the node / wire /
-- symbol helpers, the tab badges' state and DIAGRAMS.
--
-- Every top-level name here is shared and must never be nil: a nil name falls
-- through to the component, and SASL tries to load it as a component
-- (CLAUDE.md 14). Hence note_hook and watch_hover start as false, and a
-- temporary that can be nil stays `local`.
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- Palette (SASL colours are {r,g,b,a} floats 0..1)
-- ---------------------------------------------------------------------------
COL_BG     = { 0.10, 0.11, 0.13, 0.97 }
COL_TAB    = { 0.14, 0.15, 0.18, 1 }
COL_TABON  = { 0.20, 0.22, 0.27, 1 }
COL_CARD   = { 0.13, 0.14, 0.17, 1 }
COL_FRAME  = { 0.28, 0.30, 0.35, 1 }
COL_TEXT   = { 0.88, 0.90, 0.94, 1 }
COL_DIM    = { 0.55, 0.58, 0.64, 1 }
COL_GREEN  = { 0.27, 0.82, 0.40, 1 }
COL_AMBER  = { 0.98, 0.74, 0.20, 1 }
COL_RED    = { 0.94, 0.30, 0.30, 1 }
-- pinned / plotted: a name on Watch and its trace, and nothing else
COL_ACCENT = { 0.32, 0.66, 0.96, 1 }
-- S_STBY, "available / armed": the ECAM cyan, and used for nothing else
COL_CYAN   = { 0.30, 0.82, 0.86, 1 }
-- selected chrome (active tab, chip, button): neutral, so it never reads as a state
COL_SEL    = { 0.30, 0.32, 0.38, 1 }
-- fills and wires only, never text: about 1.9:1 on COL_CARD
COL_OFF    = { 0.30, 0.32, 0.37, 1 }
-- the dimmest text colour
COL_TER    = { 0.46, 0.48, 0.54, 1 }

-- Roboto-Regular.ttf ships in data/components, on the resource path.
-- loadFont() forces the FreeType autohinter; Roboto's own hinting is crisper
-- at 11-12 px. rawget, because a bare unresolved global is handed to the
-- component loader (CLAUDE.md 14).
local hinter = rawget(_G, "FONT_HINTER_NATIVE")
font = hinter and sasl.gl.loadFontHinted("Roboto-Regular.ttf", hinter)
    or sasl.gl.loadFont("Roboto-Regular.ttf")

-- ---------------------------------------------------------------------------
-- Dataref read cache (memoised handles)
--
-- globalProperty() on a missing name (scp/api/*, RXP/*, bp/* without their
-- plugins) logs WARN + STACK and returns nil, which is not memoised. So probe
-- quietly first, as glbl_func's quietBind does, and re-probe a miss every
-- MISS_RETRY s for plugins that load late. readv()'s pcall turns nil into 0.
-- ---------------------------------------------------------------------------
local handles = {}
local TYPE_ANY = rawget(_G, "TYPE_UNKNOWN")
local MISS_RETRY = 2.0
local missClock = sasl.createTimer()
sasl.startTimer(missClock)
local missUntil = {} -- name -> elapsed seconds before which it is not re-probed

local function drefExists(name)
    if sasl.findDataRef(name, TYPE_ANY, true) then return true end
    -- "name[3]": globalProperty() binds the array and indexes it
    local base = name:match("^(.+)%[%d+%]$")
    return base ~= nil and sasl.findDataRef(base, TYPE_ANY, true) and true or false
end

function H(name)
    local h = handles[name]
    if h then return h end
    local now = sasl.getElapsedSeconds(missClock)
    local retry = missUntil[name]
    if retry and now < retry then return nil end
    if drefExists(name) then h = globalProperty(name) end
    if h then
        handles[name] = h
        missUntil[name] = nil
    else
        missUntil[name] = now + MISS_RETRY
    end
    return h
end

-- The DATAREFS overlay lists what readv() touched while the tab's content drew,
-- so the list cannot drift from the code. Capture is off unless it is up.
ref_capture = false
ref_seen = {}       -- name -> true
ref_list = {}       -- names in first-read order

function readv(name)
    if ref_capture and not ref_seen[name] then
        ref_seen[name] = true
        ref_list[#ref_list + 1] = name
    end
    local ok, v = pcall(get, H(name))
    if ok and type(v) == "number" then
        return v
    end
    return 0
end

-- ---------------------------------------------------------------------------
-- Watch tab value history. Sampled on a fixed sim-time cadence fed from
-- frame_time (update(), CLAUDE.md 7a), so a paused sim adds no samples.
-- ---------------------------------------------------------------------------
WATCH_MAX = 6  -- traces; more than this and the rows stop being readable
WATCH_N = 190  -- samples per trace, about 4 px each across the plot
WATCH_DT = 0.1 -- sim seconds between samples, so 19 s of history
watch = {}     -- { name = , v = ring, n = filled, w = next write slot }
watch_hover = false -- the mouse over the content area, in window coordinates

-- the pinned names (not the history), rewritten whenever the set changes
WATCH_FILE = pluginDataDir .. "/output/debug_watch.ini"

function watchSave()
    local f = io.open(WATCH_FILE, "w")
    if f then
        f:write("; debug inspector: the datarefs pinned to the Watch tab\n")
        for i = 1, #watch do
            f:write("pin = " .. watch[i].name .. "\n")
        end
        f:close()
    end
end

function watchFind(name)
    for i = 1, #watch do
        if watch[i].name == name then
            return i
        end
    end
end

function watchToggle(name)
    local i = watchFind(name)
    if i then
        table.remove(watch, i)
    elseif #watch < WATCH_MAX then
        watch[#watch + 1] = { name = name, v = {}, n = 0, w = 1 }
    end
    watchSave()
end

function watchSample()
    for i = 1, #watch do
        local t = watch[i]
        t.v[t.w] = readv(t.name)
        t.w = t.w % WATCH_N + 1
        if t.n < WATCH_N then
            t.n = t.n + 1
        end
    end
end

-- restore the pins the last session saved; straight into the table, because
-- watchToggle would rewrite the file once per pin while reading it
do
    local f = io.open(WATCH_FILE, "r")
    if f then
        for line in f:lines() do
            local name = line:match("^%s*pin%s*=%s*(%S+)")
            if name and not watchFind(name) and #watch < WATCH_MAX then
                watch[#watch + 1] = { name = name, v = {}, n = 0, w = 1 }
            end
        end
        f:close()
    end
end

function clamp(lo, v, hi)
    if v < lo then
        return lo
    end
    if v > hi then
        return hi
    end
    return v
end

-- h = { x1, y1, x2, y2 }, half-open on the far edges
function inRect(h, x, y)
    return x >= h[1] and x < h[3] and y >= h[2] and y < h[4]
end

-- ---------------------------------------------------------------------------
-- Geometry: a fixed 1180 x 740 canvas, drawn 1:1 (debug_inspector.lua)
-- ---------------------------------------------------------------------------
W, Hh = size[1], size[2]
TAB_H = 30
HEADER_H = 28
PAD = 10
-- tab bar wraps to as many rows as needed to keep each tab >= MIN_TAB_W wide
N_TABS = #schema
MIN_TAB_W = 84
TAB_ROWS = math.max(1, math.ceil(N_TABS / math.floor(W / MIN_TAB_W)))
TAB_PER_ROW = math.ceil(N_TABS / TAB_ROWS)
TAB_W = W / TAB_PER_ROW
TAB_AREA_H = TAB_ROWS * TAB_H

CONTENT_L = PAD
CONTENT_T = Hh - TAB_AREA_H - HEADER_H -- top y, below the tab rows
CONTENT_B = PAD
CONTENT_W = W - 2 * PAD
CONTENT_H = CONTENT_T - CONTENT_B

function fmt(v, dp)
    return string.format("%." .. (dp or 0) .. "f", v)
end

-- Wire / node states, in increasing order of "look at me". Each means one
-- thing on every tab; a legend may reword it, not redefine it.
--   S_LIVE  green  energised / pressurised AND doing its job
--   S_STBY  cyan   available or armed, not active
--   S_LOW   amber  caution: off setpoint, degraded, held, overheat
--   S_DEAD  grey   off, unpowered, empty -- normal on a cold aircraft
--   S_FAULT red    failure flag, fire, overload, leak, redline
-- Unpowered or unpressurised is S_DEAD, never S_FAULT. A normal action (a
-- deflected surface, a leg in transit) is not a caution, and a nominal row is
-- left uncoloured.
S_DEAD  = 0
S_STBY  = 1
S_LOW   = 2
S_LIVE  = 3
S_FAULT = 4

function stateCol(s)
    if s == S_FAULT then
        return COL_RED
    end
    if s == S_LIVE then
        return COL_GREEN
    end
    if s == S_LOW then
        return COL_AMBER
    end
    if s == S_STBY then
        return COL_CYAN
    end
    return COL_OFF
end

-- the colour to WRITE a value in: stateCol, except that a dead value is still
-- text and has to be readable
function stateTxt(s)
    if s == S_DEAD then
        return COL_TER
    end
    return stateCol(s)
end

-- Tab-bar dots. A diagram is judged by drawing it with sasl.gl swapped for
-- no-ops (BADGE.pass, in the frame) while listNode / slimNode report their
-- states to BADGE.note. `per` (tabs re-judged per frame) and `live` (the tab
-- on screen judges itself) are switched off by diagcheck; `dry` marks a pass
-- over a tab that is not on screen. Declared above the node helpers
-- (CLAUDE.md 14).
BADGE = { tab = {}, nxt = 1, per = 1, live = true, on = false, worst = nil, dry = false }

-- the link rows (listNode `link`) of the last on-screen draw; a badge pass
-- never writes it
HITS = {}
function BADGE.note(s)
    if s == S_FAULT then
        BADGE.worst = S_FAULT
    elseif s == S_LOW and BADGE.worst ~= S_FAULT then
        BADGE.worst = S_LOW
    end
end

-- the thresholds systems/ itself tests, all written `> n`
NOM_115, NOM_36, NOM_27 = 110, 30, 13

function voltState(v, nominal)
    if v > nominal then
        return S_LIVE
    end
    if v > 1 then
        return S_LOW
    end
    return S_DEAD
end

-- a feeder that exists but is not necessarily the one selected
function feedState(available, selected)
    if not available then
        return S_DEAD
    end
    return selected and S_LIVE or S_STBY
end

-- Diagrams are laid out in depths below CONTENT_T (Y() converts) and in
-- columns from colX / colC. LEG_D is the shared footer depth: an 11 px swatch
-- row with a note 16 px under it.
LEG_D = CONTENT_H - 24

function Y(dy)
    return CONTENT_T - dy
end

-- orthogonal polyline: wire(state, x1, y1, x2, y2, ...)
function wire(s, ...)
    local p = { ... }
    -- whole pixels: a 2 px line on a half pixel smears over three columns
    for i = 1, #p do
        p[i] = math.floor(p[i])
    end
    local col = stateCol(s)
    local th = (s == S_LIVE or s == S_FAULT) and 3 or 2
    for i = 1, #p - 3, 2 do
        sasl.gl.drawWideLine(p[i], p[i + 1], p[i + 2], p[i + 3], th, col)
    end
end

function junction(x, y, s)
    sasl.gl.drawCircle(math.floor(x), math.floor(y), 4, true, stateCol(s))
end

-- one-line node, for the PTS-250 output buses
function slimNode(x, dy, w, h, title, s, v1)
    local yb = Y(dy + h)
    sasl.gl.drawRectangle(x, yb, w, h, COL_CARD)
    sasl.gl.drawRectangle(x, yb, 4, h, stateCol(s))
    sasl.gl.drawFrame(x, yb, w, h, COL_FRAME)
    sasl.gl.drawText(font, x + 9, yb + 7, title, 11, false, false, TEXT_ALIGN_LEFT, COL_TEXT)
    if BADGE.on then
        BADGE.note(s)
    end
    sasl.gl.drawText(font, x + w - 7, yb + 7, v1, 11, false, false, TEXT_ALIGN_RIGHT, stateTxt(s))
end

-- A selection chip (TUE source, balancer side, Lamps view): selection, not
-- state, so neutral. In a node's title row pass h = 12, place it at the node
-- top - 13 and start it at afterTitle(): the right end belongs to the headline.
function chip(x, y, w, txt, on, h)
    h = h or 15
    sasl.gl.drawRectangle(x, y, w, h, on and COL_SEL or COL_TAB)
    sasl.gl.drawFrame(x, y, w, h, on and COL_DIM or COL_FRAME)
    if h < 15 then
        sasl.gl.drawText(font, x + w / 2, y + 2, txt, 10, false, false, TEXT_ALIGN_CENTER, COL_TEXT)
    else
        sasl.gl.drawText(font, x + w / 2, y + 3, txt, 11, false, false, TEXT_ALIGN_CENTER, COL_TEXT)
    end
end

-- x for a chip in a listNode title row: just past the title text
function afterTitle(x, title)
    return x + 16 + sasl.gl.measureText(font, title, 12, false, false)
end

-- the 27 V bus tie, drawn as a contactor so an open tie is unmistakable
function contactor(cx, y, closed, s)
    local col = stateCol(s)
    cx, y = math.floor(cx), math.floor(y)
    sasl.gl.drawCircle(cx - 13, y, 3, true, col)
    sasl.gl.drawCircle(cx + 13, y, 3, true, col)
    if closed then
        -- a flat closed link would read as plain wire, so it is lifted
        sasl.gl.drawWideLine(cx - 13, y, cx - 9, y + 9, 2, col)
        sasl.gl.drawWideLine(cx - 9, y + 9, cx + 9, y + 9, 3, col)
        sasl.gl.drawWideLine(cx + 9, y + 9, cx + 13, y, 2, col)
    else
        sasl.gl.drawWideLine(cx - 13, y, cx + 9, y + 13, 2, COL_DIM)
    end
end

-- ---------------------------------------------------------------------------
-- Schematic symbols. Each is centred on (cx, cy), so a diagram drops it on a
-- run it already draws and it has no coordinates of its own. All take a state
-- and draw in stateCol; where the shape also carries the state (a valve's
-- bar, a pump's impeller) that is deliberate -- the state colours are close
-- for a red-green eye, the shapes are not.
-- ---------------------------------------------------------------------------

SYM_R = 9 -- shared radius of the round symbols

-- Flow direction along (dx, dy); every run is orthogonal. A solid head only on
-- a live run (something is moving), an open chevron on any other.
function arrow(cx, cy, dx, dy, s)
    local col = stateCol(s)
    cx, cy = math.floor(cx), math.floor(cy)
    if s ~= S_LIVE then
        if dx ~= 0 then
            -- +-4 px: at 5 it reached the caption 9 px above a bar
            local d = dx > 0 and 3 or -3
            sasl.gl.drawWideLine(cx - d, cy - 4, cx + d, cy, 2, col)
            sasl.gl.drawWideLine(cx + d, cy, cx - d, cy + 4, 2, col)
        else
            local d = dy > 0 and 3 or -3
            sasl.gl.drawWideLine(cx - 5, cy - d, cx, cy + d, 2, col)
            sasl.gl.drawWideLine(cx, cy + d, cx + 5, cy - d, 2, col)
        end
        return
    end
    if dx ~= 0 then
        local d = dx > 0 and 6 or -6
        sasl.gl.drawTriangle(cx - d, cy - 4, cx - d, cy + 4, cx + d, cy, col)
    else
        local d = dy > 0 and 6 or -6
        sasl.gl.drawTriangle(cx - 4, cy - d, cx + 4, cy - d, cx, cy + d, col)
    end
end

-- The schematic bowtie; shut adds a bar across the throat.
function valveSym(cx, cy, open, s, vert)
    local col = stateCol(s)
    cx, cy = math.floor(cx), math.floor(cy)
    -- the triangles meet AT the centre, or the wire shows through the throat
    if vert then
        sasl.gl.drawTriangle(cx - 7, cy - 8, cx + 7, cy - 8, cx, cy, col)
        sasl.gl.drawTriangle(cx - 7, cy + 8, cx + 7, cy + 8, cx, cy, col)
        if not open then
            sasl.gl.drawWideLine(cx - 10, cy, cx + 10, cy, 2, COL_DIM)
        end
    else
        sasl.gl.drawTriangle(cx - 8, cy - 7, cx - 8, cy + 7, cx, cy, col)
        sasl.gl.drawTriangle(cx + 8, cy - 7, cx + 8, cy + 7, cx, cy, col)
        if not open then
            sasl.gl.drawWideLine(cx, cy - 10, cx, cy + 10, 2, COL_DIM)
        end
    end
end

-- impeller chevron when turning, a bar when not
function pumpSym(cx, cy, running, s)
    local col = stateCol(s)
    cx, cy = math.floor(cx), math.floor(cy)
    sasl.gl.drawCircle(cx, cy, SYM_R, true, COL_CARD)
    sasl.gl.drawCircle(cx, cy, SYM_R, false, col)
    if running then
        sasl.gl.drawTriangle(cx - 4, cy - 5, cx - 4, cy + 5, cx + 6, cy, col)
    else
        sasl.gl.drawWideLine(cx - 5, cy, cx + 5, cy, 2, col)
    end
end

-- a named round machine (generator, TR, VU, inverter)
function roundSym(cx, cy, txt, s)
    cx, cy = math.floor(cx), math.floor(cy)
    sasl.gl.drawCircle(cx, cy, SYM_R, true, COL_CARD)
    sasl.gl.drawCircle(cx, cy, SYM_R, false, stateCol(s))
    sasl.gl.drawText(font, cx, cy - 4, txt, 10, false, false, TEXT_ALIGN_CENTER, stateTxt(s))
end

-- Two cells, plates ACROSS the run. From the plus terminal: long plate, then
-- short 4 px on, cells 7 px apart (even spacing reads as a ladder). y grows
-- upward, so a vertical cell's short plate goes below its long one.
function battSym(cx, cy, s, horiz)
    local col = stateCol(s)
    cx, cy = math.floor(cx), math.floor(cy)
    for i = 0, 1 do
        if horiz then
            local x = cx - 8 + i * 11
            sasl.gl.drawWideLine(x, cy - 11, x, cy + 11, 2, col)
            sasl.gl.drawWideLine(x + 4, cy - 4, x + 4, cy + 4, 2, col)
        else
            local y = cy - 4 + i * 11
            sasl.gl.drawWideLine(cx - 11, y, cx + 11, y, 2, col)
            sasl.gl.drawWideLine(cx - 4, y - 4, cx + 4, y - 4, 2, col)
        end
    end
end

-- resistor zigzag: heat made by current rather than carried by air
function heaterSym(cx, cy, s)
    local col = stateCol(s)
    cx, cy = math.floor(cx), math.floor(cy)
    local px, py = cx - 14, cy
    for i = 1, 6 do
        local nx = cx - 14 + i * 4.5
        local ny = (i % 2 == 1) and (cy + 5) or (cy - 5)
        sasl.gl.drawWideLine(px, py, nx, ny, 2, col)
        px, py = nx, ny
    end
    sasl.gl.drawWideLine(px, py, cx + 14, cy, 2, col)
end

-- Set only by _tools/diagcheck.py, to catch a `note` row whose text changes.
note_hook = false

-- A node whose body is label / value rows, { label, value, [state] }; a row
-- state colours that value only. Row flags:
--   hd = true     headline: the value is also drawn 13 px in the title row.
--                 The row stays -- removing it would move every depth table.
--   note = true   fixed explanation, not a reading; tertiary grey.
--   link = "Tab"  a click opens that tab; the label is drawn blue.
-- `fill` (0..1) washes the node bottom in its state colour (how full / how
-- loaded). role "readout": reports about a system rather than being part of
-- it, so no card fill (use readout()). Height for n rows is 21 + n * 13
-- (LN_H*): drawText's y is a baseline and the bottom row needs its descenders.
function listNode(x, dy, w, h, title, s, rows, fill, role)
    local yb = Y(dy + h)
    if role ~= "readout" then
        sasl.gl.drawRectangle(x, yb, w, h, COL_CARD)
    end
    if fill and fill > 0 then
        local c = stateCol(s)
        sasl.gl.drawRectangle(x + 1, yb + 1, w - 2, (h - 2) * clamp(0, fill, 1),
            { c[1], c[2], c[3], 0.14 })
    end
    sasl.gl.drawRectangle(x, yb, 4, h, stateCol(s))
    sasl.gl.drawFrame(x, yb, w, h, s == S_FAULT and COL_RED or COL_FRAME)
    sasl.gl.drawText(font, x + 8, yb + h - 12, title, 12, false, false, TEXT_ALIGN_LEFT,
        s == S_DEAD and COL_DIM or COL_TEXT)
    if BADGE.on then
        BADGE.note(s)
    end
    for i = 1, #rows do
        local r = rows[i]
        if BADGE.on then
            BADGE.note(r[3])
        end
        local ry = yb + h - 13 - i * 13   -- bottom row lands at yb + 8
        local lcol = r.link and COL_ACCENT
        if r.note then
            sasl.gl.drawText(font, x + 8, ry, r[1], 11, false, false, TEXT_ALIGN_LEFT, lcol or COL_TER)
            sasl.gl.drawText(font, x + w - 8, ry, r[2], 11, false, false, TEXT_ALIGN_RIGHT, COL_TER)
            if note_hook then
                note_hook(title, x, r[1], r[2])
            end
        else
            sasl.gl.drawText(font, x + 8, ry, r[1], 11, false, false, TEXT_ALIGN_LEFT, lcol or COL_DIM)
            sasl.gl.drawText(font, x + w - 8, ry, r[2], 11, false, false, TEXT_ALIGN_RIGHT,
                r[3] and stateTxt(r[3]) or COL_TEXT)
        end
        if r.link and not BADGE.dry then
            HITS[#HITS + 1] = { x, ry - 3, x + w, ry + 10, tab = r.link }
        end
        if r.hd then
            sasl.gl.drawText(font, x + w - 8, yb + h - 12, r[2], 13, false, false,
                TEXT_ALIGN_RIGHT, stateTxt(r[3] or s))
        end
    end
    return yb
end

function readout(x, dy, w, h, title, s, rows)
    return listNode(x, dy, w, h, title, s, rows, nil, "readout")
end

-- listNode heights for 3 / 4 / 5 / 6 rows
LN_H3, LN_H4, LN_H5, LN_H6 = 60, 73, 86, 99

-- x of the i-th of n equal columns of width w, spread edge to edge across the
-- content area
function colX(i, n, w)
    if n < 2 then
        return CONTENT_L + math.floor((CONTENT_W - w) / 2)
    end
    local gap = (CONTENT_W - n * w) / (n - 1)
    return CONTENT_L + math.floor((i - 1) * (w + gap))
end

-- width of one of n columns separated by `gap`
function colW(n, gap)
    return math.floor((CONTENT_W - (n - 1) * gap) / n)
end

function colC(i, n, w)
    return colX(i, n, w) + math.floor(w / 2)
end

-- A horizontal manifold that other lines cross: `jumps` lists the x of each
-- crossing line, and the bar is drawn as segments with a gap around each, the
-- way a schematic breaks the line that passes behind.
function barWithJumps(dy, x1, x2, s, jumps)
    local cuts = {}
    for i = 1, #jumps do
        if jumps[i] > x1 + 8 and jumps[i] < x2 - 8 then
            cuts[#cuts + 1] = jumps[i]
        end
    end
    table.sort(cuts)
    local from = x1
    for i = 1, #cuts do
        wire(s, from, Y(dy), cuts[i] - 6, Y(dy))
        from = cuts[i] + 6
    end
    wire(s, from, Y(dy), x2, Y(dy))
end

-- The shared footer: state swatches, a dim note right-aligned on the same line,
-- and a full-width note 16 px under it. Every diagram passes dy = LEG_D.
function drawLegend(dy, items, rightNote, note)
    local lx = CONTENT_L
    for i = 1, #items do
        local txt = items[i][2]
        sasl.gl.drawRectangle(lx, Y(dy), 11, 11, stateCol(items[i][1]))
        sasl.gl.drawText(font, lx + 17, Y(dy) + 1, txt, 11, false, false, TEXT_ALIGN_LEFT, COL_DIM)
        lx = lx + 35 + sasl.gl.measureText(font, txt, 11, false, false)
    end
    if rightNote then
        sasl.gl.drawText(font, W - PAD, Y(dy) + 1, rightNote, 11, false, false,
            TEXT_ALIGN_RIGHT, COL_TER)
    end
    if note then
        sasl.gl.drawText(font, CONTENT_L, Y(dy + 16), note, 11, false, false,
            TEXT_ALIGN_LEFT, COL_TER)
    end
end

-- A band label (banded diagrams, every band but the first): small grey caps at
-- the left margin, `dy` its baseline. No rule across the width: it would cut
-- every drop between the bands.
function band(dy, label)
    sasl.gl.drawText(font, CONTENT_L + 2, Y(dy), label, 10, false, false, TEXT_ALIGN_LEFT, COL_TER)
end

function enumTxt(map, v)
    return map[math.floor(v + 0.5)] or fmt(v, 0)
end

function onoff(b)
    return b and "ON" or "off"
end

-- draw functions, keyed by the schema's `diagram`
DIAGRAMS = {}
