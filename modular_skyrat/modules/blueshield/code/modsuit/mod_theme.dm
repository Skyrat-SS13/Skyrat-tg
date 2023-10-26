/datum/mod_theme/blueshield
	name = "praetorian"
	desc = "A prototype of the Magnate-class suit issued to station Blueshields, still boasting exceptional protection worthy of an honor guard."
	extended_desc = "A prototype of the Magnate-class suit issued for use with the station Blueshields, \
		it boasts the exceptional protection of it's successor, while sacrificing some of the module capacity.\
		All of the protection of the Magnate, with none of the comfort! The visor uses blue-light to obscure \
		the face of it's wearer, adding to it's imposing figure. Compared to the sleek and luxurious design \
		that came after it, this suit does nothing to hide it's purpose, the reinforced plating layered \
		over the insulated inner armor granting it protection against corrosive liquids, explosive blasts, \
		fires, electrical shocks, and contempt from the rest of the crew."

	default_skin = "praetorian"
	armor_type = /datum/armor/mod_theme_blueshield
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY + 3
	slowdown_inactive = 0.75
	slowdown_active = 0.25
	allowed_suit_storage = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	skins = list(
		"praetorian" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/blueshield/icons/praetorian.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/blueshield/icons/worn_praetorian.dmi',
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/armor/mod_theme_blueshield
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 20
