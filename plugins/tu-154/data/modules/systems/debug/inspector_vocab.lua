-- ---------------------------------------------------------------------------
-- The shared vocabulary: palette and font, readv() and the DATAREFS capture,
-- the Watch tab's value history, the canvas geometry, the S_* states, the
-- node / wire / symbol helpers, the tab badges' state and DIAGRAMS.
--
-- Every top-level name here is shared, and none may be nil: a name the
-- namespace does not hold falls through to the component, and SASL hands an
-- unresolved name to its component loader on every read (CLAUDE.md 14). That
-- is why note_hook and watch_hover start as false. A temporary that can be
-- nil stays `local` (hinter).
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
-- selected chrome -- the active tab, an active chip, a toggled button. Neutral,
-- so that no piece of UI can be read as a system state.
COL_SEL    = { 0.30, 0.32, 0.38, 1 }
-- COL_OFF is for fills and wires (a de-energised line, an empty track). Text
-- never uses it: on COL_CARD it is about 1.9:1 and could not be read, which
-- made the most important reading on a cold aircraft -- "0.0 V" -- the least
-- legible thing on the screen. COL_TER is the dimmest text there is.
COL_OFF    = { 0.30, 0.32, 0.37, 1 }
COL_TER    = { 0.46, 0.48, 0.54, 1 }

-- Roboto-Regular.ttf ships with the vendored framework in data/components,
-- which main.lua puts on the resource search path.
-- sasl.gl.loadFont() hardcodes FONT_HINTER_AUTO, the FreeType autohinter.
-- Roboto carries its own hinting instructions and they are noticeably crisper
-- at the 11 and 12 px this panel is mostly made of.
--
-- rawget, not a bare FONT_HINTER_NATIVE: an unresolved global inside a
-- component body is handed to SASL's component loader, which then reports
-- "can't load component FONT_HINTER_NATIVE" (CLAUDE.md 14). rawget asks
-- whether the C layer published the constant without tripping that.
local hinter = rawget(_G, "FONT_HINTER_NATIVE")
font = hinter and sasl.gl.loadFontHinted("Roboto-Regular.ttf", hinter)
    or sasl.gl.loadFont("Roboto-Regular.ttf")

-- ---------------------------------------------------------------------------
-- Decoupled dataref read cache (memoised handles, like texSize in glbl_draw)
-- ---------------------------------------------------------------------------
handles = {}
function H(name)
    local h = handles[name]
    if not h then
        h = globalProperty(name)
        handles[name] = h
    end
    return h
end

-- Dataref probe: readv() logs what it touches while the tab's content draws,
-- and the DATAREFS overlay lists exactly that, so the list cannot drift from
-- the code. Capture is off unless the overlay is up.
ref_capture = false -- log reads right now (content draw only)
ref_seen = {}       -- name -> true, for de-duplication
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
-- Value history for the Watch tab: the transients -- a pump dropping out for
-- a frame, a bus flickering -- that a snapshot cannot show.
--
-- Sampled on a fixed *sim*-time cadence, never per frame (CLAUDE.md 7a): the
-- accumulator is fed tu-154/time/frame_time, so a paused sim adds no samples
-- and time acceleration is followed for free.
-- ---------------------------------------------------------------------------
WATCH_MAX = 6  -- traces; more than this and the rows stop being readable
WATCH_N = 190  -- samples per trace, about 4 px each across the plot
WATCH_DT = 0.1 -- sim seconds between samples, so 19 s of history
watch = {}     -- { name = , v = ring, n = filled, w = next write slot }
watch_hover = false -- the mouse over the content area, in window coordinates

-- Pins survive a reload: the names (not the history) are written here whenever
-- the set changes and read back when the inspector loads.
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

function colorFor(v, warn_lo, warn_hi)
    if warn_lo and v < warn_lo then
        return COL_AMBER
    end
    if warn_hi and v > warn_hi then
        return COL_RED
    end
    return COL_GREEN
end

function fmt(v, dp)
    return string.format("%." .. (dp or 0) .. "f", v)
end

-- wire / node states, in increasing order of "look at me"
--
-- Each means ONE thing on every tab. A legend may word it for its system, but
-- may not change what it is:
--
--   S_LIVE  green  energised / pressurised AND doing its job
--   S_STBY  cyan   available or armed, not active right now
--   S_LOW   amber  CAUTION: abnormal but not failed -- off setpoint, degraded,
--                  held, overheat, a value short of what the code tests for
--                  while the thing is meant to be working
--   S_DEAD  grey   off, unpowered, empty. Normal on a cold aircraft.
--   S_FAULT red    a failure flag, a fire, an overload, a leak, a redline
--
-- The rule that follows is the one this palette exists for: being UNPOWERED
-- or UNPRESSURISED is S_DEAD, never S_FAULT. It used to be red in a dozen
-- places, so a cold-and-dark aircraft looked like an emergency on half the
-- tabs and red stopped meaning anything. Likewise a normal action -- a
-- deflected surface, a leg in transit, a dry crank -- is not a caution.
-- Nominal is quiet: a row that says "ok" or "ENGAGED" is not coloured at all,
-- only the word that is wrong.
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

