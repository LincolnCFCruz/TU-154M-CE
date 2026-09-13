
-- system has 3 separate buses and 2 emergency buses
-- buses powered by generators of engines, APU, GPU

-- normal currents on busses are
-- bus 1 - 70
-- bus 2 - 0. if AI works - +130
-- bus 3 - 45. if galley and lights works - +60

-- 3 generators works - 3 main buses powered each by its own gen

-- 1 gen fail
-- gen 1 fail
-- bus 1 powered by gen 2. if AI is ON, by gen 3
-- bus 2 powered by gen 2
-- bus 3 powered by gen 3

-- gen 2 fail
-- bus 1 powered by gen 3
-- bus 2 powered by gen 1. if AI is ON, by gen 3
-- bus 3 powered by gen 3

-- gen 3 fail
-- bus 1 powered by gen 1
-- bus 2 powered by gen 2
-- bus 3 powered by gen 2. if AI is ON, by gen 1

-- 2 gens fail. galley and lights not work
-- remaining gen powers buses 1 and 3. bus 2 powered by APU.

-- 3 gens fail. galley and lights not work
-- buses 1 and 3 powered by APU.

-- EGT gauges can be powered from 115v or POS125
-- this logic better make insode EGT gauges
-- like:  (bus24_volt > 13 and pos125_on) or bus115_volt > 110


-- gen parameters
defineProperty("gen1_volt_bus", globalPropertyf("tu-154/elec/gen1_volt"))  -- generator voltage, initial 28.5v
defineProperty("gen2_volt_bus", globalPropertyf("tu-154/elec/gen2_volt"))
defineProperty("gen3_volt_bus", globalPropertyf("tu-154/elec/gen3_volt"))
defineProperty("gen4_volt_bus", globalPropertyf("tu-154/elec/gen4_volt"))
defineProperty("gpu_volt_bus", globalPropertyf("tu-154/elec/gpu_volt"))


defineProperty("gen1_work_bus", globalPropertyi("tu-154/elec/gen1_work"))  -- generators connected to the busses and working
defineProperty("gen2_work_bus", globalPropertyi("tu-154/elec/gen2_work"))
defineProperty("gen3_work_bus", globalPropertyi("tu-154/elec/gen3_work"))
defineProperty("gen4_work_bus", globalPropertyi("tu-154/elec/gen4_work"))
defineProperty("gpu_work_bus", globalPropertyi("tu-154/elec/gpu_work"))

-- bus parameters
defineProperty("bus115_1_volt", globalPropertyf("tu-154/elec/bus115_1_volt"))
defineProperty("bus115_2_volt", globalPropertyf("tu-154/elec/bus115_2_volt"))
defineProperty("bus115_3_volt", globalPropertyf("tu-154/elec/bus115_3_volt"))

defineProperty("bus115_em_1_volt", globalPropertyf("tu-154/elec/bus115_em_1_volt"))
defineProperty("bus115_em_2_volt", globalPropertyf("tu-154/elec/bus115_em_2_volt"))

defineProperty("bus115_1_amp", globalPropertyf("tu-154/elec/bus115_1_amp"))
defineProperty("bus115_2_amp", globalPropertyf("tu-154/elec/bus115_2_amp"))
defineProperty("bus115_3_amp", globalPropertyf("tu-154/elec/bus115_3_amp"))

defineProperty("bus115_em_1_amp", globalPropertyf("tu-154/elec/bus115_em_1_amp"))
defineProperty("bus115_em_2_amp", globalPropertyf("tu-154/elec/bus115_em_2_amp"))

-- which source the ladder below picked for each bus. 0 = none, 1 = GEN 1,
-- 2 = GEN 2, 3 = GEN 3, 4 = APU GEN, 5 = RAP. The ladder always knew this; it
-- just never published it, so nothing outside this file could tell a bus fed
-- by its own generator from one fed by a neighbour.
defineProperty("bus115_src_1", globalPropertyi("tu-154/elec/bus115_src_1"))
defineProperty("bus115_src_2", globalPropertyi("tu-154/elec/bus115_src_2"))
defineProperty("bus115_src_3", globalPropertyi("tu-154/elec/bus115_src_3"))

