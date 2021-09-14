/datum/planet_template
	var/name = "Planet Template"
	/// Map path to file to supply for the planet to be loaded from
	var/map_path
	/// Name of the map file
	var/map_file
	// ALTERNATIVELY you can supply an area and a map generator
	/// Area type of the level to set to, only matters if not loading from file
	var/area_type
	/// Generator type for the level, only matters if not loading from file
	var/generator_type

	/// Traits that the levels will recieve
	var/default_traits_input
	/// The type of the overmap object that will be created
	var/datum/overmap_object/overmap_type = /datum/overmap_object/shuttle/planet
	/// The type of the atmosphere that will be set for the turfs in its z levels to draw from
	var/atmosphere_type
	/// The type of the weather controller that will be created for the planet
	var/weather_controller_type = /datum/weather_controller
	/// The type of the day and night controller, can be left blank
	var/day_night_controller_type = /datum/day_night_controller
	/// Possible rock colors of the loaded planet
	var/list/rock_color
	/// Possible plant colors of the loaded planet
	var/list/plant_color
	/// Possible grass colors of the loaded planet
	var/list/grass_color
	/// Possible water colors of the loaded planet
	var/list/water_color
	/// Whether you want the selected plant color to act for grass too
	var/plant_color_as_grass = FALSE
	/// Whether the planet will spawn planetary ruins
	var/spawns_planetary_ruins = TRUE
	/// Flags to check whether planetary ruins can be spawned
	var/planet_flags = PLANET_HABITABLE|PLANET_WATER|PLANET_WRECKAGES
	/// Budget for ruins
	var/ruin_budget = 40
	/// Type of our ore node seeder
	var/ore_node_seeder_type = /datum/ore_node_seeder

/datum/planet_template/proc/LoadTemplate(datum/overmap_sun_system/system, coordinate_x, coordinate_y)
	var/old_z = world.maxz
	var/datum/overmap_object/linked_overmap_object = new overmap_type(system, coordinate_x, coordinate_y)
	var/picked_rock_color = CHECK_AND_PICK_OR_NULL(rock_color)
	var/picked_plant_color = CHECK_AND_PICK_OR_NULL(plant_color)
	var/picked_grass_color
	if(plant_color_as_grass)
		picked_grass_color = picked_plant_color
	else
		picked_grass_color = CHECK_AND_PICK_OR_NULL(grass_color)
	var/picked_water_color = CHECK_AND_PICK_OR_NULL(water_color)
	if(map_path)
		if(!map_file)
			WARNING("No map file passed on planet generation")
		SSmapping.LoadGroup(null, 
							name, 
							map_path, 
							map_file, 
							default_traits = default_traits_input,  
							ov_obj = linked_overmap_object, 
							weather_controller_type = weather_controller_type, 
							atmosphere_type = atmosphere_type,
							day_night_controller_type = day_night_controller_type,
							rock_color = picked_rock_color,
							plant_color = picked_plant_color,
							grass_color = picked_grass_color,
							water_color = picked_water_color,
							ore_node_seeder_type = ore_node_seeder_type
							)
	else
		if(!area_type)
			WARNING("No area type passed on planet generation")
		if(!generator_type)
			WARNING("No generator type passed on planet generation")
		var/datum/space_level/new_level = SSmapping.add_new_zlevel(name, default_traits_input, overmap_obj = linked_overmap_object)
		if(picked_rock_color)
			new_level.rock_color = picked_rock_color
		if(picked_plant_color)
			new_level.plant_color = picked_plant_color
		if(picked_grass_color)
			new_level.grass_color = picked_grass_color
		if(picked_water_color)
			new_level.water_color = picked_water_color
		if(atmosphere_type)
			var/datum/atmosphere/atmos = new atmosphere_type()
			SSair.register_planetary_atmos(atmos, new_level.z_value)
			qdel(atmos)
		if(ore_node_seeder_type)
			var/datum/ore_node_seeder/seeder = new ore_node_seeder_type
			seeder.SeedToLevel(new_level.z_value)
			qdel(seeder)
		if(day_night_controller_type)
			var/datum/day_night_controller/day_night = new day_night_controller_type(list(new_level))
			day_night.LinkOvermapObject(linked_overmap_object)
		var/area/new_area = new area_type()
		var/list/turfs = block(locate(1,1,new_level.z_value),locate(world.maxx,world.maxy,new_level.z_value))
		new_area.contents.Add(turfs)
		var/datum/map_generator/my_generator = new generator_type()
		my_generator.generate_terrain(turfs)
		qdel(my_generator)
		//Create weather controller
		if(weather_controller_type)
			var/datum/weather_controller/weather_controller = new weather_controller_type(list(new_level))
			weather_controller.LinkOvermapObject(linked_overmap_object)

	var/new_z = world.maxz

	//Remember all the levels that we've added
	var/list/z_levels = list()
	for(var/i = old_z + 1 to new_z)
		z_levels += i

	//Pass them to the ruin seeder
	SeedRuins(z_levels)

//Due to the particular way ruins are seeded right now this will be handled through a proc, rather than data-driven as of now
/datum/planet_template/proc/SeedRuins(list/z_levels)
	if(!spawns_planetary_ruins)
		return
	var/eligible_ruins = SSmapping.planet_ruins_templates.Copy()
	for(var/ruin_name in eligible_ruins)
		var/datum/map_template/ruin/planetary/planetary_ruin = eligible_ruins[ruin_name]
		if(!(planet_flags & planetary_ruin.planet_requirements))
			eligible_ruins -= ruin_name

	seedRuins(z_levels, ruin_budget, list(area_type), eligible_ruins)


/datum/planet_template/lavaland
	name = "Lavaland"
	map_path = "map_files/Mining"
	map_file = "Lavaland.dmm"
	default_traits_input = ZTRAITS_LAVALAND

	overmap_type = /datum/overmap_object/shuttle/planet/lavaland
	weather_controller_type = /datum/weather_controller/lavaland
	atmosphere_type = /datum/atmosphere/lavaland
	day_night_controller_type = null //Ash blocks off the sky

	plant_color = list("#a23c05","#662929","#ba6222","#7a5b3a")
	plant_color_as_grass = TRUE
	spawns_planetary_ruins = FALSE
	planet_flags = PLANET_VOLCANIC|PLANET_WRECKAGES

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
