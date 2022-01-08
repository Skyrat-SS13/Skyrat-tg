#define HALLUCINATION_RANGE(P) (min(7, round(P ** 0.25)))

/obj/structure/marker/special/core // THIS IS THE MARKER CORE
	name = "marker core"
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

	///The amount of damage we have currently
	var/isShardSpawned = FALSE
	///The amount of damage we have currently
	var/useSmallIcon = FALSE
	///The amount of damage we have currently
	var/isAnimated = FALSE
	///The amount of damage we have currently
	var/isActive = FALSE
	///The amount of damage we have currently
	var/damage = 0
	///The damage we had before this cycle. Used to limit the damage we can take each cycle, and for safe_alert
	var/damage_archived = 0

	///Used along with a global var to track if we can give out the sm sliver stealing objective
	var/is_main_engine = FALSE

	///Boolean used for logging if we've been powered
	var/has_been_powered = FALSE

	///How much hallucination should we produce per unit of power?
	var/hallucination_power = 0.1

	///Our soundloop
	var/datum/looping_sound/supermatter/soundloop
	///Can it be moved?
	var/moveable = FALSE

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
	soundloop = new(list(src), TRUE)
	if(isActive)
		soundloop.volume = clamp((50 + (hallucination_power / 50)), 50, 100)
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

/obj/structure/marker/special/core/update_overlays()
	. = ..()
	var/mutable_appearance/marker_overlay = mutable_appearance('modular_skyrat/modules/necromorphs/icons/obj/marker_giant.dmi', "marker_giant_anim")
	. += marker_overlay
	. += mutable_appearance('modular_skyrat/modules/necromorphs/icons/obj/marker_giant.dmi', "marker_giant_active")

/obj/structure/marker/special/core/update_icon()

	return ..()

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
		//overmind.core_process()
		overmind.update_health_hud()
	pulse_area(overmind, claim_range, pulse_range, expand_range)
//	reinforce_area(delta_time)
	produce_spores()
	..()

/obj/structure/marker/special/core/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/stationloving, FALSE, TRUE)

/obj/structure/marker/special/core/on_changed_z_level(turf/old_turf, turf/new_turf)
	if(overmind && is_station_level(new_turf?.z))
		overmind.forceMove(get_turf(src))
	return ..()
