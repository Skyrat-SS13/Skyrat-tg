/datum/shuttle_extension
	var/name = "Extension"
	var/applied = FALSE
	var/datum/overmap_object/shuttle/overmap_object
	var/obj/docking_port/mobile/shuttle
	var/datum/space_level/z_level

/datum/shuttle_extension/proc/ApplyToPosition(turf/position)
	if(IsApplied())
		return
	if(SSshuttle.is_in_shuttle_bounds(position))
		var/obj/docking_port/mobile/M = SSshuttle.get_containing_shuttle(position)
		if(M)
			AddToShuttle(M)
	else
		var/datum/space_level/level = SSmapping.z_list[position.z]
		if(level && level.related_overmap_object && level.is_overmap_controllable)
			AddToZLevel(level)

/datum/shuttle_extension/proc/IsApplied()
	return (overmap_object || shuttle || z_level)

/datum/shuttle_extension/proc/AddToZLevel(datum/space_level/z_level_to_add)
	if(z_level)
		WARNING("Shuttle extension registered to a z level, while already registered to one")
		return
	z_level = z_level_to_add
	z_level.all_extensions += src
	if(z_level.related_overmap_object && z_level.is_overmap_controllable)
		AddToOvermapObject(z_level.related_overmap_object)

/datum/shuttle_extension/proc/RemoveFromZLevel()
	if(z_level.related_overmap_object)
		RemoveFromOvermapObject()
	z_level.all_extensions -= src
	z_level = null

/datum/shuttle_extension/proc/AddToShuttle(obj/docking_port/mobile/shuttle_to_add)
	if(shuttle)
		WARNING("Shuttle extension registered to a shuttle, while already registered to one")
		return
	shuttle = shuttle_to_add
	shuttle.all_extensions += src
	if(shuttle.my_overmap_object)
		AddToOvermapObject(shuttle.my_overmap_object)

/datum/shuttle_extension/proc/RemoveFromShuttle()
	if(shuttle.my_overmap_object)
		RemoveFromOvermapObject()
	shuttle.all_extensions -= src
	shuttle = null

/datum/shuttle_extension/proc/AddToOvermapObject(datum/overmap_object/shuttle/object_to_add)
	if(overmap_object)
		WARNING("Shuttle extension registered to overmap object, while already registered to one")
		return
	overmap_object = object_to_add
	overmap_object.all_extensions += src

/datum/shuttle_extension/proc/RemoveFromOvermapObject()
	overmap_object.all_extensions -= src
	overmap_object = null

/datum/shuttle_extension/proc/RemoveExtension()
	if(z_level)
		RemoveFromZLevel()
	else if(shuttle)
		RemoveFromShuttle()
	else if(overmap_object) //Implies that it's non physical and abstracct if it doesnt have a shuttle but has this
		RemoveFromOvermapObject()

/datum/shuttle_extension/Destroy()
	RemoveExtension()
	return ..()

/datum/shuttle_extension/engine
	name = "Engine"
	var/current_fuel = 100
	var/maximum_fuel = 100
	var/current_efficiency = 1
	var/granted_speed = 0.5
	var/minimum_fuel_to_operate = 1
	var/turned_on = FALSE
	var/cap_speed_multiplier = 5

/datum/shuttle_extension/engine/proc/UpdateFuel()
	return

/datum/shuttle_extension/engine/proc/CanOperate()
	UpdateFuel()
	if(!turned_on)
		return FALSE
	if(current_fuel < minimum_fuel_to_operate)
		return FALSE
	return TRUE

/datum/shuttle_extension/engine/proc/GetCapSpeed(impulse_percent)
	return granted_speed * impulse_percent * current_efficiency * cap_speed_multiplier

/datum/shuttle_extension/engine/proc/DrawThrust(impulse_percent)
	return granted_speed * impulse_percent * current_efficiency

/datum/shuttle_extension/engine/AddToOvermapObject(datum/overmap_object/shuttle/object_to_add)
	. = ..()
	overmap_object.engine_extensions += src

/datum/shuttle_extension/engine/RemoveFromOvermapObject()
	overmap_object.engine_extensions -= src
	..()

