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
/// SOLGOV FASTPASS ///
// A combination of a console and linked turfs, which delete the occupants.
// -Strictly for use with 911 as their exit from the round on the Interlink-
/turf/open/floor/plating/elevatorshaft/solgov_gtfo
	name = "SolGov Fastpass Lift"
	desc = "Seeing where this thing goes to is restricted to First Responders for good reason. (This will delete you when the lift leaves.)"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF	//No touchie

/obj/machinery/computer/solgov_gtfo
	name = "SolGov Fastpass Console"
	icon_state = "computer"
	density = TRUE
	use_power = NO_POWER_USE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF	//No touchie
	icon_keyboard = "id_key"
	icon_screen = "request"

	///Variable to say if the lift is in the middle of starting or not; used for overrides/cancelling
	var/lift_starting = FALSE
	///List of all `/turf/open/floor/plating/elevatorshaft/solgov_gtfo` on the same Z-level; assumedly, these should all be mapped around the console. If not, a mapper gets shunned.
	var/list/linked_tiles = list()
	///List of all riders on the lift; determined by linked_tiles attached to the console
	var/list/list_of_riders = list()

/obj/machinery/computer/solgov_gtfo/screwdriver_act(mob/living/user, obj/item/I)
	to_chat(user, "You shouldn't touch that!")
	return FALSE

/obj/machinery/computer/solgov_gtfo/emp_act(severity)
	return FALSE

/obj/machinery/computer/solgov_gtfo/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	linked_tiles = locate_lift_tiles()

/obj/machinery/computer/solgov_gtfo/interact(mob/user)
	. = ..()
	if(!user.client.holder)	//Admins skip this datum check
		if(!user.mind.has_antag_datum(/datum/antagonist/ert/request_911))
			say("ACCESS DENIED: SolGov First Responder Clearances Required.")
			return FALSE
	else	//Admins DO get a warning, though. If they delete any rando people, it is NOT on me
		to_chat(user, span_admin("Admin, you're given access to this for Debug ONLY. Dont use this console without good reason."))
		return TRUE

/obj/machinery/computer/solgov_gtfo/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		//Probably a good time to reset linked tiles too, because this is probably the first time its been opened..
		locate_lift_tiles()
		ui = new(user, src, "Skyrat_SolGovGTFO", name)
		ui.open()

/obj/machinery/computer/solgov_gtfo/ui_data(mob/user)
	var/list/data = list()
	///Status of the lift (Usually always active, but here in case admins disable it)
	var/lift_status


	for(var/i in linked_tiles)	//Checks all attached tiles, to get a list of the riders.
		var/mob/living/carbon/human/checked_rider = i
		list_of_riders += checked_rider

	data["list_of_riders"] = list_of_riders
	data["lift_status"] = lift_status
	return data

/obj/machinery/computer/solgov_gtfo/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("activate_lift")
			activate_lift()

///Finds users on the 'lift' gives ample warning, then deletes them all. Effectively, its how 911 will leave the round.
/obj/machinery/computer/solgov_gtfo/proc/activate_lift(mob/user, list_of_riders)
	if(user.client.holder)	//Debug purposes, admins get a slightly modified warning specifying 'hey, admin, dont use this if you arent debugging'
		if(!isliving(user))
			to_chat(user, span_admin("Stop trying to debug 'delete all rider' platforms as a ghost. Counter-intuitive as hell."))
		if(!tgui_alert(user, span_admin("Admin, are you sure? This will remove all riders from the round. You should only use this for debug purposes."), "Activate Lift", list("I'm Sure", "Abort")) == "I'm Sure")
			return FALSE
	else
		if(!user.mind.has_antag_datum(/datum/antagonist/ert/request_911))
			say("ACCESS DENIED: SolGov First Responder Clearances Required.")
			return FALSE
		if(!tgui_alert(user, "Are you sure? This will remove all riders from the round.", "Activate Lift", list("I'm Sure", "Abort")) == "I'm Sure")
			return FALSE

	message_admins("[ADMIN_LOOKUPFLW(user)] has begun to use the SolGov Interlink Lift - this will remove all riders from the round.")
	say("SolGov Clearances accepted. Hello, First Responders. Please, take a seat, the FastPass Lift will depart shortly.")
	//wait 30 seconds

	for(var/mob/living/carbon/human/rider in linked_tiles)
		to_chat(rider, span_warning("You get a small pang of anxiety. No going back after this..."))


///Finds valid tiles to use as the 'lift'
/obj/machinery/computer/solgov_gtfo/proc/locate_lift_tiles()
	for(var/turf/open/floor/plating/elevatorshaft/solgov_gtfo/lift_tile in world)
		if(!lift_tile || lift_tile.z != src.z)	//If the turf somehow has no location (bugged) or isnt on the same z-level as the console, we skip it
			continue
		linked_tiles += lift_tile
	if(!linked_tiles)	//Shits fucked, SOMEHOW
		log_game("[src] has no linked tiles to delete users from!")
		message_admins("[ADMIN_LOOKUPFLW(src)] has no linked tiles to delete users from! Fix this before 911 is called by spawning /turf/open/floor/plating/elevatorshaft/solgov_gtfo around it!")

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
