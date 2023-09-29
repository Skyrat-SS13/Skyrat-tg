// Short wooden fences, oh me oh my

/obj/structure/railing/wooden_fencing
	name = "wooden fence"
	desc = "A basic wooden fence meant to prevent people like you either in or out of somewhere."
	icon = 'modular_skyrat/modules/primitive_structures/icons/wooden_fence.dmi'
	icon_state = "fence"
	layer = BELOW_OBJ_LAYER // I think this is the default but lets be safe?
	resistance_flags = FLAMMABLE
	flags_1 = NODECONSTRUCT_1

/obj/structure/railing/wooden_fencing/Initialize(mapload)
	. = ..()
	icon_state = pick(
		"fence",
		"fence_2",
		"fence_3",
	)

/obj/structure/railing/wooden_fencing/update_icon()
	. = ..()
	switch(dir)
		if(SOUTH)
			layer = ABOVE_MOB_LAYER
		if(NORTH)
			layer = initial(layer) - 0.01
		else
			layer = initial(layer)