/datum/shuttle_extension/engine/AddToShuttle(obj/docking_port/mobile/shuttle_to_add)
	..()
	shuttle.engine_extensions += src

/datum/shuttle_extension/engine/RemoveFromShuttle()
	shuttle.engine_extensions -= src
	..()

//used by types of `/obj/structure/shuttle/engine` and works off of magic
/datum/shuttle_extension/engine/burst
	name = "Burst Engine"
	///Reference to the physical engine, we'll need to bother it to draw our thrust, just for the effect.
	var/obj/structure/shuttle/engine/our_engine

/datum/shuttle_extension/engine/burst/New(obj/structure/shuttle/engine/passed_engine)
	. = ..()
	our_engine = passed_engine

/datum/shuttle_extension/engine/burst/DrawThrust(impulse_percent)
	if(our_engine)
		our_engine.DrawThrust()
	return ..()

//used by types of `/obj/structure/shuttle/engine` and works off of hot atmospheric gas
/datum/shuttle_extension/engine/propulsion
	name = "Propulsion Engine"
	///Reference to the physical engine, we'll need to bother it to draw our thrust.
	var/obj/machinery/atmospherics/components/unary/engine/our_engine

/datum/shuttle_extension/engine/propulsion/New(obj/machinery/atmospherics/components/unary/engine/passed_engine)
	. = ..()
	our_engine = passed_engine

/datum/shuttle_extension/engine/propulsion/Destroy()
	our_engine = null
	return ..()

/datum/shuttle_extension/engine/propulsion/UpdateFuel()
	if(our_engine)
		current_fuel = our_engine.GetCurrentFuel()

/datum/shuttle_extension/engine/propulsion/DrawThrust(impulse_percent)
	var/engine_multiplier = 1
	if(our_engine)
		engine_multiplier = our_engine.DrawThrust(impulse_percent * current_efficiency)
	return granted_speed * impulse_percent * current_efficiency * engine_multiplier

/datum/shuttle_extension/shield
	name = "Shield Generator"
	var/on = FALSE
	var/maximum_shield = 100
	var/current_shield = 0
	var/shield_per_process = 0.20
	var/maximum_buffer = 80
	var/current_buffer = 0
	var/buffer_per_process = 0.15
	var/max_buffer_drain = 10
	var/obj/machinery/shield_generator/my_generator
	var/next_operable_time = 0
	var/operable = TRUE

/datum/shuttle_extension/shield/proc/is_functioning()
	if(operable && on)
		return TRUE

/datum/shuttle_extension/shield/proc/take_damage(damage)
	if(!damage)
		return
	current_shield -= damage
	if(!current_shield)
		make_inoperable()

/datum/shuttle_extension/shield/proc/make_inoperable(inform = TRUE)
	current_shield = 0
	current_buffer = 0
	operable = FALSE
	next_operable_time = world.time + 1 MINUTES
	if(inform && overmap_object)
		overmap_object.inform_shields_down()

/datum/shuttle_extension/shield/AddToOvermapObject(datum/overmap_object/shuttle/object_to_add)
	. = ..()
	overmap_object.shield_extensions += src

/datum/shuttle_extension/shield/RemoveFromOvermapObject()
	overmap_object.shield_extensions -= src
	..()

/datum/shuttle_extension/shield/process(delta_time)
	if(my_generator && my_generator.machine_stat & NOPOWER)
		return
	if(!operable)
		if(world.time > next_operable_time)
			operable = TRUE
			if(on && overmap_object)
				overmap_object.inform_shields_up()
		else
			return
	if(on)
		var/charge_to_gain = shield_per_process
		//Draw power from the shield buffer
		if(current_buffer)
			var/drain = max_buffer_drain
			if(drain > current_buffer)
				drain = current_buffer
			current_buffer -= drain
			charge_to_gain += drain
		current_shield += charge_to_gain
		current_shield = min(current_shield, maximum_shield)
	else
		//If the shield generator is off, but has power, it generates a buffer
		if(current_buffer == maximum_buffer)
			return
		current_buffer += buffer_per_process
		current_buffer = min(current_buffer, maximum_buffer)

