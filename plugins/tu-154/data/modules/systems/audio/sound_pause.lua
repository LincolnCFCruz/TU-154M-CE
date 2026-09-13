-- Holds the looping samples while the sim is paused (frame_time == 0): neither
-- SASL3 nor X-Plane stops them. The mechanism is in core/glbl_func.lua; this is
-- the per-frame driver, last in main.lua's table so it sees what the frame
-- played. One-shots (switch clicks, callouts) still play while paused.

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- Bound once, through rawget: calling an undefined global makes SASL3 try to
-- load it as a COMPONENT (see the trap list in CLAUDE.md), so if glbl_func.lua
-- did not install the wrappers this module must go quiet rather than error
-- every frame.
local setSoundPaused = rawget(_G, "setSoundPaused")

if not setSoundPaused then
	logWarning("glbl_func.lua did not install the sound wrappers -- looping samples will play through a pause")
end

function update()
	-- frame_time == 0 is how systems/cockpit/time_logic.lua signals "the
	-- simulation is not advancing". setSoundPaused() is idempotent, so this
	-- only does work on the two transition frames.
	if setSoundPaused then
		setSoundPaused(get(frame_time) == 0)
	end
end
