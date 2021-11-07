/obj/item/clothing/head/domina_cap
	name = "dominant cap"
	desc = "For special types of inspections."
	icon_state = "dominacap"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_hats.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_hats.dmi'
	mutant_variants = NONE

//message when equipping that thing
/obj/item/clothing/head/domina_cap/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/C = user
	if(src == C.head)
		to_chat(user, span_purple("You feel much more determined."))
	else
		return

//message when unequipping that thing
/obj/item/clothing/head/domina_cap/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/C = user
	if(src == C.head)
		to_chat(user, span_purple("BDSM session ended, huh?"))
