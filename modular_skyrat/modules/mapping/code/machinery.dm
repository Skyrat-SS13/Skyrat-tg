//For ruin-specific machines --- limitied/unique functions, or functions mimicked from normal machines.
//Think along the lines of a console with lore or a fuse box that needs x fuses to activate --- or, just a retextured GPS Computer, like the first item

/* ----------------- Computers ----------------- */
/obj/item/gps/computer/space //Subtype that runs pod computer code, with a texture to blend better with normal walls
	icon = 'modular_skyrat/modules/mapping/icons/machinery/gps_computer.dmi'	//needs its own file for pixel size ;-;
	name = "gps computer"
	icon_state = "pod_computer"
	anchored = TRUE
	density = TRUE
	pixel_y = -5    //I dunno why this sprite lines up differently, but this is a better value to line this one up in a way that looks built into a wall
	gpstag = SPACE_SIGNAL_GPSTAG	//really the only non-aesthetic change, gives the space ruin GPS signal

/obj/item/gps/computer/space/wrench_act(mob/living/user, obj/item/I)
	..()
	if(flags_1 & NODECONSTRUCT_1)
		return TRUE

	user.visible_message(span_warning("[user] disassembles [src]."),
		span_notice("You start to disassemble [src]..."), span_hear("You hear clanking and banging noises."))
	if(I.use_tool(src, user, 20, volume=50))
		new /obj/item/gps/spaceruin(loc)	//really the only non-aesthetic change, gives the space ruin GPS signal
		qdel(src)
	return TRUE

/obj/item/gps/computer/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	attack_self(user)

///////////////////////
/// SOLFED FASTPASS ///
// A combination of a console, linked turfs, and an area (/area/centcom/interlink/solfed), which delete the occupants.
// -Strictly for use with 911 as their exit from the round on the Interlink-
/turf/open/floor/plating/elevatorshaft/solfed_gtfo
	name = "SolFed Fastpass Lift"
	desc = "Seeing where this thing goes to is restricted to First Responders for good reason. (This will delete you when the lift leaves.)"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF	//No touchie

/obj/machinery/computer/solfed_gtfo
	name = "SolFed Fastpass Console"
	icon_state = "computer"
	density = TRUE
	use_power = NO_POWER_USE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF	//No touchie
	icon_keyboard = "id_key"
	icon_screen = "request"

	///Have admins disabled the lift?
	var/lift_blocked = FALSE
	///If the lift is disabled, WHY?
	var/block_reason

	///Variable to say if the lift is in the middle of starting or not; used for overrides/cancelling
	var/lift_starting = FALSE
	///List of all `/turf/open/floor/plating/elevatorshaft/solfed_gtfo` in the surrounding area; if these ARENT mapped around the console, someone fucked up big.
	var/list/linked_tiles = list()
	///List of all riders on the lift; determined by the contents of linked_tiles attached to the console
	var/list/list_of_riders = list()

/obj/machinery/computer/solfed_gtfo/screwdriver_act(mob/living/user, obj/item/I)
	to_chat(user, "You shouldn't touch that!")
	return FALSE

/obj/machinery/computer/solfed_gtfo/emp_act(severity)
	return FALSE

/obj/machinery/computer/solfed_gtfo/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	linked_tiles = locate_lift_tiles()

/obj/machinery/computer/solfed_gtfo/interact(mob/user)
	. = ..()
	if(!user.client.holder)	//Admins skip this datum check
		if(!user.mind.has_antag_datum(/datum/antagonist/ert/request_911))
			say("ACCESS DENIED: SolFed First Responder Clearances Required.")
			return FALSE
	else	//Admins DO get a warning, though. If they delete any rando people, it is NOT on me
		to_chat(user, span_admin("Admin, you're given access to this for Debug ONLY. Dont use this console without good reason."))
		return TRUE

/obj/machinery/computer/solfed_gtfo/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		//Probably a good time to reset linked tiles too, because this is probably the first time its been opened..
		locate_lift_tiles()
		ui = new(user, src, "Skyrat_SolFedGTFO", name)
		ui.open()

/obj/machinery/computer/solfed_gtfo/ui_data(mob/user)
	var/list/data = list()

	for(var/i in linked_tiles)	//Checks all attached tiles, to get a list of the riders.
		var/mob/living/carbon/human/checked_rider = i
		if(checked_rider in list_of_riders)	//Dont add dupes
			continue
		list_of_riders += checked_rider

	data["list_of_riders"] = list_of_riders
	data["lift_blocked"] = lift_blocked
	return data

/obj/machinery/computer/solfed_gtfo/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("activate_lift")
			activate_lift()
		if("block_lift")
			block_lift()

