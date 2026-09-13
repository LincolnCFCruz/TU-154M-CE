-- Ground power unit: Hobart 60 kVA / 150 A.
defineProperty("gpu_present", globalPropertyi("tu-154/anim/gpu_present"))
defineProperty("gpu_work_anim", globalPropertyf("tu-154/anim/gpu_work"))
defineProperty("gpu_volt", globalPropertyf("tu-154/elec/gpu_volt"))
defineProperty("gpu_amp", globalPropertyf("tu-154/elec/gpu_amp"))
defineProperty("gpu_overload", globalPropertyi("tu-154/elec/gpu_overload"))
defineProperty("gpu_on", globalPropertyi("tu-154/switchers/eng/gpu_on")) -- RAP switch

defineProperty("gpu_work_bus", globalPropertyi("tu-154/elec/gpu_work"))

-- bus 27v
defineProperty("DC_27_volt1", globalPropertyf("tu-154/elec/bus27_volt_left")) -- 27 volt
defineProperty("DC_27_volt2", globalPropertyf("tu-154/elec/bus27_volt_right")) -- 27 volt

-- sim
defineProperty("GS", globalPropertyf("sim/flightmodel/position/groundspeed"))  -- ground speed
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- enviroment
defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external"))

-- coordinates of airplane and camera
defineProperty("local_x", globalPropertyf("sim/flightmodel/position/local_x")) -- position X
defineProperty("local_y", globalPropertyf("sim/flightmodel/position/local_y")) -- position Y
defineProperty("local_z", globalPropertyf("sim/flightmodel/position/local_z")) -- position Z

defineProperty("view_x", globalPropertyf("sim/graphics/view/view_x")) -- camera position X
defineProperty("view_y", globalPropertyf("sim/graphics/view/view_y")) -- camera position Y
defineProperty("view_z", globalPropertyf("sim/graphics/view/view_z")) -- camera position Z


-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control



local gpu_start_out = loadSample('sounds/gpu_start_out.wav')
local gpu_run_out = loadSample('sounds/gpu_run_out.wav')
local gpu_stop_out = loadSample('sounds/gpu_stop_out.wav')

local gpu_start_inn = loadSample('sounds/gpu_start_inn.wav')
local gpu_run_inn = loadSample('sounds/gpu_run_inn.wav')
local gpu_stop_inn = loadSample('sounds/gpu_stop_inn.wav')

local work_timer = 0
local last_dist = 0


local gpu_connect_timer = 0

local gpuSoundsLoaded = true

local gpu_eject_timer = 0


local function loadSounds()
	gpu_start_out = loadSample('sounds/gpu_start_out.wav')
	gpu_run_out = loadSample('sounds/gpu_run_out.wav')
	gpu_stop_out = loadSample('sounds/gpu_stop_out.wav')
	
	gpu_start_inn = loadSample('sounds/gpu_start_inn.wav')
	gpu_run_inn = loadSample('sounds/gpu_run_inn.wav')
	gpu_stop_inn = loadSample('sounds/gpu_stop_inn.wav')
	
	gpuSoundsLoaded = true
end

local function unloadSounds()
	unloadSample(gpu_start_out)
	unloadSample(gpu_run_out)
	unloadSample(gpu_stop_out)
	
	unloadSample(gpu_start_inn)
	unloadSample(gpu_run_inn)
	unloadSample(gpu_stop_inn)
	
	gpuSoundsLoaded = false
end

