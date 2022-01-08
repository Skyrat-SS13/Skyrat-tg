/*
	Corruption is an extension of the bay spreading plants system.

	Corrupted tiles spread out gradually from the marker, and from any placed nodes, up to a certain radius
*/
GLOBAL_LIST_EMPTY(corruption_sources)
GLOBAL_DATUM_INIT(corruption_seed, /datum/seed/corruption, new())

#define CORRUPTION_SPREAD_HEALTH_THRESHOLD	0.3

//We'll be using a subtype in addition to a seed, becuase there's a lot of special case behaviour here
/obj/effect/vine/corruption
	name = "corruption"
	icon = 'icons/effects/corruption.dmi'
	icon_state = ""

	max_health = 30
	max_growth = 1

	var/max_alpha = 215
	var/min_alpha = 20

	spread_chance = 100	//No randomness in this, spread as soon as its ready
	spread_distance = CORRUPTION_SPREAD_RANGE	//One node creates a screen-sized patch of corruption
	growth_type = 0
	var/vine_scale = 1.1
	var/datum/extension/corruption_source/source

	//This contains a list of other corruption sources which might be able to support us - or new vines we create, if our main source can't
	var/list/alternatives

	var/growth_mult = 1

	//This is only used for the uncommon edge case where this vine is on the border between multiple chunks
	//Don't give it a value if unused, saves memory
	var/list/chunks

	//To remove corruption, destroy the nodes that are spreading it
	can_cut = FALSE


	//No clicking this
	mouse_opacity = 0

	//A temporary variable, set and then used just before and during the spawning of a new vine
	var/next_source

	can_block_movement = FALSE

/obj/effect/vine/corruption/proc/healthpercent()
	if (health <= 0)
		return 0

	if (!max_health)
		return 1

	return health / max_health

/obj/effect/vine/is_organic()
	return TRUE

/obj/effect/vine/corruption/New(var/newloc, var/datum/seed/newseed, var/obj/effect/vine/corruption/newparent, var/start_matured = 0, var/datum/extension/corruption_source/newsource)

	alpha = min_alpha


	if (!GLOB.corruption_seed)
		GLOB.corruption_seed = new /datum/seed/corruption()
	seed = GLOB.corruption_seed

	source = newsource
	source.register(src)
	.=..()

/obj/effect/vine/corruption/Destroy()
	if (source)
		source.unregister(src)
	.=..()




//No calculating, we'll input all these values in the variables above
/obj/effect/vine/corruption/calculate_growth()

	growth_mult = source.get_growthtime_multiplier(src)
	mature_time = rand_between(30 SECONDS, 45 SECONDS) * growth_mult/// source.growth_speed	//How long it takes for one tile to mature and be ready to spread into its neighbors.
	//mature_time *= 1 + (source.growth_distance_falloff * get_dist_3D(src, source.source))	//Expansion gets slower as you get farther out. Additively stacking 15% increase per tile

	growth_threshold = max_health
	possible_children = INFINITY
	return

/obj/effect/vine/corruption/update_icon()
	icon_state = "corruption-[rand(1,3)]"


	var/matrix/M = matrix()
	M = M.Scale(vine_scale)	//We scale up the sprite so it slightly overlaps neighboring corruption tiles
	var/rotation = pick(list(0,90,180,270))	//Randomly rotate it
	transform = turn(M, rotation)

	//Lets add the edge sprites
	overlays.Cut()
	for(var/turf/simulated/floor/floor in get_neighbors(FALSE, FALSE))
		var/direction = get_dir(src, floor)
		var/vector2/offset = Vector2.NewFromDir(direction)
		offset.SelfMultiply(WORLD_ICON_SIZE * vine_scale)
		var/image/I = image(icon, src, "corruption-edge", layer+1, direction)
		I.pixel_x = offset.x
		I.pixel_y = offset.y
		I.appearance_flags = RESET_TRANSFORM	//We use reset transform to not carry over the rotation

		I.transform = I.transform.Scale(vine_scale)	//We must reapply the scale
		overlays.Add(I)


//Corruption gradually fades in/out as its health goes up/down
/obj/effect/vine/corruption/adjust_health(value)
	.=..()
	if (health > 0)
		var/healthpercent = health / max_health
		alpha = min_alpha + ((max_alpha - min_alpha) * healthpercent)


//Add the effect from being on corruption
/obj/effect/vine/corruption/Crossed(atom/movable/O)
	if (isliving(O))
		var/mob/living/L = O
		if (!has_extension(L, /datum/extension/corruption_effect) && L.stat != DEAD)
			set_extension(L, /datum/extension/corruption_effect)


//This proc finds any viable corruption source to use for us
/obj/effect/vine/corruption/proc/find_corruption_host()
	//Search our alternatives list first
	if (LAZYLEN(alternatives))
		var/alternative = get_viable_alternative(src)
		if (alternative)
			return alternative

	for (var/datum/extension/corruption_source/CS in GLOB.corruption_sources)
		if (CS.can_support(src))
			return CS

	return null



