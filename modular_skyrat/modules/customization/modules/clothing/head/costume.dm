/obj/item/clothing/head/costume/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/costume.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	dog_fashion = null

/obj/item/clothing/head/costume/skyrat/maid
	name = "maid headband"
	desc = "Maid in China."
	icon_state = "maid"

/obj/item/clothing/head/costume/skyrat/papakha
	name = "papakha"
	desc = "A big wooly clump of fur designed to go on your head."
	icon_state = "papakha"
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/costume/skyrat/papakha/white
	icon_state = "papakha_white"

/obj/item/clothing/head/costume/skyrat/flowerpin
	name = "flower pin"
	desc = "A small, colourable flower pin"
	icon_state = "flowerpin"
	greyscale_config = /datum/greyscale_config/flowerpin
	greyscale_config_worn = /datum/greyscale_config/flowerpin/worn
	greyscale_colors = "#FF0000"
	flags_1 = IS_PLAYER_COLORABLE_1
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/head/costume/skyrat/christmas
	name = "christmas hat"
	desc = "How festive!"
	icon_state = "christmas"

/obj/item/clothing/head/costume/skyrat/christmas/green
	icon_state = "christmas_g"

/obj/item/clothing/head/costume/skyrat/en //One of the two parts of E-N's butchering
	name = "E-N suit head"
	icon_state = "enhead"
	supports_variations_flags = NONE

//Ushankas
//These have to be subtypes of TG's ushanka to inherit the toggleability
/obj/item/clothing/head/costume/ushanka/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/costume.dmi'
	name = "security ushanka"
	desc = "A warm and comfortable ushanka, dyed with 'all natural flavors' according to the tag."
	icon_state = "ushankablue"
	inhand_icon_state = "rus_ushanka"
	upsprite = "ushankablueup"
	downsprite = "ushankablue"

//Pelts
//Not made into a subtype of /costume but stored in the same file
/obj/item/clothing/head/pelt
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/costume.dmi'
	name = "bear pelt"
	desc = "A luxurious bear pelt, good to keep warm in winter. Or to sleep through it."
	icon_state = "bearpelt_brown"
	inhand_icon_state = "cowboy_hat_brown"
	cold_protection = CHEST|HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/head/pelt/black
	icon_state = "bearpelt_black"
	inhand_icon_state = "cowboy_hat_black"

/obj/item/clothing/head/pelt/white
	icon_state = "bearpelt_white"
	inhand_icon_state = "cowboy_hat_white"

/obj/item/clothing/head/pelt/tiger
	name = "shiny tiger pelt"
	desc = "A vibrant tiger pelt, particularly fabulous."
	icon_state = "tigerpelt_shiny"
	inhand_icon_state = "cowboy_hat_grey"

/obj/item/clothing/head/pelt/snow_tiger
	name = "snow tiger pelt"
	desc = "A pelt of a less vibrant tiger, but rather warm."
	icon_state = "tigerpelt_snow"
	inhand_icon_state = "cowboy_hat_white"

/obj/item/clothing/head/pelt/pink_tiger
	name = "pink tiger pelt"
	desc = "A particularly vibrant tiger pelt, for those who want to be the most fabulous at parties."
	icon_state = "tigerpelt_pink"
	inhand_icon_state = "cowboy_hat_red"

/obj/item/clothing/head/pelt/wolf
	name = "wolf pelt"
	desc = "A fuzzy wolf pelt that demands respect as a hunter... assuming it wasn't just purchased, that is, for all the glory but none of the credit."
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/pelt_big.dmi'
	icon_state = "wolfpelt_brown"

/obj/item/clothing/head/pelt/wolf/black
	icon_state = "wolfpelt_gray"
	inhand_icon_state = "cowboy_hat_grey"

/obj/item/clothing/head/pelt/wolf/white
	icon_state = "wolfpelt_white"
	inhand_icon_state = "cowboy_hat_white"
//End Pelts
