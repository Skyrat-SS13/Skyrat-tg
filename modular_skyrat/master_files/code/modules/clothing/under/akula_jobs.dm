/// A proc to be used in `equipped()` for all akula clothing which has the 'special tech' to keep their wearers slippery
/obj/item/clothing/proc/apply_wetsuit_status_effect(mob/living/carbon/human/user)
	if(!HAS_TRAIT(user, TRAIT_SLICK_SKIN))
		return FALSE
	user.apply_status_effect(/datum/status_effect/wetsuit)

/// A proc to remove the wetsuit status effect, used with the `dropped()` proc
/obj/item/clothing/proc/remove_wetsuit_status_effect(mob/living/carbon/human/user)
	if(!HAS_TRAIT(user, TRAIT_SLICK_SKIN))
		return FALSE
	user.remove_status_effect(/datum/status_effect/wetsuit)

/datum/status_effect/wetsuit
	id = "wetsuit"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	tick_interval = 10 SECONDS

/datum/status_effect/wetsuit/tick()
	owner.set_wet_stacks(15)

/obj/item/clothing/under/akula_wetworks
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "default"
	inhand_icon_state = null
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
	armor_type = /datum/armor/wetworks_under
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	can_adjust = FALSE
	/// If an akula tail accessory is present, we can overlay an additional icon
	var/tail_overlay

/obj/item/clothing/under/akula_wetworks/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/clothing/under/akula_wetworks/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!tail_overlay || isinhands)
		return
	. += mutable_appearance('modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi', tail_overlay, ABOVE_MOB_LAYER)


/obj/item/clothing/under/akula_wetworks/equipped(mob/user, slot)
	. = ..()
	check_physique(user)
	check_tail_overlay(user)
	apply_wetsuit_status_effect(user)
	update_appearance()

/obj/item/clothing/under/akula_wetworks/dropped(mob/user)
	. = ..()
	remove_wetsuit_status_effect(user)

/// This will check the wearer's bodytype and change the wetsuit worn sprite according to if its male/female
/obj/item/clothing/under/akula_wetworks/proc/check_physique(mob/living/carbon/human/user)
	icon_state = base_icon_state
	if(user.physique == FEMALE)
		icon_state = "[icon_state]_f"
	return TRUE

/// Checks if the wearer has a compatible tail for the `tail_overlay` variable
/obj/item/clothing/under/akula_wetworks/proc/check_tail_overlay(mob/living/carbon/human/user)
	// No tail
	if(!istype(user.getorganslot(ORGAN_SLOT_EXTERNAL_TAIL), /obj/item/organ/external/tail))
		return FALSE

	var/tail = user.dna.species.mutant_bodyparts["tail"][MUTANT_INDEX_NAME]
	switch(tail)
		if("Akula")
			tail_overlay = "overlay_akula"
		if("Shark")
			tail_overlay = "overlay_shark"
		if("Shark (No Fin)")
			tail_overlay = "overlay_shark_no_fin"
		if("Fish")
			tail_overlay = "overlay_fish"
		else
			tail_overlay = null

	/// Suit armor
/datum/armor/wetworks_under
	bio = 100
	fire = 95
	acid = 95

/obj/item/clothing/under/akula_wetworks/engineering
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "engi"

/obj/item/clothing/under/akula_wetworks/cargo
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "cargo"

/obj/item/clothing/under/akula_wetworks/science
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "sci"

/obj/item/clothing/under/akula_wetworks/medical
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "medical"

/obj/item/clothing/under/akula_wetworks/security
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "sec"

/obj/item/clothing/under/akula_wetworks/command
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "command"
	inhand_icon_state = "command"


/obj/item/clothing/head/helmet/space/akula_wetworks
	name = "wetworks envirohelmet"
	desc = ""
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/akula.dmi'
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | PLASMAMAN_HELMET_EXEMPT
	icon_state = "helmet"
	inhand_icon_state = "helmet"
	strip_delay = 6 SECONDS
	armor_type = /datum/armor/wetworks_helmet
	resistance_flags = FIRE_PROOF
	/// Variable for storing hats which are worn inside the bubble helmet
	var/obj/item/clothing/head/attached_hat
	flags_inv = null
	flags_cover = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF

	/// Helmet armor
/datum/armor/wetworks_helmet
	bio = 100
	fire = 95
	acid = 95

/obj/item/clothing/head/helmet/space/akula_wetworks/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/clothing/head/helmet/space/akula_wetworks/Destroy()
	. = ..()
	if(attached_hat)
		attached_hat.forceMove(drop_location())

/obj/item/clothing/head/helmet/space/akula_wetworks/equipped(mob/user, slot)
	. = ..()
	apply_wetsuit_status_effect(user)

/obj/item/clothing/head/helmet/space/akula_wetworks/dropped(mob/user)
	. = ..()
	remove_wetsuit_status_effect(user)

// Wearing hats inside the wetworks helmet
/obj/item/clothing/head/helmet/space/akula_wetworks/examine()
	. = ..()
	if(attached_hat)
		. += span_notice("There's [attached_hat] placed in the helmet.")
		. += span_bold("Right-click to remove it.")
	else
		. += span_notice("There's nothing placed in the helmet.")

/obj/item/clothing/head/helmet/space/akula_wetworks/attackby(obj/item/hitting_item, mob/living/user)
	. = ..()
	if(!istype(hitting_item, /obj/item/clothing/head))
		return
	var/obj/item/clothing/hitting_hat = hitting_item
	if(hitting_hat.clothing_flags & PLASMAMAN_HELMET_EXEMPT)
		to_chat(user, span_notice("You cannot place [hitting_hat] in helmet!"))
		return
	if(attached_hat)
		to_chat(user, span_notice("There's already something placed inside the helmet!"))
		return

	attached_hat = hitting_hat
	to_chat(user, span_notice("You placed [hitting_hat] in the helmet!"))
	hitting_hat.forceMove(src)
	icon_state = "empty"
	update_appearance()

/obj/item/clothing/head/helmet/space/akula_wetworks/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!attached_hat || isinhands)
		return

	var/mutable_appearance/attached_hat_MA = mutable_appearance(attached_hat.worn_icon, attached_hat.icon_state, -(HEAD_LAYER-0.1))
	attached_hat_MA.add_overlay(mutable_appearance(worn_icon, "helmet", -HEAD_LAYER))
	. += attached_hat_MA


/obj/item/clothing/head/helmet/space/akula_wetworks/attack_hand_secondary(mob/user)
	..()
	if(!attached_hat)
		return
	user.put_in_active_hand(attached_hat)
	to_chat(user, span_notice("You removed [attached_hat] from helmet!"))
	attached_hat = null
	icon_state = "helmet"
	update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
