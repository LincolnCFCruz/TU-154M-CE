-- Great-circle helpers for rsbn_logic.lua, which include()s this file.

-- distance by coords in degrees
function calc_range(lat1, lon1, lat2, lon2)

	lat1 = math.rad(lat1)
	lon1 = math.rad(lon1)
	lat2 = math.rad(lat2)
	lon2 = math.rad(lon2)


	local d = math.acos(math.sin(lat1) * math.sin(lat2) + math.cos(lat1) * math.cos(lat2) * math.cos(lon1-lon2))
	return math.abs(math.deg(d) * 60), math.abs(d) -- in nm and radians
end

-- true course by coords in deg
function calc_true_course(lat1, lon1, lat2, lon2, dist)
	-- dist must be in miles
	local tc = 0
	local foo, d = 0, 1

	if dist == nil then
		foo, d = calc_range(lat1, lon1, lat2, lon2)
	else d = math.rad(dist / 60)
	end

	d = math.abs(d)

	if d < 0.00001 then return 0 end


	if lat1 > 89.9 then tc = math.pi
	elseif lat1 < -89.9 then tc = 0
	elseif math.sin(math.rad(lon2-lon1)) > 0 then
		tc = math.acos((math.sin(math.rad(lat2)) - math.sin(math.rad(lat1)) * math.cos(d)) / (math.sin(d) * math.cos(math.rad(lat1))))
	else
		tc = 2 * math.pi - math.acos((math.sin(math.rad(lat2)) - math.sin(math.rad(lat1)) * math.cos(d)) / (math.sin(d) * math.cos(math.rad(lat1))))
	end

	tc = math.deg(tc)

	while tc > 180 do tc = tc - 360 end
	while tc < -180 do tc = tc + 360 end

	return tc -- return degrees

end
