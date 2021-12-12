/datum/outfit/shuttle_pilot
	name = "Shuttle Pilot"

	shoes = /obj/item/clothing/shoes/combat/tan
	ears = /obj/item/radio/headset/heads/captain
	uniform = /obj/item/clothing/under/rank/utility_tan
	glasses = /obj/item/clothing/glasses/sunglasses/swat
	head = /obj/item/clothing/head/helmet/tan
	suit = /obj/item/clothing/suit/armor/vest/tan

	belt = /obj/item/storage/belt/military/tan

	gloves = /obj/item/clothing/gloves/combat/tan

	back = /obj/item/storage/backpack/satchel/leather

	box = /obj/item/storage/box/survival/expeditionary_corps

	backpack_contents = list(/obj/item/advanced_choice_beacon/exp_corps)

	id = /obj/item/card/id/advanced/chameleon/black

	belt = /obj/item/pda/syndicate

/obj/item/clothing/shoes/combat/tan
	name = "tan combat boots"
	desc = "High speed, low drag combat boots."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "tanboots"
	inhand_icon_state = "tanboots"

/obj/item/clothing/under/rank/utility_tan
	name = "tan utility uniform"
	icon_state = "tanutility"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 10, BIO = 10, FIRE = 30, ACID = 30, WOUND = 10)
	strip_delay = 70
	alt_covers_chest = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/storage/belt/military/tan
	name = "tan chest rig"
	desc = "A set of tactical webbing."
	icon_state = "webbing_tan"
	worn_icon_state = "webbing_tan"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'

/obj/item/clothing/gloves/combat/tan
	name = "tan combat gloves"
	icon_state = "gloves_tan"
	worn_icon_state = "gloves_tan"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'

/obj/item/clothing/head/helmet/tan
	name = "tan helmet"
	desc = "A robust helmet."
	icon_state = "tanhelmet"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 30, BIO = 0, FIRE = 80, ACID = 100, WOUND = 30)
	mutant_variants = NONE

/obj/item/clothing/suit/armor/vest/tan
	name = "tan armor vest"
	desc = "An armored vest that provides decent protection against most types of damage."
	icon_state = "tanarmor"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 40, BIO = 0, FIRE = 80, ACID = 100, WOUND = 30)
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS
	dog_fashion = null
	mutant_variants = NONE

/obj/item/clothing/glasses/sunglasses/swat
	name = "swat goggles"
	desc = "Combat goggles providing decent eye protection."
	icon_state = "swat_goggles"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
