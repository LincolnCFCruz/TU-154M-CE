
-- sim variables
defineProperty("sim_engine_on_fire1", globalPropertyi("sim/operation/failures/rel_engfir0"))  -- left engine on fire
defineProperty("sim_engine_on_fire2", globalPropertyi("sim/operation/failures/rel_engfir1"))  -- mid engine on fire
defineProperty("sim_engine_on_fire3", globalPropertyi("sim/operation/failures/rel_engfir2"))  -- right engine on fire


defineProperty("sim_engine_ext1", globalProperty("sim/cockpit2/engine/actuators/fire_extinguisher_on[0]"))  -- left engine fire extinguiher
defineProperty("sim_engine_ext2", globalProperty("sim/cockpit2/engine/actuators/fire_extinguisher_on[1]"))  -- mid engine fire extinguiher
defineProperty("sim_engine_ext3", globalProperty("sim/cockpit2/engine/actuators/fire_extinguisher_on[2]"))  -- right engine fire extinguiher

-- controls
defineProperty("lamp_test", globalPropertyi("tu-154/buttons/lamp_test_fire_panel")) -- lamp test button on the fire panel	0
defineProperty("smoke_test", globalPropertyi("tu-154/buttons/eng/smoke_test")) -- smoke detector test
defineProperty("ext_test", globalPropertyi("tu-154/buttons/eng/ext_test")) -- fire extinguisher test


defineProperty("fire_ext_1", globalPropertyi("tu-154/buttons/eng/fire_ext_1")) -- fire extinguishing sequence
defineProperty("fire_ext_2", globalPropertyi("tu-154/buttons/eng/fire_ext_2")) -- fire extinguishing sequence
defineProperty("fire_ext_3", globalPropertyi("tu-154/buttons/eng/fire_ext_3")) -- fire extinguishing sequence
defineProperty("cold_eng_1", globalPropertyi("tu-154/buttons/eng/cold_eng_1")) -- halon discharge
defineProperty("cold_eng_2", globalPropertyi("tu-154/buttons/eng/cold_eng_2")) -- halon discharge
defineProperty("cold_eng_3", globalPropertyi("tu-154/buttons/eng/cold_eng_3")) -- halon discharge
defineProperty("cold_apu", globalPropertyi("tu-154/buttons/eng/cold_apu")) -- halon discharge
defineProperty("neutral_gas", globalPropertyi("tu-154/buttons/eng/neutral_gas")) -- neutral gas

defineProperty("fire_sensor_sel", globalPropertyi("tu-154/switchers/eng/fire_sensor_sel")) -- sensor group selection
defineProperty("fire_place_sel", globalPropertyi("tu-154/switchers/eng/fire_place_sel")) -- compartment selection

defineProperty("fire_main_switch", globalPropertyi("tu-154/switchers/eng/fire_main_switch")) -- fire system switch
defineProperty("fire_buzzer", globalPropertyi("tu-154/switchers/eng/fire_buzzer")) -- fire siren

-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu-154/elec/bus27_volt_right"))

defineProperty("fire_sys_cc", globalPropertyf("tu-154/fire/fire_sys_cc")) -- fire system current draw



-- results
defineProperty("ext_used_1", globalPropertyi("tu-154/fire/ext_used_1")) -- extinguisher used
defineProperty("ext_used_2", globalPropertyi("tu-154/fire/ext_used_2")) -- extinguisher used
defineProperty("ext_used_3", globalPropertyi("tu-154/fire/ext_used_3")) -- extinguisher used

defineProperty("ng_used", globalPropertyi("tu-154/fire/ng_used")) -- neutral gas used

defineProperty("valve_open_1", globalPropertyi("tu-154/fire/valve_open_1")) -- engine 1 extinguishing valve
defineProperty("valve_open_2", globalPropertyi("tu-154/fire/valve_open_2")) -- engine 2 extinguishing valve
defineProperty("valve_open_3", globalPropertyi("tu-154/fire/valve_open_3")) -- engine 3 extinguishing valve
defineProperty("valve_open_4", globalPropertyi("tu-154/fire/valve_open_4")) -- APU extinguishing valve

