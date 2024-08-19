
/obj/effect/timestop
	anchored = TRUE
	name = "chronofield"
	desc = "ZA WARUDO"
	icon = 'icons/effects/160x160.dmi'
	icon_state = "time"
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	pixel_x = -64
	pixel_y = -64
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/list/immune = list() // the one who creates the timestop is immune, which includes wizards and the dead slime you murdered to make this chronofield
	var/turf/target
	var/freezerange = 2
	var/duration = 140
	var/datum/proximity_monitor/advanced/timestop/chronofield
	alpha = 125
	var/antimagic_flags = NONE
	///if true, immune atoms moving ends the timestop instead of duration.
	var/channelled = FALSE
	/// hides time icon effect and mutes sound
	var/hidden = FALSE

/obj/effect/timestop/Initialize(mapload, radius, time, list/immune_atoms, start = TRUE, silent = FALSE) //Immune atoms assoc list atom = TRUE
	. = ..()
	if(!isnull(time))
		duration = time
	if(!isnull(radius))
		freezerange = radius
	if(silent)
		hidden = TRUE
		alpha = 0
	for(var/A in immune_atoms)
		immune[A] = TRUE
	for(var/mob/living/to_check in GLOB.player_list)
		if(HAS_TRAIT(to_check, TRAIT_TIME_STOP_IMMUNE))
			immune[to_check] = TRUE
	for(var/mob/living/basic/guardian/stand in GLOB.parasites)
		if(stand.summoner && HAS_TRAIT(stand.summoner, TRAIT_TIME_STOP_IMMUNE)) //It would only make sense that a person's stand would also be immune.
			immune[stand] = TRUE
	if(start)
		INVOKE_ASYNC(src, PROC_REF(timestop))

/obj/effect/timestop/Destroy()
	QDEL_NULL(chronofield)
	if(!hidden)
		playsound(src, 'sound/magic/timeparadox2.ogg', 75, TRUE, frequency = -1) //reverse!
	return ..()

/obj/effect/timestop/proc/timestop()
	target = get_turf(src)
	if(!hidden)
		playsound(src, 'sound/magic/timeparadox2.ogg', 75, TRUE, -1)
	chronofield = new (src, freezerange, TRUE, immune, antimagic_flags, channelled)
	if(!channelled)
		QDEL_IN(src, duration)


/obj/effect/timestop/magic
	antimagic_flags = MAGIC_RESISTANCE

///indefinite version, but only if no immune atoms move.
/obj/effect/timestop/channelled
	channelled = TRUE

/datum/proximity_monitor/advanced/timestop
	edge_is_a_field = TRUE
	var/list/immune = list()
	var/list/frozen_things = list()
	var/list/frozen_mobs = list() //cached separately for processing
	var/list/frozen_structures = list() //Also machinery, and only frozen aestethically
	var/list/frozen_turfs = list() //Only aesthetically
	var/antimagic_flags = NONE
	///if true, this doesn't time out after a duration but rather when an immune atom inside moves.
	var/channelled = FALSE

	var/static/list/global_frozen_atoms = list()

/datum/proximity_monitor/advanced/timestop/New(atom/_host, range, _ignore_if_not_on_turf = TRUE, list/immune, antimagic_flags, channelled)
	..()
	src.immune = immune
	src.antimagic_flags = antimagic_flags
	src.channelled = channelled
	recalculate_field(full_recalc = TRUE)
	START_PROCESSING(SSfastprocess, src)

/datum/proximity_monitor/advanced/timestop/Destroy()
	unfreeze_all()
	if(channelled)
		for(var/atom in immune)
			UnregisterSignal(atom, COMSIG_MOVABLE_MOVED)
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/datum/proximity_monitor/advanced/timestop/field_turf_crossed(atom/movable/movable, turf/old_location, turf/new_location)
	freeze_atom(movable)

/datum/proximity_monitor/advanced/timestop/proc/freeze_atom(atom/movable/A)
	if(global_frozen_atoms[A] || !istype(A))
		return FALSE
	if(immune[A]) //a little special logic but yes immune things don't freeze
		if(channelled)
			RegisterSignal(A, COMSIG_MOVABLE_MOVED, PROC_REF(atom_broke_channel), override = TRUE)
		return FALSE
	if(ismob(A))
		var/mob/M = A
		if(M.can_block_magic(antimagic_flags))
			immune[A] = TRUE
			return
	var/frozen = TRUE
	if(isliving(A))
		freeze_mob(A)
	else if(isprojectile(A))
		freeze_projectile(A)
	else if(ismecha(A))
		freeze_mecha(A)
	else if((ismachinery(A) && !istype(A, /obj/machinery/light)) || isstructure(A)) //Special exception for light fixtures since recoloring causes them to change light
		freeze_structure(A)
	else
		frozen = FALSE
	if(A.throwing)
		freeze_throwing(A)
		frozen = TRUE
	if(!frozen)
		return

	frozen_things[A] = A.move_resist
	A.move_resist = INFINITY
	global_frozen_atoms[A] = src
	into_the_negative_zone(A)
	RegisterSignal(A, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(unfreeze_atom))
	RegisterSignal(A, COMSIG_ITEM_PICKUP, PROC_REF(unfreeze_atom))

	SEND_SIGNAL(A, COMSIG_ATOM_TIMESTOP_FREEZE, src)

	return TRUE

