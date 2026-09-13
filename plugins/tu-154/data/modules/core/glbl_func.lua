--[[
  Shared helpers, published on _G. A contextWindow's root component has no
  parent, so lookups from inside a popup end at _G, not at main.lua.

  Scope rule: anything shared between components is assigned explicitly as
  _G.name (as here and in panels/panel_windows.lua); everything else is local.
  A module-level global lands in that component's own environment, where only
  its children can see it -- and reading one that is nil hands the name to
  SASL's component loader (CLAUDE.md, SASL3 API traps).
--]]

-- Piecewise-linear interpolation over a sorted {{x1,y1},{x2,y2},...} table.
-- NOTE: this deliberately shadows SASL3's interpolator-handle `interpolate`,
-- exactly as avionics.lua shadowed SASL2's. The Tu-154 never uses
-- newInterpolator/selfInterpolator, so nothing else wants the SASL version.
function _G.interpolate(tbl, value)
    local lastActual = 0
    local lastReference = 0
    for _k, v in pairs(tbl) do
        if value == v[1] then
            return v[2]
        end
        if value < v[1] then
            local a = value - lastActual
            local m = v[2] - lastReference
            return lastReference + a / (v[1] - lastActual) * m
        end
        lastActual = v[1]
        lastReference = v[2]
    end
    return value - lastActual + lastReference
end

function _G.sign(x)
    if x >= 0 then return 1 else return -1 end
end

function _G.bool2int(var)
    if var then return 1
    else return 0 end
end

function _G.line(x, x1, y1, x2, y2)
    -- (x - x1)/(x2 - x1) = (y - y1)/(y2 - y1)
    if x2 - x1 ~= 0 then
        return (x - x1) * (y2 - y1) / (x2 - x1) + y1
    else return 0
    end
end

function _G.isILS(freq)
    if (10810 > freq) or (11195 < freq) then
        return false
    end
    local v, f = math.modf(freq / 100)
    v = math.floor(f * 10 + 0.001)
    return 1 == (v % 2)
end

-- Smoothing coefficient for a first-order lag written as
--   x = x + (target - x) * lagCoef(dt, rate)
-- `rate` is the per-second convergence rate, so this reads the same as the bare
-- `* dt * rate` form the tree already uses -- it just cannot step past the
-- target. tu-154/time/frame_time is clamped to 0.1 s, so a bare `* dt * rate`
-- reaches a coefficient of 1.0 at rate 10, rings above it and DIVERGES above
-- rate 20. Use this wherever rate > 10.
function _G.lagCoef(dt, rate)
    local k = dt * rate
    if k <= 0 then return 0 end
    if k > 1 then return 1 end
    return k
end

-- Random failures. Each *_fails.lua lists its flags as { prop, k1, k2, failed }
-- and rolls them in that order every check period; the chance of a roll is
-- k1 * FAIL * k2, evaluated in that order. `failed` is the flag's failed value:
-- 1 for tu-154/ flags, 6 for X-Plane's own. A flag that has not failed is
-- rewritten on every roll (0 or `failed`).
function _G.rollFailures(list, FAIL)
    for _, f in ipairs(list) do
        if get(f[1]) ~= f[4] then
            set(f[1], bool2int(math.random() < f[2] * FAIL * f[3]) * f[4])
        end
    end
end

function _G.clearFailures(list)
    for _, f in ipairs(list) do
        set(f[1], 0)
    end
end

-- ---------------------------------------------------------------------------
-- Sound pause
-- ---------------------------------------------------------------------------
--
-- Neither X-Plane nor SASL3 stops this plugin's samples on pause. Looping
-- samples (world state: engines, ambience, fans) are tracked here so that
-- systems/audio/sound_pause.lua can hold them; one-shots still play, so a
-- switch clicked on the pause screen still clicks. The wrappers must exist
-- before any component body runs, because some call playSample at load time.

