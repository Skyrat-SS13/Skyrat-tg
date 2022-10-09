/obj/item/clothing/mask/infiltrator
	name = "infiltrator balaclava"
	desc = "It makes you feel safe in your anonymity, but for a stealth outfit you sure do look obvious that you're up to no good. It seems to have a built in heads-up display."
	icon_state = "syndicate_balaclava"
	inhand_icon_state = "syndicate_balaclava"
	clothing_flags = MASKINTERNALS
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 10, BULLET = 5, LASER = 5,ENERGY = 5, BOMB = 0, BIO = 50, FIRE = 100, ACID = 40)
	resistance_flags = FIRE_PROOF | ACID_PROOF

	var/voice_unknown = FALSE ///This makes it so that your name shows up as unknown when wearing the mask.

/obj/item/clothing/mask/infiltrator/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_MASK))
		return
	to_chat(user, "You roll the balaclava over your face, and a data display appears before your eyes.")
	ADD_TRAIT(user, TRAIT_DIAGNOSTIC_HUD, MASK_TRAIT)
	var/datum/atom_hud/diag_hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_BASIC]
	diag_hud.show_to(user)
	voice_unknown = TRUE

/obj/item/clothing/mask/infiltrator/dropped(mob/living/carbon/human/user)
	to_chat(user, "You pull off the balaclava, and the mask's internal hud system switches off quietly.")
	REMOVE_TRAIT(user, TRAIT_DIAGNOSTIC_HUD, MASK_TRAIT)
	var/datum/atom_hud/diag_hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_BASIC]
	diag_hud.hide_from(user)
	voice_unknown = FALSE
	return ..()
