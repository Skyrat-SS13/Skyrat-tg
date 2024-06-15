//Few global vars to track the blob
GLOBAL_LIST_EMPTY(blobs) //complete list of all blobs made.
GLOBAL_LIST_EMPTY(blob_cores)
GLOBAL_LIST_EMPTY(overminds)
GLOBAL_LIST_EMPTY(blob_nodes)


/mob/camera/blob
	name = "Blob Overmind"
	real_name = "Blob Overmind"
	desc = "The overmind. It controls the blob."
	icon = 'icons/mob/silicon/cameramob.dmi'
	icon_state = "marker"
	mouse_opacity = MOUSE_OPACITY_ICON
	move_on_shuttle = TRUE
	invisibility = INVISIBILITY_OBSERVER
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	see_invisible = SEE_INVISIBLE_LIVING
	pass_flags = PASSBLOB
	faction = list(ROLE_BLOB)
	// Vivid blue green, would be cool to make this change with strain
	lighting_cutoff_red = 0
	lighting_cutoff_green = 35
	lighting_cutoff_blue = 20
	hud_type = /datum/hud/blob_overmind
	var/obj/structure/blob/special/core/blob_core = null // The blob overmind's core
	var/blob_points = 0
	var/max_blob_points = OVERMIND_MAX_POINTS_DEFAULT
	var/last_attack = 0
	var/datum/blobstrain/reagent/blobstrain
	var/list/blob_mobs = list()
	/// A list of all blob structures
	var/list/all_blobs = list()
	var/list/resource_blobs = list()
	var/list/factory_blobs = list()
	var/list/node_blobs = list()
	var/free_strain_rerolls = OVERMIND_STARTING_REROLLS
	var/last_reroll_time = 0 //time since we last rerolled, used to give free rerolls
	var/nodes_required = TRUE //if the blob needs nodes to place resource and factory blobs
	var/placed = FALSE
	var/manualplace_min_time = OVERMIND_STARTING_MIN_PLACE_TIME // Some time to get your bearings
	var/autoplace_max_time = OVERMIND_STARTING_AUTO_PLACE_TIME // Automatically place the core in a random spot
	var/list/blobs_legit = list()
	var/max_count = 0 //The biggest it got before death
	var/blobwincount = OVERMIND_WIN_CONDITION_AMOUNT
	var/victory_in_progress = FALSE
	var/rerolling = FALSE
	var/announcement_size = OVERMIND_ANNOUNCEMENT_MIN_SIZE // Announce the biohazard when this size is reached
	var/announcement_time
	var/has_announced = FALSE

	/// The list of strains the blob can reroll for.
	var/list/strain_choices

/mob/camera/blob/Initialize(mapload, starting_points = OVERMIND_STARTING_POINTS)
	ADD_TRAIT(src, TRAIT_BLOB_ALLY, INNATE_TRAIT)
	validate_location()
	blob_points = starting_points
	manualplace_min_time += world.time
	autoplace_max_time += world.time
	GLOB.overminds += src
	var/new_name = "[initial(name)] ([rand(1, 999)])"
	name = new_name
	real_name = new_name
	last_attack = world.time
	var/datum/blobstrain/BS = pick(GLOB.valid_blobstrains)
	set_strain(BS)
	color = blobstrain.complementary_color
	if(blob_core)
		blob_core.update_appearance()
	SSshuttle.registerHostileEnvironment(src)
	. = ..()
	START_PROCESSING(SSobj, src)
	GLOB.blob_telepathy_mobs |= src

/mob/camera/blob/proc/validate_location()
	var/turf/T = get_turf(src)
	if(is_valid_turf(T))
		return

	if(LAZYLEN(GLOB.blobstart))
		var/list/blobstarts = shuffle(GLOB.blobstart)
		for(var/_T in blobstarts)
			if(is_valid_turf(_T))
				T = _T
				break
	else // no blob starts so look for an alternate
		for(var/i in 1 to 16)
			var/turf/picked_safe = get_safe_random_station_turf()
			if(is_valid_turf(picked_safe))
				T = picked_safe
				break

	if(!T)
		CRASH("No blobspawnpoints and blob spawned in nullspace.")
	forceMove(T)

