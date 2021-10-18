/*
Self explanatory, this file is for suits that are GAGSified. If it doesnt have greyscale, it doesnt go here.
*/

///HOODIES///
///The hoodies and attached sprites [WERE ORIGINALLY FROM] https://github.com/Citadel-Station-13/Citadel-Station-13-RP before GAGSification
///Respective datums can be found in modular_skyrat/modules/customization/datums/greyscale/hoodies
///These are now a subtype of toggle/jacket too, so it properly toggles and isnt the unused 'storage' type
/obj/item/clothing/suit/toggle/jacket/hoodie
	name = "hoodie"
	desc = "A warm hoodie. you cant help but mess with the zipper..."
	icon_state = "hoodie"
	greyscale_config = /datum/greyscale_config/hoodie
	greyscale_config_worn = /datum/greyscale_config/hoodie/worn
	greyscale_colors = "#a8a8a8"
	flags_1 = IS_PLAYER_COLORABLE_1
	mutant_variants = NONE
	min_cold_protection_temperature = T0C - 20	//Not as good as the base jacket

/obj/item/clothing/suit/toggle/jacket/hoodie/trim
	icon_state = "hoodie_trim"
	greyscale_config = /datum/greyscale_config/hoodie/trim
	greyscale_config_worn = /datum/greyscale_config/hoodie/trim/worn
	greyscale_colors = "#ffffff#313131"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/jacket/hoodie/trim/alt
	icon_state = "hoodie_trim_alt"
	greyscale_colors = "#ffffff#313131"
	flags_1 = IS_PLAYER_COLORABLE_1

///Preset greyscales + branded hoodies
/obj/item/clothing/suit/toggle/jacket/hoodie/white
	greyscale_colors = "#ffffff"

/obj/item/clothing/suit/toggle/jacket/hoodie/black
	greyscale_colors = "#313131"

/obj/item/clothing/suit/toggle/jacket/hoodie/red
	greyscale_colors = "#D13838"

/obj/item/clothing/suit/toggle/jacket/hoodie/blue
	greyscale_colors = "#034A8D"

/obj/item/clothing/suit/toggle/jacket/hoodie/green
	greyscale_colors = "#1DA103"

/obj/item/clothing/suit/toggle/jacket/hoodie/orange
	greyscale_colors = "#F79305"

/obj/item/clothing/suit/toggle/jacket/hoodie/yellow
	greyscale_colors = "#F0D655"

/obj/item/clothing/suit/toggle/jacket/hoodie/branded
	name = "NT hoodie"
	desc = "A warm, blue sweatshirt.  It proudly bears the silver NanoTrasen insignia lettering on the back.  The edges are trimmed with silver."
	icon_state = "hoodie_NT"
	greyscale_config = /datum/greyscale_config/hoodie/branded
	greyscale_config_worn = /datum/greyscale_config/hoodie/branded/worn
	greyscale_colors = "#02519A#ffffff"	//white to prevent changing the actual color of the icon. I've no clue why it REQUIRES two inputs despite being set otherwise.
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/hoodie/branded/nrti
	name = "New Reykjavik Technical Institute hoodie"
	desc = "A warm, gray sweatshirt. It bears the letters NRT on the back, in reference to Sif's premiere technical institute."
	icon_state = "hoodie_NRTI"
	greyscale_colors = "#747474#a83232"

/obj/item/clothing/suit/toggle/jacket/hoodie/branded/mu
	name = "mojave university hoodie"
	desc = "A warm, gray sweatshirt.  It bears the letters MU on the front, a lettering to the well-known public college, Mojave University."
	icon_state = "hoodie_MU"
	greyscale_colors = "#747474#ffffff"


/obj/item/clothing/suit/toggle/jacket/hoodie/branded/cti
	name = "CTI hoodie"
	desc = "A warm, black sweatshirt.  It bears the letters CTI on the back, a lettering to the prestigious university in Tau Ceti, Ceti Technical Institute.  There is a blue supernova embroidered on the front, the emblem of CTI."
	icon_state = "hoodie_CTI"
	greyscale_colors = "#313131#ffffff"

/obj/item/clothing/suit/toggle/jacket/hoodie/branded/smw
	name = "Space Mountain Wind hoodie"
	desc = "A warm, black sweatshirt.  It has the logo for the popular softdrink Space Mountain Wind on both the front and the back."
	icon_state = "hoodie_SMW"
	greyscale_colors = "#313131#ffffff"

