// Signal Technician
/obj/item/clothing/suit/hooded/wintercoat/engineering/tcomms
	name = "signal technician winter coat"
	desc = "A surprisingly heavy yellow winter coat with reflective orange stripes. It has a small wrench for its zipper tab, and the inside layer is covered with a radiation-resistant silver-nylon blend. Because you're worth it."
	icon = 'modular_skyrat/modules/ntsl/icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'modular_skyrat/modules/ntsl/icons/mob/clothing/suits/wintercoat.dmi'
	icon_state = "coatsignaltech"
	inhand_icon_state = "coatsignaltech"
	allowed = list(
		/obj/item/radio,
		/obj/item/analyzer,
		/obj/item/multitool,
		/obj/item/assembly/signaler,
	)
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 10, FIRE = 20, ACID = 0)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering
	species_exception = list(/datum/species/golem/uranium)

/obj/item/clothing/head/hooded/winterhood/engineering/tcomms
	desc = "A yellow winter coat hood. Definitely not a replacement for a hard hat."
	icon = 'modular_skyrat/modules/ntsl/icons/obj/clothing/head/winterhood.dmi'
	worn_icon = 'modular_skyrat/modules/ntsl/icons/mob/clothing/head/winterhood.dmi'
	icon_state = "winterhood_signaltech"
	worn_icon_state = "winterhood_signaltech"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 10, FIRE = 20, ACID = 0)
