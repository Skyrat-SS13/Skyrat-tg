/// Global list containing all the clothing we'd want to check prefs for before we put on someone.
GLOBAL_LIST_INIT(pref_checked_clothes, list(
	/obj/item/clothing/mask/ballgag,
	/obj/item/clothing/mask/ballgag/choking,
	/obj/item/clothing/mask/gas/bdsm_mask,
	/obj/item/clothing/suit/corset,
	/obj/item/clothing/head/deprivation_helmet,
	/obj/item/clothing/glasses/hypno,
	/obj/item/clothing/neck/kink_collar,
	/obj/item/clothing/neck/mind_collar,
	/obj/item/clothing/glasses/blindfold/kinky,
	/obj/item/clothing/ears/kinky_headphones,
	/obj/item/clothing/suit/straight_jacket/kinky_sleepbag,
	/obj/item/clothing/suit/straight_jacket/latex_straight_jacket,
	/obj/item/clothing/gloves/ball_mittens,
	/obj/item/clothing/gloves/ball_mittens_reinforced,
	/obj/item/clothing/suit/straight_jacket/shackles,
	/obj/item/clothing/suit/straight_jacket/shackles/reinforced,
	/obj/item/clothing/gloves/shibari_hands,
	/obj/item/clothing/shoes/shibari_legs,
	/obj/item/clothing/under/shibari,
))

/obj/item/clothing/mob_can_equip(mob/living/user, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE)
	if((slot_flags & slot) && (src.type in GLOB.pref_checked_clothes))
		if(!(user.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy)))
			return FALSE
	return ..()

