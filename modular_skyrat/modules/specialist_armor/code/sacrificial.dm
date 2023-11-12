// Sacrificial armor has massive bullet protection, but gets damaged by being shot, thus, is sacrificing itself to protect the wearer
/datum/armor/armor_sf_sacrificial
	melee = 30
	bullet = 80 // When the level IV plates stop the bullet but not the energy transfer
	laser = 10
	energy = 10
	bomb = 50
	fire = 50
	acid = 30
	wound = 30

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
	atom_integrity = 250
	limb_integrity = 250 // Can take 200 points of damage before it falls to nothing
	repairable_by = null // No being cheeky and keeping a pile of repair materials in your bag to fix it either

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
	atom_integrity = 250
	limb_integrity = 250 // Can take 200 points of damage before it falls to nothing
	repairable_by = null // No being cheeky and keeping a pile of repair materials in your bag to fix it either
	dog_fashion = null
	flags_inv = null

/obj/item/clothing/head/helmet/sf_sacrificial/examine_more(mob/user)
	. = ..()

	. += "An extreme solution to an extreme problem. While many galactic armors have some semblance of self-repairing tech \
		in them to prevent the armor becoming useless after being shot enough, it does have its limits. Those limits tend to be \
		that the self-repairing, while handy, take the place of what could have simply been more armor. For a small market, \
		one that doesn't care if their armor lasts more than one gunfight, there exists a niche for armors such as the 'Val'. \
		Passing up self-repair for nigh-immunity to bullets, the right tool for a certain job, if you can find whatever that job may be."

	return .
