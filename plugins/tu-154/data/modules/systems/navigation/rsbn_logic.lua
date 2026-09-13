

-- controls
defineProperty("rsbn_control_strobe", globalPropertyi("tu-154/buttons/ovhd/rsbn_control_strobe")) -- RSBN strobe test
defineProperty("rsbn_control_azimuth", globalPropertyi("tu-154/buttons/ovhd/rsbn_control_azimuth")) -- RSBN azimuth zero test
defineProperty("rsbn_control_distance", globalPropertyi("tu-154/buttons/ovhd/rsbn_control_distance")) -- RSBN range zero test

defineProperty("rsbn_ch_ten", globalPropertyi("tu-154/buttons/ovhd/rsbn_ch_ten")) -- channel tens setting
defineProperty("rsbn_ch_one", globalPropertyi("tu-154/buttons/ovhd/rsbn_ch_one")) -- channel units setting

defineProperty("rsbn_on", globalPropertyi("tu-154/switchers/ovhd/rsbn_on")) -- RSBN power
defineProperty("rsbn_recon", globalPropertyi("tu-154/switchers/ovhd/rsbn_recon")) -- RSBN identification

-- sources
defineProperty("latitude", globalPropertyd("sim/flightmodel/position/latitude")) -- real latitude position
defineProperty("longitude", globalPropertyd("sim/flightmodel/position/longitude")) -- The longitude of the aircraft
defineProperty("elevation", globalPropertyd("sim/flightmodel/position/elevation")) -- The longitude of the aircraft

defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

-- power
defineProperty("bus27_volt_left", globalPropertyf("tu-154/elec/bus27_volt_left"))
defineProperty("bus115_1_volt", globalPropertyf("tu-154/elec/bus115_1_volt"))
defineProperty("rsbn_cc", globalPropertyf("tu-154/radio/rsbn_cc")) -- current draw from the RSBN

-- failures
defineProperty("rsbn_fail", globalPropertyi("tu-154/failures/rsbn_fail")) -- RSBN failure


-- results
defineProperty("distance", globalPropertyf("tu-154/rsbn/distance")) -- slant range from the beacon
defineProperty("azimuth", globalPropertyf("tu-154/rsbn/azimuth")) -- azimuth from the beacon


include("nav_funcs.lua")


local nav_table = {}
local work_table = {}
local channel_set = 0

local table_read_timer = 0


function read_nav_dat()
	-- RSBN beacon database. Lives with the plugin, not at the aircraft root:
	-- pluginDataDir.."/modules/databases/" is the An-24RV-CE convention.
	-- cis.dat sits beside it -- the same beacons under their post-Soviet names,
	-- unreferenced here (the An-24 switches between the two; this aircraft has
	-- never had that control).
	local file_name = pluginDataDir.."/modules/databases/rsbn.dat"
	
	local file = io.open(file_name, "r")
	
	
	if file then
		nav_table = {}
		
		while true do
			local line = file:read("*line")
			if line == nil then break end
			local a = 1
			local b = string.find(line, "|", a) -- find a vertical line
			
			if b ~= nil then
				
				local channel = tonumber(string.sub(line, a, b-1))
				a = b+1
				b = string.find(line, "|", b+1)
				
				local name = string.sub(line, a, b-1)
				a = b+1
				b = string.find(line, "|", b+1)
				
				local code = string.sub(line, a, b-1)
				a = b+1
				b = string.find(line, "|", b+1)
				
				local freq = tonumber(string.sub(line, a, b-1))
				a = b+1
				b = string.find(line, "|", b+1)
				
				local lat = tonumber(string.sub(line, a, b-1))
				a = b+1
				b = string.find(line, "|", b+1)
				
				local long = tonumber(string.sub(line, a, b-1))
				a = b+1
				b = string.find(line, "|", b+1)
				
				local elev = tonumber(string.sub(line, a))
				
				
				table.insert(nav_table, {["chan"] = channel, ["lat"] = lat, ["lon"] = long, ["elev"] = elev, ["icao"] = code, ["name"] = name})
				
				
			end
			
		end	
		print("rsbn.dat read OK")
		
		file:close()
	else print("can't read rsbn.dat")
	end
	
