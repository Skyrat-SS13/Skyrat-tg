#define MAX_ACCESS_KEYS 2

/datum/outfit/job/janitor/pre_equip(mob/living/carbon/human/human_equipper, visuals_only)
	. = ..()

	var/access_keys = 0
	for(var/obj/item/jani_gear in GLOB.janitor_devices)
		if(istype(jani_gear, /obj/item/access_key))
			access_keys++
	if(access_keys < MAX_ACCESS_KEYS  && !visuals_only)
		backpack_contents += list(/obj/item/access_key)

#undef MAX_ACCESS_KEYS
