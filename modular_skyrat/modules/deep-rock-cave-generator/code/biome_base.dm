/datum/biome/deep_rock
	/// Weighted list of the types that spawns if the turf is open
	var/list/weighted_open_turf_types = list(/turf/open/misc/asteroid/airless = 1)
	/// Expanded list of the types that spawns if the turf is open
	var/list/open_turf_types
	/// Weighted list of the types that spawns if the turf is closed
	var/list/weighted_closed_turf_types = list(/turf/closed/mineral/random = 1)
	/// Expanded list of the types that spawns if the turf is closed
	var/list/closed_turf_types


	/// Weighted list of mobs that can spawn in the area.
	var/list/weighted_mob_spawn_list
	/// Expanded list of mobs that can spawn in the area. Reads from the weighted list
	var/list/mob_spawn_list
	/// Weighted list of flora that can spawn in the area.
	var/list/weighted_flora_spawn_list
	/// Expanded list of flora that can spawn in the area. Reads from the weighted list
	var/list/flora_spawn_list
	/// Weighted list of extra features that can spawn in the area, such as geysers.
	var/list/weighted_feature_spawn_list
	/// Expanded list of extra features that can spawn in the area. Reads from the weighted list
	var/list/feature_spawn_list

	/// Base chance of spawning a mob
	var/mob_spawn_chance = 5
	/// Base chance of spawning flora
	var/flora_spawn_chance = 50
	/// Base chance of spawning features
	var/feature_spawn_chance = 25

/datum/biome/deep_rock/New()
	. = ..()

	if(length(weighted_mob_spawn_list))
		mob_spawn_list = expand_weights(weighted_mob_spawn_list)

	if(length(weighted_flora_spawn_list))
		flora_spawn_list = expand_weights(weighted_flora_spawn_list)

	if(length(weighted_feature_spawn_list))
		feature_spawn_list = expand_weights(weighted_feature_spawn_list)

	open_turf_types = expand_weights(weighted_open_turf_types)
	closed_turf_types = expand_weights(weighted_closed_turf_types)

/datum/biome/deep_rock/generate_turf(turf/gen_turf, closed, area/generate_in, mobs_allowed)
	var/turf/new_turf = pick(closed ? closed_turf_types : open_turf_types)
	new_turf = new new_turf(gen_turf)

	// If the turf is closed we do not need to bother with features
	if(closed)
		return

	// If we spawn a flora object, we don't need to continue onwards
	if(prob(flora_spawn_chance))
		var/flora_type = pick(flora_spawn_list)
		new flora_type(new_turf)
		return

	// When spawning a feature object, checks to make sure there is not a similar in too close of a range
	// Will also not continue the chain if one spawns
	if(prob(feature_spawn_chance))
		var/atom/picked_feature = pick(feature_spawn_list)

		for(var/obj/structure/existing_feature in range(2, new_turf))
			if(istype(existing_feature, picked_feature))
				return

		new picked_feature(new_turf)
		return

	// If the area allows it, will spawn a random mob from the list
	if(mobs_allowed && prob(mob_spawn_chance))
		var/atom/picked_mob = pick(mob_spawn_list)

		// prevents tendrils spawning in each other's collapse range
		if(ispath(picked_mob, /obj/structure/spawner/lavaland))
			for(var/obj/structure/spawner/lavaland/spawn_blocker in range(2, new_turf))
				return

		//if the random is a standard mob, avoid spawning if there's another one within 12 tiles
		else if(isminingpath(picked_mob))
			for(var/mob/living/mob_blocker in range(7, new_turf))
				if(ismining(mob_blocker))
					return

		new picked_mob(new_turf)