//Gradually dies off without a nearby host
/obj/effect/vine/corruption/Process()
	.=..()
	if (!source)
		adjust_health(-(SSplants.wait*0.1))	//Plant subsystem has a 6 second delay oddly, so compensate for it here


/obj/effect/vine/corruption/can_regen()
	.=..()
	if (.)
		if (!source)
			return FALSE

//Vines themselves don't do this
/obj/effect/vine/corruption/can_spawn_plant()
	return (!source)

//We can only place plants under a marker or growth node
//And before placing, we should look for an existing one
/obj/effect/vine/corruption/spawn_plant()
	var/datum/extension/corruption_source/CS = find_corruption_host()
	if (!CS)
		plant = null
		return
	if (CS.register(src))
		calculate_growth()



/obj/effect/vine/corruption/is_necromorph()
	return TRUE

/obj/effect/vine/corruption/can_reach(var/turf/floor)
	if (!QDELETED(source) && source.can_support(floor))
		next_source = source
		return TRUE

	else
		//If our own source can't support it, lets see if any of our alternatives can take over
		next_source = get_viable_alternative(floor)
		if (next_source)
			return TRUE

	return FALSE

/obj/effect/vine/corruption/can_spread()
	if(!neighbors || !neighbors.len)
		return FALSE

	if (healthpercent() <= CORRUPTION_SPREAD_HEALTH_THRESHOLD)
		return FALSE

	return TRUE

/obj/effect/vine/corruption/wake_up(var/wake_adjacent = TRUE)
	if (QDELETED(source))
		source = null
	.=..()
	if (source)
		calculate_growth()

/obj/effect/vine/corruption/should_sleep()
	if(neighbors.len) //got places to spread to
		return FALSE
	if(health < max_health) //got some growth to do
		return FALSE
	if(!is_supported())
		return FALSE
	return TRUE

/obj/effect/vine/corruption/spread_to(turf/target_turf)
	var/obj/effect/vine/corruption/child = new type(target_turf,seed,parent, FALSE, (next_source ? next_source : source)) // This should do a little bit of animation.
	child.update_icon()
	child.set_dir(child.calc_dir())
	child.wake_neighbors() //Update surrounding tiles to handle edges
	update_icon()	//We don't need one of our edges now, update to get rid of it
	// Some plants eat through plating.
	if(islist(seed.chems) && !isnull(seed.chems[/datum/reagent/acid/triflicacid]))
		target_turf.ex_act(prob(80) ? 3 : 2)

	//Update our neighbors list
	update_neighbors()
	child.get_chunks()	//Populate the nearby chunks list, for later visual updates
	return child



//Checks if this tile of corruption is supported by a valid/existing source.
//Optionally, a source can be passed in, then it returns true if we're connected to THAT source specifically and false if any other, or not at all
/obj/effect/vine/corruption/proc/is_supported(var/datum/extension/corruption_source/compare)
	if (compare && source != compare)
		return FALSE

	//If we have no source? welp
	if (QDELETED(source))
		return FALSE

	if (!source.enabled)
		return FALSE

	return TRUE


//Alternative Handling
//This attempts to find an alternative source to fit a target turf
/obj/effect/vine/corruption/proc/get_viable_alternative(var/turf/T)
	if (!LAZYLEN(alternatives))
		return null
	var/best_multiplier = INFINITY
	var/best_source = null
	for (var/ref in alternatives)
		var/datum/extension/corruption_source/CS = locate(ref)
		if (QDELETED(CS) || !istype(CS))
			//No longer valid
			alternatives -= ref
			continue


		//Its temporarily deactivated, ignore but keep it in the list
		if (!CS.enabled)
			continue

		if (!CS.can_support(T))
			continue

		//Okay it can support us, lets see how well
		var/mult = CS.get_growthtime_multiplier(T)
		if (mult < best_multiplier)
			best_multiplier = mult
			best_source = CS

	return best_source



/* Visualnet Handling */
//-------------------
/obj/effect/vine/corruption/get_visualnet_tiles(var/datum/visualnet/network)
	return trange(1, src)

/obj/effect/vine/corruption/watched_tile_updated(var/turf/T)
	if (source)
		source.needs_update = TRUE
	.=..()

//Finds all visualnet chunks that this vine could possibly infringe on.
/obj/effect/vine/corruption/proc/get_chunks()
	var/list/chunksfound = list(GLOB.necrovision.get_chunk(x, y, z))
	for (var/direction in list(NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST))
		var/turf/T = get_step(src, direction)
		var/datum/chunk/newchunk = GLOB.necrovision.get_chunk(T.x, T.y, T.z)
		if (istype(newchunk))
			chunksfound |= newchunk


	//We only care if there's more than one chunk
	if (chunksfound.len > 1)
		chunks = chunksfound

