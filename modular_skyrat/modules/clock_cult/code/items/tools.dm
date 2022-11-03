/obj/item/wirecutters/brass
	name = "brass wirecutters"
	desc = "A pair of wirecutters made of brass. The handle feels faintly warm."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "cutters_brass"
	random_color = FALSE
	toolspeed = 0.5

/obj/item/screwdriver/brass
	name = "brass screwdriver"
	desc = "A screwdriver made of brass. The handle feels warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "screwdriver_brass"
	toolspeed = 0.5
	random_color = FALSE
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null

/obj/item/weldingtool/experimental/brass
	name = "brass welding tool"
	desc = "A brass welder that seems to constantly refuel itself. It is faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "welder_brass"
	toolspeed = 0.5

/obj/item/crowbar/brass
	name = "brass crowbar"
	desc = "A brass crowbar. It feels faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "crowbar_brass"
	toolspeed = 0.5

/obj/item/wrench/brass
	name = "brass wrench"
	desc = "A brass wrench. It's faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "wrench_brass"
	toolspeed = 0.5

/obj/item/storage/belt/utility/clock
	name = "old toolbelt"
	desc = "Holds tools. This one's seen better days, though. There's a cog roughly cut into the leather on one side."

/obj/item/storage/belt/utility/clock/PopulateContents()
	new /obj/item/screwdriver/brass(src)
	new /obj/item/crowbar/brass(src)
	new /obj/item/weldingtool/experimental/brass(src)
	new /obj/item/wirecutters/brass(src)
	new /obj/item/wrench/brass(src)
	new /obj/item/multitool(src)
