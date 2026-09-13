-- Produces tu-154/time/frame_time -- the ONE delta-time source every system
-- module integrates against (131 modules under systems/ and core/ read it).
--
-- The contract for consumers:
--   * frame_time is SECONDS OF SIM TIME since the previous frame.
--   * frame_time == 0 means "the simulation is not advancing" (paused).
--     Freeze: do not integrate, do not step a state machine, do not divide.
--   * frame_time is clamped to CLAMP, so a consumer may assume it is small.
--   * never advance anything per frame -- always multiply by frame_time.
--
-- History. This file used to derive the pause state from
-- sim/flightmodel/position/M staying bit-identical between two frames. That is
-- an exact float32 compare on a physics value, and it fails in both
-- directions: at high frame rates M rounds to the same float and a whole frame
-- of simulated time is silently dropped, and on a fully settled parked
-- aircraft M is genuinely constant, which stalls every timer in the plugin --
-- including the load-time gates in core/save_state.lua and the 25 modules that
-- reset their switches behind `sim_start_timer > 0.3`. X-Plane publishes the
-- real answer in sim/time/paused, so ask it. The sibling An-24RV-CE made the
-- same change. See CLAUDE.md "Time base".

defineProperty("sim_paused",   globalPropertyi("sim/time/paused"))                  -- 1 while the sim is paused
defineProperty("sim_flt_time", globalPropertyf("sim/time/total_flight_time_sec"))   -- SIM clock: stops on pause, scales with sim/time/sim_speed
defineProperty("frame_period", globalPropertyf("sim/operation/misc/frame_rate_period")) -- the sim time step for this frame

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- Largest delta a single frame may report. Below ~10 FPS the aircraft systems
-- deliberately run slower than real time rather than integrate one huge step:
-- several consumers smooth with `x = x + (target - x) * frame_time * K`, and
-- K = 10 is exactly critically damped at 0.1 s -- anything larger rings or
-- diverges. Raising this constant destabilises those filters.
local CLAMP = 0.1

-- A flight-time step larger than this is not a frame, it is the flight being
-- reset (total_flight_time_sec restarts at 0) or the sim catching up after a
-- load. Fall back to the frame period for that one frame.
local FLT_MAX_STEP = 1.0

local flt_last  = -1
local first_run = true

function update()

	local flt_now = get(sim_flt_time)

	-- First real frame: seed the baseline and report nothing. Seeding it at
	-- module-load time (as this file used to) measures the gap between SASL
	-- loading the plugin and X-Plane finishing the scenery load -- seconds,
	-- not a frame.
	if first_run then
		flt_last  = flt_now
		first_run = false
		set(frame_time, 0)
		return
	end

	-- Paused. Re-baseline as we go, so resuming does not release the whole
	-- pause as one delta.
	if get(sim_paused) == 1 then
		flt_last = flt_now
		set(frame_time, 0)
		return
	end

	-- total_flight_time_sec is the clock that tracks SIM time, so running the
	-- systems off its delta accounts for time acceleration automatically --
	-- no assumption needed about whether sim/time/sim_speed scales the
	-- wall-clock datarefs.
	local passed = flt_now - flt_last

	-- Two cases where that delta is not usable:
	--   * <= 0 : the flight was reset, or -- at a very high frame rate late in
	--            a long flight -- the step fell below the float32 resolution of
	--            an accumulating seconds counter and quantised to zero.
	--   * big  : the flight was reset the other way, or the sim just caught up.
	-- frame_rate_period is the sim's own time step for this frame and does not
	-- accumulate, so it has neither problem.
	if passed <= 0 or passed > FLT_MAX_STEP then
		passed = get(frame_period)
		if passed == nil or passed <= 0 then passed = CLAMP end
	end

	if passed > CLAMP then passed = CLAMP end

	set(frame_time, passed)

	flt_last = flt_now

end
