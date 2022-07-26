/datum/mod_theme/event
	name = "upgraded"
	desc = "A suit upgraded from civilian standards to better fit the needs of colonizing harsh environments."
	extended_desc = "While the standards of planetary colonization are usually to land a large \
	colony ship upon the desired planet, some locations exist that can't support this style. That \
	is where this suit comes in, the next common method is simply dropping pods of people and supplies \
	to the planet below, and this upgrade on the standard civilian brand of suit has been modified \
	for increased module capacity, as well as resistance to electrical and environmental hazards. \
	Unfortunately due to the complexity of the upgrade process, more cannot be made in-situ."
	default_skin = "civilian"
	armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 30, BOMB = 70, BIO = 100, FIRE = 100, ACID = 25, WOUND = 10)
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY + 5
	charge_drain = DEFAULT_CHARGE_DRAIN - 2
	slowdown_inactive = 1
	slowdown_active = 0.5
	inbuilt_modules = list(/obj/item/mod/module/springlock/contractor/no_complexity)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/analyzer,
		/obj/item/construction/rcd,
		/obj/item/pipe_dispenser,
		/obj/item/t_scanner,
		/obj/item/storage/bag/construction,
	)
	skins = list(
		"civilian" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
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

/obj/item/mod/control/pre_equipped/event
	theme = /datum/mod_theme/event
	applied_cell = /obj/item/stock_parts/cell/super
	initial_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/orebag,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/flashlgiht,
		/obj/item/mod/module/visor/diaghud,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/status_readout,
		/obj/item/mod/module/thermal_regulator,
	)
