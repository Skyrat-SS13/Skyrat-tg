/obj/item/gun/microfusion/mcr01
	name = "MCR01"
	desc = "An advanced energy gun design that sports a removable microfusion cell platform, produced by Allstar Lasers Incorporated."
	icon_state = "mcr01"
	inhand_icon_state = "mcr01"
	shaded_charge = TRUE

//////////////MICROFUSION SPAWNERS
/obj/effect/spawner/armory_spawn/microfusion
	icon_state = "random_rifle"
	gun_count = 4
	guns = list(
		/obj/item/gun/microfusion/mcr01,
		/obj/item/gun/microfusion/mcr01,
		/obj/item/gun/microfusion/mcr01,
		/obj/item/gun/microfusion/mcr01,
	)
