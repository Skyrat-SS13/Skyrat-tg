/obj/item/wirecutters/bronze
	name = "bronze wirecutters"
	desc = "A pair of wirecutters made of bronze. The handle feels faintly warm."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "cutters_bronze"
	random_color = FALSE
	toolspeed = 0.5

/obj/item/screwdriver/bronze
	name = "bronze screwdriver"
	desc = "A screwdriver made of bronze. The handle feels warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "screwdriver_bronze"
	toolspeed = 0.5
	random_color = FALSE
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null

/obj/item/weldingtool/experimental/bronze
	name = "bronze welding tool"
	desc = "A bronze welder that seems to constantly refuel itself. It is faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "welder_bronze"

/obj/item/crowbar/bronze
	name = "bronze crowbar"
	desc = "A bronze crowbar. It feels faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "crowbar_bronze"
	toolspeed = 0.5

/obj/item/wrench/bronze
	name = "bronze wrench"
	desc = "A bronze wrench. It's faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "wrench_bronze"
	toolspeed = 0.5

/obj/item/storage/belt/utility/clock
	name = "old toolbelt"
	desc = "Holds tools. This one's seen better days, though. There's a cog roughly cut into the leather on one side."

/obj/item/storage/belt/utility/clock/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver/bronze, src)
	SSwardrobe.provide_type(/obj/item/crowbar/bronze, src)
	SSwardrobe.provide_type(/obj/item/weldingtool/experimental/bronze, src)
	SSwardrobe.provide_type(/obj/item/wirecutters/bronze, src)
	SSwardrobe.provide_type(/obj/item/wrench/bronze, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
