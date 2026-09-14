-- ---------------------------------------------------------------------------
-- The list tabs (every tab with `fields`): label | value rows under `section`
-- headers in LS.NCOL balanced columns. A long section carries on in the next
-- column as "TITLE (cont.)"; a tab that outgrows LS.NCOL full columns scrolls
-- a column at a time. Nominal is quiet: a clear fault or failure is a hollow
-- dot and a grey "ok", and only a non-zero enum gets a chip.
-- ---------------------------------------------------------------------------
LS = {
    ROW   = 19,  -- row pitch
    HEAD  = 24,  -- section header
    GAP   = 16,  -- between columns
    SGAP  = 8,   -- after a section
    NCOL  = 3,
    cache = {},  -- tab index -> layout; it depends on nothing live
}
LS.CW = math.floor((CONTENT_W - (LS.NCOL - 1) * LS.GAP) / LS.NCOL)

function listLayout(i)
    local lay = LS.cache[i]
    if lay then
        return lay
    end
    local blocks, cur = {}, nil
    for _, f in ipairs(schema[i].fields) do
        if f.section then
            cur = { title = f.section, rows = {} }
            blocks[#blocks + 1] = cur
        else
            if not cur then
                cur = { rows = {} }
                blocks[#blocks + 1] = cur
            end
            cur.rows[#cur.rows + 1] = f
        end
    end
    local total = 0
    for _, b in ipairs(blocks) do
        total = total + (b.title and LS.HEAD or 0) + #b.rows * LS.ROW + LS.SGAP
    end
    -- Fill each column to an even share of the whole rather than to the
    -- bottom, so three columns come out level -- unless the whole does not fit
    -- LS.NCOL columns anyway, in which case every column is filled.
    local share = math.ceil(total / LS.NCOL) + LS.ROW
    local items, col, y = {}, 1, 0
    local function limit()
        if total <= LS.NCOL * CONTENT_H and col < LS.NCOL then
            return math.min(share, CONTENT_H)
        end
        return CONTENT_H
    end
    for _, b in ipairs(blocks) do
        if b.title then
            -- never leave a header at a column foot over fewer than two rows
            local need = LS.HEAD + math.min(2, #b.rows) * LS.ROW
            if y > 0 and y + need > limit() then
                col, y = col + 1, 0
            end
            items[#items + 1] = { col = col, y = y, head = b.title }
            y = y + LS.HEAD
        end
        for k, f in ipairs(b.rows) do
            -- a section's last row is not carried over just to level the
            -- columns (a one-row "(cont.)" is a widow), only if it cannot fit
            local last = (k == #b.rows) and (y + LS.ROW <= CONTENT_H)
            if y + LS.ROW > limit() and not last then
                col, y = col + 1, 0
                if b.title then
                    items[#items + 1] = { col = col, y = y, head = b.title .. " (cont.)" }
                    y = y + LS.HEAD
                end
            end
            items[#items + 1] = { col = col, y = y, f = f, zebra = (k % 2 == 0) }
            y = y + LS.ROW
        end
        y = y + LS.SGAP
    end
    lay = { items = items, cols = col }
    LS.cache[i] = lay
    return lay
end

local function colorFor(v, warn_lo, warn_hi)
    if warn_lo and v < warn_lo then
        return COL_AMBER
    end
    if warn_hi and v > warn_hi then
        return COL_RED
    end
    return COL_GREEN
end

-- `top` is the depth below CONTENT_T
local function drawHead(x, top, title)
    local yb = CONTENT_T - top - LS.HEAD
    sasl.gl.drawText(font, x + 2, yb + 8, title, 11, false, false, TEXT_ALIGN_LEFT, COL_DIM)
    sasl.gl.drawRectangle(x, yb + 3, LS.CW, 1, COL_FRAME)
end

local function drawRow(x, top, f, zebra)
    local w = LS.CW
    local yb = CONTENT_T - top - LS.ROW
    local ty, xr = yb + 5, x + w - 6
    if zebra then
        sasl.gl.drawRectangle(x, yb, w, LS.ROW, COL_CARD)
    end
    -- read even when dead, so the DATAREFS probe lists it like every other row
    local v = readv(f.dref)
    if f.dead then
        sasl.gl.drawText(font, x + 6, ty, f.label, 12, false, false, TEXT_ALIGN_LEFT, COL_TER)
        sasl.gl.drawText(font, xr, ty, "not modelled", 11, false, false, TEXT_ALIGN_RIGHT, COL_TER)
        return
    end
    sasl.gl.drawText(font, x + 6, ty, f.label, 12, false, false, TEXT_ALIGN_LEFT, COL_DIM)
    local kind = f.kind
    local txt, col, dot, hollow
    if kind == "lamp" then
        local on = v > 0.5
        if f.fault then
            txt, col = on and "ALARM" or "ok", on and COL_RED or COL_TER
            dot, hollow = on and COL_RED or COL_OFF, not on
        else
            txt, col = on and "ON" or "OFF", on and COL_TEXT or COL_DIM
            dot = on and COL_GREEN or COL_OFF
        end
    elseif kind == "fail" then
        -- tu-154/failures/... are plain 0/1 flags, not X-Plane failure codes
        local bad = math.abs(v) > 0.5
        txt, col = bad and "FAIL" or "ok", bad and COL_RED or COL_TER
        dot, hollow = bad and COL_RED or COL_OFF, not bad
    elseif kind == "enum" then
        local key = math.floor(v + 0.5)
        txt = (f.map and f.map[key]) or fmt(v, 0)
        col = (key ~= 0) and COL_TEXT or COL_DIM
        if key ~= 0 then
            local tw = sasl.gl.measureText(font, txt, 12, false, false)
            sasl.gl.drawRectangle(xr - tw - 6, yb + 2, tw + 10, LS.ROW - 4, COL_SEL)
        end
        xr = xr - 2
    else
        local ranged = (kind == "bar" or kind == "gauge")
        local minv, maxv = f.min or 0, f.max or 1
        local dp = f.dp or ((ranged and (maxv - minv) < 50) and 1 or 0)
        txt = fmt(v, dp)
        if f.unit and f.unit ~= "" then
            txt = txt .. " " .. f.unit
        end
        col = COL_TEXT
        if ranged then
            -- where the value sits in its range, left of the number
            local bx, bw = x + w - 150, 64
            local frac = clamp(0, (v - minv) / (maxv - minv), 1)
            sasl.gl.drawRectangle(bx, yb + 7, bw, 5, COL_OFF)
            if frac > 0 then
                sasl.gl.drawRectangle(bx, yb + 7, bw * frac, 5, colorFor(v, f.warn_lo, f.warn_hi))
            end
        end
    end
    sasl.gl.drawText(font, xr, ty, txt, 12, false, false, TEXT_ALIGN_RIGHT, col)
    if dot then
        local tw = sasl.gl.measureText(font, txt, 12, false, false)
        sasl.gl.drawCircle(math.floor(xr - tw - 10), yb + 9, 4, not hollow, dot)
    end
end

-- `scroll` is in whole columns; the frame code owns it
function drawList(i, scroll)
    local lay = listLayout(i)
    for _, it in ipairs(lay.items) do
        local c = it.col - 1 - scroll
        if c >= 0 and c < LS.NCOL then
            local x = CONTENT_L + c * (LS.CW + LS.GAP)
            if it.head then
                drawHead(x, it.y, it.head)
            else
                drawRow(x, it.y, it.f, it.zebra)
            end
        end
    end
end