defineProperty("engine_fire_state_1", globalPropertyi("tu-154/fire/engine_fire_state_1")) -- engine state. 0 = normal, 1 = overheat, 2 = fire
defineProperty("engine_fire_state_2", globalPropertyi("tu-154/fire/engine_fire_state_2")) -- engine state. 0 = normal, 1 = overheat, 2 = fire
defineProperty("engine_fire_state_3", globalPropertyi("tu-154/fire/engine_fire_state_3")) -- engine state. 0 = normal, 1 = overheat, 2 = fire
defineProperty("engine_fire_state_4", globalPropertyi("tu-154/fire/engine_fire_state_4")) -- APU state. 0 - normal, 1 - overheat, 2 - fire

defineProperty("fire_detected", globalPropertyi("tu-154/fire/fire_detected")) -- fire detected

defineProperty("fire_siren", globalPropertyi("tu-154/fire/fire_siren")) -- siren running



defineProperty("fire_vlv_open_1", globalPropertyf("tu-154/fuel/fire_vlv_open_1")) -- fire shutoff valve open
defineProperty("fire_vlv_open_2", globalPropertyf("tu-154/fuel/fire_vlv_open_2")) -- fire shutoff valve open
defineProperty("fire_vlv_open_3", globalPropertyf("tu-154/fuel/fire_vlv_open_3")) -- fire shutoff valve open


-- start hot-start protection: inputs (see the HS block further down)
defineProperty("hs_egt_1", globalProperty("sim/cockpit2/engine/indicators/EGT_deg_cel[0]")) -- raw gas temp, not the gauge
defineProperty("hs_egt_2", globalProperty("sim/cockpit2/engine/indicators/EGT_deg_cel[1]"))
defineProperty("hs_egt_3", globalProperty("sim/cockpit2/engine/indicators/EGT_deg_cel[2]"))

defineProperty("hs_burn_1", globalProperty("sim/flightmodel2/engines/engine_is_burning_fuel[0]"))
defineProperty("hs_burn_2", globalProperty("sim/flightmodel2/engines/engine_is_burning_fuel[1]"))
defineProperty("hs_burn_3", globalProperty("sim/flightmodel2/engines/engine_is_burning_fuel[2]"))

defineProperty("hs_n2_1", globalPropertyf("tu-154/gauges/engine/rpm_high_1")) -- displayed %, idle is 59.5...61.5
defineProperty("hs_n2_2", globalPropertyf("tu-154/gauges/engine/rpm_high_2"))
defineProperty("hs_n2_3", globalPropertyf("tu-154/gauges/engine/rpm_high_3"))

defineProperty("hs_apd_1", globalPropertyf("tu-154/start/apd_working_1")) -- start panel driving this engine
defineProperty("hs_apd_2", globalPropertyf("tu-154/start/apd_working_2"))
defineProperty("hs_apd_3", globalPropertyf("tu-154/start/apd_working_3"))

defineProperty("hs_time", globalPropertyf("tu-154/time/frame_time"))

-- start hot-start protection: output, consumed by engine_gauges.lua
defineProperty("hs_hot_1", globalPropertyf("tu-154/engine/hotstart_1")) -- severity 0..1, slows the spool
defineProperty("hs_hot_2", globalPropertyf("tu-154/engine/hotstart_2"))
defineProperty("hs_hot_3", globalPropertyf("tu-154/engine/hotstart_3"))

-- published for the Fire diagram; nothing else reads them and nothing here
-- changes as a result (see CLAUDE.md 12, "prefer publishing over inferring")
defineProperty("hs_clock_1", globalPropertyf("tu-154/fire/hotstart_timer_1"))
defineProperty("hs_clock_2", globalPropertyf("tu-154/fire/hotstart_timer_2"))
defineProperty("hs_clock_3", globalPropertyf("tu-154/fire/hotstart_timer_3"))





-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control




