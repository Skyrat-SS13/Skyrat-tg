// Its modsuiting time

/datum/mod_theme/frontier_colonist
	name = "frontier hazard protective"
	desc = "An unusual design of suit, in reality being no more than a slim underlayer with a built in coat and sealed helmet."
	extended_desc = "The pinnacle of frontier cheap technology. Suits like this are usually not unified in design \
		though are common in frontier settlements with less than optimal infrastructure. As with most unofficial \
		designs, there are flaws and no single one is perfect, but they achieve a singular goal and that is the \
		important part. Suits such as these are made specifically for the rare emergency that creates a hazard \
		environment that other equipment just can't quite handle. Often, these suits are able to protect their users \
		from not only electricity, but also radiation, biological hazards, other people, so on. This suit will not, \
		however, protect you from yourself."

	default_skin = "colonist"
	armor_type = /datum/armor/colonist_hazard
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY - 7
	charge_drain = DEFAULT_CHARGE_DRAIN * 2
	slowdown_inactive = 1.5
	slowdown_active = 1
	inbuilt_modules = list(
		/obj/item/mod/module/plate_compression/permanent,
		/obj/item/mod/module/joint_torsion/permanent
	)
	allowed_suit_storage = list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/flashlight,
		/obj/item/gun,
		/obj/item/melee,
		/obj/item/tank/internals,
		/obj/item/storage/belt/holster,
		/obj/item/construction,
		/obj/item/fireaxe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/storage/medkit,
	)
	skins = list(
		"colonist" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/kahraman_equipment/icons/modsuits/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/kahraman_equipment/icons/modsuits/mod_worn.dmi',
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
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

/obj/item/mod/control/pre_equipped/frontier_colonist
	theme = /datum/mod_theme/frontier_colonist
	applied_cell = /obj/item/stock_parts/cell/high
	applied_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/status_readout,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/rad_protection,
	)
	default_pins = list(
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/thermal_regulator,
	)

/obj/item/mod/control/pre_equipped/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Plate compression module that cannot be removed

/obj/item/mod/module/plate_compression/permanent
	removable = FALSE
	complexity = 0

// Joint torsion module that can't be removed and has no complexity

/obj/item/mod/module/joint_torsion/permanent
	removable = FALSE
	complexity = 0
