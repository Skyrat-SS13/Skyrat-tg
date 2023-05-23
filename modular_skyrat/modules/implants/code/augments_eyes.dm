/obj/item/organ/internal/eyes/robotic
	icon = 'modular_skyrat/modules/implants/icons/internal_HA.dmi' //So I had to fucking include the eye sprites
	icon_state = "cybernetic_eyeballs"

/obj/item/organ/internal/eyes/robotic/xray
	eye_color_left = "#00ffe5"
	eye_color_right = "#00ffe5"
	icon_state = "xray_eyes"

/obj/item/organ/internal/eyes/robotic/thermals
	eye_color_left = "#FC0"
	eye_color_right = "#FC0"
	icon_state = "thermal_eyes"

/obj/item/organ/internal/eyes/robotic/shield
	eye_color_left = "#ff2700"
	eye_color_right = "#ff2700"
	icon_state = "shielded_eyes"

/obj/item/organ/internal/eyes/night_vision/cyber
	name = "nightvision eyes"
	icon = 'modular_skyrat/modules/implants/icons/internal_HA.dmi' //All in the chest implants .dmi
	icon_state = "eyes_nvcyber"
	desc = "A pair of eyes with built-in nightvision optics, with the additional bonus of being rad as hell."
	eye_color_left = "#0ffc03"
	eye_color_right = "#ff2700"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	low_light_cutoff = list(0, 15, 20)
	medium_light_cutoff = list(0, 20, 35)
	high_light_cutoff = list(0, 40, 50)
