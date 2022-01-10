/*

	The marker needs to be able to move by player interaction prior to its activation.
	This includes the marker shard, but once it is anchored it cannot move anymore.
	TODO: CREATE SMALL WEAK VARIATION OF MARKER.

*/


#define HALLUCINATION_RANGE(P) (min(7, round(P ** 0.25)))

/obj/structure/marker/special/core // THIS IS THE MARKER CORE
	name = "The Marker"
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/marker_giant.dmi'
	icon_state = "marker_giant_active"
	desc = "A huge, pulsating yellow mass."
	max_integrity = MARKER_CORE_MAX_HP
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 75, ACID = 90)
	explosion_block = 6
	point_return = -1
	health_regen = 0 //we regen in Life() instead of when pulsed
	resistance_flags = LAVA_PROOF
	strong_reinforce_range = MARKER_CORE_STRONG_REINFORCE_RANGE
	reflector_reinforce_range = MARKER_CORE_REFLECTOR_REINFORCE_RANGE
	claim_range = MARKER_CORE_CLAIM_RANGE
	pulse_range = MARKER_CORE_PULSE_RANGE
	expand_range = MARKER_CORE_EXPAND_RANGE
	max_spores = MARKER_CORE_MAX_SLASHERS
	ignore_syncmesh_share = TRUE

	pixel_x = -32
	//pixel_y = -32
	//bound_height = 196
	bound_width = 32
	bound_x = -32
	bound_y = 0

	///The amount of damage we have currently
	var/isShardSpawned = FALSE
	///The amount of damage we have currently
	var/useSmallIcon = TRUE
	///The amount of damage we have currently
	var/isAnimated = FALSE
	///The amount of damage we have currently
	var/isActive = TRUE
	///The amount of damage we have currently
	var/damage = 0
	///The damage we had before this cycle. Used to limit the damage we can take each cycle, and for safe_alert
	var/damage_archived = 0

	///Used along with a global var to track if we can give out the sm sliver stealing objective
	var/is_main_engine = FALSE

	///Boolean used for logging if we've been powered
	var/has_been_powered = FALSE

	///How much hallucination should we produce per unit of power?
	var/hallucination_power = 1

	///Our soundloop
	var/datum/looping_sound/supermatter/soundloop
	///Can it be moved?
	var/moveable = FALSE

	var/resource_delay = 0
	/// The amount of health regenned on core_process
	var/base_core_regen = MARKER_CORE_HP_REGEN
	/// The amount of points gained on core_process
	var/point_rate = MARKER_BASE_POINT_RATE
	// Various vars that strains can buff the blob with
	/// HP regen bonus added by strain
	var/core_regen_bonus = 0
	/// resource point bonus added by strain
	var/point_rate_bonus = 0

	//For making hugbox supermatters
	///Disables all methods of taking damage
	var/takes_damage = TRUE
	///Disables power changes
	var/power_changes = TRUE
	///Disables the sm's proccessing totally.
	var/processes = TRUE

/obj/structure/marker/special/core/examine(mob/user)
	. = ..()
	var/immune = HAS_TRAIT(user, TRAIT_SUPERMATTER_MADNESS_IMMUNE) || (user.mind && HAS_TRAIT(user.mind, TRAIT_SUPERMATTER_MADNESS_IMMUNE))
	if(isliving(user) && !immune && (get_dist(user, src) < HALLUCINATION_RANGE(hallucination_power)))
		. += span_danger("You get headaches just from looking at it.")

/obj/structure/marker/special/core/Initialize(mapload, client/new_overmind = null, placed = 0)
	GLOB.marker_cores += src
	START_PROCESSING(SSobj, src)
	SSpoints_of_interest.make_point_of_interest(src)
	soundloop = new(list(src), TRUE)
	if(isActive)
		//soundloop.volume = clamp((50 + (hallucination_power / 50)), 50, 100)
		soundloop.volume = 50
	if(damage >= 300)
		soundloop.mid_sounds = list('sound/machines/sm/loops/delamming.ogg' = 1)
	else
		soundloop.mid_sounds = list('sound/machines/sm/loops/calm.ogg' = 1)
	AddElement(/datum/element/point_of_interest)
	update_appearance() //so it atleast appears
	if(!placed && !overmind)
		return INITIALIZE_HINT_QDEL
	. = ..()

