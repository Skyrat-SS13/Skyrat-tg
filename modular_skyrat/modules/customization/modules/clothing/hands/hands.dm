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

/obj/item/clothing/gloves/bracer/wraps
	name = "cloth arm wraps"
	desc = "Cloth bracers, the colour all left up to the choice of the wearer."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	icon_state = "arm_wraps"
	inhand_icon_state = "greyscale_gloves"
	greyscale_config = /datum/greyscale_config/armwraps
	greyscale_config_worn = /datum/greyscale_config/armwraps/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/gloves
	worn_icon_teshari = TESHARI_HANDS_ICON

/obj/item/clothing/gloves/maid_arm_covers
	name = "maid arm covers"
	desc = "Maid in China."
	icon_state = "maid_arm_covers"
	greyscale_config = /datum/greyscale_config/maid_arm_covers
	greyscale_config_worn = /datum/greyscale_config/maid_arm_covers/worn
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = "#7b9ab5#edf9ff"
	flags_1 = IS_PLAYER_COLORABLE_1

