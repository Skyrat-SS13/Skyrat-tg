/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral
	icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi'
	icon_state = "basalt"
	var/list/possible_minerals = list(
		/obj/item/stack/ore/glass = 1
	)
	var/obj/item/stack/ore/mineralType = /obj/item/stack/ore/glass
	var/mineralChance = 1
	var/spreadingChance = 0
	var/mineralSpawnChanceList = list(
		/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/iron = 40,
		/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/silver = 12,
		/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/titanium = 11,
		/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/plasma = 20,
		/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/gold = 10,
		/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/uranium = 5,
		/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/diamond = 1,
		/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/bluespace = 1,
		/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/bananium = 0.1)
	var/max_mining_allowed = 1

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/Initialize(mapload)
	. = ..()
	if(prob(mineralChance))
		var/chosen_floor = pickweight(mineralSpawnChanceList)
		ChangeTurf(chosen_floor)
		if(spreadingChance)
			for(var/dir in GLOB.cardinals)
				if(prob(spreadingChance))
					var/turf/T = get_step(src, dir)
					T.ChangeTurf(src.type)
	max_mining_allowed = rand(300, 1000)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/iron
	icon_state = "basalt_iron"
	mineralType = /obj/item/stack/ore/iron
	spreadingChance = 50
	possible_minerals = list(
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/glass = 1
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/silver
	icon_state = "basalt_silver"
	spreadingChance = 50
	mineralType = /obj/item/stack/ore/silver
	possible_minerals = list(
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 35,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/titanium
	icon_state = "basalt_titanium"
	spreadingChance = 50
	mineralType = /obj/item/stack/ore/titanium
	possible_minerals = list(
		/obj/item/stack/ore/titanium = 30,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/plasma
	icon_state = "basalt_plasma"
	spreadingChance = 50
	mineralType = /obj/item/stack/ore/plasma
	possible_minerals = list(
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 35,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/gold
	icon_state = "basalt_gold"
	spreadingChance = 50
	mineralType = /obj/item/stack/ore/gold
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 1,
		/obj/item/stack/ore/gold = 25,
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/uranium
	icon_state = "basalt_uranium"
	spreadingChance = 50
	mineralType = /obj/item/stack/ore/uranium
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 20,
		/obj/item/stack/ore/gold = 1,
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/diamond
	icon_state = "basalt_diamond"
	spreadingChance = 25
	mineralType = /obj/item/stack/ore/diamond
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/diamond = 5,
		/obj/item/stack/ore/gold = 3,
		/obj/item/stack/ore/titanium = 3,
		/obj/item/stack/ore/silver = 3,
		/obj/item/stack/ore/plasma = 3,
		/obj/item/stack/ore/iron = 3,
		/obj/item/stack/ore/glass = 3
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/bluespace
	icon_state = "basalt_bluespace"
	spreadingChance = 25
	mineralType = /obj/item/stack/ore/bluespace_crystal
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/gold = 3,
		/obj/item/stack/ore/titanium = 3,
		/obj/item/stack/ore/silver = 3,
		/obj/item/stack/ore/plasma = 3,
		/obj/item/stack/ore/iron = 3,
		/obj/item/stack/ore/glass = 3,
		/obj/item/stack/ore/bluespace_crystal = 5
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/bananium
	icon_state = "basalt_bananium"
	spreadingChance = 25
	mineralType = /obj/item/stack/ore/bananium
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/gold = 3,
		/obj/item/stack/ore/titanium = 3,
		/obj/item/stack/ore/silver = 3,
		/obj/item/stack/ore/plasma = 3,
		/obj/item/stack/ore/iron = 3,
		/obj/item/stack/ore/glass = 3,
		/obj/item/stack/ore/bananium = 1
	)