/mob/camera/blob/proc/set_strain(datum/blobstrain/new_strain)
	if (!ispath(new_strain))
		return FALSE

	var/had_strain = FALSE
	if (istype(blobstrain))
		blobstrain.on_lose()
		qdel(blobstrain)
		had_strain = TRUE

	blobstrain = new new_strain(src)
	blobstrain.on_gain()

	if (had_strain)
		to_chat(src, span_notice("Your strain is now: <b><font color=\"[blobstrain.color]\">[blobstrain.name]</b></font>!"))
		to_chat(src, span_notice("The <b><font color=\"[blobstrain.color]\">[blobstrain.name]</b></font> strain [blobstrain.description]"))
		if(blobstrain.effectdesc)
			to_chat(src, span_notice("The <b><font color=\"[blobstrain.color]\">[blobstrain.name]</b></font> strain [blobstrain.effectdesc]"))
	SEND_SIGNAL(src, COMSIG_BLOB_SELECTED_STRAIN, blobstrain)

/mob/camera/blob/can_z_move(direction, turf/start, turf/destination, z_move_flags = NONE, mob/living/rider)
	if(placed) // The blob can't expand vertically (yet)
		return FALSE
	. = ..()
	if(!.)
		return
	var/turf/target_turf = .
	if(!is_valid_turf(target_turf)) // Allows unplaced blobs to travel through station z-levels
		if(z_move_flags & ZMOVE_FEEDBACK)
			to_chat(src, span_warning("Your destination is invalid. Move somewhere else and try again."))
		return null

/mob/camera/blob/proc/is_valid_turf(turf/tile)
	var/area/area = get_area(tile)
	if((area && !(area.area_flags & BLOBS_ALLOWED)) || !tile || !is_station_level(tile.z) || isgroundlessturf(tile))
		return FALSE
	return TRUE

/mob/camera/blob/process()
	if(!blob_core)
		if(!placed)
			if(manualplace_min_time && world.time >= manualplace_min_time)
				to_chat(src, span_boldnotice("You may now place your blob core."))
				to_chat(src, span_boldannounce("You will automatically place your blob core in [DisplayTimeText(autoplace_max_time - world.time)]."))
				manualplace_min_time = 0
			if(autoplace_max_time && world.time >= autoplace_max_time)
				place_blob_core(BLOB_RANDOM_PLACEMENT)
		else
			// If we get here, it means yes: the blob is kill
			SSticker.news_report = BLOB_DESTROYED
			qdel(src)
	else if(!victory_in_progress && (blobs_legit.len >= blobwincount))
		victory_in_progress = TRUE
		priority_announce("Biohazard has reached critical mass. Station loss is imminent.", "Biohazard Alert")
		SSsecurity_level.set_level(SEC_LEVEL_DELTA)
		max_blob_points = INFINITY
		blob_points = INFINITY
		addtimer(CALLBACK(src, PROC_REF(victory)), 45 SECONDS)
	else if(!free_strain_rerolls && (last_reroll_time + BLOB_POWER_REROLL_FREE_TIME<world.time))
		to_chat(src, span_boldnotice("You have gained another free strain re-roll."))
		free_strain_rerolls = 1

	if(!victory_in_progress && max_count < blobs_legit.len)
		max_count = blobs_legit.len

	if(announcement_time && (world.time >= announcement_time || blobs_legit.len >= announcement_size) && !has_announced)
		priority_announce("Confirmed outbreak of level 5 biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", ANNOUNCER_OUTBREAK5)
		has_announced = TRUE

