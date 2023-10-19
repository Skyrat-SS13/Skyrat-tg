/obj/machinery/vending/primitive_catgirl_clothing_vendor
	name = "wardrobe"
	desc = "It's a big wardrobe filled up with all sorts of clothing."
	icon = 'icons/obj/storage/closet.dmi'
	icon_state = "cabinet"

	use_power = FALSE

	shut_up = TRUE
	vend_reply = null

	products = list(
		/obj/item/clothing/under/dress/skirt/primitive_catgirl_body_wraps = 15,
		/obj/item/clothing/suit/jacket/primitive_catgirl_coat = 15,
		/obj/item/clothing/gloves/fingerless/primitive_catgirl_armwraps = 15,
		/obj/item/clothing/shoes/winterboots/ice_boots/primitive_catgirl_boots = 15,
		/obj/item/clothing/gloves/fingerless/primitive_catgirl_gauntlets = 10,
		/obj/item/clothing/mask/primitive_catgirl_greyscale_gaiter = 10,
		/obj/item/clothing/suit/apron/chef/colorable_apron/primitive_catgirl_leather = 10,
		/obj/item/clothing/head/standalone_hood/primitive_catgirl_colors = 10,
		/obj/item/clothing/neck/scarf/primitive_catgirl_scarf = 5,
		/obj/item/clothing/neck/large_scarf/primitive_catgirl_off_white = 5,
		/obj/item/clothing/neck/infinity_scarf/primitive_catgirl_blue = 5,
		/obj/item/clothing/neck/mantle/recolorable/primitive_catgirl_off_white = 5,
		/obj/item/clothing/neck/ranger_poncho/primitive_catgirl_leather = 5,
		/obj/item/clothing/glasses/eyepatch/wrap = 5,
		/obj/item/clothing/head/pelt/snow_tiger = 5,
		/obj/item/clothing/head/pelt/black = 5,
		/obj/item/clothing/head/pelt/white = 5,
		/obj/item/clothing/head/pelt/wolf = 5,
		/obj/item/clothing/head/pelt/wolf/white = 5,
	)

/obj/machinery/vending/primitive_catgirl_clothing_vendor/Initialize(mapload)
	. = ..()

	onstation = FALSE

/obj/machinery/vending/primitive_catgirl_clothing_vendor/speak(message)
	return
