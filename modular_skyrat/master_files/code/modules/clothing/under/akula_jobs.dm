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

/obj/item/clothing/under/akula_wetsuit
	name = "Shoredress wetsuit"
	desc = "The 'Wetworks'-pattern Shoredress is a long-standing template upon which most Azulean 'wetsuits' are made. \
		This atmospheric exploration suit is a single form-fitting garment, designed to keep wearers comfortable in the harsh environment of dry land; \
		even sometimes worn underneath orbital suits such as MODs. Shoredresses apply active thermal channels and motion-powered micropumps \
		to allow for water of the wearer's temperature choice to circulate; ensuring ample flow over not only the gills, but the rest of the wearer's skin, \
		at the cost of occasional movement being needed when the wearer is still. These suits are known to come with luminescent panels that take on a bright glow when underwater, \
		meant for signalling as well as higher visibility in deep waters. The system is meant to only be able to process water, fresh or otherwise; but unofficially, \
		a great many chemicals or even drinks have been loaded in by adventurous or careless explorers of the New Principalities-- at fantastic personal risk to their gills."
	icon_state = "default"
	base_icon_state = "default"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
	armor_type = /datum/armor/wetsuit_under
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	can_adjust = FALSE
	/// If an akula tail accessory is present, we can overlay an additional icon
	var/tail_overlay


/obj/item/clothing/under/akula_wetsuit/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/clothing/under/akula_wetsuit/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_ICLOTHING)
		return
	check_physique(user)
	check_tail_overlay(user)
	add_tail_overlay(user)
	apply_wetsuit_status_effect(user)
	update_appearance()

/obj/item/clothing/under/akula_wetsuit/dropped(mob/user)
	. = ..()
	if(tail_overlay)
		user.cut_overlay(tail_overlay)
		tail_overlay = null
	remove_wetsuit_status_effect(user)
	update_appearance()

/// This will check the wearer's bodytype and change the wetsuit worn sprite according to if its male/female
/obj/item/clothing/under/akula_wetsuit/proc/check_physique(mob/living/carbon/human/user)
	icon_state = base_icon_state
	if(user.physique == FEMALE)
		icon_state = "[icon_state]_f"
	return TRUE

/// Checks if the wearer has a compatible tail for the `tail_overlay` variable
/obj/item/clothing/under/akula_wetsuit/proc/check_tail_overlay(mob/living/carbon/human/user)
	if(!user.dna.species.mutant_bodyparts["tail"])
		tail_overlay = null
		return

	var/tail = user.dna.species.mutant_bodyparts["tail"][MUTANT_INDEX_NAME]
	// to-do: write this better
	switch(tail)
		if("Akula")
			tail_overlay = mutable_appearance('modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi', "overlay_akula", -(BODY_FRONT_LAYER-0.1))
		if("Shark")
			tail_overlay = mutable_appearance('modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi', "overlay_shark", -(BODY_FRONT_LAYER-0.1))
		if("Shark (No Fin)")
			tail_overlay = mutable_appearance('modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi', "overlay_shark_no_fin", -(BODY_FRONT_LAYER-0.1))
		if("Fish")
			tail_overlay = mutable_appearance('modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi', "overlay_fish", -(BODY_FRONT_LAYER-0.1))
		else
			tail_overlay = null

/// Render the actual overlay
/obj/item/clothing/under/akula_wetsuit/proc/add_tail_overlay(mob/user)
	if(!tail_overlay)
		return
	user.add_overlay(tail_overlay)

	/// Suit armor
/datum/armor/wetsuit_under
	bio = 10
	wound = 5

/obj/item/clothing/under/akula_wetsuit/job
	name = "Shoredress wetsuit"
	/// Our large examine text
	var/extended_desc = "The 'Wetworks'-pattern Shoredress is a long-standing template upon which most Azulean 'wetsuits' are made. \
		This atmospheric exploration suit is a single form-fitting garment, designed to keep wearers comfortable in the harsh environment of dry land; \
		even sometimes worn underneath orbital suits such as MODs. Shoredresses apply active thermal channels and motion-powered micropumps \
		to allow for water of the wearer's temperature choice to circulate; ensuring ample flow over not only the gills, but the rest of the wearer's skin, \
		at the cost of occasional movement being needed when the wearer is still. These suits are known to come with luminescent panels that take on a bright glow when underwater, \
		meant for signalling as well as higher visibility in deep waters. The system is meant to only be able to process water, fresh or otherwise; but unofficially, \
		a great many chemicals or even drinks have been loaded in by adventurous or careless explorers of the New Principalities-- at fantastic personal risk to their gills."

/obj/item/clothing/under/akula_wetsuit/job/examine(mob/user)
	. = ..()
	. += span_notice("This item could be examined further...")

/obj/item/clothing/under/akula_wetsuit/job/examine_more(mob/user)
	. = ..()
	. += extended_desc

/obj/item/clothing/under/akula_wetsuit/job/engineering
	name = "Engineer Shoredress wetsuit"
	desc = "The 'Engineering'-Type Shoredress is a ubiquitous model used by a wide variety of companies, only hardly changed from its' original Azulean design. \
		The luminescent panels on the arms have been given higher flow of power for greater visibility, and the entire suit has been focused \
		first and foremost on the incorporation of heat-resistant alloys and skintight heatsinks to protect against fires. Additionally, \
		the materials used to construct this wetsuit have rendered it extremely hardy against corrosive liquids and gasses."
	icon_state = "engi"
	base_icon_state = "engi"

