/// A space-worthy skinsuit to be combined with the skinsuit armor
/obj/item/clothing/under/skinsuit
	name = "\improper Voidcrosser stardress"
	desc = "The 'Voidcrosser'-pattern Stardress is a long-standing template upon which most Azulean spacesuits are made. \n\
		This EVA suit is a single skintight garment, designed for flexibility and maneuverability while using jetpacks or any sort of thruster; \
		Azuleans preferring to use more familiar swimming motions than most EVA workers. The 'Voidcrosser' applies similar technologies to traditional Shoredresses, \
		utilizing high-tech fabrics and water pumps to exert pressure over the Azulean's body. \n\n\
		An attached Shoredress helm is often used in conjunction with a third-party oxygen supply to allow one to breathe, \
		and open pores in the suit allow the body to be cooled by the perspiration of internal water. \n\
		These suits are reputable among orbital workers for having very little interference with movement, and easy storage by simply folding them inside of any bubble-shaped helmet."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
	icon_state = "skinsuit"
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/clothing_under/wetsuit
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	resistance_flags = NONE
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/skinsuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)

/obj/item/clothing/under/skinsuit/Destroy()
	. = ..()
	qdel(GetComponent(/datum/component/wetsuit))

/obj/item/clothing/head/helmet/space/skinsuit_helmet
	name = "\improper Stardress helm"
	desc = "A reinforced type of 'Glass' often used particularly by Azulean boarding teams, this offshoot of the ones seen in Shoredresses is built to last. \n\
		These make use of laminated glass rather than the typical 'flexiglass' of civilian models, allowing them not only durability, but to hold together when a shatter does occur; \
		and for what remains to stay in the frame. These are typically made of up to four layers of the stuff, working unintentionally to ensure the faces of their wearers are difficult to identify. \n\n\
		In addition, the interlayer gives the helms sound insulation properties, and the ability to block UV radiation. \
		These helmets are known for being distinctly uncomfortable in comparison to their civilian counterparts; cramped and with only the most barebones climate control tech."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/akula.dmi'
	icon_state = "skinsuithelmet"

/obj/item/clothing/head/helmet/space/skinsuit_helmet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)

/obj/item/clothing/head/helmet/space/skinsuit_helmet/Destroy()
	. = ..()
	qdel(GetComponent(/datum/component/wetsuit))

/obj/item/clothing/suit/armor/riot/skinsuit_armor
	name = "\improper Shorebreaker plating"
	desc = "'Shorebreaker'-pattern Stardress plating was developed for Azulean boarding teams in service of the New Principalities. \
		Kept resilient and maneuverable, Shorebreaker armor is built predominantly close-quarters breaching. \n\n\
		Having sparse plating around the wearer's arms and legs, boarding teams are encouraged after their pod lands to do one thing: \
		make use of their rapid movement, and render their enemies past tense. The armor is relatively hardy against ranged weapons, \
		but the alloys involved are primarily constructed around resisting strikes from boarding axes, lances, and other common pirate-repellant weapons."
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

/// Pick an icon_state that matches nicer with tails if one is found on the wearer
/obj/item/clothing/suit/armor/riot/skinsuit_armor/proc/check_tail(mob/living/carbon/human/user)
	icon_state = base_icon_state
	if(!user.dna.species.mutant_bodyparts["tail"])
		return

	icon_state = "skinsuitarmor_cutback"