function update()
	local passed = get(frame_time)
	local external = get(external_view) -- 0 = inside, 1 = external
	
	-- check if GPU can be conected
	local present = get(gpu_present)
	if math.abs(get(GS)) > 0.1 then
		gpu_eject_timer = gpu_eject_timer + passed
	else
		gpu_eject_timer = 0
	end
	
	
	if gpu_eject_timer < 1 then
	
		if present == 1 then 
			work_timer = work_timer + passed * 0.25 -- 3 sec for start
		else 
			work_timer = work_timer - passed * 0.1 -- 10 sec for stop
			set(gpu_overload, 0) -- reset overload flag
		end
		-- set limits and working parameters
		if work_timer > 1 then 
			work_timer = 1
			if get(DC_27_volt1) > 13 or get(DC_27_volt2) > 13 then 
				set(gpu_volt, 115 * (1 - get(gpu_overload)))
			else
				set(gpu_volt, 0)
			end
		elseif work_timer < 0 then 
			work_timer = 0
			set(gpu_volt, 0)
		elseif work_timer < 0.9 then 
			set(gpu_volt, 0)
		end
		set(gpu_work_anim, work_timer) -- set animation
		
		-- connect GPU to the bus
		if get(gpu_on) == 1 then 
			gpu_connect_timer = gpu_connect_timer + passed
			if gpu_connect_timer >= 1 then
				if work_timer == 1 and get(gpu_overload) ~= 1 then set(gpu_work_bus, 1) 
				else set(gpu_work_bus, 0) end
				gpu_connect_timer = 1
			else
				set(gpu_work_bus, 0) 
			end
			
			
		else 
			set(gpu_work_bus, 0) 
			gpu_connect_timer = 0
			
		end
		
		
		
		
		-- set overload flag and reset it when GPU is disconnected
		if get(gpu_amp) > 500 then set(gpu_overload, 1)
		elseif get(gpu_on) == 0 then set(gpu_overload, 0) end


		-- set sounds
		if work_timer > 0 and work_timer < 1 and not isSamplePlaying(gpu_start_out) and present == 1 then
			playSample(gpu_start_out, false)
			playSample(gpu_start_inn, false)
			stopSample(gpu_run_out)
			stopSample(gpu_run_inn)
		elseif work_timer == 1 and not isSamplePlaying(gpu_run_out) then
			playSample(gpu_run_out, true)
			playSample(gpu_run_inn, true)
		elseif work_timer > 0 and work_timer < 1 and not isSamplePlaying(gpu_stop_out) and present == 0 then
			playSample(gpu_stop_out, false)
			playSample(gpu_stop_inn, false)
			stopSample(gpu_start_out)
			stopSample(gpu_run_out)
			stopSample(gpu_start_inn)
			stopSample(gpu_run_inn)
		elseif work_timer == 0 then
			stopSample(gpu_start_out)
			stopSample(gpu_start_inn)
			stopSample(gpu_run_out)
			stopSample(gpu_run_inn)
		end
		
		-- set effects to external GPU sound
		local camera_distance = math.sqrt(((get(view_x)-get(local_x))^2)+((get(view_y)-get(local_y))^2)+((get(view_z)-get(local_z))^2)) -- in meters
		if camera_distance < 1 then camera_distance = 1 end -- limit minimum distance
		
		local dist_coef = 300 / camera_distance ^ 1.7
		if dist_coef > 1 then dist_coef = 1 end

		last_dist = camera_distance

		-- A Doppler coefficient used to be derived here from the camera closing
		-- speed, but nothing ever consumed it and the maths was wrong twice over:
		-- the divide-by-zero guard read math.min(0.0001, passed) instead of
		-- math.max, so it always divided by 0.0001 rather than the frame time,
		-- and the upper clamp tested > 400 but assigned 300. Removed; last_dist
		-- is kept so re-adding it is a one-liner.

		local window_open = 0 -- temp
		
		-- set sound volume
		setSampleGain(gpu_start_out, 1000 * (external + window_open * (1 - external)) * dist_coef)
		setSampleGain(gpu_run_out, 1000 * (external + window_open * (1 - external)) * dist_coef)
		setSampleGain(gpu_stop_out, 1000 * (external + window_open * (1 - external)) * dist_coef)

		setSampleGain(gpu_start_inn, 2000 * (1 - external))
		setSampleGain(gpu_run_inn, 2000 * (1 - external))
		setSampleGain(gpu_stop_inn, 2000 * (1 - external))
		--setSampleGain(prop_out_1, prop_loud_1 * (external + window_open * (1 - external)) * N1 * dist_coef) -- example
	
	else
		work_timer = 0
		
		set(gpu_work_anim, 0)
		set(gpu_present, 0)
		set(gpu_volt, 0)
		set(gpu_overload, 0)
		set(gpu_work_bus, 0)
		
		-- unload sounds
		stopSample(gpu_run_out)
		stopSample(gpu_start_out)
		stopSample(gpu_stop_out)
		
		--if gpuSoundsLoaded then unloadSounds() end
	end
	
	
end