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

/obj/item/clothing/head/helmet/sf_sacrificial/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/clothing_damaged_by_bullets)

/obj/item/clothing/head/helmet/sf_sacrificial/examine_more(mob/user)
	. = ..()

	. += "An extreme solution to an extreme problem. While many galactic armors have some semblance of self-repairing tech \
		in them to prevent the armor becoming useless after being shot enough, it does have its limits. Those limits tend to be \
		that the self-repairing, while handy, take the place of what could have simply been more armor. For a small market, \
		one that doesn't care if their armor lasts more than one gunfight, there exists a niche for armors such as the 'Val'. \
		Passing up self-repair for nigh-immunity to bullets, the right tool for a certain job, if you can find whatever that job may be."

	return .