/// Create a blob spore and link it to us
/mob/camera/blob/proc/create_spore(turf/spore_turf, spore_type = /mob/living/basic/blob_minion/spore/minion)
	var/mob/living/basic/blob_minion/spore/spore = new spore_type(spore_turf)
	assume_direct_control(spore)
	return spore

/// Give our new minion the properties of a minion
/mob/camera/blob/proc/assume_direct_control(mob/living/minion)
	minion.AddComponent(/datum/component/blob_minion, src)

/// Add something to our list of mobs and wait for it to die
/mob/camera/blob/proc/register_new_minion(mob/living/minion)
	blob_mobs |= minion
	if (!istype(minion, /mob/living/basic/blob_minion/blobbernaut))
		RegisterSignal(minion, COMSIG_LIVING_DEATH, PROC_REF(on_minion_death))

/// When a spore (or zombie) dies then we do this
/mob/camera/blob/proc/on_minion_death(mob/living/spore)
	SIGNAL_HANDLER
	blobstrain.on_sporedeath(spore)

/mob/camera/blob/proc/victory()
	sound_to_playing_players('sound/machines/alarm.ogg')
	sleep(10 SECONDS)
	for(var/mob/living/live_guy as anything in GLOB.mob_living_list)
		var/turf/guy_turf = get_turf(live_guy)
		if(isnull(guy_turf) || !is_station_level(guy_turf.z))
			continue

		if(live_guy in GLOB.overminds || (live_guy.pass_flags & PASSBLOB))
			continue

		var/area/blob_area = get_area(guy_turf)
		if(!(blob_area.area_flags & BLOBS_ALLOWED))
			continue

		if(!(ROLE_BLOB in live_guy.faction))
			playsound(live_guy, 'sound/effects/splat.ogg', 50, TRUE)
			if(live_guy.stat != DEAD)
				live_guy.investigate_log("has died from blob takeover.", INVESTIGATE_DEATHS)
			live_guy.death()
			create_spore(guy_turf)
		else
			live_guy.fully_heal()

		for(var/area/check_area in GLOB.areas)
			if(!is_type_in_list(check_area, GLOB.the_station_areas))
				continue
			if(!(check_area.area_flags & BLOBS_ALLOWED))
				continue
			check_area.color = blobstrain.color
			check_area.name = "blob"
			check_area.icon = 'icons/mob/nonhuman-player/blob.dmi'
			check_area.icon_state = "blob_shield"
			check_area.layer = BELOW_MOB_LAYER
			check_area.SetInvisibility(INVISIBILITY_NONE)
			check_area.blend_mode = 0

	var/datum/antagonist/blob/B = mind.has_antag_datum(/datum/antagonist/blob)
	if(B)
		var/datum/objective/blob_takeover/main_objective = locate() in B.objectives
		if(main_objective)
			main_objective.completed = TRUE
	to_chat(world, span_blobannounce("[real_name] consumed the station in an unstoppable tide!"))
	SSticker.news_report = BLOB_WIN
	SSticker.force_ending = FORCE_END_ROUND

/mob/camera/blob/Destroy()
	QDEL_NULL(blobstrain)
	for(var/BL in GLOB.blobs)
		var/obj/structure/blob/B = BL
		if(B && B.overmind == src)
			B.overmind = null
			B.update_appearance() //reset anything that was ours
	for(var/obj/structure/blob/blob_structure as anything in all_blobs)
		blob_structure.overmind = null
	all_blobs = null
	resource_blobs = null
	factory_blobs = null
	node_blobs = null
	blob_mobs = null
	GLOB.overminds -= src
	QDEL_LIST_ASSOC_VAL(strain_choices)

	SSshuttle.clearHostileEnvironment(src)
	STOP_PROCESSING(SSobj, src)
	GLOB.blob_telepathy_mobs -= src

	return ..()

