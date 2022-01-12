/*
	List of things we can absorb:
	Infinite:
		/obj/machinery/growth_tank, code/game/machinery/ds13/bpl/growth_tank.dm
		/obj/structure/morgue, code/game/object/strucures/morgue.dm
		/obj/machinery/portable_atmospherics/hydroponics, code/modules/hydroponics/trays/tray.dm
		/obj/machinery/cryopod, code/game/machinery/cryopod.dm

	Limited:
		/obj/structure/reagent_dispensers/biomass, code/game/machinery/ds13/bpl/biomass_storage.dm
		/obj/machinery/vending, code/game/machinery/vending.dm (only certain subtypes which contain biological matter)
*/

#define HARVESTER_HARVEST_RANGE	10

#define HARVESTER_SPINE_COOLDOWN 3 SECONDS
#define HARVESTER_ACID_COOLDOWN 14 SECONDS
#define HARVESTER_WHIP_COOLDOWN 3 SECONDS

/obj/structure/corruption_node/harvester
	name = "harvester"
	desc = "It will take its due"
	max_health = 475
	resistance = 9	//Extremely tough, basically immune to small arms fire
	icon = 'icons/effects/corruption96x96.dmi'
	icon_state = "harvester"
	density = TRUE

	appearance_flags = PIXEL_SCALE

	default_pixel_x = -32
	pixel_x = -32

	biomass = 50
	reclamation_time = 20 MINUTES
	placement_type = /datum/click_handler/placement/necromorph/harvester
	default_scale = 1
	random_rotation = FALSE

	var/list/passive_sources = list()
	var/list/active_sources = list()
	var/list/all_sources = list()

	var/datum/biomass_source/passive_datum
	var/datum/biomass_source/active_datum

	var/refresh_timer

	//Harvester dies fast without corruption support
	degen = 5
	regen = 0.75

	//The harvester needs to exist for this long before it fully deploys
	var/deployment_time = 1 MINUTE


	var/deployed = FALSE


	layer = LARGE_MOB_LAYER

	can_block_movement = TRUE


/obj/structure/corruption_node/harvester/update_icon()
	set waitfor = FALSE

	.=..()

	underlays.Cut()
	overlays.Cut()

	if (deployed)
		overlays += image(icon, src, "beak")
		underlays += image(icon, src, "tentacle_1")
		sleep(1)
		underlays += image(icon, src, "tentacle_2")
		sleep(1)
		underlays += image(icon, src, "tentacle_3")
		sleep(1)
		underlays += image(icon, src, "tentacle_4")
	else
		overlays += image(icon, src, "beak_closed")


/obj/structure/corruption_node/harvester/Initialize()
	.=..()
	register_sources()
	update_icon()

/obj/structure/corruption_node/harvester/Destroy()
	unregister_sources()
	.=..()

/obj/structure/corruption_node/harvester/Process()

	if (!deployed)
		if (deployment_time > 0)
			deployment_time -= 1 SECOND

		if (deployment_time <= 0 && turf_corrupted(src, TRUE))
			deployed = TRUE
			update_icon()
	else if (!turf_corrupted(src, TRUE))
		deployed = FALSE
		update_icon()

	.=..()


/obj/structure/corruption_node/harvester/can_stop_processing()
	if (!deployed)
		return FALSE

//Registration and listeners
//----------------------------

/obj/structure/corruption_node/harvester/proc/refresh_sources()
	deltimer(refresh_timer)
	refresh_timer = null
	unregister_sources()
	register_sources()

/obj/structure/corruption_node/harvester/proc/register_sources()
	var/list/stuff = get_harvestable_biomass_sources(src, FALSE)
	if (stuff.len == 2)
		passive_sources = stuff[1]
		active_sources = stuff[2]
	all_sources = passive_sources + active_sources

	//Ok now lets do individual stuff for them
	for (var/atom/A as anything in all_sources)
		GLOB.moved_event.register(A, src, /obj/structure/corruption_node/harvester/proc/source_moved)
		GLOB.destroyed_event.register(A, src, /obj/structure/corruption_node/harvester/proc/source_deleted)
		set_extension(A, /datum/extension/being_harvested)

	//Alright lets create the biomass sources on the marker
	var/obj/machinery/marker/M = get_marker()
	if (LAZYLEN(passive_sources))
		passive_datum = M.add_biomass_source(src, INFINITY, INFINITY, /datum/biomass_source/harvest)
		var/passive_biomass = 0
		for (var/datum/D as anything in passive_sources)
			passive_biomass += D.harvest_biomass(1)
		//This is how much the passive biomass sources will give in total each tick
		passive_datum.last_absorb = passive_biomass

	if (LAZYLEN(active_sources))
		active_datum = M.add_biomass_source(src, INFINITY, INFINITY, /datum/biomass_source/harvest/active)

	//We add an outline visual effect to each thing we're absorbing from
	for (var/atom/A in all_sources)
		var/newfilter = filter(type="outline", size=1, color=COLOR_HARVESTER_RED)
		A.filters.Add(newfilter)
		all_sources[A] = newfilter//We store the reference to that filter in the all_sources list, so we can cleanly remove it later if needed




