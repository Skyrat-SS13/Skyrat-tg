/datum/outfit/raider
	name = "Deep Space Raider"

	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/bulletproof // eh maybe
	back = /obj/item/mod/control/pre_equipped/raider
	ears = /obj/item/radio/headset/guild
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/helmet/alt
	shoes = /obj/item/clothing/shoes/jackboots
	mask = /obj/item/clothing/mask/breath
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	l_pocket = /obj/item/storage/bag/ammo/mosin
	l_hand = /obj/item/gun/ballistic/rifle/boltaction
	internals_slot = ITEM_SLOT_RPOCKET

/datum/outfit/raider/leader
	name = "Deep Space Raider Leader"

	back = /obj/item/mod/control/pre_equipped/raider/leader
	ears = /obj/item/radio/headset/guild/command
	l_hand = /obj/item/gun/ballistic/rifle/boltaction

/datum/mod_theme/raider
	name = "raider"
	desc = "A prototype suit held together with scrap metal and spare parts."
	extended_desc = "A suit (formerly) created by Nakamura Engineering,\
	This model looks to be old and weathered enough to barely maintain a pressure seal.\
	Filled with aftermarket parts and questionable repair jobs, it's not the fastest suit,\
	but it'll get you through a jam. Probably."
	default_skin = "prototype"
	armor_type = /datum/armor/mod_theme_raider
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

/datum/armor/mod_theme_raider
	melee = 30
	bullet = 40
	laser = 30
	energy = 20
	bomb = 40
	bio = 100
	fire = 100
	acid = 40
	wound = 10

/obj/item/mod/control/pre_equipped/raider
	theme = /datum/mod_theme/raider
	applied_cell = /obj/item/stock_parts/cell/high
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/mouthhole,
		/obj/item/mod/module/magboot,
	)

/obj/item/mod/control/pre_equipped/raider/leader
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/pepper_shoulders, //if nothing else, for identifiability
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/mouthhole,
		/obj/item/mod/module/magboot,
	)

/obj/item/storage/bag/ammo/mosin
	contents = list(
		/obj/item/ammo_box/a762 = 3,
	)


/obj/structure/cannon/trash/raider
	name = "\proper the prototype"
	desc = "You suddenly wonder just how much you had to drink last night."
	fires_before_deconstruction = INFINITY
	can_be_unanchored = TRUE
	anchorable_cannon = TRUE
	explode_chance = 0