/mob/camera/blob/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	to_chat(src, span_blobannounce("You are the overmind!"))
	if(!placed && autoplace_max_time <= world.time)
		to_chat(src, span_boldannounce("You will automatically place your blob core in [DisplayTimeText(autoplace_max_time - world.time)]."))
		to_chat(src, span_boldannounce("You [manualplace_min_time ? "will be able to":"can"] manually place your blob core by pressing the Place Blob Core button in the bottom right corner of the screen."))
	update_health_hud()
	add_points(0)

/mob/camera/blob/examine(mob/user)
	. = ..()
	if(blobstrain)
		. += "Its strain is <font color=\"[blobstrain.color]\">[blobstrain.name]</font>."

/mob/camera/blob/update_health_hud()
	if(!blob_core)
		return FALSE
	var/current_health = round((blob_core.get_integrity() / blob_core.max_integrity) * 100)
	hud_used.healths.maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#82ed00'>[current_health]%</font></div>")
	for(var/mob/living/basic/blob_minion/blobbernaut/blobbernaut in blob_mobs)
		var/datum/hud/using_hud = blobbernaut.hud_used
		if(!using_hud?.blobpwrdisplay)
			continue
		using_hud.blobpwrdisplay.maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#82ed00'>[current_health]%</font></div>")

/mob/camera/blob/proc/add_points(points)
	blob_points = clamp(blob_points + points, 0, max_blob_points)
	hud_used.blobpwrdisplay.maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#e36600'>[round(blob_points)]</font></div>")

/mob/camera/blob/say(
	message,
	bubble_type,
	list/spans = list(),
	sanitize = TRUE,
	datum/language/language,
	ignore_spam = FALSE,
	forced,
	filterproof = FALSE,
	message_range = 7,
	datum/saymode/saymode,
	list/message_mods = list(),
)
	if (!message)
		return

	if (src.client)
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, span_boldwarning("You cannot send IC messages (muted)."))
			return
		if (!(ignore_spam || forced) && src.client.handle_spam_prevention(message, MUTE_IC))
			return

	if (stat)
		return

	blob_talk(message)

/mob/camera/blob/proc/blob_talk(message)

	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))

	if (!message)
		return

	src.log_talk(message, LOG_SAY)

	var/message_a = say_quote(message)
	var/rendered = span_big(span_blob("<b>\[Blob Telepathy\] [name](<font color=\"[blobstrain.color]\">[blobstrain.name]</font>)</b> [message_a]"))
	relay_to_list_and_observers(rendered, GLOB.blob_telepathy_mobs, src)

/mob/camera/blob/blob_act(obj/structure/blob/B)
	return

/mob/camera/blob/get_status_tab_items()
	. = ..()
	if(blob_core)
		. += "Core Health: [blob_core.get_integrity()]"
		. += "Power Stored: [blob_points]/[max_blob_points]"
		. += "Blobs to Win: [blobs_legit.len]/[blobwincount]"
	if(free_strain_rerolls)
		. += "You have [free_strain_rerolls] Free Strain Reroll\s Remaining"
	if(!placed)
		if(manualplace_min_time)
			. += "Time Before Manual Placement: [max(round((manualplace_min_time - world.time)*0.1, 0.1), 0)]"
		. += "Time Before Automatic Placement: [max(round((autoplace_max_time - world.time)*0.1, 0.1), 0)]"

/mob/camera/blob/Move(NewLoc, Dir = 0)
	if(placed)
		var/obj/structure/blob/B = locate() in range(OVERMIND_MAX_CAMERA_STRAY, NewLoc)
		if(B)
			forceMove(NewLoc)
		else
			return FALSE
	else
		var/area/check_area = get_area(NewLoc)
		if(isgroundlessturf(NewLoc) || istype(check_area, /area/shuttle)) //if unplaced, can't go on shuttles or groundless tiles
			return FALSE
		forceMove(NewLoc)
		return TRUE

/mob/camera/blob/mind_initialize()
	. = ..()
	var/datum/antagonist/blob/blob = mind.has_antag_datum(/datum/antagonist/blob)
	if(!blob)
		mind.add_antag_datum(/datum/antagonist/blob)
