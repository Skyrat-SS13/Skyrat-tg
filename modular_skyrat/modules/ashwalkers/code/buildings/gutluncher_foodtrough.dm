/obj/structure/ore_container/gutlunch_trough/attackby(/obj/item/storage/bag/ore/ore_bag, mob/living/carbon/human/user, list/modifiers)
	if(!istype(ore_bag))
		return ..()
		
	for(var/obj/item/stack/ore/stored_ore in ore_bag.contents)
		ore_bag.atom_storage?.attempt_remove(stored_ore, src)
