

/obj/item/clothing/suit/armor/vest/nanotrasen_representative
	name = "nanotrasen coat"
	desc = "A premium black coat with real fur round the neck, it seems to have some armor padding inside as well."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "bladerunner"
	inhand_icon_state = "armoralt"
	blood_overlay_type = "suit"
	dog_fashion = null
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|ARMS|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT

/obj/item/clothing/under/rank/nanotrasen_representative
	desc = "It's a green jumpsuit with some gold markings denoting the rank of \"Nanotrasen Representative\"."
	name = "nanotrasen representative's jumpsuit"
	icon_state = "ntrep"
	inhand_icon_state = "b_suit"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/nanotrasen_representative/skirt
	name = "nanotrasen representative's jumpskirt"
	desc = "It's a green jumpskirt with some gold markings denoting the rank of \"Nanotrasen Representative\"."
	icon_state = "ntrep_skirt"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/head/beret/nanotrasen_representative
	name = "nanotrasen representative's beret"
	desc =  "A beret made from durathread, it has an insignia on the front denoting the rank of a Nanotrasen Representative."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "ntrep_berret"
	armor = list(MELEE = 15, BULLET = 5, LASER = 15, ENERGY = 25, BOMB = 10, BIO = 0, RAD = 0, FIRE = 30, ACID = 5, WOUND = 4)

/obj/item/clothing/head/nanotrasen_representative
	name = "nanotrasen representative's hat"
	desc = "A cap made from durathread, it has an insignia on the front denoting the rank of a Nanotrasen Representative."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "ntrep_cap"
	inhand_icon_state = "that"
	flags_inv = 0
	armor = list(MELEE = 15, BULLET = 5, LASER = 15, ENERGY = 25, BOMB = 10, BIO = 0, RAD = 0, FIRE = 30, ACID = 5, WOUND = 4)
	strip_delay = 60
	dog_fashion = null
