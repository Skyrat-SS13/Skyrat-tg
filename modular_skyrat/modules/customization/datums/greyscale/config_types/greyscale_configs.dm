/// BERETS ///
/datum/greyscale_config/beret
	name = "Beret"
	icon_file = 'modular_skyrat/modules/berets/icons/obj/clothing/head/beret.dmi'
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/beret/beret.json'

/datum/greyscale_config/beret/worn
	name = "Beret Worn"
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/beret/beret_worn.json'

/datum/greyscale_config/beret_badge
	name = "Beret With Badge"
	icon_file = 'modular_skyrat/modules/berets/icons/obj/clothing/head/beret.dmi'
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/beret/beret_badge.json'

/datum/greyscale_config/beret_badge/worn
	name = "Beret With Badge Worn"
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/beret/beret_badge_worn.json'

/datum/greyscale_config/beret_badge_fancy
	name = "Beret With Fancy Badge"
	icon_file = 'modular_skyrat/modules/berets/icons/obj/clothing/head/beret.dmi'
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/beret/beret_badge_fancy.json'

/datum/greyscale_config/beret_badge_fancy/worn
	name = "Beret With Fancy Badge Worn"
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/beret/beret_badge_fancy_worn.json'

/////-----UNIFORMS-----/////
/datum/greyscale_config/turtleneck
	name = "Turtleneck"
	icon_file = 'modular_skyrat/modules/berets/icons/obj/clothing/head/beret.dmi'
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/under/unsorted.json'

/datum/greyscale_config/turtleneck/worn
	name = "Turtleneck Worn"
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/under/unsorted_worn.json'

/////-----SUITS-----/////
/// HOODIES ///
/datum/greyscale_config/hoodie
	name = "Hoodie"
	icon_file = 'modular_skyrat/modules/berets/icons/obj/clothing/head/beret.dmi'	//TEMPORARY, WILL BE CHANGED
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/suit/hoodie/hoodie.json'

/datum/greyscale_config/hoodie/worn
	name = "Hoodie Worn"
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/suit/hoodie/hoodie_worn.json'

/datum/greyscale_config/hoodie/trim
	name = "Trimmed Hoodie"
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/suit/hoodie/hoodie_trim.json'

/datum/greyscale_config/hoodie/trim/worn
	name = "Trimmed Hoodie Worn"
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/suit/hoodie/hoodie_trim_worn.json'

/datum/greyscale_config/hoodie/branded
	name = "Branded Hoodie"
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/suit/hoodie/hoodie_branded.json'

/datum/greyscale_config/hoodie/branded/worn
	name = "Branded Hoodie Worn"
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/suit/hoodie/hoodie_branded_worn.json'

/// PATTERNED + TEMPLATES///
/// Due to how generic most of these are, they'll be in the same .json and their differences chosen by the icon_state
/// Currently this includes Flannels and Hawaiian Shirts (Add to this list if it changes)
/datum/greyscale_config/SR_suittemplate
	name = "Template-Built Suit"
	icon_file = 'modular_skyrat/modules/berets/icons/obj/clothing/head/beret.dmi'
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/suit/template.json'

/datum/greyscale_config/SR_suittemplate/worn
	name = "Template-Built Suit Worn"
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/suit/template_worn.json'

/// MISC ///
///I just dunno where to put these ones ngl, same as above: determined by the icon_state but otherwise in the same .json
/datum/greyscale_config/SR_suitmisc
	name = "Misc Suit"
	icon_file = 'modular_skyrat/modules/berets/icons/obj/clothing/head/beret.dmi'
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/suit/unsorted.json'

/datum/greyscale_config/SR_suitmisc/worn
	name = "Misc Suit Worn"
	json_config = 'modular_skyrat/modules/customization/datums/greyscale/json_configs/suit/unsorted_worn.json'