local valve_1 = get(valve_open_1)
local valve_2 = get(valve_open_2)
local valve_3 = get(valve_open_3)
local valve_4 = get(valve_open_4)

local valves_open = 0 -- open valves counter


-- ---------------------------------------------------------------------------
-- Start hot-start protection (550 C / 15 s, sim-calibrated)
--
-- Both manuals give a 550 C / 4 s limit in almost the same words: during a
-- start the gas temperature behind the turbine must not be allowed to exceed
-- 550 C, and running at 550 C is permitted for no more than 4 s.
--   RLE Book 2, section 8.1.2, start checklist item (g), p.8.1.8.1
--   D-30KU-154 RE 59-00-800RE, 072.00.00 p.32, VNIMANIE note
--
-- [CAL-HOTSTART] The 4 s figure is the real D-30KU-154's number, not
-- X-Plane's. Evgeniy tested the 4 s version on 2026-09-09: even after the
-- consecutive-time fix above, EVERY normal start still tripped overheat,
-- meaning this add-on's simulated EGT genuinely sits continuously above
-- 550 C for more than 4 s during an ordinary start -- X-Plane's simplified
-- turbine model runs a hotter/longer light-off than the real engine (a raw
-- EGT peak of ~1910 C was measured, vs. the 800 C ceiling the cockpit gauge
-- itself is capped to), so the real engine's 4 s allowance is too tight for
-- it. Raised to 15 s as a sim-side calibration, not a manual figure.
-- Confirmed clean on 2026-09-09 with diagnostic prints: all three engines,
-- longest continuous streak above 550 C was 7.7 s, none tripped -- good
-- margin under 15 s. The diagnostic prints have been removed now that this
-- is calibrated; re-add them (see fire_logic_changelog.txt for the snippet)
-- if a false trip or a missed one ever needs re-diagnosing.
--
-- Why this lives in fire_logic.lua: engine_fire_state_N is written every frame
-- further down (fire -> 2, otherwise -> 0), so a writer in any other module
-- would simply be overwritten. State 1 "overheat" is declared in
-- dataref_creator_2.lua, rendered by fire_panel.lua and mapped by the debug
-- inspector, but until now nothing ever produced it - a hot start is what it
-- is for, so detection and annunciation both belong here.
--
-- The severity written to tu-154/engine/hotstart_N is already consumed by
-- engine_gauges.lua, which slows the spool-up in proportion to it. That
-- dataref was created with the comment "No writer yet"; this is the writer.
-- ---------------------------------------------------------------------------
local HOT_EGT    = 550  -- C, the documented ceiling
local HOT_ALLOW  = 15   -- s continuously at or above it (sim-calibrated, see CAL-HOTSTART above; manual figure is 4 s)
local HOT_FULL   = 4    -- further s above HOT_ALLOW for severity to reach a full 1.0
local HOT_IDLE   = 58   -- displayed N2 %; below this the start is still running
local HOT_STOPPED = 5   -- displayed N2 %; below this the engine has stopped

local HS = {
	timer = { 0, 0, 0 },              -- s accumulated above HOT_EGT this start
	sev   = { 0, 0, 0 },              -- 0..1 severity handed to engine_gauges
	trip  = { false, false, false },  -- latched until the engine is shut down
}


set(sim_engine_ext1, 0)
set(sim_engine_ext2, 0)
set(sim_engine_ext3, 0)


function update()

local MASTER = get(ismaster) ~= 1	
	

