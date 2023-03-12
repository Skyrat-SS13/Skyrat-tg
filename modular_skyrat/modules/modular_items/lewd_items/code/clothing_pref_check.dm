/// Global list containing all the clothing we'd want to check prefs for before we put on someone.
GLOBAL_LIST_INIT(pref_checked_clothes, list(
	/obj/item/clothing/mask/ballgag
))

/obj/item/clothing/mob_can_equip(mob/living/user, slot)
	if((slot_flags & slot) && (src.type in GLOB.pref_checked_clothes))
		if(!(user.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy)))
			return FALSE
	return ..()

