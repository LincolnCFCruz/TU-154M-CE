
-- sources
defineProperty("absu_contr_pitch", globalPropertyf("tu-154/absu/contr_pitch")) -- RA-56 pitch actuator rod travel
defineProperty("absu_contr_roll", globalPropertyf("tu-154/absu/contr_roll")) -- RA-56 roll actuator rod travel
defineProperty("absu_contr_yaw", globalPropertyf("tu-154/absu/contr_yaw")) -- RA-56 yaw actuator rod travel


defineProperty("int_pitch_trim", globalPropertyf("tu-154/trimmers/int_pitch_trim")) -- elevator trim position

-- results
defineProperty("rudder_pos_ind", globalPropertyf("tu-154/gauges/misc/rudder_pos_ind")) -- rudder position indicator
defineProperty("aileron_pos_ind", globalPropertyf("tu-154/gauges/misc/aileron_pos_ind")) -- aileron position indicator
defineProperty("elevator_pos_ind", globalPropertyf("tu-154/gauges/misc/elevator_pos_ind")) -- elevator position indicator

defineProperty("absu_power_27", globalPropertyi("tu-154/absu_power_27"))

function update()
	local power=get(absu_power_27)
	set(rudder_pos_ind, get(absu_contr_yaw) / 0.4*power)
	set(aileron_pos_ind, get(absu_contr_roll) / 0.45*power)
	set(elevator_pos_ind, get(absu_contr_pitch) / 0.45*power)

	
end