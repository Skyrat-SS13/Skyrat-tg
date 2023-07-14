/obj/item/clothing/under/costume/nri //Copied from the russian outfit
	name = "advanced imperial fatigues"
	desc = "The latest in tactical and comfortable russian military outfits."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'
	icon_state = "nri_soldier"
	inhand_icon_state = "hostrench"
	armor_type = /datum/armor/clothing_under/costume_nri
	strip_delay = 50
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	can_adjust = FALSE

/datum/armor/clothing_under/costume_nri
	melee = 10
	fire = 30
	acid = 30

/obj/item/clothing/under/costume/nri/captain
	icon_state = "nri_captain"

/obj/item/clothing/under/costume/nri/medic
	icon_state = "nri_medic"

/obj/item/clothing/under/costume/nri/engineer
	icon_state = "nri_engineer"