/obj/effect/vine/corruption/proc/update_chunks()
	//Clear the necrovision cache
	GLOB.necrovision.visibility_cache = list()
	if (chunks)
		for (var/datum/chunk/C as anything in chunks)
			C.visibility_changed()
	else
		var/turf/T = get_turf(src)
		T.update_chunk(FALSE)






/* The seed */
//-------------------
/datum/seed/corruption
	display_name = "Corruption"
	no_icon = TRUE
	growth_stages = 1


/datum/seed/corruption/New()
	set_trait(TRAIT_IMMUTABLE,            1)            // If set, plant will never mutate. If -1, plant is highly mutable.
	set_trait(TRAIT_SPREAD,               2)            // 0 limits plant to tray, 1 = creepers, 2 = vines.
	set_trait(TRAIT_MATURATION,           0)            // Time taken before the plant is mature.
	set_trait(TRAIT_PRODUCT_ICON,         0)            // Icon to use for fruit coming from this plant.
	set_trait(TRAIT_PLANT_ICON,           'icons/effects/corruption.dmi')            // Icon to use for the plant growing in the tray.
	set_trait(TRAIT_PRODUCT_COLOUR,       0)            // Colour to apply to product icon.
	set_trait(TRAIT_POTENCY,              1)            // General purpose plant strength value.
	set_trait(TRAIT_REQUIRES_NUTRIENTS,   0)            // The plant can starve.
	set_trait(TRAIT_REQUIRES_WATER,       0)            // The plant can become dehydrated.
	set_trait(TRAIT_WATER_CONSUMPTION,    0)            // Plant drinks this much per tick.
	set_trait(TRAIT_LIGHT_TOLERANCE,      INFINITY)            // Departure from ideal that is survivable.
	set_trait(TRAIT_TOXINS_TOLERANCE,     INFINITY)            // Resistance to poison.
	set_trait(TRAIT_HEAT_TOLERANCE,       20)           // Departure from ideal that is survivable.
	set_trait(TRAIT_LOWKPA_TOLERANCE,     0)           // Low pressure capacity.
	set_trait(TRAIT_ENDURANCE,            100)          // Maximum plant HP when growing.
	set_trait(TRAIT_HIGHKPA_TOLERANCE,    INFINITY)          // High pressure capacity.
	set_trait(TRAIT_IDEAL_HEAT,           293)          // Preferred temperature in Kelvin.
	set_trait(TRAIT_NUTRIENT_CONSUMPTION, 0)         // Plant eats this much per tick.
	set_trait(TRAIT_PLANT_COLOUR,         "#ffffff")    // Colour of the plant icon.


/datum/seed/corruption/update_growth_stages()
	growth_stages = 1




/* Crossing Effect */
//-------------------
//Any mob that walks over a corrupted tile recieves this effect. It does varying things
	//On most mobs, it applies a slow to movespeed
	//On necromorphs, it applies a speedboost, passive healing and defense buff instead

/datum/extension/corruption_effect
	name = "Corruption Effect"
	expected_type = /mob/living
	flags = EXTENSION_FLAG_IMMEDIATE

	//Effects on necromorphs
	var/healing_per_tick = 1	//Passive Healing
	var/speedup = 1.25	//Bonus movespeed
	var/incoming_damage_mod = 0.85	//Incoming damage reduction

	//Effects on non necros
	var/slowdown = 0.625	//Movespeed Penalty

	var/speed_factor = 0


	var/necro = FALSE

	statmods = list(STATMOD_MOVESPEED_MULTIPLICATIVE = 1.25,//This is dynamic
	STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE = 0.85)


/datum/extension/corruption_effect/New(var/datum/holder)
	.=..()
	var/mob/living/L = holder
	if (L.is_necromorph())
		necro = TRUE
		speed_factor = speedup //Necros are sped up
		to_chat(L, SPAN_DANGER("The corruption beneath speeds your passage and mends your vessel."))
	else
		to_chat(L, SPAN_DANGER("This growth underfoot is sticky and slows you down."))
		speed_factor = slowdown	//humans are slowed down



	START_PROCESSING(SSprocessing, src)

/datum/extension/corruption_effect/get_statmod(var/modtype)
	var/mob/living/L = holder
	if (L.is_necromorph())
		.=..()	//Default values are for necros
	else
		if (modtype == STATMOD_MOVESPEED_MULTIPLICATIVE)
			return slowdown
		if (modtype == STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE)
			return 1


/datum/extension/corruption_effect/Process()
	var/mob/living/L = holder
	if (!L || !turf_corrupted(L) || L.stat == DEAD)
		//If the mob is no longer standing on a corrupted tile, we stop
		//Likewise if they're dead or gone
		remove_extension(holder, type)
		return PROCESS_KILL

	if (necro)
		L.heal_overall_damage(healing_per_tick)

