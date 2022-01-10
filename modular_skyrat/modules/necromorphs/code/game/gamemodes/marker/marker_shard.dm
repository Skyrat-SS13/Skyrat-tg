/*
	A small chunk taken from the marker. When left alone (and active) for a while, it will begin spreading corruption

	It activates at the same time as the marker
*/

/obj/item/marker_shard
	name = "strange rock"
	desc = "It's covered in odd writing."
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/marker_shard.dmi'
	icon_state = "marker_shard_dormant"
//	randpixel = 0

	var/mass_active = 30 //It gets heavier when active

//	resistance = 40
//	max_health = 1000

	var/active = FALSE

	//How long does the shard have to remain in one spot before it starts spreading corruption?
	var/deploy_time = 2 MINUTES
	var/deploy_timer
	var/deployed = FALSE	//Are we currently spreading corruption?

	//Thing we're usign to manage our corruption
	var/datum/extension/corruption_source/CS

	//Last place we were
	var/last_known_location
	var/last_moved = 0 //Last time we were moved

	var/corruption_range = 9
	var/corruption_speed = 0.8
	var/corruption_falloff = 0.8
	var/corruption_limit = 100

	//When dug into corruption, it fades a little
	var/alpha_sunk = 200

	var/tool_cut_multiplier = 0.015

/obj/item/marker_shard/Initialize()
	.=..()
	last_known_location = loc
	var/obj/machinery/marker/M = get_marker()
	if (M && M.active)
		activate()

	SSnecromorph.register_shard(src)



/obj/item/marker_shard/Destroy()
	SSnecromorph.unregister_shard(src)
	.=..()

/obj/item/marker_shard/examine(var/mob/user)
	.=..()
	if (anchored)
		to_chat(user, "It's stuck fast in those growths, you'd need a bladed implement to cut it out.")

/*
	Activation and timer
*/
/obj/item/marker_shard/proc/activate()
	active = TRUE
	last_known_location = loc
	GLOB.moved_event.register(src, src, .proc/moved)
	attempt_deploy()
	mass = mass_active
	update_icon()

/obj/item/marker_shard/proc/deactivate()
	active = FALSE
	mass = initial(mass)
	GLOB.moved_event.unregister(src, src, .proc/moved)
	update_icon()

/obj/item/marker_shard/proc/set_deploy_timer()
	deltimer(deploy_timer)
	if (active)
		deploy_timer = addtimer(CALLBACK(src, /obj/item/marker_shard/proc/attempt_deploy),  deploy_time, TIMER_STOPPABLE)


/obj/item/marker_shard/proc/erode_corruption(var/strength)
	for (var/obj/effect/vine/corruption/C in loc)
		C.adjust_health(-strength)

/obj/item/marker_shard/update_icon()
	if (active)
		icon_state = "marker_shard_active"
		set_light(1, 1, 8, 2, COLOR_MARKER_RED)
	else
		icon_state = "marker_shard_dormant"
		set_light(0)

/obj/item/marker_shard/proc/sink()
	if (istype(loc, /turf))
		anchored = TRUE
		alpha = alpha_sunk
		loc.visible_message("The corruption closes tight around [src]")

//Here we check if we've stayed still since our location was last updated
/obj/item/marker_shard/proc/attempt_deploy()
	deltimer(deploy_timer)
	if (!active)
		return

	if (loc == last_known_location && (world.time - last_moved) >= deploy_time)
		//Yes!
		deploy()
	else

		set_deploy_timer()	//Nop, update the location and wait another 3 mins

/obj/item/marker_shard/proc/deploy()

	deployed = TRUE
	sink()
	CS = set_extension(src, /datum/extension/corruption_source, corruption_range, corruption_speed, corruption_falloff, corruption_limit)


