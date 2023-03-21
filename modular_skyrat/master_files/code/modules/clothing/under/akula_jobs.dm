/obj/item/clothing/under/akula_wetworks
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "default"
	inhand_icon_state = "default"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
	armor_type = /datum/armor/wetworks_under
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	can_adjust = FALSE
	strip_delay = 40
	/// If an akula tail accessory is present, we can overlay a stylish additional icon
	var/style_overlay

/obj/item/clothing/under/akula_wetworks/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/clothing/under/akula_wetworks/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!isinhands && style_overlay)
		. += mutable_appearance('modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi', style_overlay, ABOVE_MOB_LAYER)
	else
		cut_overlays()

/obj/item/clothing/under/akula_wetworks/equipped(mob/user, slot)
	. = ..()
	check_physique(user)
	check_style_overlay(user)
	update_appearance()

/obj/item/clothing/under/akula_wetworks/proc/check_physique(mob/living/carbon/human/user)
	icon_state = initial(icon_state)
	if(user.physique == FEMALE)
		icon_state = "[icon_state]_f"
	else
		return

/obj/item/clothing/under/akula_wetworks/proc/check_style_overlay(mob/living/carbon/human/user)
	if(istype(user.getorganslot(ORGAN_SLOT_EXTERNAL_TAIL), /obj/item/organ/external/tail))
		var/tail = user.dna.species.mutant_bodyparts["tail"][MUTANT_INDEX_NAME]
		switch(tail)
			if("Akula")
				style_overlay = "overlay_akula"
			if("Shark")
				style_overlay = "overlay_shark"
			if("Shark (No Fin)")
				style_overlay = "overlay_shark_no_fin"
			if("Fish")
				style_overlay = "overlay_fish"
			else
				style_overlay = null
	else
		style_overlay = null

	/// Suit armor
/datum/armor/wetworks_under
	bio = 100
	fire = 95
	acid = 95

/obj/item/clothing/under/akula_wetworks/engineering
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "engi"
	inhand_icon_state = "engi"

/obj/item/clothing/under/akula_wetworks/cargo
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "cargo"
	inhand_icon_state = "cargo"

/obj/item/clothing/under/akula_wetworks/science
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "science"
	inhand_icon_state = "science"

/obj/item/clothing/under/akula_wetworks/medical
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "medical"
	inhand_icon_state = "medical"

/obj/item/clothing/under/akula_wetworks/security
	name = "wetworks envirosuit"
	desc = ""
	icon_state = "security"
	inhand_icon_state = "security"

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
	strip_delay = 60
	armor_type = /datum/armor/wetworks_helmet
	resistance_flags = FIRE_PROOF
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

	/// Wearing hats inside the wetworks helmet
/obj/item/clothing/head/helmet/space/akula_wetworks/examine()
	. = ..()
	if(attached_hat)
		. += span_notice("There's [attached_hat.name] placed in the helmet. Right-click to remove it.")
	else
		. += span_notice("There's nothing placed in the helmet.")

/obj/item/clothing/head/helmet/space/akula_wetworks/attackby(obj/item/hitting_item, mob/living/user)
	. = ..()
	if(istype(hitting_item, /obj/item/clothing/head))
		var/obj/item/clothing/hitting_clothing = hitting_item
		if(hitting_clothing.clothing_flags & PLASMAMAN_HELMET_EXEMPT)
			to_chat(user, span_notice("You cannot place [hitting_clothing.name] in helmet!"))
			return
		if(attached_hat)
			to_chat(user, span_notice("There's already something placed inside the helmet!"))
			return
		attached_hat = hitting_clothing
		to_chat(user, span_notice("You placed [hitting_clothing.name] in the helmet!"))
		hitting_clothing.forceMove(src)
		icon_state = "empty"
		update_appearance()

/obj/item/clothing/head/helmet/space/akula_wetworks/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!isinhands && attached_hat)
		var/mutable_appearance/attached_hat_MA = mutable_appearance(attached_hat.worn_icon, attached_hat.icon_state, -(HEAD_LAYER-0.1))
		attached_hat_MA.add_overlay(mutable_appearance(worn_icon, "helmet", -HEAD_LAYER))
		. += attached_hat_MA
	else
		cut_overlays()

/obj/item/clothing/head/helmet/space/akula_wetworks/attack_hand_secondary(mob/user)
	..()
	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!attached_hat)
		return
	user.put_in_active_hand(attached_hat)
	to_chat(user, span_notice("You removed [attached_hat.name] from helmet!"))
	attached_hat = null
	icon_state = "helmet"
	update_appearance()