/obj/structure/corruption_node/harvester/proc/unregister_sources()
	for (var/atom/A as anything in all_sources)
		if (!QDELETED(A))
			GLOB.moved_event.unregister(A, src, /obj/structure/corruption_node/harvester/proc/source_moved)
			GLOB.destroyed_event.unregister(A, src, /obj/structure/corruption_node/harvester/proc/source_deleted)
			A.filters.Remove(all_sources[A])	//Remove the visual filter we created earlier by using its stored reference
			remove_extension(A, /datum/extension/being_harvested)

	passive_sources = list()
	active_sources = list()
	all_sources = list()

	//These biomass source datums do their own cleanup in destroy, we can just delete them and everything works magically
	QDEL_NULL(passive_datum)
	QDEL_NULL(active_datum)

//When a source moves, we update, but with a delay for batching
/obj/structure/corruption_node/harvester/proc/source_moved()
	if (refresh_timer)
		return
	refresh_timer = addtimer(CALLBACK(src, /obj/structure/corruption_node/harvester/proc/refresh_sources), 3 SECONDS, TIMER_STOPPABLE)

//If a source is deleted we refresh immediately
/obj/structure/corruption_node/harvester/proc/source_deleted()
	refresh_sources()



/obj/structure/corruption_node/harvester/get_blurb()
	return "The Harvester is a node for securiting territory and extracting biomass from certain objects. It is expensive and takes a long \
	time to refund if destroyed, but is generally extremely tough and can withstand a lot of damage. It requires a clear area to place in, and can't be placed too close to another harvester\
	When placed, the harvester requires a 1 minute warmup period to take root before it becomes active.<br>\
	It serves two main functions: <br>\
	<br>\
	<br>\
	1. Biomass Extraction<br>\
	<br>\
	The harvester can draw biomass slowly, but infinitely, from the following kinds of objects:<br>\
		-Cryostorage beds<br>\
		-Bioprosthetic Growth Tanks<br>\
		-Morgue Drawers<br>\
		-Hydroponics Trays<br>\
		-Kitchen Appliances<br>\
	<br>\
	In addition, the Harvester can draw biomass more rapidly - but in limited total quantities, from the following objects:<br>\
		-Food/Snack/Drink/fertilizer vending machiness<br>\
		-Biomass Storage tank<br>\
	<br>\
	<br>\
	2. Securing Territory:<br>\
	The harvester is the most durable of all corruption nodes, many smaller weapons will bounce harmlessly off of it, and bigger things will \
	need a lot of time and ammo to outdamage its regeneration and high health pool.<br>\
	<br>\
	In addition to this, the harvester has three powerful attacks to help it fight back against people attempting to get past it or destroy it.\
		-Tentacle Whip<br>\
		-Spine Launch<br>\
		-Acid Spray<br>\
	The harvester has no intelligence though, all of these weapons must be manually activated by signal spells. \
	 At least two signals working in tandem are required to operate the weapons at maximum efficiency. If used correctly, the harvester is an immovable object<br>\
	 <br>\
	 The harvester has only one weakness. It depends heavily on corruption support. Like any other node, it will starve and die-off if the corruption nodes nearby are removed"

/*
	Biomass Absorbing
*/
/obj/structure/corruption_node/harvester/proc/handle_active_absorb(var/ticks = 1)
	//If anything returns MASS_FAIL, we will have to redo our sources
	var/failed = FALSE
	var/total = 0
	for (var/datum/D as anything in active_sources)
		var/result = D.can_harvest_biomass()
		//This thing is no longer viable
		if (result == MASS_FAIL)
			failed = TRUE
			continue

		//Its still viable but isn't giving us anything this tick, thats fine
		else if (result == MASS_PAUSE)
			continue

		else
			//Alright we can absorb!
			total += D.harvest_biomass(ticks)

	.=total	//We'll return the total

	//If we failed, spawn off a refresh to get new sources
	if (failed)
		spawn()
			refresh_sources()

/*
	Click Handler
*/
/datum/click_handler/placement/necromorph/harvester

