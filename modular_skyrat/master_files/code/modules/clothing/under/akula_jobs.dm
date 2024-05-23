/// The DMI containing the tail overlay sprites
#define TAIL_OVERLAY_DMI 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
/// The proper layer to render the tail overlays onto
#define TAIL_OVERLAY_LAYER 5.9

/obj/item/clothing/under/akula_wetsuit
	name = "Shoredress wetsuit"
	desc = "The 'Wetworks'-pattern Shoredress is a long-standing template upon which most Azulean 'wetsuits' are made. \
		This atmospheric exploration suit is a single form-fitting garment, designed to keep wearers comfortable in the harsh environment of dry land; \
		even sometimes worn underneath orbital suits such as MODs. \n\n\
		Shoredresses apply active thermal channels and motion-powered micropumps to allow for water of the wearer's temperature choice to circulate; \
		ensuring ample flow over not only the gills, but the rest of the wearer's skin, at the cost of occasional movement being needed when the wearer is still. \n\
		These suits are known to come with luminescent panels that take on a bright glow when underwater, meant for signalling as well as higher visibility in deep waters. \
		The system is meant to only be able to process water, fresh or otherwise; but unofficially, \
		a great many chemicals or even drinks have been loaded in by adventurous or careless explorers of the New Principalities-- at fantastic personal risk to their gills. "
	icon_state = "default"
	base_icon_state = "default"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
	armor_type = /datum/armor/clothing_under/wetsuit
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	can_adjust = FALSE
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	/// If an akula tail accessory is present, we can overlay an additional icon
	var/tail_overlay


/obj/item/clothing/under/akula_wetsuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)
	update_appearance()

/obj/item/clothing/under/akula_wetsuit/Destroy()
	. = ..()
	var/mob/user = loc
	if(!istype(user))
		return

	if(tail_overlay)
		user.cut_overlay(tail_overlay)
		tail_overlay = null

	qdel(GetComponent(/datum/component/wetsuit))

/obj/item/clothing/under/akula_wetsuit/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_ICLOTHING)
		return

	check_physique(user)
	add_tail_overlay(user)
	update_appearance()

/obj/item/clothing/under/akula_wetsuit/dropped(mob/user)
	. = ..()
	if(tail_overlay)
		user.cut_overlay(tail_overlay)
		tail_overlay = null

	update_appearance()

/// This will check the wearer's bodytype and change the wetsuit worn sprite according to if its male/female
/obj/item/clothing/under/akula_wetsuit/proc/check_physique(mob/living/carbon/human/user)
	icon_state = base_icon_state
	if(user.physique == FEMALE)
		icon_state = "[icon_state]_f"
	return TRUE

/// If the wearer has a compatible tail for the `tail_overlay` variable, render it
/obj/item/clothing/under/akula_wetsuit/proc/add_tail_overlay(mob/living/carbon/human/user)
	if(!user.dna.species.mutant_bodyparts["tail"])
		return

	var/tail = user.dna.species.mutant_bodyparts["tail"][MUTANT_INDEX_NAME]
	switch(tail)
		if("Akula")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_akula", -(TAIL_OVERLAY_LAYER))
		if("Shark")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_shark", -(TAIL_OVERLAY_LAYER))
		if("Shark (No Fin)")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_shark_no_fin", -(TAIL_OVERLAY_LAYER))
		if("Fish")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_fish", -(TAIL_OVERLAY_LAYER))
		else
			tail_overlay = null

	if(tail_overlay)
		user.add_overlay(tail_overlay)
		icon_state = "[icon_state]_tail"

	/// Suit armor
/datum/armor/clothing_under/wetsuit
	bio = 10

/obj/item/clothing/under/akula_wetsuit/job
	/// Our large examine text
	var/extended_desc = "The 'Wetworks'-pattern Shoredress is a long-standing template upon which most Azulean 'wetsuits' are made. \
		This atmospheric exploration suit is a single form-fitting garment, designed to keep wearers comfortable in the harsh environment of dry land; \
		even sometimes worn underneath orbital suits such as MODs. \n\n\
		Shoredresses apply active thermal channels and motion-powered micropumps to allow for water of the wearer's temperature choice to circulate; \
		ensuring ample flow over not only the gills, but the rest of the wearer's skin, at the cost of occasional movement being needed when the wearer is still. \n\
		These suits are known to come with luminescent panels that take on a bright glow when underwater, meant for signalling as well as higher visibility in deep waters. \
		The system is meant to only be able to process water, fresh or otherwise; but unofficially, \
		a great many chemicals or even drinks have been loaded in by adventurous or careless explorers of the New Principalities-- at fantastic personal risk to their gills."

