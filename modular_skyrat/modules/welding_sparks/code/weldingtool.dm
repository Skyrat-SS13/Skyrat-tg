/**
 * Modularity is a neccessary evil.
 *
 * It makes everything far harder, yet it is the only way to achieve salvation.
 *
 * Without it, we would be nothing.
 *
 * These are the side effects of our choice to achieve salvation.
 */

/obj/item
	/// An image effect for displaying a welding effect for items that support it.
	var/image/welding_sparks

/obj/item/Initialize(mapload)
	. = ..()
	if(tool_behaviour == TOOL_WELDER) // If we act like a welder, set up some spark effects.
		welding_sparks = image('modular_skyrat/modules/welding_sparks/icons/welding_effect.dmi', "welding_sparks", GASFIRE_LAYER)
		welding_sparks.plane = ABOVE_LIGHTING_PLANE

/obj/item/Destroy(force)
	QDEL_NULL(welding_sparks)
	return ..()
