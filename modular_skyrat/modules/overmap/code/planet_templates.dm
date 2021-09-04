/datum/planet_template
	var/name = "Planet Template"
	var/map_path
	var/map_file
	var/default_traits_input

	var/datum/overmap_object/overmap_type

/datum/planet_template/proc/LoadTemplate(datum/overmap_sun_system/system, coordinate_x, coordinate_y)
	var/old_z = world.maxz
	var/datum/overmap_object/linked_overmap_object = new overmap_type(system, coordinate_x, coordinate_y)
	SSmapping.LoadGroup(null, name, map_path, map_file, default_traits = default_traits_input,  ov_obj = linked_overmap_object)
	var/new_z = world.maxz

	//Remember all the levels that we've added
	var/list/z_levels = list()
	for(var/i = old_z + 1 to new_z)
		z_levels += i

	//Pass them to the ruin seeder
	SeedRuins(z_levels)

//Due to the particular way ruins are seeded right now this will be handled through a proc, rather than data-driven as of now
/datum/planet_template/proc/SeedRuins(list/z_levels)
	return

/datum/planet_template/lavaland
	name = "Lavaland"
	map_path = "map_files/Mining"
	map_file = "Lavaland.dmm"
	default_traits_input = ZTRAITS_LAVALAND

	overmap_type = /datum/overmap_object/lavaland


/datum/planet_template/lavaland/SeedRuins(list/z_levels)
	var/list/lava_ruins = SSmapping.levels_by_trait(ZTRAIT_LAVA_RUINS)
	//Only account for the levels we loaded, in case we load 2 lavalands
	for(var/i in lava_ruins)
		if(!(i in z_levels))
			lava_ruins -= i

	if (z_levels.len)
		seedRuins(z_levels, CONFIG_GET(number/lavaland_budget), list(/area/lavaland/surface/outdoors/unexplored), SSmapping.lava_ruins_templates)
		for (var/lava_z in z_levels)
			spawn_rivers(lava_z)

/datum/planet_template/jungle_planet
	name = "Jungle Planet"
	map_path = "map_files/Planets"
	map_file = "JunglePlanet.dmm"
	default_traits_input = ZTRAITS_JUNGLE_PLANET

	overmap_type = /datum/overmap_object/jungle_planet