/datum/proximity_monitor/advanced/timestop/proc/unfreeze_all()
	for(var/i in frozen_things)
		unfreeze_atom(i)
	for(var/T in frozen_turfs)
		unfreeze_turf(T)

/datum/proximity_monitor/advanced/timestop/proc/unfreeze_atom(atom/movable/A)
	SIGNAL_HANDLER
	if(A.throwing)
		unfreeze_throwing(A)
	if(isliving(A))
		unfreeze_mob(A)
	else if(isprojectile(A))
		unfreeze_projectile(A)
	else if(ismecha(A))
		unfreeze_mecha(A)

	UnregisterSignal(A, COMSIG_MOVABLE_PRE_MOVE)
	UnregisterSignal(A, COMSIG_ITEM_PICKUP)

	SEND_SIGNAL(A, COMSIG_ATOM_TIMESTOP_UNFREEZE, src)

	escape_the_negative_zone(A)
	A.move_resist = frozen_things[A]
	frozen_things -= A
	global_frozen_atoms -= A


/datum/proximity_monitor/advanced/timestop/proc/freeze_mecha(obj/vehicle/sealed/mecha/M)
	M.completely_disabled = TRUE

/datum/proximity_monitor/advanced/timestop/proc/unfreeze_mecha(obj/vehicle/sealed/mecha/M)
	M.completely_disabled = FALSE

/datum/proximity_monitor/advanced/timestop/proc/freeze_throwing(atom/movable/AM)
	var/datum/thrownthing/T = AM.throwing
	T.paused = TRUE

/datum/proximity_monitor/advanced/timestop/proc/unfreeze_throwing(atom/movable/AM)
	var/datum/thrownthing/T = AM.throwing
	if(T)
		T.paused = FALSE

/datum/proximity_monitor/advanced/timestop/proc/freeze_turf(turf/T)
	into_the_negative_zone(T)
	frozen_turfs += T

/datum/proximity_monitor/advanced/timestop/proc/unfreeze_turf(turf/T)
	escape_the_negative_zone(T)

/datum/proximity_monitor/advanced/timestop/proc/freeze_structure(obj/O)
	into_the_negative_zone(O)
	frozen_structures += O

/datum/proximity_monitor/advanced/timestop/proc/unfreeze_structure(obj/O)
	escape_the_negative_zone(O)

/datum/proximity_monitor/advanced/timestop/process()
	for(var/i in frozen_mobs)
		var/mob/living/m = i
		m.Stun(20, ignore_canstun = TRUE)

/datum/proximity_monitor/advanced/timestop/setup_field_turf(turf/target)
	. = ..()
	for(var/i in target.contents)
		freeze_atom(i)
	freeze_turf(target)

/datum/proximity_monitor/advanced/timestop/proc/freeze_projectile(obj/projectile/P)
	P.paused = TRUE

/datum/proximity_monitor/advanced/timestop/proc/unfreeze_projectile(obj/projectile/P)
	P.paused = FALSE

/datum/proximity_monitor/advanced/timestop/proc/freeze_mob(mob/living/victim)
	frozen_mobs += victim
	victim.Stun(20, ignore_canstun = TRUE)
	victim.add_traits(list(TRAIT_MUTE, TRAIT_EMOTEMUTE), TIMESTOP_TRAIT)
	GLOB.move_manager.stop_looping(victim) //stops them mid pathing even if they're stunimmune //This is really dumb
	if(isanimal(victim))
		var/mob/living/simple_animal/animal_victim = victim
		animal_victim.toggle_ai(AI_OFF)
		if(ishostile(victim))
			var/mob/living/simple_animal/hostile/hostile_victim = victim
			hostile_victim.LoseTarget()
	else if(isbasicmob(victim))
		var/mob/living/basic/basic_victim = victim
		basic_victim.ai_controller?.set_ai_status(AI_STATUS_OFF)

/datum/proximity_monitor/advanced/timestop/proc/unfreeze_mob(mob/living/victim)
	victim.AdjustStun(-20, ignore_canstun = TRUE)
	victim.remove_traits(list(TRAIT_MUTE, TRAIT_EMOTEMUTE), TIMESTOP_TRAIT)
	frozen_mobs -= victim
	if(isanimal(victim))
		var/mob/living/simple_animal/animal_victim = victim
		animal_victim.toggle_ai(initial(animal_victim.AIStatus))
	else if(isbasicmob(victim))
		var/mob/living/basic/basic_victim = victim
		basic_victim.ai_controller?.reset_ai_status()

//you don't look quite right, is something the matter?
/datum/proximity_monitor/advanced/timestop/proc/into_the_negative_zone(atom/A)
	A.add_atom_colour(COLOR_MATRIX_INVERT, TEMPORARY_COLOUR_PRIORITY)

//let's put some colour back into your cheeks
/datum/proximity_monitor/advanced/timestop/proc/escape_the_negative_zone(atom/A)
	A.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY)

//signal fired when an immune atom moves in the time freeze zone
/datum/proximity_monitor/advanced/timestop/proc/atom_broke_channel(datum/source)
	SIGNAL_HANDLER
	qdel(host)
