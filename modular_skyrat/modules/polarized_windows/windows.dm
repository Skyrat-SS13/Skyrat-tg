/obj/structure/window
	/// A variable for mappers to make the window start polarized, with a specific
	/// id linked, for the polarization controller to link to. Mapping stuff.
	/// Should usually be a string, so it doesn't get confused with what players
	/// can make the id on the controller be.
	/// HAS NO EFFECT AFTER THE WINDOW HAS BEEN THROUGH `Initialize()`!!!
	var/polarizer_id_on_spawn = ""

/obj/structure/window/Initialize(mapload, direct)
	. = ..()

	if(polarizer_id_on_spawn)
		AddComponent(/datum/component/polarization_controller, polarizer_id = polarizer_id_on_spawn)


/obj/effect/spawner/structure/window
	/// A variable for mappers to make the windows spawned by this spawner to
	/// start polarized, with a specific id linked, for the polarization
	/// controller to link to. Mapping stuff. Should usually be a string, so it
	/// doesn't get confused with what players can make the id on the controller be.
	/// FOR MAPPERS ONLY. DONE THIS WAY TO AVOID HAVING TO CREATE A TON OF SUBTYPES.
	var/polarizer_id = ""


/obj/effect/spawner/structure/window/Initialize(mapload)
	if(!polarizer_id)
		return ..()

	// We do this so that we spawn everything in order, but we also add the
	// polarization_controller component to all the windows that we spawn.
	for(var/spawn_type in spawn_list)
		var/obj/structure/window/spawned_window = new spawn_type(loc)

		if(!istype(spawned_window))
			continue

		spawned_window.AddComponent(/datum/component/polarization_controller, polarizer_id = polarizer_id)


	spawn_list = list()

	return ..()
