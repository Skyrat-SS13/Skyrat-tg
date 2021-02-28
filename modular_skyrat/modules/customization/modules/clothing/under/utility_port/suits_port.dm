//Bartender Winter coat, with the ability to hold shakers/beakers/rags in its suit storage slot
/obj/item/clothing/suit/hooded/wintercoat/bartender
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "bartender's winter coat"
	desc = "A heavy jacket made from wool originally stolen from the chef's goat. This new design is made to fit the classic suit-and-tie aesthetic, but without the hypothermia."
	icon_state = "coatbar"
	mutant_variants = NONE
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/reagent_containers/food/drinks/shaker, /obj/item/reagent_containers/food/drinks/flask, /obj/item/reagent_containers/glass/rag)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/bartender

/obj/item/clothing/head/hooded/winterhood/bartender
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "winterhood_bar"

//Base Jacket - same stats as /obj/item/clothing/suit/jacket, just toggleable and serving as the base for all the departmental jackets and flannels
/obj/item/clothing/suit/toggle/jacket
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "bomber jacket"
	desc = "A warm bomber jacket, with synthetic-wool lining to keep you nice and warm in the depths of space. Aviators not included."
	icon_state = "bomberalt"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/radio)
	body_parts_covered = CHEST|ARMS|GROIN
	cold_protection = CHEST|ARMS|GROIN
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	mutant_variants = NONE
	togglename = "zipper"

//Job Jackets
/obj/item/clothing/suit/toggle/jacket/engi
	name = "engineering jacket"
	desc = "A comfortable jacket in engineering yellow."
	icon_state = "engi_dep_jacket"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 20, "fire" = 30, "acid" = 45)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/t_scanner, /obj/item/construction/rcd, /obj/item/pipe_dispenser, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)

/obj/item/clothing/suit/toggle/jacket/sci
	name = "science jacket"
	desc = "A comfortable jacket in science purple."
	icon_state = "sci_dep_jacket"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/toggle/jacket/med
	name = "medbay jacket"
	desc = "A comfortable jacket in medical blue."
	icon_state = "med_dep_jacket"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 0, "acid" = 45)

/obj/item/clothing/suit/toggle/jacket/supply
	name = "cargo jacket"
	desc = "A comfortable jacket in supply brown."
	icon_state = "supply_dep_jacket"

/obj/item/clothing/suit/toggle/jacket/supply/head
	name = "quartermaster's jacket"
	desc = "Even if people refuse to recognize you as a head, they can recognize you as a badass."
	icon_state = "qmjacket"

/obj/item/clothing/suit/toggle/jacket/sec
	name = "security jacket"
	desc = "A comfortable jacket in security blue. Probably against uniform regulations."
	icon_state = "sec_dep_jacket"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 45)

/obj/item/clothing/suit/toggle/jacket/sec/old	//Oldsec (Red)
	icon_state = "sec_dep_jacket_old"

//Flannels
/obj/item/clothing/suit/toggle/jacket/flannel
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "flannel jacket"
	desc = "A cozy and warm plaid flannel jacket. Praised by Lumberjacks and Truckers alike."
	icon_state = "flannel"
	body_parts_covered = CHEST|ARMS //Being a bit shorter, flannels dont cover quite as much as the rest of the woolen jackets (- GROIN)
	cold_protection = CHEST|ARMS
	heat_protection = CHEST|ARMS	//As a plus side, they're more insulating, protecting a bit from the heat as well

/obj/item/clothing/suit/toggle/jacket/flannel/red
	name = "red flannel jacket"
	icon_state = "flannel_red"

/obj/item/clothing/suit/toggle/jacket/flannel/aqua
	name = "aqua flannel jacket"
	icon_state = "flannel_aqua"

/obj/item/clothing/suit/toggle/jacket/flannel/brown
	name = "brown flannel jacket"
	icon_state = "flannel_brown"

//Labcoats
/obj/item/clothing/suit/toggle/labcoat/highvis
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "high vis labcoat"
	desc = "A high visibility vest for emergency responders, intended to draw attention away from the blood."
	icon_state = "labcoat_highvis"
	mutant_variants = NONE

/obj/item/clothing/suit/toggle/labcoat/para_red
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "red paramedic labcoat"
	desc = "A red vest with reflective strips for First Responsers."
	icon_state = "labcoat_pmedred"
	mutant_variants = NONE

//Costume-suits are located under other_port.dm, to keep them with their costume sets