if playSample ~= nil and stopSample ~= nil then

    local sasl_playSample = playSample
    local sasl_stopSample = stopSample

    local loops     = {}     -- id -> true while some module wants this loop running
    local sndPaused = false

    function _G.playSample(id, isLooping)
        if isLooping then
            loops[id] = true
            -- While paused, record the intent but do not start it. Modules poll
            --   if not isSamplePlaying(x) then playSample(x, true) end
            -- and a paused sample does not report as playing, so without this
            -- they would restart it every frame and defeat the pause.
            if sndPaused then return end
        end
        return sasl_playSample(id, isLooping)
    end

    function _G.stopSample(id)
        loops[id] = nil
        return sasl_stopSample(id)
    end

    --- Pauses or resumes every looping sample. Idempotent.
    --- @param p boolean
    function _G.setSoundPaused(p)
        p = p and true or false
        if p == sndPaused then return end
        sndPaused = p
        for id in pairs(loops) do
            if p then
                pauseSample(id)
            else
                -- Restart unconditionally rather than testing isSamplePlaying:
                -- this also covers loops requested *during* the pause, which
                -- the wrapper above deliberately did not start. Re-issuing a
                -- loop that is already running costs at worst a phase jump in
                -- an ambience track.
                sasl_playSample(id, true)
            end
        end
    end

    --- True while the looping samples are held. Read by the driver module.
    function _G.isSoundPaused() return sndPaused end

    --- How many looping samples are currently registered. Diagnostics only --
    --- a non-zero count is what proves the wrapper is actually seeing the
    --- project's playSample calls rather than being shadowed somewhere in the
    --- component environment chain.
    function _G.loopingSampleCount()
        local n = 0
        for _ in pairs(loops) do n = n + 1 end
        return n
    end

end

-- ---------------------------------------------------------------------------
-- SASL2 compatibility helper
-- ---------------------------------------------------------------------------

-- SASL2's onMouseDown fired on the press AND then repeated while the button
-- was held (initial delay, then a steady period). SASL3 replaced it with
-- onMouseHold, which fires EVERY FRAME -- a raw stepping handler bound straight
-- to it would advance 3-12x during one ordinary click.
--
-- holdToRepeat restores the SASL2 cadence. A new press is detected by a gap in
-- the hold events, so onMouseDown needs no changes.
--   onMouseHold = holdToRepeat(),       -- repeat the component's onMouseDown
--   onMouseHold = holdToRepeat(stepFn), -- repeat a custom step function
local repeatClock = sasl.createTimer()
sasl.startTimer(repeatClock)

function _G.holdToRepeat(stepFn, delay, period)
    delay = delay or 0.5
    period = period or 0.15
    local lastSeen, dueAt = -1, 0
    return function(comp, x, y, button, parentX, parentY)
        local now = sasl.getElapsedSeconds(repeatClock)
        if now - lastSeen > 0.3 then -- hold events stopped arriving: new press
            dueAt = now + delay
        end
        lastSeen = now
        if now < dueAt then
            return true
        end
        dueAt = now + period
        if stepFn then
            return stepFn(comp, x, y, button, parentX, parentY) ~= false
        end
        return comp.onMouseDown(comp, x, y, button, parentX, parentY)
    end
end

-- ---------------------------------------------------------------------------
-- Late-binding datarefs
-- ---------------------------------------------------------------------------
--
-- SASL3's globalProperty*() returns nil for a dataref that does not exist yet,
-- and `get(nil) > 0` then throws. Optional plugins (SmartCopilot, RealityXP,
-- BetterPushback, the KLN90B) may load after the aircraft or not at all, so an
-- unresolved name yields a property that reads the type's zero and retries the
-- lookup every RETRY_PERIOD. Resolved names go straight to SASL3, unwrapped.

local _sasl3_gpf = globalPropertyf
local _sasl3_gpi = globalPropertyi
local _sasl3_gpd = globalPropertyd
local _sasl3_gps = globalPropertys