-- results
defineProperty("gen1_amp", globalPropertyf("tu-154/elec/gen1_amp"))
defineProperty("gen2_amp", globalPropertyf("tu-154/elec/gen2_amp"))
defineProperty("gen3_amp", globalPropertyf("tu-154/elec/gen3_amp"))
defineProperty("gen4_amp", globalPropertyf("tu-154/elec/gen4_amp"))
defineProperty("gpu_amp", globalPropertyf("tu-154/elec/gpu_amp"))

-- time
defineProperty("frame_time", globalPropertyf("tu-154/time/frame_time"))

function update()
	
	if get(frame_time) > 0 then
	
		-- voltages of busses
		local bus1_volt = 0
		local bus2_volt = 0
		local bus3_volt = 0
		
		local bus_em_1_volt = 0
		local bus_em_2_volt = 0

		-- the source each branch below selects, alongside the voltage it sets
		local src1 = 0
		local src2 = 0
		local src3 = 0

		-- currents on busses
		local bus1_amp = get(bus115_1_amp)
		local bus2_amp = get(bus115_2_amp)
		local bus3_amp = get(bus115_3_amp)
		
		local bus_em1_amp = get(bus115_em_1_amp)
		local bus_em2_amp = get(bus115_em_2_amp)
		
		-- generators parameters
		local gen1_work = get(gen1_work_bus) == 1
		local gen2_work = get(gen2_work_bus) == 1
		local gen3_work = get(gen3_work_bus) == 1
		local gen4_work = get(gen4_work_bus) == 1
		local gpu_work = get(gpu_work_bus) == 1
		
		local gen1_volt = get(gen1_volt_bus)
		local gen2_volt = get(gen2_volt_bus)
		local gen3_volt = get(gen3_volt_bus)
		local gen4_volt = get(gen4_volt_bus)
		local gpu_volt = get(gpu_volt_bus)
		
		-- set voltages and currents to buses according to working generators
		if gen1_work and gen2_work and gen3_work then -- all 3 gens work. APU and GPU doesn't matter
			bus1_volt = gen1_volt
			src1 = 1
			bus2_volt = gen2_volt
			src2 = 2
			bus3_volt = gen3_volt
			src3 = 3
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, bus1_amp)
			set(gen2_amp, bus2_amp)
			set(gen3_amp, bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, 0)
		elseif gen2_work and gen3_work then -- gen 2 and 3 works. APU and GPU doesn't matter
			bus1_volt = gen2_volt
			src1 = 2
			bus2_volt = gen2_volt
			src2 = 2
			bus3_volt = gen3_volt
			src3 = 3
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, 0)
			set(gen2_amp, bus2_amp + bus1_amp)
			set(gen3_amp, bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen1_work and gen3_work and gpu_work then -- gen 1 and 3 works. GPU works too. APU doesn't matter
			bus1_volt = gen1_volt
			src1 = 1
			bus2_volt = gpu_volt
			src2 = 5
			bus3_volt = gen3_volt
			src3 = 3
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, bus1_amp)
			set(gen2_amp, 0)
			set(gen3_amp, bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, bus2_amp)
		elseif gen1_work and gen3_work then -- gen 1 and 3 works. GPU disconnected. APU doesn't matter
			bus1_volt = gen1_volt
			src1 = 1
			bus2_volt = gen1_volt
			src2 = 1
			bus3_volt = gen3_volt
			src3 = 3
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, bus1_amp + bus2_amp)
			set(gen2_amp, 0)
			set(gen3_amp, bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen1_work and gen2_work  and gpu_work  then -- gen 1 and 2 works. GPU works too. APU doesn't matter
			bus1_volt = gen1_volt
			src1 = 1
			bus2_volt = gen2_volt
			src2 = 2
			bus3_volt = gpu_volt
			src3 = 5
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, bus1_amp)
			set(gen2_amp, bus2_amp)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, bus3_amp)	
		elseif gen1_work and gen2_work then -- gen 1 and 2 works. GPU disconnected. APU doesn't matter
			bus1_volt = gen1_volt
			src1 = 1
			bus2_volt = gen2_volt
			src2 = 2
			bus3_volt = gen2_volt
			src3 = 2
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, bus1_amp )
			set(gen2_amp, bus2_amp + bus3_amp)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen1_work and gen4_work then -- gen 1 and APU works. GPU ignored.
			bus1_volt = gen1_volt
			src1 = 1
			bus2_volt = gen4_volt
			src2 = 4
			bus3_volt = gen1_volt
			src3 = 1
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, bus1_amp + bus3_amp)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, bus2_amp)
			set(gpu_amp, 0)	
		elseif gen2_work and gen4_work then -- gen 2 and APU works. GPU ignored.
			bus1_volt = gen2_volt
			src1 = 2
			bus2_volt = gen4_volt
			src2 = 4
			bus3_volt = gen2_volt
			src3 = 2
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, 0)
			set(gen2_amp, bus1_amp + bus3_amp)
			set(gen3_amp, 0)
			set(gen4_amp, bus2_amp)
			set(gpu_amp, 0)	
		elseif gen3_work and gen4_work then -- gen 3 and APU works. GPU ignored.
			bus1_volt = gen3_volt
			src1 = 3
			bus2_volt = gen4_volt
			src2 = 4
			bus3_volt = gen3_volt
			src3 = 3
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, bus1_amp + bus3_amp)
			set(gen4_amp, bus2_amp)
			set(gpu_amp, 0)
		elseif gen1_work and gpu_work then -- gen 1 works. GPU connected
			bus1_volt = gen1_volt
			src1 = 1
			bus2_volt = gpu_volt
			src2 = 5
			bus3_volt = gpu_volt
			src3 = 5
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, bus1_amp)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, bus2_amp + bus3_amp)	
		elseif gen2_work and gpu_work then -- gen 2 works. GPU connected
			bus1_volt = gpu_volt
			src1 = 5
			bus2_volt = gen2_volt
			src2 = 2
			bus3_volt = gpu_volt
			src3 = 5
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, 0)
			set(gen2_amp, bus2_amp)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, bus1_amp + bus3_amp)	
		elseif gen3_work and gpu_work then -- gen 3 works. GPU connected
			bus1_volt = gpu_volt
			src1 = 5
			bus2_volt = gpu_volt
			src2 = 5
			bus3_volt = gen3_volt
			src3 = 3
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, bus1_amp + bus2_amp)	
		elseif gen1_work then -- gen 1 works. GPU and APU disconnected
			bus1_volt = gen1_volt
			src1 = 1
			bus2_volt = 0
			src2 = 0
			bus3_volt = gen1_volt
			src3 = 1
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, bus1_amp + bus3_amp)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen2_work then -- gen 2 works. GPU and APU disconnected
			bus1_volt = gen2_volt
			src1 = 2
			bus2_volt = 0
			src2 = 0
			bus3_volt = gen2_volt
			src3 = 2
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, 0)
			set(gen2_amp, bus1_amp + bus3_amp)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen3_work then -- gen 3 works. GPU and APU disconnected
			bus1_volt = gen3_volt
			src1 = 3
			bus2_volt = 0
			src2 = 0
			bus3_volt = gen3_volt
			src3 = 3
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, bus1_amp + bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen4_work and gpu_work then -- APU and GPU connected. generators are OFF or failed.
			bus1_volt = gen4_volt
			src1 = 4
			bus2_volt = gen4_volt
			src2 = 4
			bus3_volt = gpu_volt
			src3 = 5
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, bus1_amp + bus2_amp)
			set(gpu_amp, bus3_amp)		
		elseif gpu_work then -- GPU connected. generators are OFF or failed.
			bus1_volt = gpu_volt
			src1 = 5
			bus2_volt = gpu_volt
			src2 = 5
			bus3_volt = gpu_volt
			src3 = 5
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, bus1_amp + bus2_amp + bus3_amp)		
		elseif gen4_work then -- GPU connected. generators are OFF or failed.
			bus1_volt = gen4_volt
			src1 = 4
			bus2_volt = gen4_volt
			src2 = 4
			bus3_volt = gen4_volt
			src3 = 4
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, bus1_amp + bus2_amp + bus3_amp)
			set(gpu_amp, 0)
		else
			bus1_volt = 0
			src1 = 0
			bus2_volt = 0
			src2 = 0
			bus3_volt = 0
			src3 = 0
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			-- set currents
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, 0)		
		end
		
		
		set(bus115_1_volt, bus1_volt)
		set(bus115_2_volt, bus2_volt)
		set(bus115_3_volt, bus3_volt)
		
		set(bus115_em_1_volt, bus_em_1_volt)
		set(bus115_em_2_volt, bus_em_2_volt)

		-- the emergency buses are strapped to buses 1 and 3, so they need no
		-- source of their own
		set(bus115_src_1, src1)
		set(bus115_src_2, src2)
		set(bus115_src_3, src3)

	end

end