-- The tab-bar dots: which tabs have something red or amber on them. A diagram
-- is judged by drawing it with the sasl.gl calls swapped for no-ops
-- (BADGE.pass, in the frame) while listNode and slimNode report every state
-- they are handed to BADGE.note, so the dot is whatever the diagram itself
-- would colour. Declared above every node helper: a function that reads it
-- must come after it (CLAUDE.md 14).
BADGE = { tab = {}, nxt = 1, per = 1, live = true, on = false, worst = nil,
                dry = false } -- dry: a badge pass is drawing a tab that is not on screen

-- Where the last draw of the tab on screen put its clickable rows -- a row
-- that links to another tab (listNode `link`). Rebuilt every draw, and never
-- by a badge pass, which draws other tabs with the drawing switched off.
HITS = {}
function BADGE.note(s)
    if s == S_FAULT then
        BADGE.worst = S_FAULT
    elseif s == S_LOW and BADGE.worst ~= S_FAULT then
        BADGE.worst = S_LOW
    end
end

-- The thresholds systems/ itself tests: 27 V is `> 13` at 94 sites and
-- nothing else, 115 V `> 110` at 37 (four `>= 115` sites ask "fully up to
-- voltage", a different question), 36 V `> 30` at 29.
NOM_115, NOM_36, NOM_27 = 110, 30, 13

function voltState(v, nominal)
    -- strictly greater, because every threshold in systems/ is written `> n`
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
-- columns from colX / colC (below). CONTENT_H is 642; a third tab row would
-- take 30 px off it. Every diagram's footer sits at LEG_D: the swatch row is
-- 11 px and the note 16 px under it, the lowest depth that fits both.
LEG_D = CONTENT_H - 24

function Y(dy)
    return CONTENT_T - dy
end

-- orthogonal polyline: wire(state, x1, y1, x2, y2, ...)
function wire(s, ...)
    local p = { ... }
    -- snap to whole pixels: a midpoint of two depths is often x.5, and a 2 px
    -- line drawn on a half pixel is smeared across three columns of pixels
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

-- a selection chip: which zone is the TUE source, which side the balancer
-- holds, which Lamps view is showing. Selection, not state -- so neutral.
-- `h` defaults to 15. A chip that sits in a node's title row passes 12, is
-- placed at the node top - 13, and starts at afterTitle(): the right end of the
-- title row belongs to the node's headline value.
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
        -- A closed switch is a straight line in a schematic, and a straight
        -- line lying along a wire is not a symbol at all -- it was drawn and
        -- read as plain wire. Lift the link into a bridge so the device is
        -- visible as a device whether it is closed or open.
        sasl.gl.drawWideLine(cx - 13, y, cx - 9, y + 9, 2, col)
        sasl.gl.drawWideLine(cx - 9, y + 9, cx + 9, y + 9, 3, col)
        sasl.gl.drawWideLine(cx + 9, y + 9, cx + 13, y, 2, col)
    else
        sasl.gl.drawWideLine(cx - 13, y, cx + 9, y + 13, 2, COL_DIM)
    end
end

-- ---------------------------------------------------------------------------
-- Schematic symbols
--
-- A one-line diagram made only of boxes and lines says what is connected but
-- not what the connection IS: a fuel line and a busbar look identical, and a
-- run of wire gives no hint which way anything moves. These are the glyphs a
-- real schematic uses for that, and every one is centred on (cx, cy) so a
-- diagram drops it at the midpoint of a run it already draws -- the symbol
-- never has its own coordinates to keep in step with the wire's.
--
-- All of them take a state and are drawn in `stateCol`, so a shut valve and a
-- failed one differ in colour, not only in shape. Where the shape also carries
-- the state (a valve's crossbar, a pump's impeller) it says the same thing
-- twice on purpose: the colours are close together for a red-green eye, and
-- the shape is not.
-- ---------------------------------------------------------------------------

SYM_R = 9 -- the radius the round symbols share, so a row of them lines up

-- Flow direction along (dx, dy). Every run in these diagrams is orthogonal, so
-- only the sign of one axis matters.
--
-- A solid head means something is MOVING, so it is drawn only on a live run;
-- every other run gets a thin open chevron in its own colour, which keeps the
-- direction without claiming flow.
function arrow(cx, cy, dx, dy, s)
    local col = stateCol(s)
    cx, cy = math.floor(cx), math.floor(cy)
    if s ~= S_LIVE then
        if dx ~= 0 then
            -- 4 px either side, the height of the solid head: the bars these sit
            -- on carry a caption 9 px above them, and at 5 the chevron reached it
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

-- A valve, as the schematic bowtie. Shut adds the bar across the throat, which
-- is what makes a shut valve readable without reading its colour.
function valveSym(cx, cy, open, s, vert)
    local col = stateCol(s)
    cx, cy = math.floor(cx), math.floor(cy)
    -- The two triangles meet AT the centre. Stopping them one pixel short left
    -- a gap at the throat that the wire underneath showed through, which read
    -- as two separate arrowheads rather than as one valve.
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

-- A pump: the circle, with the impeller chevron when it is turning and a bar
-- across when it is not.
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

-- Any round machine that is named rather than shaped -- a generator, a
-- transformer-rectifier, an inverter, an engine. The letter is the label the
-- Russian panels use, so G / VU / TR / PTS read straight across.
function roundSym(cx, cy, txt, s)
    cx, cy = math.floor(cx), math.floor(cy)
    sasl.gl.drawCircle(cx, cy, SYM_R, true, COL_CARD)
    sasl.gl.drawCircle(cx, cy, SYM_R, false, stateCol(s))
    sasl.gl.drawText(font, cx, cy - 4, txt, 10, false, false, TEXT_ALIGN_CENTER, stateTxt(s))
end

-- A battery: two cells of long plate / short plate, drawn ACROSS the run the
-- symbol sits on (along it, it reads as a fence beside the wire).
function battSym(cx, cy, s, horiz)
    local col = stateCol(s)
    cx, cy = math.floor(cx), math.floor(cy)
    -- Read along the run from the plus terminal. A cell's plates sit 4 px
    -- apart and the cells 7 px: evenly spaced plates read as a ladder. SASL's
    -- y grows upward, so a vertical cell's short plate goes BELOW its long one.
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

-- An electric heating element: the resistor zigzag. Used where the heat is
-- made by current rather than carried by air, which on this aeroplane is the
-- whole distinction the anti-ice diagram is banded around.
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

-- Set only by _tools/diagcheck.py, to learn what every `note` row drew: a note
-- whose text changes with the data is a live reading mislabelled as a note.
note_hook = false

-- A node whose body is a list of label / value rows, for the parts of a system
-- that are described by several small readings rather than one headline. Rows
-- are { label, value, [state] }; a row state overrides the node colour for that
-- value only. Two optional flags on a row:
--
--   hd = true    this is the node's headline. Its value is ALSO drawn in the
--                title row, 13 px in the row's state colour (the node's when
--                the row has none), so the one number a node exists to show
--                reads without reading the rows. The row stays, with its label:
--                taking it out would shrink the node and move every depth
--                table on the tab.
--   note = true  fixed explanation, not a reading -- "returns to reservoir 1",
--                "nominal 210 kg/cm2". Drawn in tertiary grey, behind the
--                live rows.
--                diagcheck fails a note whose text changes over its sweep.
--
-- `role` says what KIND of thing the node is:
--   "readout"  reports ABOUT a system rather than being part of it (totals,
--              loads, what the sim is told) and has no wire. No card fill, so
--              the schematic stands forward and these recede. Use readout().
--   nil        everything else: the plain box.
--
-- The chrome follows the state too: a 4 px state bar down the left edge beside
-- the title, a dead node's title dimmed, a failed node framed in red.
--
-- Height for n rows is 21 + n * 13 (LN_H2..LN_H6 below): the title band plus
-- room for the bottom row's descenders, because drawText's y is a BASELINE.
function listNode(x, dy, w, h, title, s, rows, fill, role)
    local yb = Y(dy + h)
    if role ~= "readout" then
        sasl.gl.drawRectangle(x, yb, w, h, COL_CARD)
    end
    -- `fill` (0..1) washes the bottom of the node in its state colour, so a tank
    -- or a bus reads as "how full / how loaded" without doing the arithmetic.
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
        -- a `link` row goes to another tab when clicked: its LABEL is drawn in
        -- the interactive blue, so the value keeps its own state colour
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