/datum/click_handler/placement/necromorph/harvester/placement_blocked(var/turf/candidate)
	.=..()
	if (!.)
		/*
		var/found_food = get_harvestable_biomass_sources(candidate, TRUE)
		if (!found_food)
			return "There are no objects within range of this location which contain harvestable biomass."
		*/

		for (var/obj/structure/corruption_node/harvester/H in range(4, candidate))
			return "Cannot be placed within 4 tiles of an existing harvester."

		for (var/turf/T in trange(1, candidate))
			if (!turf_clear(T, TRUE))
				return "Requires a 3x3 clear area to place within."


//Helper Proc
//This searched for nearby things that could be used by a harvester node.
//If single_check is set true, this proc simply returns TRUE if it finds any sources at all, and FALSE otherwise
//When single_check is disabled, this proc returns a list of two sublists, one for passive objects and one for active objects
/proc/get_harvestable_biomass_sources(var/atom/source, var/single_check = FALSE)
	var/list/passive_sources = list()
	var/list/active_sources = list()
	var/list/things = dview(HARVESTER_HARVEST_RANGE, source)
	for (var/atom/O in things)
		var/result = O.can_harvest_biomass()
		if (result == MASS_FAIL)
			continue

		var/datum/extension/being_harvested/BH = get_extension(O, /datum/extension/being_harvested)
		if (BH)
			continue

		if (single_check)
			return TRUE	//We found anything, we're done

		if (result == MASS_READY)
			passive_sources += O
		else if (result == MASS_ACTIVE)
			active_sources += O

	//Alright at the end, lets see.
	if (single_check)
		return FALSE	//We didnt find anything

	return list(passive_sources, active_sources)



//Simple extension to mark an object as the property of a specific harvester, so that two of them can't draw from the same thing
/datum/extension/being_harvested




//Procs on objects

/*
	Called to see if we can harvest biomass from this thing.
	This should return MASS_FAIL if no
	MASS_READY if its an infinite source
	MASS_ACTIVE if its a limited quantity source

*/
/datum/proc/can_harvest_biomass()
	return MASS_FAIL


//This is called in two situations:
//1. For infinite sources, it's called once at the start - possibly only once ever - to find out how much biomass this source is worth per tick
//2. For limited sources, it's called each time biomass is absorbed, so the source can deplete itself appropriately.
	//Return zero to indicate we've run out of biomass, and force a re-considering of things
//In either case, this proc should return the quantity of biomass which was successfully harvested
//The ticks var contains the number of ticks (seconds) since the last time biomass was absorbed. This should be applied as a multiplier on the biomass taken and returned
/datum/proc/harvest_biomass(var/ticks = 1)
	return 0


/*
	Signal Abilities
*/
/datum/signal_ability/harvester

	target_string = "Any tile within the view field of a harvester node."
	base_type = /datum/signal_ability/harvester
	targeting_method	=	TARGET_CLICK
	energy_cost = 25

/datum/signal_ability/harvester/proc/get_harvesters(var/atom/origin)
	var/list/harvesters = list()
	var/turf/T = get_turf(origin)
	for (var/obj/structure/corruption_node/harvester/H in range(15, T))
		harvesters += H

	return harvesters

/datum/signal_ability/harvester/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/list/harvesters = get_harvesters(target)
	if (!harvesters || !harvesters.len)
		to_chat(user, SPAN_WARNING("No nearby harvesters found to attack from."))
		refund(user)
		return FALSE

	return harvesters




//Spinelaunch: Identical to lurker spines, throws a single projectile
/datum/signal_ability/harvester/spine
	name = "Harvester: Spine Launch"
	id = "h_spine"
	desc = "This ability is a trigger for functions on a Harvester node. It requires a harvester somewhere near your target location. \
	The cooldown on these harvester abilities is longer than what the harvester itself can do, so for best results;\
	 two or more signals should man each harvester during combat<br>\
	<br>\
	The harvester fires a sharp bony spine, dealing ballistic damage on impact."
	cooldown = HARVESTER_SPINE_COOLDOWN*1.5


/datum/signal_ability/harvester/spine/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/list/harvesters = ..()
	if (!harvesters)
		return

	var/fired = FALSE

	//In case of multiple nearby harvesters, we will loop through them in hopes of finding one off cooldown
	for (var/obj/structure/corruption_node/harvester/H in harvesters)
		fired = H.shoot_ability(/datum/extension/shoot/harvester_spine, target , /obj/item/projectile/bullet/spine, accuracy = 20, dispersion = list(0), num = 1, windup_time = 0, fire_sound  = list('sound/effects/creatures/necromorph/lurker/spine_fire_1.ogg',
		'sound/effects/creatures/necromorph/lurker/spine_fire_2.ogg',
		'sound/effects/creatures/necromorph/lurker/spine_fire_3.ogg'), nomove = 0, cooldown = HARVESTER_SPINE_COOLDOWN)

		if (fired)
			break

	if (!fired)
		to_chat(user, SPAN_WARNING("Nearby harvester is not ready to fire spines yet."))
		refund(user)
		return


