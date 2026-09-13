--[[

  File: inspector_watch.lua
  -----
  Tu-154M System Viewer / Debug Inspector -- the Watch tab (DIAGRAMS.watch), the pinned value history.

  Loaded by debug_inspector_view.lua into the inspector's shared namespace
  (see "The inspector's files" there): the vocabulary it draws with --
  listNode, wire, readv, the S_* states, colX, Y and the rest of
  inspector_vocab.lua -- is in scope without being imported, and its own
  top-level locals stay private to this file.

--]]

-- ---------------------------------------------------------------------------
-- Watch tab: the pinned traces. Each row autoscales to its own window, because
-- the interesting thing about a bus volt and a fuel flow on the same screen is
-- the *shape* of each, not their ratio.
-- ---------------------------------------------------------------------------
-- Watch tab geometry, same convention as EG above.
local WG = {
    LBL = 340, -- width of the label column, left of the plot
}

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

    -- The rows share the whole height out between however many are pinned, so
    -- one pinned value is one full-height plot rather than a 150 px strip and
    -- 490 px of nothing. A tall row is not wasted on a trace: the plot
    -- autoscales to its own window, so the extra height is extra resolution on
    -- exactly the small transient this tab exists to catch.
    local pitch = math.floor((CONTENT_H - 26) / #watch)
    -- every row has the same x axis
    local px0 = CONTENT_L + WG.LBL
    local pw = CONTENT_W - WG.LBL - 12
    local step = pw / math.max(1, WATCH_N - 1)

    -- The time cursor. The row under the mouse turns the pointer's x into an
    -- AGE -- how many samples before that row's newest -- and every row then
    -- shows its own sample of that age. A trace is drawn oldest-first from the
    -- left edge, so until its ring is full a trace pinned later has its samples
    -- at different x than one pinned earlier; reading "the sample under x" in
    -- each row would put different instants side by side. By age, they are the
    -- same instant. A row with no sample that old shows no cursor.
    local age
    local hx, hy
    if watch_hover then
        hx, hy = watch_hover[1], watch_hover[2]
    end
    if hx and hx >= px0 and hx <= px0 + pw then
        for i = 1, #watch do
            local t = watch[i]
            local h = pitch - 8
            local py0 = Y(6 + (i - 1) * pitch + h) + 12
            if t.n > 0 and hy >= py0 and hy <= py0 + h - 26 then
                age = t.n - clamp(1, math.floor((hx - px0) / step + 0.5) + 1, t.n)
                break
            end
        end
    end

    for i = 1, #watch do
        local t = watch[i]
        local dy = 6 + (i - 1) * pitch
        local h = pitch - 8
        local yb = Y(dy + h)
        sasl.gl.drawRectangle(CONTENT_L, yb, CONTENT_W, h, COL_CARD)
        sasl.gl.drawFrame(CONTENT_L, yb, CONTENT_W, h, COL_FRAME)

        -- window extremes, and the newest sample
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
        local cur = t.n > 0 and t.v[(t.w - 2) % WATCH_N + 1] or 0
        local span = hi - lo
        if span < 1e-6 then
            -- a dead flat trace still needs a band to sit in the middle of
            lo, hi = lo - 0.5, hi + 0.5
            span = hi - lo
        end

        -- the label block hangs from the top of the row, so it stays a block
        -- whether the row is 94 px tall or 600
        local ly = yb + h
        sasl.gl.drawText(font, CONTENT_L + 10, ly - 16, t.name, 11, false, false,
            TEXT_ALIGN_LEFT, COL_TEXT)
        sasl.gl.drawText(font, CONTENT_L + 10, ly - 46, fmt(cur, 2), 20, false, false,
            TEXT_ALIGN_LEFT, COL_ACCENT)
        sasl.gl.drawText(font, CONTENT_L + 10, ly - 64,
            "min " .. fmt(lo, 2) .. "    max " .. fmt(hi, 2), 11, false, false,
            TEXT_ALIGN_LEFT, COL_DIM)
        sasl.gl.drawText(font, CONTENT_L + WG.LBL - 12, ly - 64,
            t.n .. " / " .. WATCH_N, 11, false, false, TEXT_ALIGN_RIGHT, COL_TER)

        -- plot area
        local py0, ph = yb + 12, h - 26
        sasl.gl.drawFrame(px0, py0, pw, ph, COL_OFF)
        -- zero line, when the window straddles it
        if lo < 0 and hi > 0 then
            local zy = py0 + (0 - lo) / span * ph
            sasl.gl.drawLine(px0, zy, px0 + pw, zy, COL_FRAME)
        end
        -- a faint line every 5 s of sim time, counted back from the newest
        -- sample, so a transient's age and length read off the plot itself
        -- and not only off the cursor; they ride with the trace as it fills
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

        -- Oldest sample first. The n most recent writes occupy the slots
        -- ending at w-1, so the k-th oldest is at (w - n + k - 2) mod N + 1.
        local lx, ly2
        for k = 1, t.n do
            local v = t.v[(t.w - t.n + k - 2) % WATCH_N + 1]
            local x = px0 + (k - 1) * step
            local y = py0 + (v - lo) / span * ph
            if lx then
                sasl.gl.drawWideLine(lx, ly2, x, y, 2, COL_ACCENT)
            end
            lx, ly2 = x, y
        end

        -- this row's sample at the cursor's age: a hairline, a tick on the
        -- trace, and the value -- on the far side of the line near the right
        -- edge, so it never runs out of the plot
        if age and age < t.n then
            local k = t.n - age
            local v = t.v[(t.w - t.n + k - 2) % WATCH_N + 1]
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