-- Retries use sasl.findDataRef's THIRD argument, which suppresses SASL's
-- "not found" log line. SASL's own globalProperty() shows the idiom: it probes
-- quietly, and when that fails re-probes *noisily* purely to emit the message.
-- Without the quiet probe a name that never appears (SmartCopilot on a
-- single-player flight, say) logs a warning on every retry -- that was 8622
-- warnings in one short flight, 5435 of them for scp/api/ismaster alone.
--
-- [QUIET-BIND] The first bind used to be deliberately noisy (one real,
-- warning-producing call per missing name) as a diagnostic: so a genuine typo
-- in a dataref path would still show up once in Log.txt. In practice this
-- aircraft's three documented optional-plugin families (SmartCopilot,
-- RealityXP GNS/BetterPushback, the inherited An-24 xap/* names) are the only
-- things that ever hit it, every single flight, on every install that lacks
-- those plugins -- 78 files reference scp/api/ismaster alone -- so the
-- "diagnostic" was pure noise (172 warnings/flight) rather than a signal. The
-- first bind now uses the same quiet probe as the retries, so a genuinely
-- missing name is silent, matching the SASL2 behaviour this wrapper restores.
--
-- What that silence cost is a misspelt name, which now reads 0 without a word.
-- So the diagnostic comes back as ONE line: REPORT_AFTER seconds after load,
-- the first read of any still-unresolved property logs every name that is
-- still unresolved, minus the optional-plugin families below. A clean install
-- logs nothing; a typo logs once per flight.
local resolveClock = sasl.createTimer()
sasl.startTimer(resolveClock)
local RETRY_PERIOD = 2.0 -- seconds between silent re-probes
local REPORT_AFTER = 60  -- seconds of real time before the one-line report

local OPTIONAL_PREFIXES = {
    "scp/api/",                    -- SmartCopilot
    "RXP/", "bp/",                 -- RealityXP GNS, BetterPushback
    "custom/KLN90/", "custom/MD41/",
}
-- ...and the names plugins/kln90b creates in this aircraft's own namespace,
-- written without their "tu-154/" head: they are prefixes, not dataref names,
-- and drefcheck.py would report them as never created.
local OPTIONAL_OWN = { "kln90/", "xap/KLN90", "xap/MD41" }
local unresolved = {}  -- name -> true while its deferred property is unbound
local reported = false

local function startsWithAny(s, prefixes)
    for _, p in ipairs(prefixes) do
        if s:sub(1, #p) == p then return true end
    end
    return false
end

local function reportUnresolved()
    reported = true
    local list = {}
    for name in pairs(unresolved) do
        local own = name:match("^tu%-154/(.*)")
        local optional = startsWithAny(name, OPTIONAL_PREFIXES)
            or (own ~= nil and startsWithAny(own, OPTIONAL_OWN))
        if not optional then list[#list + 1] = name end
    end
    if #list > 0 then
        table.sort(list)
        sasl.logWarning("datarefs still unresolved " .. REPORT_AFTER
            .. " s after load (a typo, or a plugin that never loaded): "
            .. table.concat(list, ", "))
    end
end

-- Read through rawget: this file is included into a COMPONENT environment, whose
-- __index turns an unknown global into loadComponent("TYPE_UNKNOWN") and an
-- error per call (the same trap as SASL2's showClickableAreas). SASL passes a
-- nil type through as "any", so the fallback is harmless if it ever moves.
local TYPE_ANY = rawget(_G, "TYPE_UNKNOWN")

local function deferredProperty(finder, name, zero)
    local real, nextTry = nil, 0
    unresolved[name] = true
    local function resolve()
        if real then return real end
        local now = sasl.getElapsedSeconds(resolveClock)
        if not reported and now >= REPORT_AFTER then reportUnresolved() end
        if now < nextTry then
            return nil
        end
        nextTry = now + RETRY_PERIOD
        -- quiet existence check; only bind for real once the dataref is there
        if not sasl.findDataRef(name, TYPE_ANY, true) then
            return nil
        end
        real = finder(name)
        if real then unresolved[name] = nil end
        return real
    end
    return {
        __p = 1,
        name = name,
        get = function(_, offset, numValues)
            local r = resolve()
            if r then return r:get(offset, numValues) end
            return zero
        end,
        set = function(_, value, offset, numValues)
            local r = resolve()
            if r then r:set(value, offset, numValues) end
        end,
        size = function()
            local r = resolve()
            if r then return r.size() end
            return 1
        end,
        free = function()
            if real then real.free() end
        end,
        raw = function()
            local r = resolve()
            if r then return r.raw() end
            return nil
        end
    }
end

-- [QUIET-BIND] Quiet existence check before the first (real) call, so a
-- missing name goes straight to deferredProperty without ever invoking the
-- noisy native lookup. A name that IS present still binds immediately and
-- permanently below, with no wrapper and no per-frame overhead.
-- A name that exists but has a type the typed accessor refuses (a scalar
-- accessor on an array, say) makes the finder return nil; it falls through to
-- the deferred property and reads 0, exactly as before quietBind.
local function quietBind(finder, name, zero)
    if sasl.findDataRef(name, TYPE_ANY, true) then
        return finder(name) or deferredProperty(finder, name, zero)
    end
    return deferredProperty(finder, name, zero)
end

function _G.globalPropertyf(name)
    return quietBind(_sasl3_gpf, name, 0)
end
function _G.globalPropertyi(name)
    return quietBind(_sasl3_gpi, name, 0)
end
function _G.globalPropertyd(name)
    return quietBind(_sasl3_gpd, name, 0)
end
function _G.globalPropertys(name)
    return quietBind(_sasl3_gps, name, "")
end