/obj/item/clothing/under/akula_wetsuit/job/examine(mob/user)
	. = ..()
	. += span_notice("This item could be examined further...")

/obj/item/clothing/under/akula_wetsuit/job/examine_more(mob/user)
	. = ..()
	. += extended_desc

/obj/item/clothing/under/akula_wetsuit/job/engineering
	name = "engineer Shoredress wetsuit"
	desc = "The 'Engineering'-Type Shoredress is a ubiquitous model used by a wide variety of companies, only hardly changed from its' original Azulean design. \n\
		The luminescent panels on the arms have been given higher flow of power for greater visibility, and the entire suit has been focused \
		first and foremost on the incorporation of heat-resistant alloys and skintight heatsinks to protect against fires. \n\
		Additionally, the materials used to construct this wetsuit have rendered it extremely hardy against corrosive liquids and gasses."
	icon_state = "engi"
	base_icon_state = "engi"
	armor_type = /datum/armor/clothing_under/wetsuit/engineering

/datum/armor/clothing_under/wetsuit/engineering
	fire = 95
	acid = 95

/obj/item/clothing/under/akula_wetsuit/job/cargo
	name = "cargo Shoredress wetsuit"
	desc = "The 'Cargo'-Type Shoredress was made as a partnership between the Free Trade Union and the New Principalities of Agurkrral, predominantly \
		designed for comfort. \n\
		Warehouse workers on land and sea are treated to low-powered actuators meant to help distribute heavy loads when lifting, \
		and the plush interior of 'Medical'-Type Shoredresses has been expanded on three times over to ensure maximum cushioning for the wearer's body. \n\n\
		Systems around the neck are capable of slightly flavoring any Shoredress Glasses with over five hundred different choices, \
		and the temperature-control pumps are some of the best available to those that aren't royalty."
	icon_state = "cargo"
	base_icon_state = "cargo"
	armor_type = /datum/armor/clothing_under/wetsuit/cargo

/datum/armor/clothing_under/wetsuit/cargo
	fire = 40

/obj/item/clothing/under/akula_wetsuit/job/science
	name = "science Shoredress wetsuit"
	desc = "The 'Science'-Type Shoredress is yet another model commissioned by NanoTrasen. This suit has been adapted from 'Ordnance'-Type Shoredresses \
		used in the New Principalities predominantly by mining teams. \n\
		It is made of a special polymer that provides some minor protection against explosives \
		such as abandoned naval or land-based mines, and features an inbuilt external sterilization field to protect against biohazards typically found in strange places."
	icon_state = "sci"
	base_icon_state = "sci"
	armor_type = /datum/armor/clothing_under/wetsuit/science

/datum/armor/clothing_under/wetsuit/science
	bomb = 40
	acid = 95

/obj/item/clothing/under/akula_wetsuit/job/medical
	name = "medical Shoredress wetsuit"
	desc = "The 'Medical'-Type Shoredress is yet another model commissioned by NanoTrasen. This suit has been adapted from exploration \
		Shoredresses meant for use in murky or even outright toxic environments, being predominantly composed of self-sterilizing polymers with \
		a system able to filter out all sorts of hazardous particles in the air or water including fumes, smoke, allergens, or ocean-bound toxins. \n\
		This has made it convenient for the Company's medical division, let alone the plush interior to allow for greater comfortable standing hours."
	icon_state = "medical"
	base_icon_state = "medical"
	armor_type = /datum/armor/clothing_under/wetsuit/medical

/datum/armor/clothing_under/wetsuit/medical
	acid = 95
	bio = 95

