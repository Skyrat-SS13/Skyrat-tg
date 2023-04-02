/// A space-worthy skinsuit to be combined with the skinsuit armor
/obj/item/clothing/under/skinsuit
	name = ""
	desc = ""
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
	icon_state = "skinsuit"
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/wetsuit_under
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	resistance_flags = NONE

/obj/item/clothing/under/skinsuit/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_ICLOTHING)
		return
	apply_wetsuit_status_effect(user)

/obj/item/clothing/under/skinsuit/dropped(mob/user)
	. = ..()
	remove_wetsuit_status_effect(user)

/obj/item/clothing/head/helmet/space/skinsuit_helmet
	name = ""
	desc = ""
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/akula.dmi'
	icon_state = "skinsuithelmet"

/obj/item/clothing/head/helmet/space/skinsuit_helmet/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_ICLOTHING)
		return
	apply_wetsuit_status_effect(user)

/obj/item/clothing/head/helmet/space/skinsuit_helmet/dropped(mob/user)
	. = ..()
	remove_wetsuit_status_effect(user)

/obj/item/clothing/suit/armor/riot/skinsuit_armor
	name = ""
	desc = ""
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/akula.dmi'
	icon_state = "skinsuitarmor"
	base_icon_state = "skinsuitarmor"


/obj/item/clothing/suit/armor/riot/skinsuit_armor/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_ICLOTHING)
		return
	check_tail(user)
	update_appearance()

/obj/item/clothing/suit/armor/riot/skinsuit_armor/dropped(mob/user)
	. = ..()
	check_tail(user)
	update_appearance()

// Pick an icon_state that matches nicer with tails if one is found on the wearer
/obj/item/clothing/suit/armor/riot/skinsuit_armor/proc/check_tail(mob/living/carbon/human/user)
	icon_state = base_icon_state
	if(!user.dna.species.mutant_bodyparts["tail"])
		return
	icon_state = "skinsuitarmor_cutback"
