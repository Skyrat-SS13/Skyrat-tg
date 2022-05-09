/obj/item/clothing/gloves/evening
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	name = "evening gloves"
	desc = "Thin, pretty gloves intended for use in regal feminine attire, but knowing Space China these are just for some maid fetish."
	icon_state = "evening"
	strip_delay = 40
	equip_delay_other = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT

/obj/item/clothing/gloves/kim
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	name = "aerostatic gloves"
	desc = "Vivid red gloves that exude a mysterious style, sadly not the best for gardening, or getting bodies out of trees."
	icon_state = "aerostatic_gloves"

/obj/item/clothing/gloves/military
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	name = "military gloves"
	desc = "Tactical gloves made for military personnel, they are thin to allow easy operation of most firearms."
	icon_state = "military_gloves"
	siemens_coefficient = 0.4
	strip_delay = 60
	equip_delay_other = 60
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
