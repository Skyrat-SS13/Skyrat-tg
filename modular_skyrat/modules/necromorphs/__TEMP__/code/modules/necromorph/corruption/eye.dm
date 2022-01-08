/*
	The eye node serves four main purposes

	1. It provides necrovision in a broad area around it
	2. It alerts necromorphs of any humans that come near
	3. It tracks sightings of humans, storing that data and making it acessible to all necro players
	4. It provides light, allowing necromorphs to find their way around dark halls
*/
/obj/structure/corruption_node/eye
	name = "eye"
	desc = "It knows you. You cannot escape its gaze."
	icon_state = "eye"
	max_health = 60	//fragile
	visualnet_range = 20
	var/minimum_notify_delay = 3 MINUTES	//Minimum time that must pass between sightings before we resend notifications
	default_scale = 1.6
	var/light_range = 8

/obj/structure/corruption_node/eye/Initialize()
	.=..()
	if (!dummy)	//Don't do this stuff if its a dummy for placement preview
		GLOB.necrovision.add_source(src, TRUE, TRUE)	//Add it as a vision source

		//Setup a trigger to track nearby mobs
		var/datum/proximity_trigger/view/PT = new (holder = src, on_turf_entered = /obj/structure/corruption_node/eye/proc/nearby_movement, range = visualnet_range)
		PT.register_turfs()
		set_extension(src, /datum/extension/proximity_manager, PT)

		set_light(1, 1, light_range, 2, COLOR_NECRO_YELLOW)

/obj/structure/corruption_node/eye/get_visualnet_tiles(var/datum/visualnet/network)

	return turfs_in_view(visualnet_range)


/obj/structure/corruption_node/eye/proc/mark_turfs()
	for (var/turf/T in turfs_in_view(visualnet_range))
		debug_mark_turf(T)

/obj/structure/corruption_node/eye/proc/nearby_movement(var/atom/movable/AM, var/atom/old_loc)
	if (ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if (!H.is_necromorph())
			var/delta = SSnecromorph.update_sighting(AM, src)
			if (delta > minimum_notify_delay)
				to_chat(H, SPAN_NOTICE("A shiver runs down your spine. You are being watched."))
				H.playsound_local(get_turf(H), get_sfx("hiss"), 50)

/obj/structure/corruption_node/eye/get_blurb()
	. = "This node is effectively an organic camera. It massively increases the view range of the necrovision network by [visualnet_range] tiles.<br><br>\
	 In addition, it will notify all necromorph players when it sees a live human. <br><br>\
	Finally, and most significantly, all eye nodes will keep track of every human they see, storing that information centrally in the Prey Sightings menu. This can be used by all necromorphs to direct and coordinate their hunting efforts."


/datum/sighting
	var/atom/movable/thing
	var/turf/last_location
	var/last_time = 0

//Returns a string that describes the delta between now and the last sighting time
/datum/sighting/proc/get_time_description()

	//How long ago were they last seen?
	var/delta = world.time - last_time

	//If they're still in the last location, mark it as such
	if (thing.loc == last_location)
		. = SPAN_DANGER("Now!")
	else if (delta < 1 MINUTE)
		. = "[round(delta/10)] seconds ago"
	else if (delta < 1 HOUR)
		. = "[round(delta/600)] minutes ago"
	else
		. = "Over an hour ago"


//This datum is basically just because nanouis need to be attached to something
/datum/sighting_menu/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/list/data = list()
	var/list/prey = list()
	for (var/mob/living/L in SSnecromorph.sightings)

		var/datum/sighting/S = SSnecromorph.sightings[L]
		var/list/sublist = list()
		sublist["who"] = L.real_name
		sublist["where"] = jumplink_public(user, S.last_location)
		sublist["when"] = S.get_time_description()

		prey += list(sublist)
	data["prey"] = prey
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "preysightings.tmpl", "Prey Sightings", 800, 700, state = GLOB.interactive_state)
		ui.set_initial_data(data)
		ui.set_auto_update(1)
		ui.open()


/mob/proc/prey_sightings()
	set name = "Prey Sightings"
	set category = SPECIES_NECROMORPH

	var/datum/sighting_menu/SM = new()
	SM.ui_interact(src)


/obj/structure/corruption_node/eye/small
	name = "Gaze"
	desc = "The abyss stares back"
	icon_state = "minieye"
	max_health = 20	//fragile
	visualnet_range = 8
	minimum_notify_delay = 3 MINUTES	//Minimum time that must pass between sightings before we resend notifications
	default_scale = 1
	light_range = 2
	marker_spawnable = FALSE


/obj/structure/corruption_node/eye/small/get_blurb()
	. = "This node is effectively an organic camera, a smaller version of the Eye node. It moderately increases the view range of the necrovision network by [visualnet_range] tiles.<br><br>\
	 In addition, it will notify all necromorph players when it sees a live human. <br><br>\
	Finally, and most significantly, all eye nodes will keep track of every human they see, storing that information centrally in the Prey Sightings menu. This can be used by all necromorphs to direct and coordinate their hunting efforts."


/*
	Signal ability
*/
/datum/signal_ability/placement/corruption/gaze
	name = "Gaze"
	id = "gaze"
	energy_cost = 120
	placement_atom = /obj/structure/corruption_node/eye/small
