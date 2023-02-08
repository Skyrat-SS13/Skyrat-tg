/obj/item/clothing/under/color
	greyscale_config_worn_monkey = /datum/greyscale_config/jumpsuit_worn/monkey

/**
 * Random jumpsuit is the preferred style of the wearer if loaded as an outfit.
 * This is cleaner than creating a ../skirt variant as skirts are precached into SSwardrobe
 * and that causes runtimes for runtimes for this class as it qdels on Initialize.
 */
/obj/item/clothing/under/color/random/proc/get_random_variant()
	var/mob/living/carbon/human/wearer = loc
	if(istype(wearer) && wearer.jumpsuit_style == PREF_SKIRT)
		return get_random_jumpskirt()

	return get_random_jumpsuit()
