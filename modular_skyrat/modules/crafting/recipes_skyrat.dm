//So I don't know if this was an oversight or a balance issue, but none of these guns can be made without these changes.
/datum/crafting_recipe/advancedegun
	name = "Advanced Energy Gun"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/gun/energy/e_gun/nuclear
	reqs = list(/obj/item/gun/energy/laser/hitscan = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/weaponcrafting/gunkit/nuclear = 1)
	time = 200
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/advancedegun/New()
	..()
	blacklist += subtypesof(/obj/item/gun/energy/laser/hitscan)

/datum/crafting_recipe/tempgun
	name = "Temperature Gun"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/gun/energy/temperature
	reqs = list(/obj/item/gun/energy/laser/hitscan = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/weaponcrafting/gunkit/temperature = 1)
	time = 200
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/tempgun/New()
	..()
	blacklist += subtypesof(/obj/item/gun/energy/laser/hitscan)

/datum/crafting_recipe/beam_rifle
	name = "Particle Acceleration Rifle"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/gun/energy/beam_rifle
	reqs = list(/obj/item/gun/energy/laser/hitscan = 1,
				/obj/item/assembly/signaler/anomaly/flux = 1,
				/obj/item/assembly/signaler/anomaly/grav = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/weaponcrafting/gunkit/beam_rifle = 1)
	time = 200
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
    
/datum/crafting_recipe/beam_rifle/New()
	..()
	blacklist += subtypesof(/obj/item/gun/energy/laser/hitscan)

/datum/crafting_recipe/xraylaser
	name = "X-ray Laser Gun"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/gun/energy/xray
	reqs = list(/obj/item/gun/energy/laser/hitscan = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/weaponcrafting/gunkit/xray = 1)
	time = 200
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/xraylaser/New()
	..()
	blacklist += subtypesof(/obj/item/gun/energy/laser/hitscan)

/datum/crafting_recipe/hellgun
	name = "Hellfire Laser Gun"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/gun/energy/laser/hellgun
	reqs = list(/obj/item/gun/energy/laser/hitscan = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/weaponcrafting/gunkit/hellgun = 1)
	time = 200
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/hellgun/New()
	..()
	blacklist += subtypesof(/obj/item/gun/energy/laser/hitscan)

/datum/crafting_recipe/ioncarbine
	name = "Ion Carbine"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/gun/energy/ionrifle/carbine
	reqs = list(/obj/item/gun/energy/laser/hitscan = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/weaponcrafting/gunkit/ion = 1)
	time = 200
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/ioncarbine/New()
	..()
	blacklist += subtypesof(/obj/item/gun/energy/laser/hitscan)

/datum/crafting_recipe/decloner
	name = "Biological Demolecularisor"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	result = /obj/item/gun/energy/decloner
	reqs = list(/obj/item/gun/energy/laser/hitscan = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/weaponcrafting/gunkit/decloner = 1,
				/datum/reagent/baldium = 30,
				/datum/reagent/toxin/mutagen = 40)
	time = 200
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/decloner/New()
	..()
	blacklist += subtypesof(/obj/item/gun/energy/laser/hitscan)
