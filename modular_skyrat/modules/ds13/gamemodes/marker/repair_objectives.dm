

//Datum to model ship systems. Disable these to lower evac point generation for the survivors

/obj/structure/ship_component
	name = "ship engine computer"
	desc = "A component critical to the operation of a starship."
	icon_state = "enginemachine"
	health = 300
	max_health = 300 //Tough.
	var/state = 1
	var/operational = TRUE

/obj/structure/ship_component/update_icon()
	if(operational)
		icon_state = initial(icon_state)
		return
	icon_state = "[initial(icon_state)]_broken"

/obj/structure/ship_component/examine(mob/user)
	. = ..()
	switch(state)
		if(1)
			to_chat(user, "<span class='notice'>[src] is reinforced with special bolts, perhaps a <b>wrench</b> could loosen them?.</span>")
		if(2)
			to_chat(user, "<span class='notice'>[src]'s internal casings are still attached, perhaps a <b>screwdriver</b> could remove them?.</span>")
		if(3)
			to_chat(user, "<span class='notice'>[src]'s internals are exposed, perhaps you could <b>weld</b> the damaged portions to repair them?.</span>")
		if(4)
			to_chat(user, "<span class='notice'>[src]'s internal casings are loose, perhaps a <b>screwdriver</b> could re-attach them?.</span>")
		if(5)
			to_chat(user, "<span class='notice'>[src]'s reinforcing bolts are loose, perhaps a <b>wrench</b> could replace them?.</span>")

/obj/structure/ship_component/attackby(obj/item/W as obj, mob/user as mob)
	switch(state)
		if(1)
			if(isWrench(W))
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				if(do_after(user, 5 SECONDS, src))
					playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
					to_chat(user, "<span class='notice'>You prize away the reinforcing bolts with [W].</span>")
					state = 2
		if(2)
			if(isScrewdriver(W))
				playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
				if(do_after(user, 5 SECONDS, src))
					playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
					to_chat(user, "<span class='notice'>You unscrew the internal casings with [W].</span>")
					state = 3
		if(3)
			if(isWelder(W))
				if( W.use_tool(user, src, WORKTIME_NORMAL, QUALITY_WELDING, FAILCHANCE_NORMAL))
					to_chat(user, "<span class='notice'>You've repaired [src]. Re-assembly is the reverse of removal.</span>")
					state = 4
		if(4)
			if(isScrewdriver(W))
				playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
				if(do_after(user, 5 SECONDS, src))
					playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
					to_chat(user, "<span class='notice'>You screw in [src]'s internal casings with [W].</span>")
					state = 5
		if(5)
			if(isWrench(W))
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				if(do_after(user, 5 SECONDS, src))
					playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
					to_chat(user, "<span class='notice'>You replace the reinforcing bolts with [W].</span>")
					state = 1
					operational = TRUE
					update_icon()
					enable_system()
					repair_damage(max_health)

/obj/structure/ship_component/New()
	. = ..()
	GLOB.shipsystem.components += src

/obj/structure/ship_component/proc/disable_system()
	command_announcement.Announce("WARNING: Engines subsystem has been disabled. Repair [name] in [get_area(src)] to continue mission.","USG Ishimura Automated Announcement")
	GLOB.shipsystem.engines_enabled = FALSE

/obj/structure/ship_component/proc/enable_system()
	command_announcement.Announce("Engines subsystem has been re-enabled. Continuing on standard trajectory.","USG Ishimura Automated Announcement")
	GLOB.shipsystem.engines_enabled = TRUE

/obj/structure/ship_component/scanners
	name = "scanner array"
	icon_state = "scannermachine"

/obj/structure/ship_component/scanners/disable_system()
	command_announcement.Announce("WARNING: Sensors subsystem has been disabled. Repair [name] in [get_area(src)] to continue mission.","USG Ishimura Automated Announcement")
	GLOB.shipsystem.scanners_enabled = FALSE

/obj/structure/ship_component/scanners/enable_system()
	command_announcement.Announce("Sensors subsystem has been re-enabled. Continuing on standard trajectory.","USG Ishimura Automated Announcement")
	GLOB.shipsystem.scanners_enabled = TRUE

/obj/structure/ship_component/comms
	name = "comms dish"
	icon_state = "commsmachine"

/obj/structure/ship_component/comms/disable_system()
	command_announcement.Announce("WARNING: The inter-ship communications subsystem has been disabled. Repair [name] in [get_area(src)] to continue mission.","USG Ishimura Automated Announcement")
	GLOB.shipsystem.comms_enabled = FALSE

/obj/structure/ship_component/comms/enable_system()
	command_announcement.Announce("The inter-ship communications subsystem has been re-enabled. Continuing on standard trajectory.","USG Ishimura Automated Announcement")
	GLOB.shipsystem.comms_enabled = TRUE

/obj/structure/ship_component/take_damage(amount)
	if(health <= amount)
		health = 5
		operational = FALSE
		update_icon()
		disable_system()
		return FALSE
	. = ..()

/datum/ship_subsystems
	var/name = "Ishimura subsystems"
	var/engines_enabled = TRUE
	var/scanners_enabled = TRUE
	var/comms_enabled = TRUE
	var/list/components = list() //Stuff that we affect. Random one of these will break when the marker spawns.

/datum/ship_subsystems/proc/get_point_gen()
	var/value = 1 //Give them at least...something, even if the marker is stomping them
	if(!engines_enabled)
		value -= 0.15
	if(!scanners_enabled)
		value -= 0.15
	if(!comms_enabled)
		value -= 0.15
	return value