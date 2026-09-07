-- Holds the looping samples while the sim is paused.
--
-- SASL3 does not stop its own samples when X-Plane pauses, and neither does
-- X-Plane. Every system module freezes as soon as tu-154/time/frame_time is 0,
-- so without this the engine and cabin loops were the only part of the aircraft
-- still running on the pause screen -- frozen at whatever pitch and gain they
-- happened to have.
--
-- The mechanism is in core/glbl_func.lua (it has to be installed before any
-- module body runs, because several of them call playSample at load time).
-- This component is only the per-frame driver, and it is registered LAST in
-- main.lua's components table so that it observes what the frame produced
-- before acting on it.
--
-- Only looping samples are held; the one-shots -- switch clicks, crew callouts
-- -- still play, so the cockpit stays usable while paused. See the note in
-- glbl_func.lua and CLAUDE.md "Time base".
--
-- Commenting this out of main.lua restores the old always-playing behaviour;
-- nothing else depends on it.

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- Bound once, through rawget: calling an undefined global makes SASL3 try to
-- load it as a COMPONENT (see the trap list in CLAUDE.md), so if glbl_func.lua
-- did not install the wrappers this module must go quiet rather than error
-- every frame.
local setSoundPaused = rawget(_G, "setSoundPaused")

if not setSoundPaused then
	print("sound_pause: glbl_func.lua did not install the sound wrappers -- looping samples will play through a pause")
end

function update()
	-- frame_time == 0 is how systems/cockpit/time_logic.lua signals "the
	-- simulation is not advancing". setSoundPaused() is idempotent, so this
	-- only does work on the two transition frames.
	if setSoundPaused then
		setSoundPaused(get(frame_time) == 0)
	end
end
