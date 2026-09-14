-- ---------------------------------------------------------------------------
-- Watch tab: the pinned traces. Each row autoscales to its own window: what
-- matters is the shape of each trace, not their ratio.
-- ---------------------------------------------------------------------------
local LBL_W = 340 -- label column, left of the plot

-- the k-th oldest sample; the n most recent writes end at slot w - 1
local function sampleAt(t, k)
    return t.v[(t.w - t.n + k - 2) % WATCH_N + 1]
end

-- row i's box (yb, h) and plot area (py0, ph), rows `pitch` apart
local function rowRect(i, pitch)
    local h = pitch - 8
    local yb = Y(6 + (i - 1) * pitch + h)
    return yb, h, yb + 12, h - 26
end

local function drawWatch()
    if #watch == 0 then
        sasl.gl.drawText(font, CONTENT_L + 10, Y(46), "Nothing pinned yet.", 17, false, false,
            TEXT_ALIGN_LEFT, COL_TEXT)
        local help = {
            "Open DATAREFS on any tab and click a name to pin it here. Click it again to unpin.",
            "Up to " .. WATCH_MAX .. " traces, sampled every " .. fmt(WATCH_DT, 1) ..
            " s of sim time, " .. fmt(WATCH_N * WATCH_DT, 0) .. " s of history.",
            "Sampling stops when the sim is paused, and follows time acceleration, because the",
            "cadence is driven by tu-154/time/frame_time rather than by frames.",
            "Pins are kept in output/debug_watch.ini, so they survive a reload.",
        }
        for i = 1, #help do
            sasl.gl.drawText(font, CONTENT_L + 10, Y(76 + (i - 1) * 18), help[i], 12, false, false,
                TEXT_ALIGN_LEFT, COL_DIM)
        end
        return
    end

    -- the pinned rows share the whole height: a tall row is more resolution
    local pitch = math.floor((CONTENT_H - 26) / #watch)
    local px0 = CONTENT_L + LBL_W
    local pw = CONTENT_W - LBL_W - 12
    local step = pw / math.max(1, WATCH_N - 1)

    -- Time cursor. The row under the mouse turns x into an AGE (samples before
    -- its newest) and every row shows its own sample of that age: until a ring
    -- fills, traces pinned at different times put different instants at one x.
    local age
    if watch_hover then
        local hx, hy = watch_hover[1], watch_hover[2]
        if hx >= px0 and hx <= px0 + pw then
            for i = 1, #watch do
                local t = watch[i]
                local _, _, py0, ph = rowRect(i, pitch)
                if t.n > 0 and hy >= py0 and hy <= py0 + ph then
                    age = t.n - clamp(1, math.floor((hx - px0) / step + 0.5) + 1, t.n)
                    break
                end
            end
        end
    end

    for i = 1, #watch do
        local t = watch[i]
        local yb, h, py0, ph = rowRect(i, pitch)
        sasl.gl.drawRectangle(CONTENT_L, yb, CONTENT_W, h, COL_CARD)
        sasl.gl.drawFrame(CONTENT_L, yb, CONTENT_W, h, COL_FRAME)

        local lo, hi = math.huge, -math.huge
        for k = 1, t.n do
            local v = t.v[k]
            if v < lo then
                lo = v
            end
            if v > hi then
                hi = v
            end
        end
        if t.n == 0 then
            lo, hi = 0, 1
        end
        local cur = t.n > 0 and sampleAt(t, t.n) or 0
        local span = hi - lo
        if span < 1e-6 then
            -- a flat trace still needs a band to sit in the middle of
            lo, hi = lo - 0.5, hi + 0.5
            span = hi - lo
        end

        -- the label block hangs from the top of the row, at any row height
        local ly = yb + h
        sasl.gl.drawText(font, CONTENT_L + 10, ly - 16, t.name, 11, false, false,
            TEXT_ALIGN_LEFT, COL_TEXT)
        sasl.gl.drawText(font, CONTENT_L + 10, ly - 46, fmt(cur, 2), 20, false, false,
            TEXT_ALIGN_LEFT, COL_ACCENT)
        sasl.gl.drawText(font, CONTENT_L + 10, ly - 64,
            "min " .. fmt(lo, 2) .. "    max " .. fmt(hi, 2), 11, false, false,
            TEXT_ALIGN_LEFT, COL_DIM)
        sasl.gl.drawText(font, CONTENT_L + LBL_W - 12, ly - 64,
            t.n .. " / " .. WATCH_N, 11, false, false, TEXT_ALIGN_RIGHT, COL_TER)

        sasl.gl.drawFrame(px0, py0, pw, ph, COL_OFF)
        if lo < 0 and hi > 0 then
            local zy = py0 + (0 - lo) / span * ph
            sasl.gl.drawLine(px0, zy, px0 + pw, zy, COL_FRAME)
        end
        -- a faint line every 5 s, counted back from the newest sample
        if t.n > 1 then
            local every = math.floor(5 / WATCH_DT + 0.5)
            local xN = px0 + (t.n - 1) * step
            local k = every
            while k < t.n do
                local gx = math.floor(xN - k * step)
                sasl.gl.drawLine(gx, py0 + 1, gx, py0 + ph - 1, COL_FRAME)
                k = k + every
            end
        end

        -- oldest sample first, from the left edge
        local lx, ly2
        for k = 1, t.n do
            local v = sampleAt(t, k)
            local x = px0 + (k - 1) * step
            local y = py0 + (v - lo) / span * ph
            if lx then
                sasl.gl.drawWideLine(lx, ly2, x, y, 2, COL_ACCENT)
            end
            lx, ly2 = x, y
        end

        -- this row's sample at the cursor's age; the value flips to the left
        -- of the line near the right edge
        if age and age < t.n then
            local k = t.n - age
            local v = sampleAt(t, k)
            local x = math.floor(px0 + (k - 1) * step)
            local y = math.floor(py0 + (v - lo) / span * ph)
            sasl.gl.drawLine(x, py0, x, py0 + ph, COL_DIM)
            sasl.gl.drawWideLine(x - 5, y, x + 5, y, 2, COL_TEXT)
            local txt = fmt(v, 2)
            local flip = x + 6 + sasl.gl.measureText(font, txt, 11, false, false) > px0 + pw - 4
            sasl.gl.drawText(font, flip and (x - 6) or (x + 6), py0 + ph - 14, txt, 11,
                false, false, flip and TEXT_ALIGN_RIGHT or TEXT_ALIGN_LEFT, COL_TEXT)
        end
    end

    local foot = "Each trace autoscales to its own window; the faint lines are 5 s apart, counted back"
        .. " from the newest sample. Click a pinned name in DATAREFS again to unpin it."
    if age then
        foot = "Cursor: " .. ((age == 0) and "the newest sample"
            or (fmt(age * WATCH_DT, 1) .. " s before the newest sample"))
            .. " -- every row shows its own value at that instant."
    end
    sasl.gl.drawText(font, CONTENT_L, Y(CONTENT_H - 6), foot, 11, false, false,
        TEXT_ALIGN_LEFT, COL_TER)
end
DIAGRAMS.watch = drawWatch
