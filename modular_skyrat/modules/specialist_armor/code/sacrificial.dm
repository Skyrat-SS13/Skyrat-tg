// Sacrificial armor has massive bullet protection, but gets damaged by being shot, thus, is sacrificing itself to protect the wearer
/datum/armor/armor_sf_sacrificial
	melee = ARMOR_LEVEL_WEAK
	bullet = ARMOR_LEVEL_INSANE // When the level IV plates stop the bullet but not the energy transfer
	laser = ARMOR_LEVEL_TINY
	energy = ARMOR_LEVEL_TINY
	bomb = ARMOR_LEVEL_MID
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_HIGH

/obj/item/clothing/suit/armor/sf_sacrificial
	name = "'Val' sacrificial ballistic vest"
	desc = "A hefty vest with a unique pattern of hexes on its outward faces. \
		As the 'sacrificial' name might imply, this vest has extremely high bullet protection \
		in exchange for allowing itself to be destroyed by impacts. It'll protect you from hell, \
		but only for so long."
	icon = 'modular_skyrat/modules/specialist_armor/icons/armor.dmi'
	icon_state = "hexagon"
	worn_icon = 'modular_skyrat/modules/specialist_armor/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_sf_sacrificial
	max_integrity = 200
	limb_integrity = 200
	repairable_by = null // No being cheeky and keeping a pile of repair materials in your bag to fix it either
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/sf_sacrificial/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/clothing_damaged_by_bullets)

/obj/item/clothing/suit/armor/sf_sacrificial/examine_more(mob/user)
	. = ..()

	. += "An extreme solution to an extreme problem. While many galactic armors have some semblance of self-repairing tech \
		in them to prevent the armor becoming useless after being shot enough, it does have its limits. Those limits tend to be \
		that the self-repairing, while handy, take the place of what could have simply been more armor. For a small market, \
		one that doesn't care if their armor lasts more than one gunfight, there exists a niche for armors such as the 'Val'. \
		Passing up self-repair for nigh-immunity to bullets, the right tool for a certain job, if you can find whatever that job may be."

	return .

/obj/item/clothing/head/helmet/sf_sacrificial
	name = "'Val' sacrificial ballistic helmet"
	desc = "A large, almost always ill-fitting helmet painted in a tacticool black. \
		As the 'sacrificial' name might imply, this helmet has extremely high bullet protection \
		in exchange for allowing itself to be destroyed by impacts. It'll protect you from hell, \
		but only for so long."
	icon = 'modular_skyrat/modules/specialist_armor/icons/armor.dmi'
	icon_state = "bulletproof"
	worn_icon = 'modular_skyrat/modules/specialist_armor/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_sf_sacrificial
	max_integrity = 200
	limb_integrity = 200
	repairable_by = null // No being cheeky and keeping a pile of repair materials in your bag to fix it either
	dog_fashion = null
	flags_inv = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	/// Holds the faceshield for quick reference
	var/obj/item/sacrificial_face_shield/face_shield

/obj/item/clothing/head/helmet/sf_sacrificial/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/clothing_damaged_by_bullets)

/obj/item/clothing/head/helmet/sf_sacrificial/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()

	if(!(istype(attacking_item, /obj/item/sacrificial_face_shield)))
		return

	add_face_shield(user, attacking_item)

/obj/item/clothing/head/helmet/sf_sacrificial/AltClick(mob/user)
	remove_face_shield(user)

/obj/item/clothing/head/helmet/sf_sacrificial/proc/add_face_shield(mob/living/carbon/human/user, obj/shield_in_question)
	if(face_shield)
		return
	if(!user.transferItemToLoc(shield_in_question, src))
		return

	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

	playsound(src, 'sound/items/modsuit/magnetic_harness.ogg', 50, TRUE)
	face_shield = shield_in_question

	icon_state = "bulletproof_glass"
	worn_icon_state = icon_state
	update_appearance()

/obj/item/clothing/head/helmet/sf_sacrificial/proc/remove_face_shield(mob/living/carbon/human/user, break_it)
	if(!face_shield)
		return

	flags_inv = initial(flags_inv)
	flags_cover = initial(flags_cover)

	if(break_it)
		playsound(src, SFX_SHATTER, 70, TRUE)
		new /obj/effect/decal/cleanable/glass(drop_location(src))
		qdel(face_shield)
		face_shield = null // just to be safe
	else
		user.put_in_hands(face_shield)
		playsound(src, 'sound/items/modsuit/magnetic_harness.ogg', 50, TRUE)
		face_shield = null

	icon_state = initial(icon_state)
	worn_icon_state = icon_state // Against just to be safe
	update_appearance()

/obj/item/clothing/head/helmet/sf_sacrificial/take_damage_zone(def_zone, damage_amount, damage_type, armour_penetration)
	. = ..()

	if((damage_amount > 20) && face_shield)
		remove_face_shield(break_it = TRUE)

/obj/item/clothing/head/helmet/sf_sacrificial/examine(mob/user)
	. = ..()
	if(face_shield)
		. += span_notice("The <b>face shield</b> can be removed with <b>Right-Click</b>.")
	else
		. += span_notice("A <b>face shield</b> can be attached to it, if you had one.")

	return .

/obj/item/clothing/head/helmet/sf_sacrificial/examine_more(mob/user)
	. = ..()

	. += "An extreme solution to an extreme problem. While many galactic armors have some semblance of self-repairing tech \
		in them to prevent the armor becoming useless after being shot enough, it does have its limits. Those limits tend to be \
		that the self-repairing, while handy, take the place of what could have simply been more armor. For a small market, \
		one that doesn't care if their armor lasts more than one gunfight, there exists a niche for armors such as the 'Val'. \
		Passing up self-repair for nigh-immunity to bullets, the right tool for a certain job, if you can find whatever that job may be."

	return .

/obj/item/sacrificial_face_shield
	name = "'Val' ballistic add-on face plate"
	desc = "A thick piece of glass with mounting points for slotting onto a 'Val' sacrificial ballistic helmet. \
		While it does not make the helmet any stronger, it does protect your face much like a riot helmet would."
	icon = 'modular_skyrat/modules/specialist_armor/icons/armor.dmi'
	icon_state = "face_shield"
	w_class = WEIGHT_CLASS_NORMAL
