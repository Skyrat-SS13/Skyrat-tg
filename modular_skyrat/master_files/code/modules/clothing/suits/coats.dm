//Coat Basetype (The Assistant's Formal Coat)
/obj/item/clothing/suit/hooded/wintercoat/skyrat
	name = "assistant's formal winter coat"
	desc = "A dark gray winter coat with bronze-gold detailing, and a zipper in the shape of a toolbox."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/wintercoat.dmi'
	icon_state = "coataformal"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat

//Hood Basetype (The Assistant's Formal Coat Hood)
/obj/item/clothing/head/hooded/winterhood/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/winterhood.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/winterhood.dmi'
	icon_state = "hood_aformal"

//Bartender
/obj/item/clothing/suit/hooded/wintercoat/skyrat/bartender
	name = "bartender's winter coat"
	desc = "A heavy jacket made from wool originally stolen from the chef's goat. This new design is made to fit the classic suit-and-tie aesthetic, but without the hypothermia."
	icon_state = "coatbar"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	allowed = list(
		/obj/item/flashlight,
		/obj/item/reagent_containers/cup/glass/shaker,
		/obj/item/reagent_containers/cup/glass/flask,
		/obj/item/reagent_containers/cup/rag
	)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat/bartender

/obj/item/clothing/head/hooded/winterhood/skyrat/bartender
	icon_state = "hood_bar"

//HoP's Formal
/obj/item/clothing/suit/hooded/wintercoat/skyrat/hopformal
	name = "head of personnel's formal winter coat"
	desc = "A long cozy winter coat, covered in thick fur. The breast features a proud yellow chevron, reminding everyone that you're the second banana. Someone at CC most really like you, huh?"
	icon_state = "coathopformal"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/hopformal

/obj/item/clothing/head/hooded/winterhood/hopformal
	icon_state = "hood_hopformal"

//Ratvar-themed
/obj/item/clothing/suit/hooded/wintercoat/skyrat/ratvar
	name = "ratvarian winter coat"
	desc = "A brass-plated button up winter coat. Instead of a zipper tab, it has a brass cog with a tiny red gemstone inset."
	icon_state = "coatratvar"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat/ratvar

/obj/item/clothing/head/hooded/winterhood/skyrat/ratvar
	icon_state = "hood_ratvar"

//Nar'sie-themed
/obj/item/clothing/suit/hooded/wintercoat/skyrat/narsie
	name = "narsian winter coat"
	desc = "A somber button-up in dark tones of grey entropy and a wicked crimson zipper. It's covered in intricate runes and symbols, and the zipper tab looks like a single drop of blood."
	icon_state = "coatnarsie"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat/narsie

/obj/item/clothing/head/hooded/winterhood/skyrat/narsie
	desc = "A black winter hood full of whispering secrets that only she shall ever know."
	icon_state = "hood_narsie"
