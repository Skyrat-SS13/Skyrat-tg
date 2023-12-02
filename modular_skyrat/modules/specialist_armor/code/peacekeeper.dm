// The peacekeeper armors and helmets will be less effective at stopping bullet damage than bulletproof vests, but stronger against wounds especially, and some other damage types
/datum/armor/armor_sf_peacekeeper
	melee = ARMOR_LEVEL_WEAK
	bullet = ARMOR_LEVEL_MID
	laser = ARMOR_LEVEL_TINY
	energy = ARMOR_LEVEL_TINY
	bomb = ARMOR_LEVEL_WEAK
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_HIGH

/obj/item/clothing/suit/armor/sf_peacekeeper
	name = "'Touvou' peacekeeper armor vest"
	desc = "A bright blue vest, proudly bearing 'SF' in white on its front and back. Dense fabric with a thin layer of rolled metal \
		will protect you from bullets best, a few blunt blows, and the wounds they cause. Lasers will burn more or less straight through it."
	icon = 'modular_skyrat/modules/specialist_armor/icons/armor.dmi'
	icon_state = "soft_peacekeeper"
	worn_icon = 'modular_skyrat/modules/specialist_armor/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_sf_peacekeeper
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/sf_peacekeeper/examine_more(mob/user)
	. = ..()

	. += "A common SolFed designed armor vest for a common cause, not having your innards become outards. \
		While heavier armors certainly exist, the 'Touvou' is relatively cheap for the protection you do get, \
		and many soldiers and officers around the galaxy will tell you the convenience of a mostly soft body armor. \
		Not for any of the protection, but for the relative comfort, especially in areas where you don't need to care \
		much if you're able to stop an anti materiel round with your chest. Likely due to all those factors, \
		it is a common sight on SolFed peacekeepers around the galaxy, alongside other misfits and corporate baddies \
		across the galaxy."

	return .

/obj/item/clothing/suit/armor/sf_peacekeeper/debranded
	name = "'Touvou' soft armor vest"
	desc = "A bright white vest, notably missing an 'SF' marking on either its front or back. Dense fabric with a thin layer of rolled metal \
		will protect you from bullets best, a few blunt blows, and the wounds they cause. Lasers will burn more or less straight through it."
	icon_state = "soft_civilian"

/obj/item/clothing/head/helmet/sf_peacekeeper
	name = "'Kastrol' peacekeeper helmet"
	desc = "A large, almost always ill-fitting helmet painted in bright blue. It proudly bears the emblems of SolFed on its sides. \
		It will protect from bullets best, with some protection against blunt blows, but falters easily in the presence of lasers."
	icon = 'modular_skyrat/modules/specialist_armor/icons/armor.dmi'
	icon_state = "helmet_peacekeeper"
	worn_icon = 'modular_skyrat/modules/specialist_armor/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_sf_peacekeeper
	dog_fashion = null
	flags_inv = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/helmet/sf_peacekeeper/examine_more(mob/user)
	. = ..()

	. += "A common SolFed designed ballistic helmet for a common cause, keeping your brain inside your head. \
		While heavier helmets certainly exist, the 'Kastrol' is relatively cheap for the protection you do get, \
		and many soldiers don't mind it much due to its large over-head size bypassing a lot of the fitting issues \
		some more advanced or more protective helmets might have. \
		Especially in areas where you don't need to care \
		much if you're able to stop an anti materiel round with your forehead, it does the job just fine. \
		Likely due to all those factors, \
		it is a common sight on SolFed peacekeepers around the galaxy, alongside other misfits and corporate baddies \
		across the galaxy."

	return .

/obj/item/clothing/head/helmet/sf_peacekeeper/debranded
	name = "'Kastrol' ballistic helmet"
	desc = "A large, almost always ill-fitting helmet painted a dull grey. This one seems to lack any special markings. \
		It will protect from bullets best, with some protection against blunt blows, but falters easily in the presence of lasers."
	icon_state = "helmet_grey"