/obj/machinery/computer/solfed_gtfo/proc/block_lift(mob/user)
	if(user.client.holder)	//Admin only
		if(!lift_blocked)
			block_reason = tgui_input_text(usr, "Provide a reason for the lift-block, if any. Leaving it blank will default to \"Current Call Incomplete\".", "Lift-Block-O-Matic", max_length = MAX_BROADCAST_LEN)
			if(block_reason.len =< 0)
				block_reason = "Current Call Incomplete"
			lift_blocked = TRUE
			say("Lift Blocked, transit unavailable.")
		else
			block_reason = null
			lift_blocked = FALSE
			say("Lift Unblocked, resuming normal operation.")

///Finds users on the 'lift', gives ample warning as to what will happen, then deletes them all. Effectively, its how 911 will leave the round.
//If it's already booting up, though, re-calling this will cancel!
/obj/machinery/computer/solfed_gtfo/proc/activate_lift(mob/user, list_of_riders)
	if(user.client.holder)	//Debug purposes, admins get a slightly modified warning specifying 'hey, admin, dont use this if you arent debugging'
		if(lift_blocked)
			to_chat(user, span_admin("Lift is Blocked, re-enable it first!"))
			return FALSE
		if(!isliving(user))
			to_chat(user, span_admin("Stop trying to debug 'delete all rider' platforms as a ghost. Counter-intuitive as hell."))
		if(!tgui_alert(user, span_admin("Admin, are you sure? This will remove all riders from the round. You should only use this for debug purposes."), "Activate Lift", list("I'm Sure", "Abort")) == "I'm Sure")
			return FALSE
	else
		if(!user.mind.has_antag_datum(/datum/antagonist/ert/request_911))
			say("ACCESS DENIED: SolFed First Responder Clearances Required.")
			return FALSE
		if(lift_blocked)
			say("ERROR: Lift has been disabled for the following reason: [block_reason]")
		if(!tgui_alert(user, "Are you sure? This will remove all riders from the round.", "Activate Lift", list("I'm Sure", "Abort")) == "I'm Sure")
			return FALSE

	message_admins("[ADMIN_LOOKUPFLW(user)] has begun to use the [ADMIN_LOOKUPFLW(src)] - this will remove all riders from the round.")
	say("SolFed Clearances accepted. Hello, First Responders. Please, take a seat, the FastPass Lift will depart shortly.")
	for(var/mob/living/rider in list_of_riders)
		to_chat(rider, span_warning("You get a large pang of anxiety. No going back after this..."))
	//wait 30 seconds



///Finds valid tiles to use as the 'lift'
/obj/machinery/computer/solfed_gtfo/proc/locate_lift_tiles()
	///This should be an area ONLY containing the lift itself! (/area/centcom/interlink/solfed)
	var/currentarea = get_area(src.loc)
	for(var/turf/open/floor/plating/elevatorshaft/solfed_gtfo/lift_tile in currentarea)
		linked_tiles += lift_tile
	if(!linked_tiles)	//Shits fucked, SOMEHOW
		log_game("[src] has no linked tiles to delete users from!")
		message_admins("[ADMIN_LOOKUPFLW(src)] has no linked tiles to delete users from! Fix this before 911 is called by spawning /turf/open/floor/plating/elevatorshaft/solfed_gtfo around it, then proc-calling locate_lift_tiles()!")

/obj/item/beamout_tool/attack_self(mob/user, modifiers)
	. = ..()
	if(!user.mind.has_antag_datum(/datum/antagonist/ert/request_911))
		to_chat(user, span_warning("You don't understand how to use this device."))
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has begun to beam-out using their beam-out tool.")
	to_chat(user, "You have begun the beam-out process. Please wait for the beam to reach the station.")
	user.balloon_alert(user, "begun beam-out")
	if(do_after(user, 30 SECONDS))
		to_chat(user, "You have completed the beam-out process and are returning to the Sol Federation.")
		message_admins("[ADMIN_LOOKUPFLW(user)] has beamed themselves out.")
		if(isliving(user))
			var/mob/living/living_user = user
			if(living_user.pulling)
				if(ishuman(living_user.pulling))
					var/mob/living/carbon/human/beamed_human = living_user.pulling
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [ADMIN_LOOKUPFLW(beamed_human)] alongside them.")
				else
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [living_user.pulling] alongside them.")
				var/turf/pulling_turf = get_turf(living_user.pulling)
				playsound(pulling_turf, 'sound/magic/Repulse.ogg', 100, 1)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(10, 1, pulling_turf)
				sparks.attach(pulling_turf)
				sparks.start()
				qdel(living_user.pulling)
			var/turf/user_turf = get_turf(living_user)
			playsound(user_turf, 'sound/magic/Repulse.ogg', 100, 1)
			var/datum/effect_system/spark_spread/quantum/sparks = new
			sparks.set_up(10, 1, user_turf)
			sparks.attach(user_turf)
			sparks.start()
			qdel(user)
	else
		user.balloon_alert(user, "beam-out cancelled")