if MASTER then	



	local power27L = get(bus27_volt_left) > 13
	local power27R = get(bus27_volt_right) > 13

	-- ---- start hot-start tracking (see the HS block above) ----------------
	-- Deliberately outside the powered branch below: an engine cooks whether or
	-- not the fire panel happens to be switched on. Only the annunciation of it
	-- is gated on power, further down, like the rest of the fire indication.
	local hs_passed = get(hs_time)
	local hs_egt  = { get(hs_egt_1),  get(hs_egt_2),  get(hs_egt_3)  }
	local hs_n2   = { get(hs_n2_1),   get(hs_n2_2),   get(hs_n2_3)   }
	local hs_burn = { get(hs_burn_1), get(hs_burn_2), get(hs_burn_3) }
	local hs_apd  = { get(hs_apd_1),  get(hs_apd_2),  get(hs_apd_3)  }

	for i = 1, 3 do
		-- "during a start" = the start panel is still driving this engine, or
		-- it is lit but has not yet reached idle. Covers in-flight starts too,
		-- which the same RLE section applies the same limit to.
		local starting = hs_apd[i] > 0 or (hs_burn[i] > 0 and hs_n2[i] < HOT_IDLE)

		-- [FIX-HOTSTART] Both manuals limit CONSECUTIVE time above 550 C to 4 s
		-- ("running at 550 C is permitted for no more than 4 s") -- a continuous
		-- excursion, not a running total across the whole start. The raw sim EGT
		-- is noisy during light-off and dips below 550 C between spikes; without
		-- a reset here, those scattered sub-threshold gaps never cleared the
		-- timer, so unrelated brief excursions kept adding up over a normal
		-- 20-40 s start and tripped "overheat" on essentially every engine,
		-- every time -- reported by Evgeniy Gimaev on 2026-09-08 as every start,
		-- even all three, tripping overheat. The else-branch below is the fix:
		-- dropping under 550 C now clears the timer, exactly like dropping out
		-- of "starting" already did.
		if starting then
			if hs_egt[i] > HOT_EGT then
				HS.timer[i] = HS.timer[i] + hs_passed
			else
				HS.timer[i] = 0
			end
		else
			HS.timer[i] = 0
		end

		if HS.timer[i] > HOT_ALLOW then
			HS.trip[i] = true
			local s = (HS.timer[i] - HOT_ALLOW) / HOT_FULL
			if s > 1 then s = 1 end
			if s > HS.sev[i] then HS.sev[i] = s end -- severity only worsens
		end

		-- A completed shutdown clears the latch, so the next start is clean.
		-- The manuals forbid restarting after an overheat without finding the
		-- cause first, but modelling that is the crew's business, not ours.
		if hs_burn[i] == 0 and hs_n2[i] < HOT_STOPPED then
			HS.timer[i] = 0
			HS.sev[i]   = 0
			HS.trip[i]  = false
		end
	end

	set(hs_hot_1, HS.sev[1])
	set(hs_hot_2, HS.sev[2])
	set(hs_hot_3, HS.sev[3])
	set(hs_clock_1, HS.timer[1])
	set(hs_clock_2, HS.timer[2])
	set(hs_clock_3, HS.timer[3])

	if power27L and get(fire_main_switch) == 1 then
		
		-- set destination manually
		if get(cold_eng_1) == 1 then valve_1 = 1 end
		if get(cold_eng_2) == 1 then valve_2 = 1 end
		if get(cold_eng_3) == 1 then valve_3 = 1 end
		if get(cold_apu) == 1 then valve_4 = 1 end
		
		-- set destination automatically
		local fire_1 = get(sim_engine_on_fire1) == 6
		local fire_2 = get(sim_engine_on_fire2) == 6
		local fire_3 = get(sim_engine_on_fire3) == 6
		
		if fire_1 then valve_1 = 1 end
		if fire_2 then valve_2 = 1 end
		if fire_3 then valve_3 = 1 end
		
		-- use neutral gas
		if get(neutral_gas) == 1 then set(ng_used, 1) end
		
		-- extinguishers work
		valves_open = valve_1 + valve_2 + valve_3 + valve_4
		
		local ext_1_ready = get(ext_used_1) == 0
		local ext_2_ready = get(ext_used_2) == 0
		local ext_3_ready = get(ext_used_3) == 0
		
		local fire_1_but = get(fire_ext_1) == 1
		local fire_2_but = get(fire_ext_2) == 1
		local fire_3_but = get(fire_ext_3) == 1
		
		-- engine 1
		if valve_1 == 1 then
			if ext_1_ready and (get(fire_vlv_open_1) < 0.5 or fire_1_but)then -- automatically use ext 1 or by button
				set(ext_used_1, 1) -- use extinguisher
				set(sim_engine_ext1, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire1, 0) -- remove fire fail
				end
			end
			
			if ext_2_ready and fire_2_but then -- use ext 2
				set(ext_used_2, 1) -- use extinguisher
				set(sim_engine_ext1, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire1, 0) -- remove fire fail
				end
			end

			if ext_3_ready and fire_3_but then -- use ext 3
				set(ext_used_3, 1) -- use extinguisher
				set(sim_engine_ext1, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire1, 0) -- remove fire fail
				end
			end
			
		end


		-- engine 2
		if valve_2 == 1 then
			if ext_1_ready and (get(fire_vlv_open_2) < 0.5 or fire_1_but)then -- automatically use ext 1 or by button
				set(ext_used_1, 1) -- use extinguisher
				set(sim_engine_ext2, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire2, 0) -- remove fire fail
				end
			end
			
			if ext_2_ready and fire_2_but then -- use ext 2
				set(ext_used_2, 1) -- use extinguisher
				set(sim_engine_ext2, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire2, 0) -- remove fire fail
				end
			end

			if ext_3_ready and fire_3_but then -- use ext 3
				set(ext_used_3, 1) -- use extinguisher
				set(sim_engine_ext2, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire2, 0) -- remove fire fail
				end
			end
			
		end		

		
		-- engine 3
		if valve_3 == 1 then
			if ext_1_ready and (get(fire_vlv_open_3) < 0.5 or fire_1_but)then -- automatically use ext 1 or by button
				set(ext_used_1, 1) -- use extinguisher
				set(sim_engine_ext3, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire3, 0) -- remove fire fail
				end
			end
			
			if ext_2_ready and fire_2_but then -- use ext 2
				set(ext_used_2, 1) -- use extinguisher
				set(sim_engine_ext3, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire3, 0) -- remove fire fail
				end
			end

			if ext_3_ready and fire_3_but then -- use ext 3
				set(ext_used_3, 1) -- use extinguisher
				set(sim_engine_ext3, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire3, 0) -- remove fire fail
				end
			end
			
		end	
		
		-- same way for APU
		
		
		
		-- fire siren
		if fire_1 or fire_2 or fire_3 or get(smoke_test) == 1 then
			set(fire_detected, 1)
			set(fire_siren, get(fire_buzzer))
		
		else
			set(fire_detected, 0)
			set(fire_siren, 0)
		end
		
		-- 2 = fire, 1 = overheat (hot start, latched), 0 = normal.
		-- Fire keeps priority; with no hot start this is bit-for-bit the old
		-- behaviour, so nothing changes on an engine that starts cleanly.
		if fire_1 then set(engine_fire_state_1, 2)
		elseif HS.trip[1] then set(engine_fire_state_1, 1)
		else set(engine_fire_state_1, 0) end

		if fire_2 then set(engine_fire_state_2, 2)
		elseif HS.trip[2] then set(engine_fire_state_2, 1)
		else set(engine_fire_state_2, 0) end

		if fire_3 then set(engine_fire_state_3, 2)
		elseif HS.trip[3] then set(engine_fire_state_3, 1)
		else set(engine_fire_state_3, 0) end
		
		--[[if fire_4 then set(engine_fire_state_4, 2)
		else set(engine_fire_state_4, 0) end--]]
		
		set(fire_sys_cc, 0.8)
	else
		-- reset valves state
		valve_1 = 0
		valve_2 = 0
		valve_3 = 0
		valve_4 = 0
		
		valves_open = 0
		
		set(fire_detected, 0)
		set(fire_siren, 0)	
		
		set(engine_fire_state_1, 0)
		set(engine_fire_state_2, 0)
		set(engine_fire_state_3, 0)
		set(engine_fire_state_4, 0)
		
		set(fire_sys_cc, 0)
	end
	
	



	set(valve_open_1, valve_1)
	set(valve_open_2, valve_2)
	set(valve_open_3, valve_3)
	set(valve_open_4, valve_4)

end

end