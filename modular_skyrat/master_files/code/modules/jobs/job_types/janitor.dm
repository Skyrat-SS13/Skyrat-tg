#define MAX_ACCESS_KEYS 3

/datum/outfit/job/janitor/pre_equip(mob/living/carbon/human/human_equipper, visuals_only)
	. = ..()

	var/access_keys = 0
	for(var/obj/item/access_key/jani_gear in GLOB.janitor_devices)
		access_keys++
	if(access_keys < MAX_ACCESS_KEYS  && !visuals_only)
		backpack_contents += list(/obj/item/access_key)

#undef MAX_ACCESS_KEYS