/datum/extension/shoot/harvester_spine
	base_type = /datum/extension/shoot/harvester_spine






/datum/signal_ability/harvester/acid
	name = "Harvester: Acid Spray"
	id = "h_acid"
	desc = "This ability is a trigger for functions on a Harvester node. It requires a harvester somewhere near your target location. \
	The cooldown on these harvester abilities is longer than what the harvester itself can do, so for best results;\
	 two or more signals should man each harvester during combat<br>\
	<br>\
	The harvester fires a narrow stream of acid over two seconds, with good range."

	cooldown = HARVESTER_ACID_COOLDOWN*2

/datum/signal_ability/harvester/acid/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/list/harvesters = ..()
	if (!harvesters)
		return

	var/fired = FALSE

	//In case of multiple nearby harvesters, we will loop through them in hopes of finding one off cooldown
	for (var/obj/structure/corruption_node/harvester/H in harvesters)
		var/list/spraydata = list("reagent" = /datum/reagent/acid/necromorph, "volume" = 5)
		fired = H.spray_ability(subtype = /datum/extension/spray/reagent, target = target, angle = 25, length = 6,  stun = TRUE, duration = 2 SECONDS, cooldown = HARVESTER_ACID_COOLDOWN, windup = 0, override_user = user, extra_data = spraydata)

		if (fired)
			break


	if (!fired)
		to_chat(user, SPAN_WARNING("Nearby harvester is not ready to spray acid yet."))
		refund(user)
		return














/datum/signal_ability/harvester/tentacle
	name = "Harvester: Tentacle"
	id = "h_tentacle"
	desc = "This ability is a trigger for functions on a Harvester node. It requires a harvester somewhere near your target location. \
	The cooldown on these harvester abilities is longer than what the harvester itself can do, so for best results;\
	 two or more signals should man each harvester during combat<br>\
	<br>\
	The harvester swings one of its tentacles in a wide arc, striking humans nearby."

	cooldown = HARVESTER_WHIP_COOLDOWN*2

/datum/signal_ability/harvester/tentacle/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/list/harvesters = ..()
	if (!harvesters)
		return

	var/fired = FALSE

	//In case of multiple nearby harvesters, we will loop through them in hopes of finding one off cooldown
	for (var/obj/structure/corruption_node/harvester/H in harvesters)
		fired = H.swing_attack(swing_type = /datum/extension/swing/harvester_tentacle,
		source = H,
		target = target,
		angle = 150,
		range = 3,
		duration = 0.85 SECOND,
		windup = 0,
		cooldown = HARVESTER_WHIP_COOLDOWN,
		effect_type = /obj/effect/effect/swing/harvester_tentacle,
		damage = 20,
		damage_flags = DAM_EDGE,
		stages = 8)

		if (fired)
			spawn(0.4 SECONDS)
				var/sound_effect = pick(list('sound/effects/attacks/big_swoosh_1.ogg',
				'sound/effects/attacks/big_swoosh_2.ogg',
				'sound/effects/attacks/big_swoosh_3.ogg',))
				playsound(H, sound_effect, VOLUME_LOW, TRUE)

			break


	if (!fired)
		to_chat(user, SPAN_WARNING("Nearby harvester is not ready to swing a tentacle yet."))
		refund(user)
		return


/obj/effect/effect/swing/harvester_tentacle
	icon_state = "harvester_tentacle"
	default_scale = 1.65
	pass_flags = PASS_FLAG_TABLE | PASS_FLAG_FLYING
	layer = BELOW_LARGE_MOB_LAYER
	inherit_order = FALSE

/datum/extension/swing/harvester_tentacle
	base_type = /datum/extension/swing/harvester_tentacle
	var/limb_used



/datum/extension/swing/harvester_tentacle/hit_mob(var/mob/living/L)
	//We harmlessly swooce over lying targets
	if (L.lying)
		return FALSE
	.=..()
	if (.)
		//If we hit someone, we'll knock them away diagonally in the direction of our swing
		var/push_angle = 45
		if (swing_direction == ANTICLOCKWISE)
			push_angle *= -1

		var/vector2/push_direction = target_direction.Turn(push_angle)
		L.apply_impulse(push_direction, 200)
		release_vector(push_direction)




/datum/extension/swing/harvester_tentacle/setup_effect()
	.=..()
	effect.pixel_y -= 32
	effect.pixel_x -= 32