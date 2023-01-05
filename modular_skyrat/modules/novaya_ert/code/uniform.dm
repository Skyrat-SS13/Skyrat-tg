/obj/item/clothing/under/costume/nri //Copied from the russian outfit
	name = "advanced imperial fatigues"
	desc = "The latest in tactical and comfortable russian military outfits."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'
	icon_state = "nri_soldier"
	inhand_icon_state = "hostrench"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 30, ACID = 30)
	strip_delay = 50
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	can_adjust = FALSE

/obj/item/clothing/under/costume/nri/captain
	icon_state = "nri_captain"

/obj/item/clothing/under/costume/nri/medic
	icon_state = "nri_medic"

/obj/item/clothing/under/costume/nri/engineer
	icon_state = "nri_engineer"