/obj/item/clothing/under/akula_wetsuit/job/security
	name = "security Shoredress wetsuit"
	desc = "The 'Security'-Type Shoredress is a model commissioned by Lopland; but the origins of this wetsuit lie in designs belonging to \
		rank-and-file warriors and fighters in the New Principalities. Designed to be protective over comfortable, these suits are no true \
		replacement for true armor, but make an excellent undersuit for even civilian plate carriers. \n\
		The systems inside have been reinforced to their logical endpoint, though their temperatures -- much like the attitude of their wearers, tends to run a bit hot due to a possible manufacturing defect."
	icon_state = "sec"
	base_icon_state = "sec"
	armor_type = /datum/armor/clothing_under/rank_security

/obj/item/clothing/under/akula_wetsuit/job/command
	name = "command Shoredress wetsuit"
	desc = "The 'Command'-Type Shoredress is yet another model commissioned by NanoTrasen; but the origins of this wetsuit lie in designs belonging to, \
			typically, high-ranking officials and managers in the Old Principalities. \n\
			The bright luminescent panels on the arms have been further set apart by similar paneling on the chest, meant to ensure the wearer looks distinct both in the water, on land, and even on camera. \n\
			The temperature systems have been upgraded, as well as the choice to use more comfortable fabrics in the construction."
	icon_state = "command"
	base_icon_state = "command"
	armor_type = /datum/armor/clothing_under/rank_security


/obj/item/clothing/head/helmet/space/akula_wetsuit
	name = "\improper Shoredress helm"
	desc = "Known simply as a 'Glass' throughout Azulean society as a whole, these spheroidal helmets are often the main source of comfort for workers on land; domestic and abroad. \
		More advanced than humans would ever give them credit for, a Shoredress's Glass is a piece of technology unto itself. \n\n\
		These helmets employ a near-invisible system of cameras and sensors to prevent refraction from the water kept inside. \
		The 'flexiglass' glass comprising the unit is chemically strengthened to be thin, light, and damage-resistant, but capable of bending even in half without shattering; all to allow you to touch your face. \n\
		Some have taken to putting electronic displays around the face to help express emotion, or to signal nonverbally. \
		These helms are normally attached to Shoredresses or Stardresses, but comes with a fitted neoprene collar to allow wear on essentially anything."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/akula.dmi'
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | STACKABLE_HELMET_EXEMPT | HEADINTERNALS
	icon_state = "helmet"
	inhand_icon_state = "helmet"
	strip_delay = 6 SECONDS
	armor_type = /datum/armor/wetsuit_helmet
	resistance_flags = FIRE_PROOF
	/// Variable for storing hats which are worn inside the bubble helmet
	var/obj/item/clothing/head/attached_hat
	flags_inv = null
	flags_cover = HEADCOVERSMOUTH | PEPPERPROOF

	/// Helmet armor
/datum/armor/wetsuit_helmet
	bio = 100
	fire = 100

/obj/item/clothing/head/helmet/space/akula_wetsuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)
	update_appearance()

/obj/item/clothing/head/helmet/space/akula_wetsuit/Destroy()
	. = ..()
	var/mob/user = loc
	if(attached_hat)
		attached_hat.forceMove(drop_location())

	if(!istype(user))
		return

	qdel(GetComponent(/datum/component/wetsuit))

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
	if(hitting_hat.clothing_flags & STACKABLE_HELMET_EXEMPT)
		balloon_alert(user, "doesn't fit!")
		return
	if(attached_hat)
		balloon_alert(user, "already something inside!")
		return

	attached_hat = hitting_hat
	balloon_alert(user, "[hitting_hat] put inside")
	hitting_hat.forceMove(src)
	icon_state = "empty"
	update_appearance()

/obj/item/clothing/head/helmet/space/akula_wetsuit/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!attached_hat || isinhands)
		return

	var/mutable_appearance/attached_hat_appearance = mutable_appearance(attached_hat.worn_icon, attached_hat.icon_state, -(HEAD_LAYER-0.1))
	attached_hat_appearance.add_overlay(mutable_appearance(worn_icon, "helmet", -HEAD_LAYER))
	. += attached_hat_appearance


/obj/item/clothing/head/helmet/space/akula_wetsuit/attack_hand_secondary(mob/user)
	..()
	if(!attached_hat)
		return

	user.put_in_active_hand(attached_hat)
	balloon_alert(user, "[attached_hat] removed")
	attached_hat = null
	icon_state = "helmet"
	update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

#undef TAIL_OVERLAY_DMI
#undef TAIL_OVERLAY_LAYER