end

read_nav_dat() -- read the nav base once

local chan_last = 0
local function chan_select()
	channel_set = get(rsbn_ch_ten) * 10 + get(rsbn_ch_one)
	
	if channel_set ~= chan_last and table.maxn(nav_table) > 0 then
		work_table = {}
		table_read_timer = 0
		for k, m in pairs (nav_table) do
			if m["chan"] == channel_set then
				table.insert(work_table, {["chan"] = m["chan"], ["name"] = m["name"], ["lat"] = m["lat"], ["lon"] = m["lon"], ["elev"] = m["elev"]})
			end
		end
	end
	
	chan_last = channel_set

end

local function get_nearest()

	local plane_lat = get(latitude)
	local plane_lon = get(longitude)
	
	local dist = 21600 -- nm
	local res_lat = 0
	local res_lon = 0
	local res_name = ""
	local res_elev = 0
	
	for k, m in pairs (work_table) do
		local b_lat = m["lat"]
		local b_lon = m["lon"]
		
		local b_dist, rad_dist = calc_range(b_lat, b_lon, plane_lat, plane_lon)
		
		if b_dist < dist then 
			dist = b_dist 
			res_lat = b_lat
			res_lon = b_lon
			res_name = m["name"]
			res_elev = m["elev"]
		end
	
	
	end	
	
	return dist, res_lat, res_lon, res_elev, res_name


end


local beacon_dist = 0 -- nm
local beacon_lat = 0
local beacon_lon = 0
local beacon_name = "none"
local beacon_azimuth = 0
local beacon_elevation = 0

local dist_show = 0
local azimuth_show = 0


function update()
	local passed = get(frame_time)
	local plane_lat = get(latitude)
	local plane_lon = get(longitude)
	local plane_elev = get(elevation)
	local power = get(rsbn_on) == 1 and get(bus27_volt_left) > 13 and get(bus115_1_volt) > 110 and get(rsbn_fail) == 0
	
	set(rsbn_cc, bool2int(power))
	
	if power then chan_select() end -- select beacons with given channel
	
	
	if table_read_timer == 0 and table.maxn(work_table) > 0 and power then -- get parameters of the nearest beacon
		beacon_dist, beacon_lat, beacon_lon, beacon_elevation, beacon_name = get_nearest()	
		
	elseif table.maxn(work_table) == 0 or not power then
		beacon_dist, beacon_lat, beacon_lon, beacon_elevation, beacon_name = 0, 0, 0, 0, "none"
	end
	
	-- calculate distance and azimuth
	if beacon_name ~= "none" then
		beacon_dist = calc_range(beacon_lat, beacon_lon, plane_lat, plane_lon) -- in nm
		beacon_azimuth = calc_true_course(beacon_lat, beacon_lon, plane_lat, plane_lon, beacon_dist)
	end
	
	-- correct distance with altitude
	local res_distance = 0
	if beacon_name ~= "none" then
		res_distance = math.sqrt((beacon_dist * 1852)^2 + (plane_elev - beacon_elevation)^2) -- distance in meters
	end
	
	-- cut off indication if beacon is out of reach
	local dist_limit = 4120 * (math.sqrt(math.max(plane_elev, 0)) + math.sqrt(math.max(beacon_elevation, 0))) + 20000 -- distance limit in meters
	
	if beacon_dist * 1852 < math.abs(plane_elev - beacon_elevation) or res_distance > dist_limit then 
		res_distance = 0
		beacon_azimuth = 0
	end
	
	-- test values
	if power and get(rsbn_control_azimuth) == 1 then
		beacon_azimuth = 1 -- degree
	end
	
	if power and get(rsbn_control_distance) == 1 then
		res_distance = 2000 -- m
	end
	
	
	table_read_timer = table_read_timer + passed
	
	if table_read_timer > 1 then table_read_timer = 0 end
	
	if res_distance ~= 0 and res_distance then dist_show = res_distance end
	if beacon_azimuth ~= 0 and beacon_azimuth then azimuth_show = beacon_azimuth end
	
	
	set(distance, dist_show * 0.001)
	set(azimuth, azimuth_show)
	
	
end

