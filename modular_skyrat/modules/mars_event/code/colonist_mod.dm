/datum/mod_theme/event
	name = "colonizer type N"
	desc = "A suit upgraded from civilian standards to better fit the needs of colonizing harsh environments."
	extended_desc = "Modified from the standard civilian series of suits, the colonizer modification \
	is special built to help the aspiring colony with increased module storage, less power usage, \
	and increased protection from hazards, electrical or environmental. Due to the complexities of these \
	modifications, these suits are hard to replace, and are unable to be made in-situ."
	default_skin = "civilian"
	armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 30, BOMB = 70, BIO = 100, FIRE = 100, ACID = 25, WOUND = 10)
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY + 5
	charge_drain = DEFAULT_CHARGE_DRAIN * 0.25
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

/datum/mod_theme/event/leader
	name = "colonizer type N-L"
	default_skin = "advanced"
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
		"advanced" = list(
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

/obj/item/mod/control/pre_equipped/event
	theme = /datum/mod_theme/event
	applied_cell = /obj/item/stock_parts/cell/super
	initial_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/orebag,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/visor/diaghud,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/status_readout,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/mouthhole,
		/obj/item/mod/module/signlang_radio,
	)

/obj/item/mod/control/pre_equipped/event/plasmaperson
	theme = /datum/mod_theme/event
	applied_cell = /obj/item/stock_parts/cell/super
	initial_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/orebag,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/visor/diaghud,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/status_readout,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/mouthhole,
		/obj/item/mod/module/signlang_radio,
		/obj/item/mod/module/plasma_stabilizer,
	)

/obj/item/mod/control/pre_equipped/event/leader
	theme = /datum/mod_theme/event/leader
	applied_cell = /obj/item/stock_parts/cell/super
	initial_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/orebag,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/visor/diaghud,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/status_readout,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/megaphone,
		/obj/item/mod/module/mouthhole,
		/obj/item/mod/module/signlang_radio,
	)

/datum/mod_theme/event/syndie
	name = "colonizer type S"
	desc = "Prototype suit design rediscovered and refit for the modern era."
	extended_desc = "Another suit taken from previous designs, and refit for use by \
	anyone looking for a suit capable of carrying your crew through the harsh environments \
	of colonizable exoplanets. The type N isn't fit for everyone, some prefer the safe feel \
	of a camera operated display instead of a glass panel, and some simply prefer the \
	orange and black color scheme this suit provides."
	default_skin = "prototype"
	armor = list(MELEE = 50, BULLET = 40, LASER = 30, ENERGY = 40, BOMB = 70, BIO = 100, FIRE = 100, ACID = 40, WOUND = 15)
	skins = list(
		"prototype" = list(
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

/obj/item/mod/control/pre_equipped/event/syndie
	theme = /datum/mod_theme/event/syndie
	applied_cell = /obj/item/stock_parts/cell/super
	initial_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/orebag,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/visor/diaghud,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/status_readout,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/mouthhole,
	)

/obj/item/mod/control/pre_equipped/event/syndie/plasmaperson
	theme = /datum/mod_theme/event/syndie
	applied_cell = /obj/item/stock_parts/cell/super
	initial_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/orebag,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/visor/diaghud,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/status_readout,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/mouthhole,
		/obj/item/mod/module/signlang_radio,
		/obj/item/mod/module/plasma_stabilizer,
	)
