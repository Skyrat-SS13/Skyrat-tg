/obj/item/clothing/glasses/hypno
	name = "Hypnotic goggles"
	desc = "Woaa-a-ah... This is lewd."
	icon_state = "hypnogoggles"
	inhand_icon_state = "hypnogoggles"
	icon = 'modular_skyrat/modules/modular_items/icons/obj/items/hypnogoggles.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/icons/mob/hypnogoggles.dmi'

	var/mob/living/carbon/victim
	var/codephrase = "Obey"//There SHOULD be default phrase, because if there is none - goggles will go buggy when you equip them without setting phrase.

/obj/item/clothing/glasses/hypno/equipped(mob/user, slot)//Adding hypnosis on equip
	. = ..()
	victim = user
	if(slot != ITEM_SLOT_EYES)
		return
	if(iscarbon(victim))
		victim.gain_trauma(new /datum/brain_trauma/hypnosis(codephrase), TRAUMA_RESILIENCE_BASIC)

/obj/item/clothing/glasses/hypno/dropped(mob/user)//Removing hypnosis on unequip
	. = ..()
	if(victim.glasses == src)
		victim.cure_trauma_type(/datum/brain_trauma/hypnosis, TRAUMA_RESILIENCE_BASIC)
		victim = null

/obj/item/clothing/glasses/hypno/attack_self(mob/user)//Setting up hypnotising phrase
	. = ..()
	codephrase = stripped_input(user, "Change the hypnotic phrase")

