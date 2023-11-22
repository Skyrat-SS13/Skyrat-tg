/obj/structure/ore_container/gutlunch_trough/attackby(obj/item/ore, mob/living/carbon/human/user, list/modifiers)
	if(istype(ore, /obj/item/storage/bag/ore))
		for(var/obj/item/stack/ore/stored_ore in ore.contents)
			ore.atom_storage?.attempt_remove(stored_ore, src)

		return

	return ..()