///---BELOW THIS LINE ARE ITEMS THAT USE THE TEMPLATE METHOD, APPLYING THE LAYERS ACCORDINGLY ALONG WITH PATTERNS. Basically, instead of suitpants and suitskirt, its suittop + pants or skirt---///
///---MOST OF THESE WILL BE IN THE SAME CONFIG, USE THE ICON_STATE TO DETERMINE WHICH CLOTHING USES WHICH PATTERN
///FLANNELS///
/obj/item/clothing/suit/toggle/jacket/flannel
	name = "flannel jacket"
	desc = "A cozy and warm plaid flannel jacket. Praised by Lumberjacks and Truckers alike."
	icon_state = "flannel"
	greyscale_config = /datum/greyscale_config/SR_suittemplate
	greyscale_config_worn = /datum/greyscale_config/SR_suittemplate/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#ffffff"
	mutant_variants = NONE
	body_parts_covered = CHEST|ARMS //Being a bit shorter, flannels dont cover quite as much as the rest of the woolen jackets (- GROIN)
	cold_protection = CHEST|ARMS
	heat_protection = CHEST|ARMS	//As a plus side, they're more insulating, protecting a bit from the heat as well

///Preset greyscales
/obj/item/clothing/suit/toggle/jacket/flannel/black
	greyscale_colors = "#3B3B3B"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/flannel/red
	greyscale_colors = "#A61E1F"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/flannel/aqua
	greyscale_colors = "#1EA4A6"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/flannel/brown
	greyscale_colors = "#662E12"
	flags_1 = NONE

///HAWAIIAN SHIRTS///
/obj/item/clothing/suit/hawaiian	//THIS OVERWRITES THE BASE TG HAWAIIAN SHIRT. I DO NOT CARE. IT FUNCTIONS AND APPEARS THE SAME ANYWAYS
	name = "hawaiian shirt"
	desc = "Strangely en vouge with aviator wearing shibas."
	icon_state = "hawaiian"
	greyscale_config = /datum/greyscale_config/SR_suittemplate
	greyscale_config_worn = /datum/greyscale_config/SR_suittemplate/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#F79305"	//Starts out blue, to preserve the base tg item
	mutant_variants = NONE
	body_parts_covered = CHEST|GROIN

///Preset greyscales
/obj/item/clothing/suit/hawaiian/orange
	greyscale_colors = "#F79305"
	flags_1 = NONE

/obj/item/clothing/suit/hawaiian/purple
	greyscale_colors = "#F79305"
	flags_1 = NONE


/obj/item/clothing/suit/hawaiian/green
	greyscale_colors = "#F79305"
	flags_1 = NONE

///MISC///
///These were probably converted from the old Polychromatic system, or are just solo items.
///Again, same as above, these are all in the same .json and the actual stuff determined by the icon_state
/obj/item/clothing/suit/toggle/jacket/cardigan
	name = "cardigan"
	desc = "It's like, half a jacket."
	icon_state = "cardigan"
	greyscale_config = /datum/greyscale_config/SR_suitmisc
	greyscale_config_worn = /datum/greyscale_config/SR_suitmisc/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#FFFFFF"
	mutant_variants = NONE

/obj/item/clothing/suit/jacket/leather/greyscale
	desc = "Pompadour not included; however, synthetic dyes ARE included."
	icon_state = "leatherjacket"
	greyscale_config = /datum/greyscale_config/SR_suitmisc
	greyscale_config_worn = /datum/greyscale_config/SR_suitmisc/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#FFFFFF"

/*
/obj/item/clothing/suit/urban
	name = "urban coat"
	desc = "A coat built for urban life."
	icon_state = "urbanjacket"
	greyscale_config = /datum/greyscale_config/SR_suitmisc
	greyscale_config_worn = /datum/greyscale_config/SR_suitmisc/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#FFFFFF"
	mutant_variants = NONE
*/ //I lost the damn icon state oh god oh fuck

/*

	"urbanjacket": [
		{
			"type": "icon_state",
			"icon_state": "urbanjacket_obj",
			"blend_mode": "overlay",
			"color_ids": [ 1 ]
		}
	],
	,
	"urbanjacket": [
		{
			"type": "icon_state",
			"icon_state": "urbanjacket",
			"blend_mode": "overlay",
			"color_ids": [ 1 ]
		}
	]
	*/

/obj/item/clothing/suit/duster
	name = "duster"
	desc = "This station aint big enough for the both of us."
	icon_state = "duster"
	greyscale_config = /datum/greyscale_config/SR_suitmisc
	greyscale_config_worn = /datum/greyscale_config/SR_suitmisc/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#FFFFFF"
	mutant_variants = NONE

/obj/item/clothing/suit/toggle/peacoat
	name = "peacoat"
	desc = "The way you guys are blending in with the local colour. I mean, Flag Girl was bad enough, but U-Boat Captain?"
	icon_state = "peacoat"
	greyscale_config = /datum/greyscale_config/SR_suitmisc
	greyscale_config_worn = /datum/greyscale_config/SR_suitmisc/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#FFFFFF"
	mutant_variants = NONE

/*TODO SUITS*/

/obj/item/clothing/suit/hooded/wintercoat/polychromic
/obj/item/clothing/head/hooded/winterhood/polychromic
