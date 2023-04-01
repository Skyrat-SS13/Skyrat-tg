
/datum/crafting_recipe/tempgun
	name = "Temperature Gun"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/gun/energy/temperature
	reqs = list(/obj/item/gun/energy/laser = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/weaponcrafting/gunkit/temperature = 1)
	time = 20 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/tempgun/New()
	..()
	blacklist += subtypesof(/obj/item/gun/energy/laser)

/datum/crafting_recipe/beam_rifle
	name = "Particle Acceleration Rifle"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/gun/energy/beam_rifle
	reqs = list(/obj/item/gun/energy/laser = 1,
				/obj/item/assembly/signaler/anomaly/flux = 1,
				/obj/item/assembly/signaler/anomaly/grav = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/weaponcrafting/gunkit/beam_rifle = 1)
	time = 20 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/beam_rifle/New()
	..()
	blacklist += subtypesof(/obj/item/gun/energy/laser)