/obj/structure/marker/special/core/Destroy()
	GLOB.marker_cores -= src
	if(overmind)
		overmind.marker_core = null
		overmind = null
	STOP_PROCESSING(SSobj, src)
	QDEL_NULL(soundloop)
	return ..()

/obj/structure/marker/special/core/scannerreport()
	return "Directs the marker's expansion, gradually expands, and sustains nearby marker spores and markerbernauts."

/*
	MARKER APPEARANCE AND ANY OVERLAYS
	TODO: ADJUST TRANSFORM TO SIT PROPERLY ON A SINGLE TILE

*/

/obj/structure/marker/special/core/update_overlays()
	. = ..()
	//var/matrix/M = matrix()
	//M.Translate(-25,-25)
	//src.transform = M

	// MARKER GROWTH
	var/mutable_appearance/marker_overlay = mutable_appearance('icons/mob/blob.dmi', "blob") // Adds the growth underneath the marker
	if(overmind)
		marker_overlay.color = COLOR_MARKER_RED
	. += marker_overlay
	. += mutable_appearance('modular_skyrat/modules/necromorphs/icons/obj/marker_giant.dmi', "marker_giant_active_anim")

/obj/structure/marker/special/core/update_icon()
	return ..()

/obj/structure/marker/special/core/update_icon_state()
	return ..()

/*
	if(useSmallIcon)
		if(isActive)
			mutable_appearance('modular_skyrat/modules/necromorphs/icons/obj/marker_normal.dmi', "marker_normal_active")
		else
			mutable_appearance('modular_skyrat/modules/necromorphs/icons/obj/marker_normal.dmi', "marker_normal_dormant")
	else
		if(isActive)
			mutable_appearance('modular_skyrat/modules/necromorphs/icons/obj/marker_giant.dmi', "marker_giant_active_anim")
		else
			mutable_appearance('modular_skyrat/modules/necromorphs/icons/obj/marker_giant.dmi', "marker_giant_dormant")
*/

/*

	TODO: ADD MARKER ACTIVATION PROCESS

*/

/obj/structure/marker/special/core/proc/activate_marker()
	return

/obj/structure/marker/special/core/ex_act(severity, target)
	var/damage = 10 * (severity + 1) //remember, the core takes half brute damage, so this is 20/15/10 damage based on severity
	take_damage(damage, BRUTE, BOMB, 0)

/obj/structure/marker/special/core/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir, overmind_reagent_trigger = 1)
	. = ..()
	if(atom_integrity > 0)
		if(overmind) //we should have an overmind, but...
			overmind.update_health_hud()

/obj/structure/marker/special/core/process(delta_time)
	if(QDELETED(src))
		return
	if(!overmind)
		qdel(src)
	if(overmind)
		core_process()
		overmind.update_health_hud()
	pulse_area(overmind, claim_range, pulse_range, expand_range)
//	reinforce_area(delta_time)
	produce_slashers()
	..()

/obj/structure/marker/special/core/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/stationloving, FALSE, TRUE)

/obj/structure/marker/special/core/on_changed_z_level(turf/old_turf, turf/new_turf)
	if(overmind && is_station_level(new_turf?.z))
		overmind.forceMove(get_turf(src))
	return ..()

/*

Will become Biomass inherent generation. Biomass also needs to be separated out from this file
Biomass is inherent to all necromorphs and related features, not just the marker.

*/


/obj/structure/marker/special/core/proc/core_process()
	if(resource_delay <= world.time)
		resource_delay = world.time + 10 // 1 second
		overmind.add_points(point_rate+point_rate_bonus)
	overmind.marker_core.repair_damage(base_core_regen + core_regen_bonus)
