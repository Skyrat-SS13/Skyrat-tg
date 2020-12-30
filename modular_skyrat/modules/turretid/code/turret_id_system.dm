GLOBAL_LIST_EMPTY(turret_id_refs)

/obj/machinery/porta_turret
	var/system_id //The ID for this turret

/obj/machinery/porta_turret/Initialize()
	. = ..()
	if(system_id)
		GLOB.turret_id_refs.Add(src)

/obj/machinery/porta_turret/Destroy()
	. = ..()
	if(system_id)
		GLOB.turret_id_refs.Remove(src)

/obj/machinery/turretid
	var/system_id //The ID system for turrets, will get any turrets with the same ID and put them in controlled turrets

/obj/machinery/turretid/Initialize()
	. = ..()
	if(system_id)
		for(var/i in GLOB.turret_id_refs[system_id])
			var/obj/machinery/porta_turret/T = i
			turrets |= T
			T.cp = src