-- a listNode with role "readout" (see there); it takes no fill
function readout(x, dy, w, h, title, s, rows)
    return listNode(x, dy, w, h, title, s, rows, nil, "readout")
end

-- listNode heights for 2 / 3 / 4 / 5 / 6 rows
LN_H2, LN_H3, LN_H4, LN_H5, LN_H6 = 47, 60, 73, 86, 99

-- x of the i-th of n equal columns of width w, spread edge to edge across the
-- content area. Every diagram column comes from here, so the canvas size is a
-- parameter rather than a rewrite.
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

-- centre of the i-th of n columns
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

-- The footer every diagram shares: state swatches on the left, a dim note on
-- the right of the same line, and a full-width note 16 px under it. `dy` is
-- the swatch line's depth; every diagram passes LEG_D.
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

-- The label of a band of a banded diagram (Ice, Fire, Ctrl, Eng, Gear): small
-- grey caps at the left margin, on the gap above the band, so a band reads as
-- a stage of the system -- hot air, then electric heat, then what resulted --
-- rather than as the next row of a grid. `dy` is the baseline depth. Every
-- band but the first carries one; the tab title names the first. No rule
-- across the width: it would cut through every drop between the bands.
function band(dy, label)
    sasl.gl.drawText(font, CONTENT_L + 2, Y(dy), label, 10, false, false, TEXT_ALIGN_LEFT, COL_TER)
end

-- shared by six diagrams, so it lives with the vocabulary rather than in the
-- file of the one that happened to define it first
function enumTxt(map, v)
    return map[math.floor(v + 0.5)] or fmt(v, 0)
end

-- every diagram file registers its draw function here, keyed by
-- the schema's `diagram`
DIAGRAMS = {}
