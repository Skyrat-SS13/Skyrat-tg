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
		AddComponent(/datum/component/polarization_controller, polarizer_id_on_spawn)
