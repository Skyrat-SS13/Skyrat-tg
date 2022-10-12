//Bartender Winter coat, with the ability to hold shakers/beakers/rags in its suit storage slot
/obj/item/clothing/suit/hooded/wintercoat/bartender
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "bartender's winter coat"
	desc = "A heavy jacket made from wool originally stolen from the chef's goat. This new design is made to fit the classic suit-and-tie aesthetic, but without the hypothermia."
	icon_state = "coatbar"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/reagent_containers/cup/glass/shaker, /obj/item/reagent_containers/cup/glass/flask, /obj/item/reagent_containers/cup/rag)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/bartender

/obj/item/clothing/head/hooded/winterhood/bartender
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "winterhood_bar"

//Base Jacket - same stats as /obj/item/clothing/suit/jacket, just toggleable and serving as the base for all the departmental jackets and flannels
/obj/item/clothing/suit/toggle/jacket
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "bomber jacket"
	desc = "A warm bomber jacket, with synthetic-wool lining to keep you nice and warm in the depths of space. Aviators not included."
	icon_state = "bomberalt"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/radio)
	body_parts_covered = CHEST|ARMS|GROIN
	cold_protection = CHEST|ARMS|GROIN
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	toggle_noun = "zipper"

//Job Jackets
/obj/item/clothing/suit/toggle/jacket/engi
	name = "engineering jacket"
	desc = "A comfortable jacket in engineering yellow."
	icon_state = "engi_dep_jacket"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 30, ACID = 45, WOUND = 0)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/t_scanner, /obj/item/construction/rcd, /obj/item/pipe_dispenser, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)

/obj/item/clothing/suit/toggle/jacket/sci
	name = "science jacket"
	desc = "A comfortable jacket in science purple."
	icon_state = "sci_dep_jacket"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 10, BIO = 0, FIRE = 0, ACID = 0, WOUND = 0)

/obj/item/clothing/suit/toggle/jacket/med
	name = "medbay jacket"
	desc = "A comfortable jacket in medical blue."
	icon_state = "med_dep_jacket"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 50, FIRE = 0, ACID = 45, WOUND = 0)

/obj/item/clothing/suit/toggle/jacket/supply
	name = "cargo jacket"
	desc = "A comfortable jacket in supply brown."
	icon_state = "supply_dep_jacket"

/obj/item/clothing/suit/toggle/jacket/assistant
	name = "non-departmental jacket"
	desc = "A comfortable jacket in a neutral black"
	icon_state = "off_dep_jacket"

/obj/item/clothing/suit/gorka	//THIS WILL BE MOVED IN THE NEXT PR ADDING PROPER GORKAS (not cargo related so not in this PR), BUT FOR NOW ITS HERE FOR THE SUBTYPE'S FILE LINKS
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/gorka/supply	//Put here for sorting purposes, considering the cargo gorkas are in the utility file too. The base Gorka and Jacket (to be added later) will most likely be elsewhere
	name = "supply gorka jacket"
	desc = "A snug jacket to wear over your gorka. This one matches with supply's colors."
	icon_state = "gorka_jacket_supply"

/obj/item/clothing/suit/toggle/jacket/supply/head
	name = "quartermaster's jacket"
	desc = "Even if people refuse to recognize you as a head, they can recognize you as a badass."
	icon_state = "qmjacket"

/obj/item/clothing/suit/toggle/jacket/sec
	name = "security jacket"
	desc = "A comfortable jacket in security blue. Probably against uniform regulations."
	icon_state = "sec_dep_jacket"
	armor = list(MELEE = 25, BULLET = 15, LASER = 30, ENERGY = 10, BOMB = 25, BIO = 0, FIRE = 0, ACID = 45, WOUND = 0)

/obj/item/clothing/suit/toggle/jacket/sec/old	//Oldsec (Red)
	icon_state = "sec_dep_jacket_old"

//Flannels
/obj/item/clothing/suit/toggle/jacket/flannel
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
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
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "high vis labcoat"
	desc = "A high visibility vest for emergency responders, intended to draw attention away from the blood."
	icon_state = "labcoat_highvis"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/para_red
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "red paramedic labcoat"
	desc = "A red vest with reflective strips for First Responsers."
	icon_state = "labcoat_pmedred"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/para_red/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/storage/medkit,
	)

//Costume-suits are located under other_port.dm, to keep them with their costume sets