/obj/item/clothing/under/akula_wetsuit/job/cargo
	name = "Cargo Shoredress wetsuit"
	desc = "The 'Cargo'-Type Shoredress was made as a partnership between the Free Trade Union and the New Principalities of Agurkrral, predominantly \
		designed for comfort. Warehouse workers on land and sea are treated to low-powered actuators meant to help distribute heavy loads when lifting, \
		and the plush interior of 'Medical'-Type Shoredresses has been expanded on three times over to ensure maximum cushioning for the wearer's body. \
		Systems around the neck are capable of slightly flavoring any Shoredress Glasses with over five hundred different choices, \
		and the temperature-control pumps are some of the best available to those that aren't royalty."
	icon_state = "cargo"
	base_icon_state = "cargo"

/obj/item/clothing/under/akula_wetsuit/job/science
	name = "Science Shoredress wetsuit"
	desc = "The 'Science'-Type Shoredress is yet another model commissioned by NanoTrasen. This suit has been adapted from 'Ordnance'-Type Shoredresses \
		used in the New Principalities predominantly by mining teams. It is made of a special polymer that provides some minor protection against explosives \
		such as abandoned naval or land-based mines, and features an inbuilt external sterilization field to protect against biohazards typically found in strange places."
	icon_state = "sci"
	base_icon_state = "sci"

/obj/item/clothing/under/akula_wetsuit/job/medical
	name = "Medical Shoredress wetsuit"
	desc = "The 'Medical'-Type Shoredress is yet another model commissioned by NanoTrasen. This suit has been adapted from exploration \
		Shoredresses meant for use in murky or even outright toxic environments, being predominantly composed of self-sterilizing polymers with \
		a system able to filter out all sorts of hazardous particles in the air or water including fumes, smoke, allergens, or ocean-bound toxins. \
		This has made it convenient for the Company's medical division, let alone the plush interior to allow for greater comfortable standing hours."
	icon_state = "medical"
	base_icon_state = "medical"

/obj/item/clothing/under/akula_wetsuit/job/security
	name = "Security Shoredress wetsuit"
	desc = "The 'Security'-Type Shoredress is a model commissioned by Lopland; but the origins of this wetsuit lie in designs belonging to \
		rank-and-file warriors and fighters in the New Principalities. Designed to be protective over comfortable, these suits are no true \
		replacement for true armor, but make an excellent undersuit for even civilian plate carriers. The systems inside have been \
		reinforced to their logical endpoint, though their temperatures -- much like the attitude of their wearers, tend to run a bit hot due to manufacturing defect."
	icon_state = "sec"
	base_icon_state = "sec"

/obj/item/clothing/under/akula_wetsuit/job/command
	name = "Command Shoredress wetsuit"
	desc = "The 'Command'-Type Shoredress is yet another model commissioned by NanoTrasen; but the origins of this wetsuit lie in designs belonging to, \
			typically, high-ranking officials and managers in the Old Principalities. The bright luminescent panels on the arms have been further set \
			apart by similar paneling on the chest, meant to ensure the wearer looks distinct both in the water, on land, and even on camera. \
			The temperature systems have been upgraded, as well as the choice to use more comfortable fabrics in the construction."
	icon_state = "command"
	base_icon_state = "command"


/obj/item/clothing/head/helmet/space/akula_wetsuit
	name = "Shoredress-Glass helmet"
	desc = "A glass dome that encompasses the wearer with H2O or just the O."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/akula.dmi'
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | PLASMAMAN_HELMET_EXEMPT
	icon_state = "helmet"
	inhand_icon_state = "helmet"
	strip_delay = 6 SECONDS
	armor_type = /datum/armor/wetsuit_helmet
	resistance_flags = FIRE_PROOF
	/// Variable for storing hats which are worn inside the bubble helmet
	var/obj/item/clothing/head/attached_hat
	flags_inv = null
	flags_cover = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF

	/// Helmet armor
/datum/armor/wetsuit_helmet
	bio = 100
	fire = 50

/obj/item/clothing/head/helmet/space/akula_wetsuit/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/clothing/head/helmet/space/akula_wetsuit/Destroy()
	. = ..()
	if(attached_hat)
		attached_hat.forceMove(drop_location())

/obj/item/clothing/head/helmet/space/akula_wetsuit/equipped(mob/user, slot)
	. = ..()
	apply_wetsuit_status_effect(user)

/obj/item/clothing/head/helmet/space/akula_wetsuit/dropped(mob/user)
	. = ..()
	remove_wetsuit_status_effect(user)

// Wearing hats inside the wetworks helmet
/obj/item/clothing/head/helmet/space/akula_wetsuit/examine()
	. = ..()
	if(attached_hat)
		. += span_notice("There's [attached_hat] placed in the helmet.")
		. += span_bold("Right-click to remove it.")
	else
		. += span_notice("There's nothing placed in the helmet.")

/obj/item/clothing/head/helmet/space/akula_wetsuit/attackby(obj/item/hitting_item, mob/living/user)
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

/obj/item/clothing/head/helmet/space/akula_wetsuit/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!attached_hat || isinhands)
		return

	var/mutable_appearance/attached_hat_MA = mutable_appearance(attached_hat.worn_icon, attached_hat.icon_state, -(HEAD_LAYER-0.1))
	attached_hat_MA.add_overlay(mutable_appearance(worn_icon, "helmet", -HEAD_LAYER))
	. += attached_hat_MA


/obj/item/clothing/head/helmet/space/akula_wetsuit/attack_hand_secondary(mob/user)
	..()
	if(!attached_hat)
		return
	user.put_in_active_hand(attached_hat)
	to_chat(user, span_notice("You removed [attached_hat] from helmet!"))
	attached_hat = null
	icon_state = "helmet"
	update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