/datum/shuttle_extension/shield/proc/turn_on()
	if(on)
		return
	if(my_generator && my_generator.machine_stat & NOPOWER)
		return
	on = TRUE
	if(operable && overmap_object)
		overmap_object.inform_shields_up()

/datum/shuttle_extension/shield/proc/turn_off(malfunction = FALSE)
	if(!on)
		return
	on = FALSE
	if(malfunction)
		make_inoperable(FALSE)
	else
		//Half of the shields is added to the buffer when voluntairly turned off
		var/buffer_to_add = current_shield/2
		current_shield = 0
		current_buffer += buffer_to_add
		current_buffer = min(current_buffer, maximum_buffer)
	if(operable && overmap_object)
		overmap_object.inform_shields_down()

/datum/shuttle_extension/transporter
	name = "Transporter"
	var/transporter_progress = 0
	var/progress_to_success = 10
	///Reference to the physical transporter
	var/obj/machinery/transporter/our_machine

/datum/shuttle_extension/transporter/New(obj/machinery/transporter/passed_machine)
	. = ..()
	our_machine = passed_machine

/datum/shuttle_extension/transporter/Destroy()
	our_machine = null
	return ..()

/datum/shuttle_extension/transporter/AddToOvermapObject(datum/overmap_object/shuttle/object_to_add)
	. = ..()
	overmap_object.transporter_extensions += src

/datum/shuttle_extension/transporter/RemoveFromOvermapObject()
	overmap_object.transporter_extensions -= src
	..()

/datum/shuttle_extension/transporter/proc/CanTransport()
	if(!overmap_object.lock)
		return FALSE
	var/datum/overmap_object/target = overmap_object.lock.target
	if(TWO_POINT_DISTANCE_OV(overmap_object,target) < 1)
		return TRUE
	return FALSE

/datum/shuttle_extension/transporter/proc/ProcessTransport()
	transporter_progress++
	if(transporter_progress >= progress_to_success)
		var/turf/destination = null
		if(our_machine)
			destination = get_turf(our_machine)
			do_sparks(3, TRUE, destination)
		overmap_object.lock.target.DoTransport(destination)
		transporter_progress = 0
		return TRUE
	return FALSE

/datum/shuttle_extension/weapon
	name = "Weapon"
	var/next_fire = 0
	var/fire_cooldown = 3 SECONDS

/datum/shuttle_extension/weapon/AddToOvermapObject(datum/overmap_object/shuttle/object_to_add)
	. = ..()
	overmap_object.weapon_extensions += src

/datum/shuttle_extension/weapon/RemoveFromOvermapObject()
	overmap_object.weapon_extensions -= src
	..()

/datum/shuttle_extension/weapon/proc/PostFire(datum/overmap_object/target)
	return

/datum/shuttle_extension/weapon/proc/Fire(datum/overmap_object/target)
	next_fire = world.time + fire_cooldown
	PostFire(target)

/datum/shuttle_extension/weapon/proc/CanFire(datum/overmap_object/target)
	if(next_fire > world.time)
		return FALSE
	if(TWO_POINT_DISTANCE_OV(overmap_object,target) >= 1)
		return FALSE
	return TRUE

/datum/shuttle_extension/weapon/mining_laser
	name = "Mining Laser"
	///Reference to the physical weapon machine
	var/obj/machinery/mining_laser/our_laser

/datum/shuttle_extension/weapon/mining_laser/New(obj/machinery/mining_laser/passed_machine)
	. = ..()
	our_laser = passed_machine

/datum/shuttle_extension/weapon/mining_laser/Destroy()
	our_laser = null
	return ..()

/datum/shuttle_extension/weapon/mining_laser/Fire(datum/overmap_object/target)
	. = ..()
	new /datum/overmap_object/projectile/damaging/mining(overmap_object.current_system, overmap_object.x, overmap_object.y, overmap_object.partial_x, overmap_object.partial_y, overmap_object, target)

/datum/shuttle_extension/weapon/mining_laser/PostFire(datum/overmap_object/target)
	if(our_laser)
		our_laser.PostFire()
